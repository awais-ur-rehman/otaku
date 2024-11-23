import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:otaku/logic/social_cubit/social_cubit.dart';
import 'package:otaku/utils/colors/color.dart';

import '../../../utils/storage/shared_prefs.dart';

class CreatePostModal extends StatefulWidget {
  const CreatePostModal({super.key});

  @override
  State<CreatePostModal> createState() => _CreatePostModalState();
}

class _CreatePostModalState extends State<CreatePostModal> {
  final TextEditingController _captionController = TextEditingController();
  String? _base64Image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _base64Image = base64Encode(bytes);
      });
    }
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: screenHeight * 0.02,
        left: screenWidth * 0.05,
        right: screenWidth * 0.05,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Create Post",
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          TextField(
            controller: _captionController,
            maxLength: 200,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: const InputDecoration(
              labelText: "What's on your mind?",
              labelStyle: TextStyle(color: AppColors.textSecondary),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.textSecondary),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.accentPurple),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          _base64Image != null
              ? Image.memory(
            base64Decode(_base64Image!),
            height: screenHeight * 0.2,
            width: screenWidth,
            fit: BoxFit.cover,
          )
              : TextButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.image, color: Colors.white),
            label: const Text(
              "Add Image",
              style: TextStyle(color: AppColors.textPrimary),
            ),
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primaryPurple,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryPurple,
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.015,
                  horizontal: screenWidth * 0.05,
                ),
              ),
              onPressed: () {
                final socialCubit = context.read<SocialCubit>();
                final userId = sharedPrefs.userId;
                if (userId != null && _captionController.text.isNotEmpty) {
                  socialCubit.createPost(
                    userId: userId,
                    content: _captionController.text,
                    image: _base64Image,
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Caption cannot be empty!"),
                    ),
                  );
                }
              },
              child: Text("Post",
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: screenWidth * 0.03,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
        ],
      ),
    );
  }
}
