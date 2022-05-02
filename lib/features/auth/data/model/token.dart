import 'package:digisina/features/profile/data/model/profile_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable(explicitToJson: true)
class Token extends Equatable {
  @JsonKey(name: 'token')
  final String token;
  @JsonKey(ignore: true)
  final String refreshToken;
  @JsonKey(name: "profile")
  final Profile? profile;

  Token({required this.token, this.refreshToken: "", this.profile});

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);

  @override
  List<Object?> get props => [this.token, this.refreshToken];
}
