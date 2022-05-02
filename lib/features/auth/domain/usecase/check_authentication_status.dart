import 'package:dartz/dartz.dart';
import 'package:digisina/cores/error/failures.dart';
import 'package:digisina/cores/usecases/usecase.dart';
import 'package:digisina/features/auth/domain/entity/auth_info.dart';
import 'package:digisina/features/auth/domain/repository/auth_repository.dart';

class CheckAuthenticationStatus extends UseCase<AuthInfo, NoParams> {
  final AuthRepository repository;

  CheckAuthenticationStatus({required this.repository});

  Future<Either<Failure?, AuthInfo>> call(NoParams param) async {
    return await repository.getAuthInfo();
  }
}
