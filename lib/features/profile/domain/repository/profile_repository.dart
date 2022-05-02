import 'package:dartz/dartz.dart';
import 'package:digisina/cores/error/failures.dart';
import 'package:digisina/features/profile/data/model/profile_model.dart';
import 'package:digisina/features/profile/domain/entity/user_profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure?, UserProfile>> persistUserProfile(
      {required UserProfile profile});

  Future<Either<Failure?, UserProfile?>> getUserProfile();

  Future<Either<Failure?, void>> clearUserProfile();

  Future<Either<Failure?, void>> changePassword(
      {required String currentPass, required String newPass});

  Future<Either<Failure?, void>> updateProfile({required UserProfile user});
}
