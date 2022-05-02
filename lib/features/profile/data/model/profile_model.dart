import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Profile {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "personnelCode")
  final int? personnelCode;
  @JsonKey(name: "Name")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "nationalNumber")
  final int? nationalNumber;
  @JsonKey(name: "phoneNumber")
  final String? phoneNumber;
  @JsonKey(name: "Post")
  final String? position;
  @JsonKey(name: "dashboard")
  final String? dashboard;
  @JsonKey(name: "family")
  final String? family;
  @JsonKey(name: "Role")
  final String? role;
  @JsonKey(name: "Branch")
  final String? branch;
  @JsonKey(name: "avatar")
  final ProfileAvatar? avatar;

  String? get fullName => firstName == null
      ? lastName == null
          ? null
          : "$lastName"
      : "$firstName $lastName";

  Profile(
    this.id,
    this.personnelCode,
    this.firstName,
    this.lastName,
    this.nationalNumber,
    this.phoneNumber,
    this.position,
    this.dashboard,
    this.family,
    this.role,
    this.branch,
    this.avatar,
  );

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

@JsonSerializable()
class ProfileAvatar {
  @JsonKey(name: "thumbnail")
  final String? thumbnail;
  @JsonKey(name: "large")
  final String? large;

  ProfileAvatar({this.thumbnail, this.large});

  factory ProfileAvatar.fromJson(Map<String, dynamic> json) =>
      _$ProfileAvatarFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileAvatarToJson(this);
}
