import 'package:flutter/material.dart';
import 'package:otaku/utils/colors/color.dart';

class ForumView extends StatelessWidget {
  const ForumView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Center(
          child: Text(
            'Login',
            style: TextStyle(
              fontFamily: 'MontserratMedium',
              fontSize: screenWidth * 0.09,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
