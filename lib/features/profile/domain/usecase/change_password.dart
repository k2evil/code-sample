import 'package:dartz/dartz.dart';
import 'package:digisina/cores/error/failures.dart';
import 'package:digisina/cores/usecases/usecase.dart';
import 'package:digisina/features/profile/data/datasource/profile_local_datasource.dart';
import 'package:digisina/features/profile/domain/entity/user_profile.dart';
import 'package:digisina/features/profile/domain/repository/profile_repository.dart';

class ChangePassword extends UseCase<void, ChangePasswordParams> {
  final ProfileRepository repository;

  ChangePassword({required this.repository});

  @override
  Future<Either<Failure?, void>> call(ChangePasswordParams params) {
    return repository.changePassword(
        currentPass: params.currentPassword, newPass: params.newPassword);
  }
}

class ChangePasswordParams {
  final String currentPassword;
  final String newPassword;

  ChangePasswordParams(
      {required this.currentPassword, required this.newPassword});
}
