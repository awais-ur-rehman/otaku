import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:otaku/utils/routes/route_names.dart';

import '../../../data/model/anime_model.dart';
import '../../../utils/colors/color.dart';

class AnimeTile extends StatelessWidget {
  final String title;
  final String description;
  final List<String> genres;
  final String coverImage;
  final Anime anime;

  const AnimeTile({
    super.key,
    required this.title,
    required this.description,
    required this.genres,
    required this.coverImage,
    required this.anime,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.02), // Gap between tiles
      padding: EdgeInsets.all(screenWidth * 0.03), // Inner padding for content
      decoration: BoxDecoration(
        color: AppColors.primaryPurple, // Background color
        borderRadius: BorderRadius.circular(10), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            blurRadius: 5, // Shadow blur
            offset: const Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: InkWell(
        onTap: (){
            context.go(
                RouteNames.animeDetailRoute,
              extra: anime,
            );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8), // Rounded image corners
              child: Image.network(
                coverImage,
                height: screenHeight * 0.2, // Adjusted size
                width: screenWidth * 0.2,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: screenWidth * 0.03), // Spacing between image and text
            // Anime Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: screenWidth * 0.04, // Adjusted font size
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenHeight * 0.01), // Spacing between title and genres
                  // Genres
                  Text(
                    genres.join(', '), // Display genres as comma-separated
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: screenWidth * 0.035,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenHeight * 0.01), // Spacing between genres and description
                  // Description
                  Text(
                    description,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: screenWidth * 0.03,
                    ),
                    maxLines: 3, // Limit description lines
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
