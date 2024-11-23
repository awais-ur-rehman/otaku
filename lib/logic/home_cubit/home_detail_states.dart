import 'package:equatable/equatable.dart';

import '../../data/model/anime_model.dart';

abstract class HomeDetailStates extends Equatable {
  const HomeDetailStates();

  @override
  List<Object> get props => [];
}

class HomeDetailLoading extends HomeDetailStates {}

class HomeDetailLoaded extends HomeDetailStates {
  final List<Anime> anime;

  const HomeDetailLoaded(this.anime);

  @override
  List<Object> get props => [anime];
}

class HomeDetailError extends HomeDetailStates {}

