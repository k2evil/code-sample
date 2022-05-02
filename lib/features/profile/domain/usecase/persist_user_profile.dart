import 'package:dartz/dartz.dart';
import 'package:digisina/cores/error/failures.dart';
import 'package:digisina/cores/usecases/usecase.dart';
import 'package:digisina/features/profile/data/datasource/profile_local_datasource.dart';
import 'package:digisina/features/profile/domain/entity/user_profile.dart';
import 'package:digisina/features/profile/domain/repository/profile_repository.dart';

class PersistUserProfile extends UseCase<UserProfile, UserProfile> {
  final ProfileRepository repository;

  PersistUserProfile({required this.repository});

  @override
  Future<Either<Failure?, UserProfile>> call(UserProfile params) {
    return repository.persistUserProfile(profile: params);
  }
}
