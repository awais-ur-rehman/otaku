class Anime {
  final int id;
  final String titleRomaji;
  final String titleEnglish;
  final String titleNative;
  final List<String> genres;
  final int episodes;
  final String description;
  final String coverImageLarge;
  final String coverImageMedium;
  final String coverImageColor;
  final String bannerImage;
  final String season;
  final int seasonYear;
  final String format;
  final String status;
  final int duration;
  final int averageScore;
  final int popularity;
  final List<String> studios;
  final List<Character> characters;

  Anime({
    required this.id,
    required this.titleRomaji,
    required this.titleEnglish,
    required this.titleNative,
    required this.genres,
    required this.episodes,
    required this.description,
    required this.coverImageLarge,
    required this.coverImageMedium,
    required this.coverImageColor,
    required this.bannerImage,
    required this.season,
    required this.seasonYear,
    required this.format,
    required this.status,
    required this.duration,
    required this.averageScore,
    required this.popularity,
    required this.studios,
    required this.characters,
  });

  // Factory constructor for creating an Anime object from JSON
  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      id: json['id'] as int,
      titleRomaji: json['title']['romaji'] as String,
      titleEnglish: json['title']['english'] as String? ?? "N/A",
      titleNative: json['title']['native'] as String,
      genres: List<String>.from(json['genres'] as List),
      episodes: json['episodes'] as int? ?? 0,
      description: json['description'] as String? ?? "No description available.",
      coverImageLarge: json['coverImage']['large'] as String,
      coverImageMedium: json['coverImage']['medium'] as String,
      coverImageColor: json['coverImage']['color'] as String? ?? "#000000",
      bannerImage: json['bannerImage'] as String? ?? "",
      season: json['season'] as String? ?? "Unknown",
      seasonYear: json['seasonYear'] as int? ?? 0,
      format: json['format'] as String? ?? "Unknown",
      status: json['status'] as String? ?? "Unknown",
      duration: json['duration'] as int? ?? 0,
      averageScore: json['averageScore'] as int? ?? 0,
      popularity: json['popularity'] as int? ?? 0,
      studios: (json['studios']['edges'] as List)
          .map((studio) => studio['node']['name'] as String)
          .toList(),
      characters: (json['characters']['edges'] as List)
          .map((char) => Character.fromJson(char['node']))
          .toList(),
    );
  }
}

class Character {
  final String name;
  final String imageUrl;

  Character({
    required this.name,
    required this.imageUrl,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name']['full'] as String,
      imageUrl: json['image']['large'] as String? ?? "",
    );
  }
}
