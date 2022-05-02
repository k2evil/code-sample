import 'dart:io';
import 'package:digisina/features/auth/domain/entity/auth_info.dart';
import 'package:digisina/features/auth/domain/repository/auth_repository.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

class Client {
  final Future<String> Function() tokenBuilder;

  Client({required this.tokenBuilder});

  Dio init() {
    Dio _dio = Dio();
    _dio.interceptors.add(_ApiInterceptors(tokenBuilder: tokenBuilder));
    _dio.options.baseUrl = "https://digi-sina.herokuapp.com/api";

    return _dio;
  }
}

class _ApiInterceptors extends Interceptor {
  final Future<String> Function() tokenBuilder;

  _ApiInterceptors({required this.tokenBuilder});

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var authorization = await tokenBuilder();
    if (authorization.isNotEmpty)
      options.headers.addAll({HttpHeaders.authorizationHeader: authorization});
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(response.toString());
    return super.onResponse(response, handler);
  }
}
