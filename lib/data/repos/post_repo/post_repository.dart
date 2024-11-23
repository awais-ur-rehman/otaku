import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:otaku/utils/storage/shared_prefs.dart';
import '../../model/post_model.dart';

class PostRepository {
  final String _baseUrl = 'http://192.168.100.169:8080/api/posts';

  // Fetch all posts
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
      print('Error fetching posts: $e');
      rethrow;
    }
  }


// Create a new post
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

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

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



  // React to a post
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
      print('Error reacting to post: $e');
      return false;
    }
  }

  // Add a comment to a post
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
      print('Error adding comment: $e');
      return false;
    }
  }
}
