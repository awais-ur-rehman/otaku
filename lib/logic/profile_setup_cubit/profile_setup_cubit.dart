import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:otaku/data/repos/profile_repository/profile_repository.dart';
import 'package:otaku/logic/profile_setup_cubit/profile_setup_states.dart';
import 'package:otaku/utils/storage/shared_prefs.dart';
import '../../data/model/profile_model.dart';

class ProfileSetupCubit extends Cubit<ProfileSetupStates> {
  ProfileSetupCubit() : super(ProfileSetupLoading());

  final ProfileRepository profileRepo = ProfileRepository();

  // Controllers for user inputs
  final bioController = TextEditingController();
  final twitterController = TextEditingController();
  final instagramController = TextEditingController();
  final websiteController = TextEditingController();

  // State variables
  String? avatarBase64;
  final List<String> predefinedGenres = [
    "Action",
    "Adventure",
    "Comedy",
    "Drama",
    "Fantasy",
    "Horror",
    "Mystery",
    "Romance",
    "Sci-Fi",
    "Slice of Life"
  ];
  final List<String> selectedGenres = [];

  // Load profile setup screen
  void loadProfileSetupScreen() {
    emit(ProfileSetupLoaded());
  }

  // Handle avatar upload
  Future<void> pickAvatar() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final bytes = await pickedImage.readAsBytes();
      avatarBase64 = base64Encode(bytes);
      emit(ProfileSetupLoaded());
    }
  }

  // Toggle genre selection
  void toggleGenre(String genre) {
    emit(ProfileSetupLoading());
    if (selectedGenres.contains(genre)) {
      selectedGenres.remove(genre);
    } else {
      selectedGenres.add(genre);
    }
    emit(ProfileSetupLoaded());
  }

  // Dispose controllers
  void disposeControllers() {
    bioController.dispose();
    twitterController.dispose();
    instagramController.dispose();
    websiteController.dispose();
  }

  // Submit profile setup
  Future<bool> setupProfile() async {
    emit(ProfileSetupLoading());
    try {
      final userId = sharedPrefs.userId;
      if (userId == null) {
        throw Exception("User ID not found in Shared Preferences");
      }

      // Create a ProfileModel instance
      final profile = ProfileModel(
        userId: userId,
        bio: bioController.text,
        favoriteGenres: selectedGenres,
        socialLinks: SocialLinks(
          twitter: twitterController.text,
          instagram: instagramController.text,
          website: websiteController.text,
        ),
        avatar: avatarBase64,
      );

      // Send data to the repository
      final success = await profileRepo.createOrUpdateProfile(profile);

      if (success) {
        emit(ProfileSetupLoaded());
        return true;
      } else {
        emit(ProfileSetupError());
        return false;
      }
    } catch (e) {
      emit(ProfileSetupError());
      return false;
    }
  }
}
