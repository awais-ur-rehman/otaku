import 'package:equatable/equatable.dart';

abstract class ProfileSetupStates extends Equatable {
  const ProfileSetupStates();

  @override
  List<Object> get props => [];
}

class ProfileSetupLoading extends ProfileSetupStates {}

class ProfileSetupLoaded extends ProfileSetupStates {}

class ProfileSetupError extends ProfileSetupStates {}

