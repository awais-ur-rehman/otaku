class StreamAnimeModel {
  final String id;
  final String title;
  final String description;
  final String image;
  final List<Episode> episodes;
  final List<String> genres;
  final String releaseDate;
  final int totalEpisodes;

  StreamAnimeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.episodes,
    required this.genres,
    required this.releaseDate,
    required this.totalEpisodes,
  });

  factory StreamAnimeModel.fromJson(Map<String, dynamic> json) {
    return StreamAnimeModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      genres: List<String>.from(json['genres'] ?? []),
      releaseDate: json['releaseDate'] ?? '',
      totalEpisodes: json['totalEpisodes'] ?? 0,
      episodes: (json['episodes'] as List<dynamic>)
          .map((episode) => Episode.fromJson(episode))
          .toList(),
    );
  }
}

class Episode {
  final String episodeId;
  final String episodeTitle;
  final String url;

  Episode({
    required this.episodeId,
    required this.episodeTitle,
    required this.url,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      episodeId: json['episodeId'] ?? '',
      episodeTitle: json['title'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
