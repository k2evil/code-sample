// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_parts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomePageParts _$HomePagePartsFromJson(Map<String, dynamic> json) {
  return HomePageParts(
    message: json['message'] as String?,
    slides: (json['slider'] as List<dynamic>?)
        ?.map(
            (e) => e == null ? null : Slide.fromJson(e as Map<String, dynamic>))
        .toList(),
    calendar: (json['calendar'] as List<dynamic>?)
        ?.map((e) =>
            e == null ? null : Calendar.fromJson(e as Map<String, dynamic>))
        .toList(),
    options: (json['tiles'] as List<dynamic>?)
        ?.map((e) =>
            e == null ? null : Option.fromJson(e as Map<String, dynamic>))
        .toList(),
    latestBlogs: (json['recently'] as List<dynamic>?)
        ?.map(
            (e) => e == null ? null : Post.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$HomePagePartsToJson(HomePageParts instance) =>
    <String, dynamic>{
      'message': instance.message,
      'slider': instance.slides?.map((e) => e?.toJson()).toList(),
      'calendar': instance.calendar?.map((e) => e?.toJson()).toList(),
      'tiles': instance.options?.map((e) => e?.toJson()).toList(),
      'recently': instance.latestBlogs?.map((e) => e?.toJson()).toList(),
    };

Slide _$SlideFromJson(Map<String, dynamic> json) {
  return Slide(
    type: json['type'] as String?,
    isActive: json['active'] as int?,
    link: json['reference'] as String?,
    imageUrl: json['slide_image'] as String?,
  );
}

Map<String, dynamic> _$SlideToJson(Slide instance) => <String, dynamic>{
      'type': instance.type,
      'reference': instance.link,
      'slide_image': instance.imageUrl,
      'active': instance.isActive,
    };

Calendar _$CalendarFromJson(Map<String, dynamic> json) {
  return Calendar(
    remainingSeconds: json['remaining'] as int?,
    dayString: json['title'] as String?,
    dayMessage: json['events'] as String?,
  );
}

Map<String, dynamic> _$CalendarToJson(Calendar instance) => <String, dynamic>{
      'title': instance.dayString,
      'remaining': instance.remainingSeconds,
      'events': instance.dayMessage,
    };

Option _$OptionFromJson(Map<String, dynamic> json) {
  return Option(
    referenceType: json['referenceType'] as String?,
    reference: json['reference'] as String?,
    title: json['title'] as String?,
    alias: json['alias'] as String?,
    id: json['id'] as int?,
    enabled: json['enabled'] as bool?,
    iconUrl: json['icon'] as String?,
  );
}

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      'title': instance.title,
      'alias': instance.alias,
      'id': instance.id,
      'referenceType': instance.referenceType,
      'reference': instance.reference,
      'enabled': instance.enabled,
      'icon': instance.iconUrl,
    };
