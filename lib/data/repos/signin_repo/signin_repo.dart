import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../utils/storage/shared_prefs.dart';
import '../../model/profile_model.dart';
import '../../model/user_model.dart';

class SigninRepository {
  final String _baseUrl = 'http://192.168.100.169:8080/api/user';

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final Map<String, String> body = {
        "email": email,
        "password": password,
      };

      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Parse user data
        final userData = jsonResponse['user'];
        final user = UserModel(
          id: userData['id'],
          username: userData['username'],
          email: userData['email'],
        );
        final profileData = jsonResponse['profile'];
        final profile = profileData != null
            ? ProfileModel.fromMap(profileData)
            : ProfileModel(
          userId: user.id,
          bio: "",
          favoriteGenres: [],
          watchHistory: [],
          socialLinks: SocialLinks(),
          avatar: "",
        );
        await sharedPrefs.clearUserData();
        await sharedPrefs.clearProfile();
        await sharedPrefs.saveUser(user);
        await sharedPrefs.saveProfile(profile);

        return true;
      } else {
        print('Signup failed: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error during signup: $e');
      return false;
    }
  }
}
