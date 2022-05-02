import 'package:digisina/features/blogs/data/model/blog_models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_parts.g.dart';

@JsonSerializable(explicitToJson: true)
class HomePageParts {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "slider")
  final List<Slide?>? slides;
  @JsonKey(name: "calendar")
  final List<Calendar?>? calendar;
  @JsonKey(name: "tiles")
  final List<Option?>? options;
  @JsonKey(name: "recently")
  final List<Post?>? latestBlogs;

  HomePageParts(
      {this.message,
      this.slides,
      this.calendar,
      this.options,
      this.latestBlogs});

  factory HomePageParts.fromJson(Map<String, dynamic> json) =>
      _$HomePagePartsFromJson(json);

  Map<String, dynamic> toJson() => _$HomePagePartsToJson(this);
}

@JsonSerializable()
class Slide {
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "reference")
  final String? link;
  @JsonKey(name: "slide_image")
  final String? imageUrl;
  @JsonKey(name: "active")
  final int? isActive;

  Slide({this.type, this.isActive, this.link, this.imageUrl});

  factory Slide.fromJson(Map<String, dynamic> json) => _$SlideFromJson(json);

  Map<String, dynamic> toJson() => _$SlideToJson(this);
}

@JsonSerializable()
class Calendar {
  @JsonKey(name: "title")
  final String? dayString;
  @JsonKey(name: "remaining")
  final int? remainingSeconds;
  @JsonKey(name: "events")
  final String? dayMessage;

  Calendar({this.remainingSeconds, this.dayString, this.dayMessage});

  factory Calendar.fromJson(Map<String, dynamic> json) =>
      _$CalendarFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarToJson(this);
}

@JsonSerializable()
class Option {
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "alias")
  final String? alias;
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "referenceType")
  final String? referenceType;
  @JsonKey(name: "reference")
  final String? reference;
  @JsonKey(name: "enabled")
  final bool? enabled;
  @JsonKey(name: "icon")
  final String? iconUrl;

  Option(
      {this.referenceType,
      this.reference,
      this.title,
      this.alias,
      this.id,
      this.enabled,
      this.iconUrl});

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);

  Map<String, dynamic> toJson() => _$OptionToJson(this);
}
