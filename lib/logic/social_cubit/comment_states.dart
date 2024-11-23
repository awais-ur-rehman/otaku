import 'package:equatable/equatable.dart';

import '../../data/model/post_model.dart';

class CommentState extends Equatable {
  final bool isLoading;
  final List<Comment> comments;
  final String? errorMessage;

  const CommentState({
    this.isLoading = false,
    this.comments = const [],
    this.errorMessage,
  });

  CommentState copyWith({
    bool? isLoading,
    List<Comment>? comments,
    String? errorMessage,
  }) {
    return CommentState(
      isLoading: isLoading ?? this.isLoading,
      comments: comments ?? this.comments,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, comments, errorMessage];
}
