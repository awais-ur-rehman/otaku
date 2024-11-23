import 'package:equatable/equatable.dart';

class ReactionState extends Equatable {
  final bool isLiked;
  final bool isDisliked;

  const ReactionState({this.isLiked = false, this.isDisliked = false});

  ReactionState copyWith({bool? isLiked, bool? isDisliked}) {
    return ReactionState(
      isLiked: isLiked ?? this.isLiked,
      isDisliked: isDisliked ?? this.isDisliked,
    );
  }

  @override
  List<Object> get props => [isLiked, isDisliked];
}
