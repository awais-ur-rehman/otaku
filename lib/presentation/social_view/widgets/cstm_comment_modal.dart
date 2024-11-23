import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/social_cubit/comment_cubit.dart';
import '../../../logic/social_cubit/comment_states.dart';
import '../../../logic/social_cubit/social_cubit.dart';
import '../../../utils/colors/color.dart';

class CommentModal extends StatelessWidget {
  final String postId;
  final String userId;

  const CommentModal({
    super.key,
    required this.postId,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final socialCubit = context.read<SocialCubit>();
    final commentController = TextEditingController();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: SizedBox(
        height: screenHeight * 0.5,
        width: screenWidth,
        child: BlocProvider(
          create: (context) => CommentCubit(socialCubit: socialCubit)..loadComments(postId),
          child: BlocBuilder<CommentCubit, CommentState>(
            builder: (context, state) {
              final commentCubit = context.read<CommentCubit>();

              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  top: 16,
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Comments",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    state.isLoading
                        ? const CircularProgressIndicator()
                        : state.comments.isEmpty
                        ? const Text(
                      "No comments yet",
                      style: TextStyle(color: AppColors.textSecondary),
                    )
                        : Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.comments.length,
                        itemBuilder: (context, index) {
                          final comment = state.comments[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              backgroundImage: comment.avatar != null
                                  ? MemoryImage(base64Decode(comment.avatar!))
                                  : null,
                              child: comment.avatar == null
                                  ? const Icon(Icons.person, color: Colors.white)
                                  : null,
                            ),
                            title: Text(
                              comment.username,
                              style: const TextStyle(
                                  color: AppColors.textPrimary,
                              ),
                            ),
                            subtitle: Text(
                              comment.content,
                              style: const TextStyle(color: AppColors.textSecondary),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: commentController,
                      style: const TextStyle(color: AppColors.textPrimary),
                      decoration: const InputDecoration(
                        hintText: "Write a comment...",
                        hintStyle: TextStyle(color: AppColors.textSecondary),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.accentPurple),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (commentController.text.trim().isNotEmpty) {
                          commentCubit.addComment(
                            postId: postId,
                            userId: userId,
                            content: commentController.text.trim(),
                          );
                          commentController.clear();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Comment cannot be empty!"),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryPurple,
                      ),
                      child: const Text("Post Comment"),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
