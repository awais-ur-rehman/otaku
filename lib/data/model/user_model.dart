class UserModel {
  final String id;
  final String username;
  final String email;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
  });

  // Convert UserModel to a Map for saving to SharedPreferences
  Map<String, String> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }

  // Create a UserModel instance from a Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, email: $email)';
  }
}
