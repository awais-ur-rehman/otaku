import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../utils/global/app_globals.dart';
import '../../../utils/storage/shared_prefs.dart';
import '../../model/profile_model.dart';


class ProfileRepository {
  final String _baseUrl = '$api/api/profile';

  Future<bool> createOrUpdateProfile(ProfileModel profile) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/create'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(profile.toMap()),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final updatedProfile = ProfileModel.fromMap(jsonResponse['profile']);
        await sharedPrefs.saveProfile(updatedProfile);
        await sharedPrefs.setIsLoggedIn(true);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
