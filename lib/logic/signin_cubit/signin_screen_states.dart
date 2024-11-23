import 'package:equatable/equatable.dart';

abstract class SigninStates extends Equatable {
  const SigninStates();

  @override
  List<Object> get props => [];
}

class SigninLoading extends SigninStates {}

class SigninLoaded extends SigninStates {}

class SigninError extends SigninStates {}

