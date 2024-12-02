import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../utils/global/app_globals.dart';
import '../../../utils/storage/shared_prefs.dart';
import '../../model/user_model.dart';

class SignupRepository {
  final String _baseUrl = '$api/api/user';

  Future<bool> createUser({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final Map<String, String> body = {
        "username": username,
        "email": email,
        "password": password,
      };

      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final userData = jsonResponse['user'];
        final user = UserModel(
          id: userData['id'],
          username: userData['username'],
          email: userData['email'],
        );
        await sharedPrefs.saveUser(user);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
