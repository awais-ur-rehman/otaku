import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otaku/logic/social_cubit/social_states.dart';
import '../../data/repos/post_repo/post_repository.dart';
import '../../utils/storage/shared_prefs.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitial());

  final PostRepository postRepository = PostRepository();

  // Method to fetch all posts
  Future<void> fetchPosts() async {
    emit(SocialLoading());
    try {
      final posts = await postRepository.getAllPosts();
      if (posts.isEmpty) {
        emit(const SocialEmpty("No posts available."));
      } else {
        emit(SocialPostsLoaded(posts));
      }
    } catch (e) {
      emit(SocialError("Failed to load posts: $e"));
    }
  }

  // Method to refresh posts
  Future<void> refreshPosts() async {
    try {
      print("fetching everything again");
      final posts = await postRepository.getAllPosts();
      if (posts.isEmpty) {
        emit(const SocialEmpty("No posts available."));
      } else {
        print("finally laoded");
        emit(SocialPostsLoaded(posts));
      }
    } catch (e) {
      emit(SocialError("Failed to refresh posts: $e"));
    }
  }

// Method to create a new post
  Future<void> createPost({
    required String userId,
    required String content,
    String? image,
  }) async {
    emit(SocialLoading());
    try {
      final userId = sharedPrefs.userId;
      if (userId == null) {
        throw Exception("User ID not found in Shared Preferences");
      }

      bool success = await postRepository.createPost(
        userId: userId,
        content: content,
        image: image,
      );
      if (success) {
        await refreshPosts();
      } else {
        emit(const SocialError("Failed to create post."));
      }
    } catch (e) {
      emit(SocialError("Failed to create post: $e"));
    }
  }


  Future<void> reactToPost({
    required String postId,
    required String userId,
    required String reactionType,
  }) async {
    try {
      final isSuccess = await postRepository.reactToPost(
        postId: postId,
        userId: userId,
        reactionType: reactionType,
      );

      if (isSuccess) {
        final currentState = state;
        if (currentState is SocialPostsLoaded) {
          final updatedPosts = currentState.posts.map((post) {
            if (post.id == postId) {
              return reactionType == "like"
                  ? post.copyWith(
                      likes: [...post.likes, userId],
                      dislikes: post.dislikes..remove(userId),
                    )
                  : post.copyWith(
                      dislikes: [...post.dislikes, userId],
                      likes: post.likes..remove(userId),
                    );
            }
            return post;
          }).toList();
        }
      } else {
        emit(SocialError("Failed to react to post"));
      }
    } catch (e) {
      emit(SocialError("Failed to react to post: $e"));
    }
  }

  // Method to add a comment to a post
  Future<void> addComment({
    required String postId,
    required String userId,
    required String content,
  }) async {
    try {
      final userId = sharedPrefs.userId;
      if (userId == null) {
        throw Exception("User ID not found in Shared Preferences");
      }
      final isSuccess = await postRepository.addComment(
        postId: postId,
        userId: userId,
        content: content,
      );
      if (isSuccess) {
        emit(SocialCommentAdded(postId));
        // Refresh comments
        final posts = await postRepository.getAllPosts();
        emit(SocialPostsLoaded(posts));
      } else {
        emit(SocialError("Failed to add comment"));
      }
    } catch (e) {
      emit(SocialError("Failed to add comment: $e"));
    }
  }
}

// Method to delete a post
// Future<void> deletePost(String postId) async {
//   emit(SocialLoading());
//   try {
//     await postRepository.deletePost(postId);
//     emit(SocialPostDeleted(postId));
//     // Refresh posts after deletion
//     await fetchPosts();
//   } catch (e) {
//     emit(SocialError("Failed to delete post: $e"));
//   }
// }
