import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otaku/logic/home_cubit/home_cubit.dart';
import 'package:otaku/logic/home_cubit/home_states.dart';
import 'package:otaku/presentation/home_view/widgets/anime_search.dart';
import 'package:otaku/presentation/home_view/widgets/anime_tile.dart';
import 'package:otaku/presentation/home_view/widgets/stream_anime_widget.dart';
import 'package:otaku/presentation/home_view/widgets/upcoming_anime_widget.dart';
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
    final homeCubit = context.read<HomeCubit>();
    homeCubit.loadAnime();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.02,
          horizontal: screenWidth * 0.02,
        ),
        child: BlocBuilder<HomeCubit, HomeStates>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                child: CustomLoader(
                  loaderColor: AppColors.accentPurple,
                ),
              );
            } else if (state is HomeError) {
              return const Center(
                child: Text(
                  "Error",
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else if (state is HomeLoaded || state is HomeSearchResults) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: screenWidth * 0.05,
                      left: screenHeight * 0.03,
                      right: screenHeight * 0.03,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimeSearchBar(
                          controller: homeCubit.searchController,
                          onSearch: (String query) {
                            homeCubit.searchAnime(query);
                          },
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipOval(
                              child: Container(
                                color: AppColors.primaryPurple,
                                width: 100,
                                height: 100,
                                child: sharedPrefs.getProfile()?.avatar != null
                                    ? Image.memory(
                                        base64Decode(
                                            sharedPrefs.getProfile()!.avatar!),
                                        fit: BoxFit.cover,
                                      )
                                    : const Icon(
                                        Icons.person,
                                        size: 50,
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
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
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          "Airing Today",
                          style: TextStyle(
                            color: AppColors.lightPurple,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        UpcomingAnimeWidget(upcomingAnime: upcomingAnime),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          "Watch Now",
                          style: TextStyle(
                            color: AppColors.lightPurple,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        StreamAnimeWidget(streamAnime: streamAnime),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          "Recommended",
                          style: TextStyle(
                            color: AppColors.lightPurple,
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: homeCubit.searchController.text.isEmpty
                              ? anime.length
                              : homeCubit.filteredAnime.length,
                          itemBuilder: (context, index) {
                            final animeList =
                                homeCubit.searchController.text.isEmpty
                                    ? anime[index]
                                    : homeCubit.filteredAnime[index];
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
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
