import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class SigninPassState extends Equatable {
  @override
  List<Object> get props => [];
}

class SigninPassStateInitial extends SigninPassState {}

class PasswordToggle extends SigninPassState {
  final bool passVisible;
  final bool confirmPassVisible;

  PasswordToggle(this.passVisible, this.confirmPassVisible);
}

class SigninPassCubit extends Cubit<SigninPassState> {
  SigninPassCubit() : super(SigninPassStateInitial());

  bool passwordToggle = false;
  bool passwordToggle2 = false;

  togglePasswordVisibility() {
    passwordToggle = !passwordToggle;
    emit(SigninPassStateInitial());
    emit(PasswordToggle(passwordToggle, passwordToggle2));
  }

  togglePasswordVisibility2() {
    passwordToggle2 = !passwordToggle2;
    emit(SigninPassStateInitial());
    emit(PasswordToggle(passwordToggle, passwordToggle2));
  }
}
