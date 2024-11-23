import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otaku/logic/home_cubit/home_cubit.dart';
import 'package:otaku/logic/profile_setup_cubit/profile_setup_cubit.dart';
import 'package:otaku/logic/signin_cubit/signin_screen_cubit.dart';
import 'package:otaku/logic/social_cubit/social_cubit.dart';

import 'logic/home_cubit/home_detail_cubit.dart';
import 'logic/signin_cubit/signin_pass_cubit.dart';
import 'logic/signup_cubit/signup_pass_cubit.dart';
import 'logic/signup_cubit/signup_screen_cubit.dart';
import 'logic/splash_cubit/splash_cubit.dart';

class MultiBlocProviders {
  static List<BlocProvider> get providers => [
    BlocProvider<SplashCubit>(
      create: (context) => SplashCubit(),
    ),
    BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(),
    ),
    BlocProvider<HomeDetailCubit>(
      create: (context) => HomeDetailCubit(),
    ),
    BlocProvider<SignupCubit>(
      create: (context) => SignupCubit(),
    ),
    BlocProvider<SigninCubit>(
      create: (context) => SigninCubit(),
    ),
    BlocProvider<SignUpPassCubit>(
      create: (context) => SignUpPassCubit(),
    ),
    BlocProvider<SigninPassCubit>(
      create: (context) => SigninPassCubit(),
    ),
    BlocProvider<ProfileSetupCubit>(
      create: (context) => ProfileSetupCubit(),
    ),
    BlocProvider<SocialCubit>(
      create: (context) => SocialCubit(),
    ),
  ];
}
