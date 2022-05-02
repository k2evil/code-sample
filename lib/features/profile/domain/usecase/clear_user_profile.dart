import 'package:dartz/dartz.dart';
import 'package:digisina/cores/error/failures.dart';
import 'package:digisina/cores/usecases/usecase.dart';
import 'package:digisina/features/profile/domain/repository/profile_repository.dart';

class ClearUserProfile extends UseCase<void, NoParams> {
  final ProfileRepository repository;

  ClearUserProfile({required this.repository});

  @override
  Future<Either<Failure?, void>> call(NoParams params) {
    return repository.clearUserProfile();
  }
}
