import 'package:flutter/material.dart';
import 'package:otaku/utils/colors/color.dart';

class ErrorView extends StatelessWidget {
  final String message;

  const ErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Text(
        message,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: screenWidth * 0.05,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
