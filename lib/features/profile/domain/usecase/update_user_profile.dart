import 'package:dartz/dartz.dart';
import 'package:digisina/cores/error/failures.dart';
import 'package:digisina/cores/usecases/usecase.dart';
import 'package:digisina/features/profile/data/datasource/profile_local_datasource.dart';
import 'package:digisina/features/profile/domain/entity/user_profile.dart';
import 'package:digisina/features/profile/domain/repository/profile_repository.dart';

class UpdateUserProfile extends UseCase<void, UserProfile> {
  final ProfileRepository repository;

  UpdateUserProfile({required this.repository});

  @override
  Future<Either<Failure?, void>> call(UserProfile user) {
    return repository.updateProfile(user: user);
  }
}
