import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:otaku/utils/global/app_globals.dart';
import '../../model/post_model.dart';

class PostRepository {
  final String _baseUrl = "$api/api/posts";

  Future<List<Post>> getAllPosts() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body)['posts'];
        return jsonResponse.map((post) => Post.fromJson(post)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      rethrow;
    }
  }


  Future<bool> createPost({
    required String userId,
    required String content,
    String? image,
  }) async {
    try {
      final Map<String, dynamic> body = {
        "userId": userId,
        "content": content,
        "image": image,
      };

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['post'] != null &&
            jsonResponse['post'] is Map<String, dynamic>) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }


  Future<bool> reactToPost({
    required String postId,
    required String userId,
    required String reactionType,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/$postId/react'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"userId": userId, "reactionType": reactionType}),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addComment({
    required String postId,
    required String userId,
    required String content,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/$postId/comment'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"userId": userId, "content": content}),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
