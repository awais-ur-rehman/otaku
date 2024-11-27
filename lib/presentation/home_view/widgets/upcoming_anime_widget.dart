import 'package:flutter/material.dart';
import 'package:otaku/utils/colors/color.dart';

import '../../../data/model/upcoming_anime_model.dart';

class UpcomingAnimeWidget extends StatelessWidget {
  final List<UpcomingAnimeModel> upcomingAnime;

  const UpcomingAnimeWidget({
    super.key,
    required this.upcomingAnime,
  });

  String _formatCountdown(int airingAt) {
    final timeLeft = DateTime.fromMillisecondsSinceEpoch(airingAt * 1000).difference(DateTime.now());
    if (timeLeft.isNegative) {
      return 'Aired';
    } else if (timeLeft.inHours > 0) {
      return '${timeLeft.inHours}h ${timeLeft.inMinutes.remainder(60)}m';
    } else {
      return '${timeLeft.inMinutes}m';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return upcomingAnime.isEmpty
        ? Container()
        : Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
      child: SizedBox(
        height: screenHeight * 0.25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: upcomingAnime.length,
          itemBuilder: (context, index) {
            final anime = upcomingAnime[index];
            return Container(
              width: screenWidth * 0.4,
              margin: EdgeInsets.only(right: screenWidth * 0.03),
              padding: EdgeInsets.all(screenWidth * 0.02),
              decoration: BoxDecoration(
                color: AppColors.primaryPurple,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cover Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      anime.coverImage ?? '',
                      height: screenHeight * 0.15,
                      width: screenWidth * 0.35,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey,
                          child: Icon(Icons.broken_image, size: screenHeight * 0.1),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  // Title
                  Text(
                    anime.title,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  // Countdown Timer
                  Text(
                    'Airing in: ${_formatCountdown(anime.airingAt)}',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: screenWidth * 0.03,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
