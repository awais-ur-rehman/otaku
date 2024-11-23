import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otaku/logic/social_cubit/social_cubit.dart';
import 'package:otaku/logic/social_cubit/social_states.dart';

import '../../data/model/post_model.dart';
import '../../utils/storage/shared_prefs.dart';
import 'comment_states.dart';

class CommentCubit extends Cubit<CommentState> {
  final SocialCubit socialCubit;

  CommentCubit({required this.socialCubit}) : super(const CommentState());

  // Load comments for a specific post from the SocialCubit state
  void loadComments(String postId) {
    emit(state.copyWith(isLoading: true));
    try {
      final currentState = socialCubit.state;
      if (currentState is SocialPostsLoaded) {
        final post = currentState.posts.firstWhere((post) => post.id == postId);
        emit(state.copyWith(isLoading: false, comments: post.comments));
      } else {
        emit(state.copyWith(isLoading: false, errorMessage: "Posts not loaded in SocialCubit"));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: "Failed to load comments: $e"));
    }
  }

  // Add a new comment and update the SocialCubit state
  Future<void> addComment({
    required String postId,
    required String userId,
    required String content,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      final isSuccess = await socialCubit.postRepository.addComment(
        postId: postId,
        userId: userId,
        content: content,
      );

      if (isSuccess) {
        final currentState = socialCubit.state;
        if (currentState is SocialPostsLoaded) {
          final updatedPosts = currentState.posts.map((post) {
            if (post.id == postId) {
              final updatedComments = [
                ...post.comments,
                Comment(
                  userId: userId,
                  content: content,
                  createdAt: DateTime.now(),
                  username: sharedPrefs.getUser()!.username,
                  avatar: sharedPrefs.getProfile()!.avatar,
                ),
              ];
              return post.copyWith(comments: updatedComments);
            }
            return post;
          }).toList();
          socialCubit.emit(SocialPostsLoaded(updatedPosts));
          loadComments(postId);
        } else {
          emit(state.copyWith(isLoading: false, errorMessage: "SocialCubit state update failed"));
        }
      } else {
        emit(state.copyWith(isLoading: false, errorMessage: "Failed to add comment"));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: "Failed to add comment: $e"));
    }
  }
}
