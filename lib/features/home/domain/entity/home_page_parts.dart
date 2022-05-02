import 'package:digisina/features/blogs/domain/entity/blog_post.dart';
import 'package:digisina/features/home/data/model/home_parts.dart';

class HomePageComponents {
  final List<HomePageSlide> slides;
  final List<HomePageCalendar> dayInfo;
  final List<HomePageOption> options;
  final List<BlogPost> blogs;

  HomePageComponents({
    required this.slides,
    required this.dayInfo,
    required this.options,
    required this.blogs,
  });
}

class HomePageSlide {
  final String? link;
  final String imageUrl;

  HomePageSlide({required this.link, required this.imageUrl});

  factory HomePageSlide.fromModel(Slide slide) => HomePageSlide(
        link: slide.link,
        imageUrl: slide.imageUrl ?? "",
      );
}

class HomePageCalendar {
  final String dayString;
  final String dayMessage;
  final int remainings;

  HomePageCalendar(
      {required this.dayString, required this.dayMessage, this.remainings = 0});

  factory HomePageCalendar.fromModel(Calendar model) => HomePageCalendar(
        dayString: model.dayString ?? "",
        dayMessage: model.dayMessage ?? "",
        remainings: model.remainingSeconds ?? 0,
      );
}

class HomePageOption {
  final String title;
  final String reference;
  final String iconUrl;
  final String referenceType;
  final bool enabled;
  final int id;

  HomePageOption({
    required this.title,
    required this.reference,
    required this.iconUrl,
    required this.enabled,
    required this.referenceType,
    required this.id,
  });

  factory HomePageOption.fromModel(Option model) => HomePageOption(
        title: model.title ?? "",
        reference: model.reference ?? "",
        iconUrl: model.iconUrl ?? "",
        referenceType: model.referenceType ?? "",
        enabled: model.enabled ?? true,
        id: model.id ?? 0,
      );
}
