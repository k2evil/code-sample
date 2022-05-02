import 'dart:convert';

import 'package:digisina/features/payroll/data/model/invoice_model.dart';
import 'package:digisina/features/payroll/data/model/payroll_model.dart';
import 'package:digisina/features/profile/data/model/profile_model.dart';
import 'package:digisina/features/profile/domain/entity/user_profile.dart';
import 'package:dio/dio.dart';

abstract class ProfileRemoteDataSource {
  Future<void> updateProfile({required UserProfile user});
  Future<void> changePassword(
      {required String currentPass, required String newPass});
}

// class PayrollRemoteMockDataSource extends PayrollRemoteDataSource {
//   @override
//   Future<PayrollResponse> getPayroll({required int year, required int month}) {
//     var response =
//         "{\"message\":\"success\",\"image_url\":\"https://quickbooks.intuit.com/us/oicms_us/uploads/2020/12/Payroll-report-summary-by-employee.png\"}";
//     return Future.delayed(Duration(milliseconds: 400),
//         () => PayrollResponse.fromJson(jsonDecode(response)));
//   }
// }

class IProfileRemoteDataSource extends ProfileRemoteDataSource {
  final Dio dio;

  IProfileRemoteDataSource({required this.dio});

  @override
  Future<void> changePassword(
      {required String currentPass, required String newPass}) async {
    var passData = {
      "user": {"current_password": currentPass, "new_password": newPass}
    };
    var response =
        await dio.put("/v1/user/profile", data: jsonEncode(passData));
  }

  @override
  Future<void> updateProfile({required UserProfile user}) async {
    var response =
        await dio.put("/v1/user/profile", data: user.toProfile().toJson());
  }
}
