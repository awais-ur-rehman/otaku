import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:otaku/presentation/auth_view/widgets/cstm_flat_button.dart';
import 'package:otaku/presentation/auth_view/widgets/signin_form.dart';
import 'package:otaku/utils/colors/color.dart';
import 'package:otaku/utils/routes/route_names.dart';
import '../../logic/signin_cubit/signin_screen_cubit.dart';
import '../../logic/signin_cubit/signin_screen_states.dart';
import '../../widgets/cstm_loader.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    context.read<SigninCubit>().loadSignInScreen();
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02, horizontal: screenWidth * 0.02),
          child:
              BlocBuilder<SigninCubit, SigninStates>(builder: (context, state) {
            if (state is SigninLoading) {
              return const Center(
                child: CustomLoader(
                  loaderColor: AppColors.accentPurple,
                ),
              );
            } else if (state is SigninError) {
              return const Center(
                child: Text("Error"),
              );
            } else if (state is SigninLoaded) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: screenHeight * 0.04),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.2,
                        width: screenWidth,
                        child: const Image(
                          image: AssetImage('assets/images/signin.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: 'MontserratMedium',
                          fontSize: screenWidth * 0.09,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      Text(
                        'Welcome back!',
                        style: TextStyle(
                          fontFamily: 'MontserratMedium',
                          fontSize: screenWidth * 0.05,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      const SignInForm(),
                      CustomFlatButton(
                        onTap: () async {
                          final navigatorContext = GoRouter.of(context)
                              .routerDelegate
                              .navigatorKey
                              .currentContext;
                          bool success =
                              await context.read<SigninCubit>().loginUser();
                          print(success);
                          if (success) {
                            if (context.mounted) {
                              context.go(RouteNames.homeRoute);
                            }
                          } else if (navigatorContext != null) {
                            ScaffoldMessenger.of(navigatorContext).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Login failed. Please check your credentials.")),
                            );
                          }
                        },
                        text: 'Login',
                        btnColor: AppColors.primaryPurple,
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Didn\'t have an account.',
                            style: TextStyle(
                              fontFamily: 'MontserratMedium',
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w200,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          InkWell(
                            onTap: () {
                              context.go(RouteNames.signupRoute);
                            },
                            child: Text(
                              'Signup',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ),
      ),
    );
  }
}
