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
      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
      padding: EdgeInsets.all(screenWidth * 0.03),
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
      child: InkWell(
        onTap: () {
          context.go(
            RouteNames.animeDetailRoute,
            extra: anime,
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                coverImage,
                height: screenHeight * 0.2,
                width: screenWidth * 0.2,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: screenWidth * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    genres.join(', '),
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: screenWidth * 0.035,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    description,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: screenWidth * 0.03,
                    ),
                    maxLines: 3,
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
