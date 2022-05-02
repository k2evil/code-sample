import 'package:digisina/features/profile/domain/entity/user_profile.dart';
import 'package:equatable/equatable.dart';

abstract class UserProfileState extends Equatable {}

class UserProfileUnInitialized extends UserProfileState {
  @override
  List<Object?> get props => [];
}

class UserProfileLoaded extends UserProfileState {
  final UserProfile profile;

  UserProfileLoaded({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class UserPasswordChanged extends UserProfileState {
  @override
  List<Object?> get props => [];
}
