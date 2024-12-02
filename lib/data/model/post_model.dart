import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String id;
  final User user;
  final String content;
  final String? image;
  final List<String> likes;
  final List<String> dislikes;
  final List<Comment> comments;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.user,
    required this.content,
    this.image,
    required this.likes,
    required this.dislikes,
    required this.comments,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'] as String? ?? '',
      user: User.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
      content: json['content'] as String? ?? '',
      image: json['image'] as String?,
      likes: List<String>.from(json['likes'] ?? []),
      dislikes: List<String>.from(json['dislikes'] ?? []),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((comment) => Comment.fromJson(comment))
          .toList() ??
          [],
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user.toJson(),
      'content': content,
      'image': image,
      'likes': likes,
      'dislikes': dislikes,
      'comments': comments.map((comment) => comment.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  Post copyWith({
    String? id,
    User? user,
    String? content,
    String? image,
    List<String>? likes,
    List<String>? dislikes,
    List<Comment>? comments,
    DateTime? createdAt,
  }) {
    return Post(
      id: id ?? this.id,
      user: user ?? this.user,
      content: content ?? this.content,
      image: image ?? this.image,
      likes: likes ?? this.likes,
      dislikes: dislikes ?? this.dislikes,
      comments: comments ?? this.comments,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props =>
      [id, user, content, image, likes, dislikes, comments, createdAt];
}

class User extends Equatable {
  final String id;
  final String username;
  final String? avatar;

  const User({
    required this.id,
    required this.username,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String? ?? '',
      username: json['username'] as String? ?? 'Unknown User',
      avatar: json['avatar'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'avatar': avatar,
    };
  }

  @override
  List<Object?> get props => [id, username, avatar];
}

class Comment extends Equatable {
  final String userId;
  final String username;
  final String? avatar;
  final String content;
  final DateTime createdAt;

  const Comment({
    required this.userId,
    required this.username,
    this.avatar,
    required this.content,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      userId: json['userId'] as String? ?? '',
      username: json['username'] as String? ?? 'Unknown User',
      avatar: json['avatar'] as String?,
      content: json['content'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'avatar': avatar,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [userId, username, avatar, content, createdAt];
}
