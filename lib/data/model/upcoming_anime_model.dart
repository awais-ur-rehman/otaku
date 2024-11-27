import 'package:equatable/equatable.dart';

class UpcomingAnimeModel extends Equatable {
  final int id;
  final int episode;
  final int airingAt;
  final String title;
  final String? coverImage;

  UpcomingAnimeModel({
    required this.id,
    required this.episode,
    required this.airingAt,
    required this.title,
    this.coverImage,
  });

  factory UpcomingAnimeModel.fromJson(Map<String, dynamic> json) {
    final media = json['media'];
    return UpcomingAnimeModel(
      id: json['id'] as int,
      episode: json['episode'] as int,
      airingAt: json['airingAt'] as int,
      title: media['title']['romaji'] ?? media['title']['english'] ?? '',
      coverImage: media['coverImage']?['large'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'episode': episode,
      'airingAt': airingAt,
      'title': title,
      'coverImage': coverImage,
    };
  }

  @override
  List<Object?> get props => [id, episode, airingAt, title, coverImage];
}
