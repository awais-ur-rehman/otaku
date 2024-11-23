import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:otaku/utils/colors/color.dart';
import 'package:otaku/utils/routes/route_names.dart';
import '../../data/model/anime_model.dart';

class AnimeDetailView extends StatelessWidget {
  final Anime anime;
  const AnimeDetailView({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        leading: InkWell(
          onTap: () {
            context.go(RouteNames.homeRoute);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner Image or Placeholder
                ClipRRect(
                  child: anime.coverImageLarge.isNotEmpty
                      ? Image.network(
                    anime.coverImageLarge,
                    width: screenWidth,
                    height: screenHeight * 0.3,
                    fit: BoxFit.cover,
                  )
                      : Container(
                    width: screenWidth,
                    height: screenHeight * 0.3,
                    color: AppColors.darkGray,
                    child: const Center(
                      child: Text(
                        'No Banner Available',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.01,
                    horizontal: screenWidth * 0.04,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        anime.titleEnglish,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
        
                      // Genres
                      Text(
                        anime.genres.join(', '),
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
        
                      // Episodes
                      Row(
                        children: [
                          const Text(
                            'Episodes: ',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            anime.episodes.toString(),
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: screenWidth * 0.035,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.01),
        
                      // Season and Year
                      Row(
                        children: [
                          const Text(
                            'Season: ',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${anime.season} ${anime.seasonYear}',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: screenWidth * 0.035,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.01),
        
                      // Format
                      Row(
                        children: [
                          const Text(
                            'Format: ',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            anime.format,
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: screenWidth * 0.035,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.01),
        
                      // Status
                      Row(
                        children: [
                          const Text(
                            'Status: ',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            anime.status,
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: screenWidth * 0.035,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.01),
        
                      // Studios
                      if (anime.studios.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Studios:',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            ...anime.studios.map(
                                  (studio) => Text(
                                studio,
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: screenWidth * 0.035,
                                ),
                              ),
                            ),
                          ],
                        ),
                      SizedBox(height: screenHeight * 0.02),
        
                      // Description
                      Text(
                        anime.description,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
