import 'package:dartz/dartz.dart';
import 'package:digisina/cores/error/failures.dart';
import 'package:digisina/cores/usecases/usecase.dart';
import 'package:digisina/features/auth/domain/entity/auth_info.dart';
import 'package:digisina/features/auth/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

class SaveAuthenticationInformation extends UseCase<AuthInfo, Params> {
  final AuthRepository repository;

  SaveAuthenticationInformation({required this.repository});

  Future<Either<Failure?, AuthInfo>> call(Params params) async {
    return repository.persistAuthInfo(
      params.token,
      params.refreshToken,
    );
  }
}

class Params extends Equatable {
  final String token;
  final String refreshToken;

  Params({required this.token, required this.refreshToken});

  @override
  List<Object?> get props => [token, refreshToken];
}
