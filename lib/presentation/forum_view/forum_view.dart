import 'package:flutter/material.dart';
import 'package:otaku/utils/colors/color.dart';

class ForumView extends StatelessWidget {
  const ForumView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(child: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child:  Center(
          child: Text("Feature Under Development!",
            style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.w400,
          ),
          ),
        ),
      )),
    );
  }
}
