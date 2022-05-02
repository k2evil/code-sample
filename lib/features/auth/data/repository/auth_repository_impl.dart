import 'package:dartz/dartz.dart';
import 'package:digisina/cores/error/exception.dart';
import 'package:digisina/cores/error/failures.dart';
import 'package:digisina/features/auth/data/datasource/auth_datasource.dart';
import 'package:digisina/features/auth/domain/entity/auth_info.dart';
import 'package:digisina/features/auth/domain/repository/auth_repository.dart';
import 'package:digisina/features/profile/domain/entity/user_profile.dart';
import 'package:dio/dio.dart';

class IAuthRepository extends AuthRepository {
  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;
  AuthInfo? _cached;

  IAuthRepository(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure, AuthInfo>> authenticate(
      {required String username, required String password}) async {
    try {
      var token = await remoteDataSource.authenticate(
        username: username,
        password: password,
      );
      await localDataSource.persistToken(token.token, token.refreshToken);
      await localDataSource.setAuthenticated(true);
      _cached = AuthInfo(
        token: token.token,
        refreshToken: token.refreshToken,
        profile: token.profile != null
            ? UserProfile.fromModel(token.profile!)
            : null,
      );
      return Right(_cached!);
    } on DioError catch (e) {
      return Left(HttpFailure(code: 0, message: e.message));
    }
  }

  @override
  Future<Either<Failure?, AuthInfo>> getAuthInfo() async {
    try {
      var isAuthenticated = await localDataSource.isAuthenticated();
      if (isAuthenticated) {
        if (_cached == null) {
          var token = await localDataSource.getToken();
          _cached =
              AuthInfo(token: token.token, refreshToken: token.refreshToken);
        }
        return Right(_cached!);
      } else {
        return Right(AuthInfo());
      }
    } catch (e) {
      return Left(null);
    }
  }

  @override
  Future<Either<Failure?, void>> logOut() async {
    try {
      localDataSource.setAuthenticated(false);
      _cached = null;
      return Right(await localDataSource.deleteAuthInfo());
    } catch (e) {
      return Left(null);
    }
  }

  @override
  Future<Either<Failure?, AuthInfo>> persistAuthInfo(
      String token, String refreshToken) async {
    try {
      var t = await localDataSource.persistToken(token, refreshToken);
      _cached = AuthInfo(token: t.token, refreshToken: t.refreshToken);
      return Right(_cached!);
    } catch (e) {
      return Left(null);
    }
  }
}
