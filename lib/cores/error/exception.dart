class AuthenticationException implements Exception {}

class RemoteApiException implements Exception{
  final String? message;
  final int code;

  RemoteApiException({required this.code, this.message});
}