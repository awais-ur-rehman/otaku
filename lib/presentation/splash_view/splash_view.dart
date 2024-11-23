import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otaku/utils/colors/color.dart';
import '../../logic/splash_cubit/splash_cubit.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SplashCubit>().navigateToHome(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.primaryPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: const AssetImage('assets/logo/logo.png'),
            height: screenHeight * 0.2,
              width: screenWidth * 0.2,
            ),
            Text(
              'Otaku',
              style: TextStyle(
                  fontSize: screenWidth * 0.09,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold)
              ,
            ),
          ],
        ),
      ),
    );
  }
}
