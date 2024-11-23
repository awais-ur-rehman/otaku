import 'package:equatable/equatable.dart';

abstract class SignupStates extends Equatable {
  const SignupStates();

  @override
  List<Object> get props => [];
}

class SignupLoading extends SignupStates {}

class SignupLoaded extends SignupStates {}

class SignupError extends SignupStates {}

