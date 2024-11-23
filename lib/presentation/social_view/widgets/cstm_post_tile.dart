import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:otaku/data/model/post_model.dart';
import 'package:otaku/utils/colors/color.dart';
import '../../../logic/social_cubit/reaction_cubit.dart';
import '../../../logic/social_cubit/reaction_state.dart';
import '../../../logic/social_cubit/social_cubit.dart';
import '../../../utils/storage/shared_prefs.dart';

class PostTile extends StatelessWidget {
  final Post post;

  const PostTile({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final userId = sharedPrefs.userId;
    return BlocProvider(
      create: (context) => ReactionCubit(),
      child: Container(
        margin: EdgeInsets.only(bottom: screenHeight * 0.02),
        padding: EdgeInsets.all(screenWidth * 0.03),
        decoration: BoxDecoration(
          color: AppColors.backgroundDark,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: post.user.avatar != null
                      ? MemoryImage(base64Decode(post.user.avatar!))
                      : null,
                  child: post.user.avatar == null
                      ? const Icon(Icons.person, color: Colors.white)
                      : null,
                ),
                SizedBox(width: screenWidth * 0.03),
                // Username
                Text(
                  post.user.username,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            // Content
            Text(
              post.content,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: screenWidth * 0.04,
              ),
            ),
            // Image
            if (post.image != null)
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                child: Image.memory(
                  base64Decode(post.image!),
                  height: screenHeight * 0.3,
                  width: screenWidth,
                  fit: BoxFit.cover,
                ),
              ),
            // Likes and Dislikes
            BlocBuilder<ReactionCubit, ReactionState>(
              builder: (context, reactionState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        final reactionCubit = context.read<ReactionCubit>();
                        reactionCubit.toggleLike();

                        context.read<SocialCubit>().reactToPost(
                          postId: post.id,
                          userId: userId!,
                          reactionType: reactionState.isLiked ? "remove_like" : "like",
                        );
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/like.svg',
                            color: reactionState.isLiked
                                ? AppColors.primaryPurple
                                : AppColors.textPrimary,
                            height: 24,
                            width: 24,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04,),
                    GestureDetector(
                      onTap: () {
                        final reactionCubit = context.read<ReactionCubit>();
                        reactionCubit.toggleDislike();

                        context.read<SocialCubit>().reactToPost(
                          postId: post.id,
                          userId: userId!,
                          reactionType: reactionState.isDisliked ? "remove_dislike" : "dislike",
                        );
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/unlike.svg',
                            color: reactionState.isDisliked
                                ? AppColors.primaryPurple
                                : AppColors.textPrimary,
                            height: 24,
                            width: 24,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
