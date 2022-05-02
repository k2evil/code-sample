// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMessage _$ResponseMessageFromJson(Map<String, dynamic> json) {
  return ResponseMessage(
    json['message'] as String?,
    json['code'] as int?,
  );
}

Map<String, dynamic> _$ResponseMessageToJson(ResponseMessage instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
    };
