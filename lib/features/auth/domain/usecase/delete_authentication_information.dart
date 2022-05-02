import 'package:dartz/dartz.dart';
import 'package:digisina/cores/error/failures.dart';
import 'package:digisina/cores/usecases/usecase.dart';
import 'package:digisina/features/auth/domain/repository/auth_repository.dart';

class DeleteAuthenticationInformation extends UseCase<void, NoParams> {
  final AuthRepository repository;

  DeleteAuthenticationInformation({required this.repository});

  @override
  Future<Either<Failure?, void>> call(NoParams params) async {
    return repository.logOut();
  }
}
