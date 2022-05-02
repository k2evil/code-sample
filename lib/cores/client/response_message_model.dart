import 'package:json_annotation/json_annotation.dart';

part 'response_message_model.g.dart';

@JsonSerializable()
class ResponseMessage {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'code')
  final int? code;

  ResponseMessage(this.message, this.code);

  factory ResponseMessage.fromJson(Map<String, dynamic> json) =>
      _$ResponseMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMessageToJson(this);
}
