import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class AuthenticationFailure extends Failure {
  final String? message;

  AuthenticationFailure({this.message});

  @override
  List<Object?> get props => [message];

}

class HttpFailure extends Failure {
  final int code;
  final String? message;

  HttpFailure({required this.code, this.message});

  @override
  List<Object?> get props => [code, message];
}

