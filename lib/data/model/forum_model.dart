import 'package:equatable/equatable.dart';

class Forum extends Equatable {
  final String id;
  final String name;
  final String description;
  final String topic;
  final String admin;
  final List<String> members;
  final List<Thread> threads;
  final DateTime createdAt;

  Forum({
    required this.id,
    required this.name,
    required this.description,
    required this.topic,
    required this.admin,
    required this.members,
    required this.threads,
    required this.createdAt,
  });

  // Factory method to create a Forum from JSON
  factory Forum.fromJson(Map<String, dynamic> json) {
    return Forum(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      topic: json['topic'] as String,
      admin: json['admin'] as String,
      members: List<String>.from(json['members'] ?? []),
      threads: (json['threads'] as List<dynamic>)
          .map((thread) => Thread.fromJson(thread))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // Convert a Forum to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'topic': topic,
      'admin': admin,
      'members': members,
      'threads': threads.map((thread) => thread.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props =>
      [id, name, description, topic, admin, members, threads, createdAt];
}

// Thread model for forums
class Thread extends Equatable {
  final String userId;
  final String content;
  final List<String> likes;
  final List<String> dislikes;
  final DateTime createdAt;

  Thread({
    required this.userId,
    required this.content,
    required this.likes,
    required this.dislikes,
    required this.createdAt,
  });

  // Factory method to create a Thread from JSON
  factory Thread.fromJson(Map<String, dynamic> json) {
    return Thread(
      userId: json['userId'] as String,
      content: json['content'] as String,
      likes: List<String>.from(json['likes'] ?? []),
      dislikes: List<String>.from(json['dislikes'] ?? []),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // Convert a Thread to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'content': content,
      'likes': likes,
      'dislikes': dislikes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [userId, content, likes, dislikes, createdAt];
}
