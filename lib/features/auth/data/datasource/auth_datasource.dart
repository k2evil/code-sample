import 'dart:io';

import 'package:digisina/cores/error/exception.dart';
import 'package:digisina/features/auth/data/model/token.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time/time.dart';

abstract class AuthLocalDataSource {
  ///Reads authentication information from a secure storage which was gotten
  ///the last time the user had logged in
  ///
  /// Throws an [AuthenticationException] for all errors
  Future<Token> getToken();

  ///Writes authentication information to a secure storage
  ///
  /// Throws an [AuthenticationException] for all errors
  Future<Token> persistToken(String token,
      String refreshToken,);

  Future<void> deleteAuthInfo();

  Future<bool> isAuthenticated();

  Future<bool> setAuthenticated(bool authenticated);
}

abstract class AuthRemoteDataSource {
  Future<Token> authenticate({
    required String username,
    required String password,
  });

  Future<Token> refreshToken({
    required String token,
    required String refreshToken,
  });
}

const TOKEN = 'TOKEN';
const REFRESH_TOKEN = 'REFRESH_TOKEN';

class AuthSecureLocalDataSource extends AuthLocalDataSource {
  final FlutterSecureStorage storage;

  AuthSecureLocalDataSource({required this.storage});

  @override
  Future<Token> getToken() async {
    if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS))
      return Token(token: "", refreshToken: "");
    try {
      var token = await storage.read(key: TOKEN);
      var refreshToken = await storage.read(key: REFRESH_TOKEN);
      return Token(token: token ?? "", refreshToken: refreshToken ?? "");
    } on Exception {
      throw AuthenticationException();
    }
  }

  @override
  Future<Token> persistToken(String token, String refreshToken) async {
    if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS))
      return Token(token: token, refreshToken: token);
    try {
      await storage.write(key: TOKEN, value: token);
      await storage.write(key: REFRESH_TOKEN, value: refreshToken);
      return Token(token: token, refreshToken: refreshToken);
    } on Exception {
      throw AuthenticationException();
    }
  }

  @override
  Future<void> deleteAuthInfo() async {
    if (kIsWeb || (!Platform.isAndroid && !Platform.isIOS)) return;
    return await storage.delete(key: TOKEN);
  }

  @override
  Future<bool> isAuthenticated() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool("authenticated") ?? false;
  }

  @override
  Future<bool> setAuthenticated(bool authenticated) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool("authenticated", authenticated);
  }
}

class IAuthRemoteDataSource extends AuthRemoteDataSource {
  final Dio dio;

  IAuthRemoteDataSource({required this.dio});

  @override
  Future<Token> authenticate(
      {required String username, required String password}) async {
    var data = {'personnelCode': username, 'nationalNumber': password};
    var response = await dio.post("/v1/user/login", data: data);
    return Token.fromJson(response.data);
  }

  @override
  Future<Token> refreshToken(
      {required String token, required String refreshToken}) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

}

class AuthRemoteMockDataSource extends AuthRemoteDataSource {
  @override
  Future<Token> authenticate(
      {required String username, required String password}) {
    return Future.delayed(
        2.seconds,
            () =>
            Token(
              token: "1234",
              refreshToken: "1234",
            ));
  }

  @override
  Future<Token> refreshToken(
      {required String token, required String refreshToken}) {
    return Future.delayed(
        1.seconds,
            () =>
            Token(
              token: "1234",
              refreshToken: "1234",
            ));
  }
}
