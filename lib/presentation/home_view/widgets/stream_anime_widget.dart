import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../data/model/stream_anime_model.dart';
import '../../../utils/colors/color.dart';
import '../../../utils/routes/route_names.dart';

class StreamAnimeWidget extends StatelessWidget {
  final List<StreamAnimeModel> streamAnime;

  const StreamAnimeWidget({super.key, required this.streamAnime});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    print(streamAnime.length);

    return streamAnime.isEmpty
        ? Center(
      child: Text(
        "No Anime Available",
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: screenWidth * 0.045,
          fontStyle: FontStyle.italic,
        ),
      ),
    )
        : SizedBox(
      height: screenHeight * 0.3,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: streamAnime.length,
        itemBuilder: (context, index) {
          final anime = streamAnime[index];
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
                    anime.image,
                    height: screenHeight * 0.18,
                    width: screenWidth * 0.35,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey,
                        child: Icon(
                          Icons.broken_image,
                          size: screenHeight * 0.1,
                          color: AppColors.textSecondary,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                // Anime Title
                Flexible(
                  child: Text(
                    "${anime.title} (${anime.releaseDate})",
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: screenWidth * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: screenHeight * 0.001),
                // Genres
                Flexible(
                  child: Text(
                    anime.genres.join(', '),
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: screenWidth * 0.03,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ).onTap(() {
            context.go(
              RouteNames.streamDetailRoute,
              extra: anime,
            );
          });
        },
      ),
    );
  }
}
