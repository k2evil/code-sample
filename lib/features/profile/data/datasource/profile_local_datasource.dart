import 'dart:convert';

import 'package:digisina/features/profile/data/model/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProfileLocalDataSource {
  Future<Profile> setProfile({required Profile profile});

  Future<Profile?> getProfile();

  Future<void> deleteProfile();
}

class IProfileLocalDataSource extends ProfileLocalDataSource {
  @override
  Future<void> deleteProfile() async {
    var preferences = await SharedPreferences.getInstance();
    preferences.remove("profile");
    return;
  }

  @override
  Future<Profile?> getProfile() async {
    var preferences = await SharedPreferences.getInstance();
    String? json = preferences.getString("profile");
    var profile = json != null ? Profile.fromJson(jsonDecode(json)) : null;
    return profile;
  }

  @override
  Future<Profile> setProfile({required Profile profile}) async {
    var preferences = await SharedPreferences.getInstance();
    preferences.setString("profile", jsonEncode(profile.toJson()));
    return profile;
  }
}
