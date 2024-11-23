import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otaku/utils/global/app_globals.dart';
import '../../data/model/anime_model.dart';
import 'home_detail_states.dart';

class HomeDetailCubit extends Cubit<HomeDetailStates> {
  HomeDetailCubit() : super(HomeDetailLoaded(anime));

  Future<void> loadDetail(List<Anime> anime) async {
    try {
      emit(HomeDetailLoaded(anime));
    } catch (e) {
      emit(HomeDetailError());
    }
  }

}
