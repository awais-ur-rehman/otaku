import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otaku/logic/social_cubit/reaction_state.dart';

class ReactionCubit extends Cubit<ReactionState> {
  ReactionCubit() : super(const ReactionState());

  void toggleLike() {
    emit(ReactionState(
      isLiked: !state.isLiked,
      isDisliked: false,
    ));
  }

  void toggleDislike() {
    emit(ReactionState(
      isLiked: false,
      isDisliked: !state.isDisliked,
    ));
  }
}
