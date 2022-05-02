import 'package:digisina/features/auth/domain/entity/auth_info.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

class AuthUninitialized extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthInfoFetched extends AuthState {
  final AuthInfo authInfo;

  AuthInfoFetched({required this.authInfo});

  @override
  List<Object?> get props => [authInfo];
}

class AuthError extends AuthState {
  final int code;
  final String? message;

  AuthError({required this.code, this.message});

  @override
  List<Object?> get props => [this.code, this.message];
}

class LoggedOut extends AuthState{
  @override
  List<Object?> get props => [];

}
