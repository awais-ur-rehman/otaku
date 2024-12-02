import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../model/stream_anime_model.dart';

class StreamAnimeRepo {
  final String baseUrl = 'https://otaku-streaming-server.onrender.com';

  Future<List<StreamAnimeModel>> fetchPopularAnime({int page = 1}) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/anime/popular?page=$page'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<StreamAnimeModel> animeList = [];
        for (var anime in data['results']) {
          final animeDetail = await fetchAnimeDetails(anime['id']);
          animeList.add(animeDetail);
        }

        return animeList;
      } else {
        throw Exception('Failed to fetch popular anime');
      }
    } catch (e) {
      throw Exception('Error fetching popular anime: $e');
    }
  }


  Future<StreamAnimeModel> fetchAnimeDetails(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/anime/info/$id'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return StreamAnimeModel.fromJson(data);
      } else {
        throw Exception('Failed to fetch anime details');
      }
    } catch (e) {
      print("Error in fetchAnimeDetails: $e"); // Debug log
      throw Exception('Error fetching anime details: $e');
    }
  }
}
