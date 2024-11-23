import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/forum_model.dart';

class ForumRepository {
  final String _baseUrl = 'http://your-api-url/api/forums';

  // Fetch all forums
  Future<List<Forum>> getAllForums() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body)['forums'];
        return jsonResponse.map((forum) => Forum.fromJson(forum)).toList();
      } else {
        throw Exception('Failed to load forums');
      }
    } catch (e) {
      print('Error fetching forums: $e');
      rethrow;
    }
  }

  // Create a new forum
  Future<Forum> createForum({
    required String name,
    required String description,
    required String topic,
    required String admin,
  }) async {
    try {
      final Map<String, String> body = {
        "name": name,
        "description": description,
        "topic": topic,
        "admin": admin,
      };

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body)['forum'];
        return Forum.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to create forum: ${response.body}');
      }
    } catch (e) {
      print('Error creating forum: $e');
      rethrow;
    }
  }

  // Join a forum
  Future<bool> joinForum(String forumId, String userId) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/$forumId/join'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"userId": userId}),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error joining forum: $e');
      return false;
    }
  }

  // Create a thread in a forum
  Future<bool> createThread({
    required String forumId,
    required String userId,
    required String content,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/$forumId/threads'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"userId": userId, "content": content}),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error creating thread: $e');
      return false;
    }
  }

  // React to a thread
  Future<bool> reactToThread({
    required String forumId,
    required String threadId,
    required String userId,
    required String reactionType,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/$forumId/threads/$threadId/react'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"userId": userId, "reactionType": reactionType}),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error reacting to thread: $e');
      return false;
    }
  }
}
