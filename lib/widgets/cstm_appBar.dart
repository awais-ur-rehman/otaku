import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:otaku/logic/splash_cubit/splash_cubit.dart';
import 'package:otaku/utils/colors/color.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: screenHeight * 0.2,
      width: screenWidth * 0.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: screenHeight * 0.08,
            width: screenWidth * 0.15,
            color: AppColors.primaryPurple,
            child: InkWell(
              onTap: (){
                context.pop();
              },
                child: const Icon(
                    Icons.arrow_back_ios_new,
                color: AppColors.black,
                )
            ),
          )
        ],
      ),
    );
  }
}
