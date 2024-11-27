import 'package:equatable/equatable.dart';

abstract class VideoPlayerState extends Equatable {
  const VideoPlayerState();

  @override
  List<Object?> get props => [];
}

class VideoPlayerInitial extends VideoPlayerState {}

class VideoPlayerLoading extends VideoPlayerState {}

class VideoPlayerPlaying extends VideoPlayerState {}

class VideoPlayerError extends VideoPlayerState {
  final String message;

  const VideoPlayerError(this.message);

  @override
  List<Object?> get props => [message];
}
