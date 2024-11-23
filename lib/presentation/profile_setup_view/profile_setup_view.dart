import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:otaku/logic/profile_setup_cubit/profile_setup_cubit.dart';
import 'package:otaku/logic/profile_setup_cubit/profile_setup_states.dart';
import 'package:otaku/utils/colors/color.dart';

import '../../utils/routes/route_names.dart';
import '../../widgets/cstm_loader.dart';
import '../auth_view/widgets/cstm_flat_button.dart';

class ProfileSetupView extends StatelessWidget {
  const ProfileSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    print("reload");
    final profileSetupCubit = context.read<ProfileSetupCubit>();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    profileSetupCubit.loadProfileSetupScreen();
    return Scaffold(
      backgroundColor: AppColors.black,
      body: BlocBuilder<ProfileSetupCubit, ProfileSetupStates>(
        builder: (context, state) {
          if (state is ProfileSetupLoading) {
            return const Center(child: CustomLoader(loaderColor: AppColors.accentPurple,));
          } else if (state is ProfileSetupError) {
            return const Center(child: Text("An error occurred. Please try again."));
          } else if (state is ProfileSetupLoaded) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02, horizontal: screenWidth * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: InkWell(
                          onTap: () => profileSetupCubit.pickAvatar(),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: profileSetupCubit.avatarBase64 != null
                                ? MemoryImage(
                                base64Decode(profileSetupCubit.avatarBase64!))
                                : null,
                            child: profileSetupCubit.avatarBase64 == null
                                ? const Icon(Icons.camera_alt, size: 50)
                                : null,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      // Bio
                      TextField(
                        controller: profileSetupCubit.bioController,
                        decoration: const InputDecoration(
                          labelText: "Bio",
                          labelStyle: TextStyle(
                            color: AppColors.textPrimary,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        maxLength: 200,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: screenWidth * 0.04
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      // Genre Selection
                      Text("Select Preferences:",
                        style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: screenWidth * 0.04
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: profileSetupCubit.predefinedGenres.map((genre) {
                          final isSelected = profileSetupCubit.selectedGenres.contains(genre);
                          return GestureDetector(
                            onTap: () => profileSetupCubit.toggleGenre(genre),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.deepPurple : Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                genre,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      // Social Links
                      TextField(
                        controller: profileSetupCubit.twitterController,
                        decoration: const InputDecoration(
                          labelText: "Twitter",
                          labelStyle: TextStyle(
                            color: AppColors.textPrimary,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: screenWidth * 0.04
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      TextField(
                        controller: profileSetupCubit.instagramController,
                        decoration: const InputDecoration(
                          labelText: "Instagram",
                          labelStyle: TextStyle(
                            color: AppColors.textPrimary,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: screenWidth * 0.04
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      TextField(
                        controller: profileSetupCubit.websiteController,
                        decoration: const InputDecoration(
                          labelText: "Website",
                          labelStyle: TextStyle(
                            color: AppColors.textPrimary,
                          ),
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: screenWidth * 0.04
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
              
                      // Save Button
                      Center(
                        child: CustomFlatButton(
                          text: "Save Profile",
                          btnColor: Colors.deepPurple,
                          onTap: () async {
                            final success = await profileSetupCubit.setupProfile();
                            if (success) {
                              if(context.mounted){
                                context.go(RouteNames.homeRoute);
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Failed to update profile.")),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
