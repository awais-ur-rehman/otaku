import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otaku/logic/signin_cubit/signin_screen_states.dart';
import '../../data/repos/signin_repo/signin_repo.dart';


class SigninCubit extends Cubit<SigninStates> {
  SigninCubit() : super(SigninLoading());

  final SigninRepository signinRepo = SigninRepository();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }

  void loadSignInScreen() {
    emit(SigninLoaded());
  }

  Future<bool> loginUser() async {
    emit(SigninLoading());
    try {
      final isSuccess = await signinRepo.loginUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (isSuccess) {
        disposeControllers();
        emit(SigninLoaded());
        return true;
      } else {
        disposeControllers();
        emit(SigninError());
        return false;
      }
    } catch (e) {
      disposeControllers();
      emit(SigninError());
      return false;
    }
  }
}

