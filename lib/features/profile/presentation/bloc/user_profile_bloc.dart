import 'package:digisina/cores/usecases/usecase.dart';
import 'package:digisina/features/profile/data/model/profile_model.dart';
import 'package:digisina/features/profile/domain/entity/user_profile.dart';
import 'package:digisina/features/profile/domain/usecase/change_password.dart';
import 'package:digisina/features/profile/domain/usecase/clear_user_profile.dart';
import 'package:digisina/features/profile/domain/usecase/get_user_profile.dart';
import 'package:digisina/features/profile/domain/usecase/persist_user_profile.dart';
import 'package:digisina/features/profile/domain/usecase/update_user_profile.dart';
import 'package:digisina/features/profile/presentation/bloc/user_profile_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit({
    required GetUserProfile getUserProfile,
    required PersistUserProfile persistUserProfile,
    required ChangePassword changePassword,
    required UpdateUserProfile updateUserProfile,
    required ClearUserProfile clearUserProfile,
  })  : this._clearUserProfile = clearUserProfile,
        this._persistUserProfile = persistUserProfile,
        this._updateUserProfile = updateUserProfile,
        this._changePassword = changePassword,
        this._getUserProfile = getUserProfile,
        super(UserProfileUnInitialized());

  final GetUserProfile _getUserProfile;
  final PersistUserProfile _persistUserProfile;
  final ChangePassword _changePassword;
  final UpdateUserProfile _updateUserProfile;
  final ClearUserProfile _clearUserProfile;

  changePassword(String currentPass, String newPass) async {
    var response = await _changePassword(ChangePasswordParams(
        currentPassword: currentPass, newPassword: newPass));
    response.fold(
      (failure) => emit(UserProfileUnInitialized()),
      (result) => emit(UserPasswordChanged()),
    );
  }

  updateUserProfile(
      String name, String lastname, String email, String phoneNumber) async {
    var user = await _getUserProfile(NoParams());
    user.fold(
      (failure) => emit(UserProfileUnInitialized()),
      (result) async {
        if (result != null) {
          var updateUser = UserProfile(
              result.id,
              result.personnelCode,
              name,
              lastname,
              result.nationalCode,
              phoneNumber,
              result.position,
              result.dashboard,
              result.family,
              result.branch,
              result.privilege,
              result.avatar);
          var response = await _updateUserProfile(updateUser);
          response.fold(
            (failure) => emit(UserProfileUnInitialized()),
            (result) => emit(UserProfileLoaded(profile: updateUser)),
          );
        }
      },
    );
  }

  setUserProfile(UserProfile profile) async {
    var response = await _persistUserProfile(profile);
    response.fold(
      (failure) => emit(UserProfileUnInitialized()),
      (result) => emit(UserProfileLoaded(profile: result)),
    );
  }

  getUserProfile() async {
    var response = await _getUserProfile(NoParams());
    response.fold(
      (failure) => emit(UserProfileUnInitialized()),
      (result) => result != null
          ? emit(UserProfileLoaded(profile: result))
          : emit(UserProfileUnInitialized()),
    );
  }

  clearUserProfile() async {
    var response = await _clearUserProfile(NoParams());
    emit(UserProfileUnInitialized());
  }
}
