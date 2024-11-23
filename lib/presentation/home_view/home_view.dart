import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otaku/logic/home_cubit/home_cubit.dart';
import 'package:otaku/logic/home_cubit/home_states.dart';
import 'package:otaku/presentation/home_view/widgets/anime_tile.dart';
import 'package:otaku/utils/colors/color.dart';
import 'package:otaku/utils/global/app_globals.dart';

import '../../data/model/user_model.dart';
import '../../utils/storage/shared_prefs.dart';
import '../../widgets/cstm_loader.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel? user = sharedPrefs.getUser();
    context.read<HomeCubit>().loadAnime();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.02, horizontal: screenWidth * 0.02),
        child: SizedBox(
          width: screenWidth,
          child: BlocBuilder<HomeCubit, HomeStates>(builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                child: CustomLoader(
                  loaderColor: AppColors.accentPurple,
                ),
              );
            } else if (state is HomeError) {
              return const Center(
                child: Text("Error"),
              );
            } else if (state is HomeLoaded) {
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: screenWidth * 0.05,
                    left: screenHeight * 0.03,
                    right: screenHeight * 0.03,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "KONICHIWA",
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                user!.username,
                                style: TextStyle(
                                  color: AppColors.accentPurple,
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          ClipOval(
                            child: Container(
                              color: AppColors.primaryPurple,
                              width: 100,
                              height: 100,
                              child: sharedPrefs.getProfile()?.avatar != null
                                  ? Image.memory(
                                base64Decode(sharedPrefs.getProfile()!.avatar!),
                                fit: BoxFit.cover,
                              )
                                  : const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: anime.length,
                          itemBuilder: (context, index) {
                            final animeList = anime[index];
                            return AnimeTile(
                              title: animeList.titleEnglish ??
                                  animeList.titleRomaji ??
                                  animeList.titleNative,
                              description: animeList.description,
                              genres: animeList.genres,
                              coverImage: animeList.coverImageMedium,
                              anime: animeList,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Container();
          }),
        ),
      ),
    );
  }
}
