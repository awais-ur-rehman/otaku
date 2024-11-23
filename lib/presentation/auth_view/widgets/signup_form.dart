import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/signup_cubit/signup_pass_cubit.dart';
import '../../../logic/signup_cubit/signup_screen_cubit.dart';
import '../../../utils/colors/color.dart';



class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
    final signUpCubit = context.read<SignupCubit>();
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: signUpCubit.userNameController,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.person_outline,
                  color: AppColors.primaryPurple,
                ),
                hintText: 'Name',
                hintStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w200,
                  color: AppColors.textPrimary,
                  letterSpacing: 1.0,
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryPurple),
                ),
              ),
              style: TextStyle(
                fontFamily: 'MontserratMedium',
                fontSize: screenWidth * 0.04,
                color: AppColors.textPrimary,
                letterSpacing: 1.0,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a username';
                }
                String pattern = r'^[a-zA-Z]+(?: [a-zA-Z]+)*$';
                RegExp regExp = RegExp(pattern);
                if (!regExp.hasMatch(value)) {
                  return 'Please enter a valid username';
                }
                signUpCubit.userNameController.text = value;
                return null;
              },
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            TextFormField(
              controller: signUpCubit.emailController,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.mail_outline_outlined,
                  color: AppColors.primaryPurple,
                ),
                hintText: 'Email',
                hintStyle: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w200,
                  color: AppColors.textPrimary,
                  letterSpacing: 1.0,
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryPurple),
                ),
              ),
              style: TextStyle(
                fontFamily: 'MontserratMedium',
                fontSize: screenWidth * 0.04,
                color: AppColors.textPrimary,
                letterSpacing: 1.0,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                }
                String pattern =
                    r'^[a-zA-Z0-9._%+-]{6,}@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                RegExp regExp = RegExp(pattern);
                if (!regExp.hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                signUpCubit.emailController.text = value;
                return null;
              },
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            BlocBuilder<SignUpPassCubit, SignUpPassState>(
              builder: (context, state) {
                return TextFormField(
                  controller: signUpCubit.passwordController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: AppColors.primaryPurple,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        context
                            .read<SignUpPassCubit>()
                            .togglePasswordVisibility();
                      },
                      icon: Icon(
                        state is PasswordToggle && state.passVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.primaryPurple,
                      ),
                    ),
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w200,
                      color: AppColors.textPrimary,
                      letterSpacing: 1.0,
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryPurple),
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: 'MontserratMedium',
                    fontSize: screenWidth * 0.04,
                    color: AppColors.textPrimary,
                    letterSpacing: 1.0,
                  ),
                  obscureText: !(state is PasswordToggle && state.passVisible),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }

                    bool hasUpperCase = value.contains(RegExp(r'[A-Z]'));
                    bool hasLowerCase = value.contains(RegExp(r'[a-z]'));
                    bool hasDigits = value.contains(RegExp(r'\d'));
                    bool hasSpecialCharacters = value.contains(RegExp(
                        r'[!@#\$&*~%^()_+=|<>?{}\[\]\/\\.,-]'));

                    if (!hasUpperCase) {
                      return 'Password must include at least one uppercase letter';
                    }
                    if (!hasLowerCase) {
                      return 'Password must include at least one lowercase letter';
                    }
                    if (!hasDigits) {
                      return 'Password must include at least one number';
                    }
                    if (!hasSpecialCharacters) {
                      return 'Password must include at least one special character';
                    }
                    signUpCubit.passwordController.text = value;
                    return null; // No validation errors
                  },
                );
              },
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            BlocBuilder<SignUpPassCubit, SignUpPassState>(
              builder: (context, state) {
                return TextFormField(
                  controller: signUpCubit.confirmPassController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: AppColors.primaryPurple,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () => context
                          .read<SignUpPassCubit>()
                          .togglePasswordVisibility2(),
                      icon: Icon(
                        state is PasswordToggle && state.confirmPassVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.primaryPurple,
                      ),
                    ),
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w200,
                      color: AppColors.textPrimary,
                      letterSpacing: 1.0,
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryPurple),
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: 'MontserratMedium',
                    fontSize: screenWidth * 0.04,
                    color: AppColors.textPrimary,
                    letterSpacing: 1.0,
                  ),
                  obscureText:
                  !(state is PasswordToggle && state.confirmPassVisible),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (signUpCubit.passwordController.text != value) {
                      return 'Passwords do not match';
                    }
                    signUpCubit.confirmPassController.text = value;
                    return null;
                  },
                );
              },
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
