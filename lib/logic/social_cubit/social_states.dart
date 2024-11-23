import 'package:equatable/equatable.dart';
import '../../data/model/post_model.dart';

abstract class SocialStates extends Equatable {
  const SocialStates();

  @override
  List<Object?> get props => [];
}

// Initial State
class SocialInitial extends SocialStates {}

// Loading States
class SocialLoading extends SocialStates {}

class SocialRefreshing extends SocialStates {}

// Loaded States
class SocialPostsLoaded extends SocialStates {
  final List<Post> posts;

  const SocialPostsLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

// Single Post Loaded (for detailed view or editing)
class SocialSinglePostLoaded extends SocialStates {
  final Post post;

  const SocialSinglePostLoaded(this.post);

  @override
  List<Object?> get props => [post];
}

// Post Created
class SocialPostCreated extends SocialStates {
  final Post post;

  const SocialPostCreated(this.post);

  @override
  List<Object?> get props => [post];
}

// Post Updated
class SocialPostUpdated extends SocialStates {
  final Post updatedPost;

  const SocialPostUpdated(this.updatedPost);

  @override
  List<Object?> get props => [updatedPost];
}

// Post Deleted
class SocialPostDeleted extends SocialStates {
  final String postId;

  const SocialPostDeleted(this.postId);

  @override
  List<Object?> get props => [postId];
}

// Like/Dislike State
class SocialReactionUpdated extends SocialStates {
  final String postId;
  final int likes;
  final int dislikes;

  const SocialReactionUpdated(this.postId, this.likes, this.dislikes);

  @override
  List<Object?> get props => [postId, likes, dislikes];
}

// Comment Added
class SocialCommentAdded extends SocialStates {
  final String postId;

  const SocialCommentAdded(this.postId);

  @override
  List<Object?> get props => [postId];
}

// Error States
class SocialError extends SocialStates {
  final String message;

  const SocialError(this.message);

  @override
  List<Object?> get props => [message];
}

// Empty State
class SocialEmpty extends SocialStates {
  final String message;

  const SocialEmpty(this.message);

  @override
  List<Object?> get props => [message];
}
