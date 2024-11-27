import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otaku/data/repos/home_repo/Anime_repo.dart';
import 'package:otaku/data/repos/home_repo/stream_repo.dart';
import '../../data/model/anime_model.dart';
import '../../utils/global/app_globals.dart';
import '../../utils/storage/shared_prefs.dart';
import 'home_states.dart';


class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeLoading());

  final AnimeRepository animeRepository = AnimeRepository();
  final StreamAnimeRepo streamAnimeRepo = StreamAnimeRepo();
  final searchController = TextEditingController();
  List<Anime> filteredAnime = [];

  Future<void> loadAnime() async {
    try {
      final genres = sharedPrefs.getProfile()?.favoriteGenres ?? [];
      if (anime.isEmpty) {
        anime.clear();
        await animeRepository.fetchAnimeByGenres(genres);
      }
      if(upcomingAnime.isEmpty){
        upcomingAnime.clear();
        await animeRepository.fetchCountDown();
      }
      if(streamAnime.isEmpty){
        streamAnime.clear();
        final popularAnime = await streamAnimeRepo.fetchPopularAnime();
        streamAnime.addAll(popularAnime);
      }

      emit(HomeLoaded(anime));
    } catch (e) {
      emit(HomeError());
    }
  }

  void searchAnime(String query) {
    if (query.isEmpty) {
      filteredAnime = [];
    } else {
      filteredAnime = anime
          .where((a) =>
      a.titleEnglish.toLowerCase().startsWith(query.toLowerCase()) ||
          a.titleRomaji.toLowerCase().startsWith(query.toLowerCase()) ||
          a.titleNative.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    }
    emit(HomeSearchResults(filteredAnime));
  }
}
