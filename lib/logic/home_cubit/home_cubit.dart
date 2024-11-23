import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otaku/data/repos/home_repo/Anime_repo.dart';

import '../../utils/global/app_globals.dart';
import '../../utils/storage/shared_prefs.dart';
import 'home_states.dart';


class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeLoading());

  final AnimeRepository animeRepository = AnimeRepository();

  Future<void> loadAnime() async {
    try {
      final genres = sharedPrefs.getProfile()?.favoriteGenres ?? [];
      if (anime.isEmpty) {
        anime.clear();
        await animeRepository.fetchAnimeByGenres(genres);
      }
      emit(HomeLoaded(anime));
    } catch (e) {
      emit(HomeError());
    }
  }

}
