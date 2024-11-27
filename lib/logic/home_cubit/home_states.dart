import 'package:equatable/equatable.dart';

import '../../data/model/anime_model.dart';

abstract class HomeStates extends Equatable {
  const HomeStates();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeStates {}

class HomeLoaded extends HomeStates {
  final List<Anime> anime;

  const HomeLoaded(this.anime);

  @override
  List<Object> get props => [anime];
}

class HomeSearchResults extends HomeStates {
  final List<Anime> searchResults;

  const HomeSearchResults(this.searchResults);

  @override
  List<Object> get props => [searchResults];
}


class HomeError extends HomeStates {}

