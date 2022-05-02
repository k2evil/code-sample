import 'package:dartz/dartz.dart';
import 'package:digisina/cores/error/failures.dart';
import 'package:digisina/cores/usecases/usecase.dart';
import 'package:digisina/features/profile/domain/entity/user_profile.dart';
import 'package:digisina/features/profile/domain/repository/profile_repository.dart';

class GetUserProfile extends UseCase<UserProfile?, NoParams> {
  final ProfileRepository repository;

  GetUserProfile({required this.repository});

  @override
  Future<Either<Failure?, UserProfile?>> call(NoParams params) {
    return repository.getUserProfile();
  }
}
