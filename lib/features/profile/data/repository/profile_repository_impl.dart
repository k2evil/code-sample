import 'package:dartz/dartz.dart';
import 'package:digisina/cores/error/failures.dart';
import 'package:digisina/features/profile/data/datasource/profile_local_datasource.dart';
import 'package:digisina/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:digisina/features/profile/data/model/profile_model.dart';
import 'package:digisina/features/profile/domain/entity/user_profile.dart';
import 'package:digisina/features/profile/domain/repository/profile_repository.dart';

class IProfileRepository extends ProfileRepository {
  final ProfileLocalDataSource localDataSource;
  final ProfileRemoteDataSource remoteDataSource;

  IProfileRepository(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure?, void>> clearUserProfile() async {
    await localDataSource.deleteProfile();
    return Right(null);
  }

  @override
  Future<Either<Failure?, UserProfile?>> getUserProfile() async {
    var profile = await localDataSource.getProfile();
    var user = profile != null ? UserProfile.fromModel(profile) : null;
    return Right(user);
  }

  @override
  Future<Either<Failure?, UserProfile>> persistUserProfile(
      {required UserProfile profile}) async {
    var model = Profile(
      profile.id,
      profile.personnelCode,
      profile.firstName,
      profile.lastName,
      int.tryParse(profile.nationalCode),
      profile.phoneNumber,
      profile.position,
      profile.dashboard,
      profile.family,
      profile.privilege == Privilege.ceo
          ? "ceo"
          : profile.privilege == Privilege.manager
              ? "manager"
              : profile.privilege == Privilege.employee
                  ? "employee"
                  : profile.privilege == Privilege.family
                      ? "family"
                      : "",
      profile.branch,
      ProfileAvatar(large: profile.avatar),
    );
    await localDataSource.setProfile(profile: model);
    return Right(profile);
  }

  @override
  Future<Either<Failure?, void>> changePassword(
      {required String currentPass, required String newPass}) async {
    var response = await remoteDataSource.changePassword(
        currentPass: currentPass, newPass: newPass);
    //var user = profile != null ? UserProfile.fromModel(profile) : null;
    return Right(response);
  }

  @override
  Future<Either<Failure?, void>> updateProfile(
      {required UserProfile user}) async {
    var response = await remoteDataSource.updateProfile(user: user);

    return Right(response);
  }
}
