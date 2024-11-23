import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/storage/shared_prefs.dart';

class SplashCubit extends Cubit<void> {
  SplashCubit() : super(null);

  void navigateToHome(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    if (sharedPrefs.isLoggedIn) {
      context.go('/home');
    } else {
      context.go('/signup');
    }
  }
}
