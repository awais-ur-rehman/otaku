import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otaku/logic/signup_cubit/signup_screen_states.dart';
import '../../data/repos/signup_repo/signup_repo.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() : super(SignupLoaded());

  final SignupRepository signupRepo = SignupRepository();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();


  dispose() {
    userNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPassController.clear();
  }

  loadSignUpScreen() {
    emit(SignupLoaded());
  }

  Future<bool> createUser() async {
    emit(SignupLoading());
    try {
      if (passwordController.text != confirmPassController.text) {
        emit(SignupError());
        return false;
      }

      final isSuccess = await signupRepo.createUser(
        username: userNameController.text,
        email: emailController.text,
        password: passwordController.text,
      );

      if (isSuccess) {
        dispose();
        return true;
      } else {
        dispose();
        emit(SignupError());
        return false;
      }
    } catch (e) {
      dispose();
      emit(SignupError());
      return false;
    }
  }

}
