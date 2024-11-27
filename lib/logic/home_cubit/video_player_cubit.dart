import 'package:flutter_bloc/flutter_bloc.dart';
import 'video_player_states.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerCubit() : super(VideoPlayerInitial());

  Future<void> loadWebPage(String webUrl) async {
    emit(VideoPlayerLoading());
    try {
      if (webUrl.isEmpty) {
        throw Exception("Invalid web URL");
      }
      emit(VideoPlayerPlaying());
    } catch (e) {
      emit(VideoPlayerError(e.toString()));
    }
  }
}
