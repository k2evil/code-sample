import 'package:dartz/dartz.dart';
import 'package:digisina/cores/error/failures.dart';
import 'package:digisina/cores/usecases/usecase.dart';
import 'package:digisina/features/auth/domain/entity/auth_info.dart';
import 'package:digisina/features/auth/domain/repository/auth_repository.dart';

class Authenticate extends UseCase<AuthInfo, Params> {
  final AuthRepository repository;

  Authenticate({required this.repository});

  @override
  Future<Either<Failure?, AuthInfo>> call(Params params) =>
      repository.authenticate(
        username: params.username,
        password: params.password,
      );
}

class Params {
  final String username;
  final String password;

  Params({required this.username, required this.password});
}
