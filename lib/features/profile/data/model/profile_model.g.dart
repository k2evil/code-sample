// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
    json['_id'] as String?,
    json['personnelCode'] as int?,
    json['Name'] as String?,
    json['lastName'] as String?,
    json['nationalNumber'] as int?,
    json['phoneNumber'] as String?,
    json['Post'] as String?,
    json['dashboard'] as String?,
    json['family'] as String?,
    json['Role'] as String?,
    json['Branch'] as String?,
    json['avatar'] == null
        ? null
        : ProfileAvatar.fromJson(json['avatar'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      '_id': instance.id,
      'personnelCode': instance.personnelCode,
      'Name': instance.firstName,
      'lastName': instance.lastName,
      'nationalNumber': instance.nationalNumber,
      'phoneNumber': instance.phoneNumber,
      'Post': instance.position,
      'dashboard': instance.dashboard,
      'family': instance.family,
      'Role': instance.role,
      'Branch': instance.branch,
      'avatar': instance.avatar?.toJson(),
    };

ProfileAvatar _$ProfileAvatarFromJson(Map<String, dynamic> json) {
  return ProfileAvatar(
    thumbnail: json['thumbnail'] as String?,
    large: json['large'] as String?,
  );
}

Map<String, dynamic> _$ProfileAvatarToJson(ProfileAvatar instance) =>
    <String, dynamic>{
      'thumbnail': instance.thumbnail,
      'large': instance.large,
    };
