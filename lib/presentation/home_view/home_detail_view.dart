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
        title: Text(
          anime.titleEnglish,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  horizontal: screenWidth * 0.04,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      anime.titleEnglish != ""
                          ? anime.titleRomaji
                          : anime.titleNative,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      anime.genres.join(', '),
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: [
                        _infoChip('Episodes', anime.episodes.toString()),
                        _infoChip('Duration', '${anime.duration} mins'),
                        _infoChip('Popularity', anime.popularity.toString()),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      children: [
                        const Text(
                          'Average Score: ',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${anime.averageScore}%',
                          style: const TextStyle(
                            color: AppColors.accentPurple,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      children: [
                        _infoChip(
                            'Season', '${anime.season} ${anime.seasonYear}'),
                        _infoChip('Format', anime.format),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
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
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: anime.studios
                                .map(
                                  (studio) => Chip(
                                    backgroundColor: AppColors.darkGray,
                                    label: Text(
                                      studio,
                                      style: const TextStyle(
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    SizedBox(height: screenHeight * 0.02),
                    const Text(
                      'Description:',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      anime.description,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    if (anime.characters.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Characters:',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          SizedBox(
                            height: screenHeight * 0.25,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: anime.characters.length,
                              itemBuilder: (context, index) {
                                final character = anime.characters[index];
                                return _characterCard(
                                    character, screenWidth, screenHeight);
                              },
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.darkGray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        '$label: $value',
        style: const TextStyle(
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _characterCard(
      Character character, double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.only(right: screenWidth * 0.02),
      width: screenWidth * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              character.imageUrl,
              width: screenWidth * 0.28,
              height: screenHeight * 0.12,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          Text(
            character.name,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: screenWidth * 0.035,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
