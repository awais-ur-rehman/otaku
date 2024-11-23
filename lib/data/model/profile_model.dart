class ProfileModel {
  final String userId;
  final String? bio;
  final List<String>? favoriteGenres;
  final List<WatchHistory>? watchHistory;
  final SocialLinks? socialLinks;
  final String? avatar;

  ProfileModel({
    required this.userId,
    this.bio,
    this.favoriteGenres,
    this.watchHistory,
    this.socialLinks,
    this.avatar,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'bio': bio,
      'preferences': {
        'favoriteGenres': favoriteGenres,
        'watchHistory': watchHistory?.map((e) => e.toMap()).toList(),
      },
      'socialLinks': socialLinks?.toMap(),
      'avatar': avatar,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      userId: map['userId'],
      bio: map['bio'],
      favoriteGenres: List<String>.from(map['preferences']['favoriteGenres'] ?? []),
      watchHistory: map['preferences']['watchHistory'] != null
          ? List<WatchHistory>.from(map['preferences']['watchHistory']
          .map((e) => WatchHistory.fromMap(e)))
          : [],
      socialLinks: map['socialLinks'] != null
          ? SocialLinks.fromMap(map['socialLinks'])
          : null,
      avatar: map['avatar'],
    );
  }
}

class WatchHistory {
  final String animeId;
  final DateTime lastWatched;

  WatchHistory({required this.animeId, required this.lastWatched});

  Map<String, dynamic> toMap() {
    return {
      'animeId': animeId,
      'lastWatched': lastWatched.toIso8601String(),
    };
  }

  factory WatchHistory.fromMap(Map<String, dynamic> map) {
    return WatchHistory(
      animeId: map['animeId'],
      lastWatched: DateTime.parse(map['lastWatched']),
    );
  }
}

class SocialLinks {
  final String? twitter;
  final String? instagram;
  final String? website;

  SocialLinks({this.twitter, this.instagram, this.website});

  Map<String, dynamic> toMap() {
    return {
      'twitter': twitter,
      'instagram': instagram,
      'website': website,
    };
  }

  factory SocialLinks.fromMap(Map<String, dynamic> map) {
    return SocialLinks(
      twitter: map['twitter'],
      instagram: map['instagram'],
      website: map['website'],
    );
  }
}
