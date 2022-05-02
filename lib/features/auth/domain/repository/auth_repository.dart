import 'package:dartz/dartz.dart';
import 'package:digisina/cores/error/failures.dart';
import 'package:digisina/features/auth/domain/entity/auth_info.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthInfo>> authenticate({
    required String username,
    required String password,
  });

  Future<Either<Failure?, AuthInfo>> getAuthInfo();

  Future<Either<Failure?, AuthInfo>> persistAuthInfo(
    String token,
    String refreshToken,
  );

  Future<Either<Failure?, void>> logOut();
}
