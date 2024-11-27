import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:otaku/data/model/stream_anime_model.dart';
import 'package:otaku/utils/colors/color.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/routes/route_names.dart';

class StreamDetailScreen extends StatelessWidget {
  final StreamAnimeModel streamAnime;

  const StreamDetailScreen({super.key, required this.streamAnime});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
          streamAnime.title,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.02,
          horizontal: screenWidth * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Anime Cover and Details
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cover Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    streamAnime.image,
                    height: screenHeight * 0.25,
                    width: screenWidth * 0.4,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: screenHeight * 0.25,
                        width: screenWidth * 0.4,
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
                SizedBox(width: screenWidth * 0.03),
                // Anime Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        streamAnime.title,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'Episodes: ${streamAnime.episodes.length}',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        streamAnime.description.toString(),
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: screenWidth * 0.035,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            // Episodes List
            Text(
              'Episodes',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: ListView.builder(
                itemCount: streamAnime.episodes.length,
                itemBuilder: (context, index) {
                  final episode = streamAnime.episodes[index];
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Episode Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Episode ${index + 1}',
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: screenHeight * 0.005),
                              Text(
                                episode.episodeTitle.isNotEmpty
                                    ? episode.episodeTitle
                                    : 'No Title Available',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: screenWidth * 0.035,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        // Play Button
                        IconButton(
                          onPressed: () {
                            _streamEpisode(context, episode.url);
                          },
                          icon: const Icon(Icons.play_circle_fill),
                          color: AppColors.accentPurple,
                          iconSize: screenWidth * 0.08,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _streamEpisode(BuildContext context, String streamUrl) async {
    if (streamUrl.isNotEmpty) {
      final Uri url = Uri.parse(streamUrl);
      try {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: AppColors.primaryPurple,
              title: const Text(
                'Unable to Open Link',
                style: TextStyle(color: AppColors.textPrimary),
              ),
              content: const Text(
                'This link cannot be opened right now.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Close',
                    style: TextStyle(color: AppColors.accentPurple),
                  ),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.primaryPurple,
            title: const Text(
              'Stream Not Available',
              style: TextStyle(color: AppColors.textPrimary),
            ),
            content: const Text(
              'This episode cannot be streamed right now.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Close',
                  style: TextStyle(color: AppColors.accentPurple),
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
