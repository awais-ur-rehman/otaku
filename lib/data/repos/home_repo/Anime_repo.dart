import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../utils/global/app_globals.dart';
import '../../model/anime_model.dart';

class AnimeRepository {
  final String _baseUrl = 'https://graphql.anilist.co';

  Future<void> fetchAnimeByGenres(List<String> genres) async {
    const String query = """
    query (\$genres: [String]) {
      Page {
        media(genre_in: \$genres, type: ANIME) {
          id
          title {
            romaji
            english
            native
          }
          genres
          episodes
          description
          coverImage {
            large
            medium
            color
          }
          bannerImage
          season
          seasonYear
          format
          status
          duration
          averageScore
          popularity
          studios {
            edges {
              node {
                name
              }
            }
          }
          characters {
            edges {
              node {
                name {
                  full
                }
                image {
                  large
                }
              }
              voiceActors {
                name {
                  full
                }
                language
              }
            }
          }
        }
      }
    }
    """;

    try {
      final Map<String, dynamic> body = {
        "query": query,
        "variables": {"genres": genres},
      };

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> mediaList = jsonResponse['data']['Page']['media'] ?? [];
        anime = mediaList.map((anime) => Anime.fromJson(anime)).toList();
      } else {
        throw Exception('Failed to load anime data');
      }
    } catch (e) {
      print('Error fetching anime: $e');
      rethrow;
    }
  }
}
