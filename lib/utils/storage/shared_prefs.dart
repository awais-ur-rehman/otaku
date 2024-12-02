import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../data/model/profile_model.dart';
import '../../data/model/user_model.dart';

class SharedPrefs {
  static late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get isLoggedIn => _prefs.getBool('isLoggedIn') ?? false;

  Future<void> setIsLoggedIn(bool status) async {
    await _prefs.setBool('isLoggedIn', status);
  }

  Future<void> saveUser(UserModel user) async {
    await _prefs.setString('userId', user.id);
    await _prefs.setString('username', user.username);
    await _prefs.setString('email', user.email);
    await setIsLoggedIn(true);
  }

  String? get userId => _prefs.getString('userId');

  UserModel? getUser() {
    final id = _prefs.getString('userId');
    final username = _prefs.getString('username');
    final email = _prefs.getString('email');

    if (id != null && username != null && email != null) {
      return UserModel(id: id, username: username, email: email);
    }
    return null;
  }

  Future<void> clearUserData() async {
    await _prefs.remove('userId');
    await _prefs.remove('username');
    await _prefs.remove('email');
    await setIsLoggedIn(false);
  }

  Future<void> saveProfile(ProfileModel profile) async {
    await _prefs.setString('profile', json.encode(profile.toMap()));
  }

  ProfileModel? getProfile() {
    final profileData = _prefs.getString('profile');
    if (profileData != null) {
      return ProfileModel.fromMap(json.decode(profileData));
    }
    return null;
  }

  Future<void> clearProfile() async {
    await _prefs.remove('profile');
  }
}

final sharedPrefs = SharedPrefs();
