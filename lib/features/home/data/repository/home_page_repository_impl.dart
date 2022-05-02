import 'package:dartz/dartz.dart';
import 'package:digisina/cores/error/failures.dart';
import 'package:digisina/features/blogs/domain/entity/blog_post.dart';
import 'package:digisina/features/home/data/datasource/home_page_datasource.dart';
import 'package:digisina/features/home/domain/entity/home_page_parts.dart';
import 'package:digisina/features/home/domain/repository/home_page_repository.dart';

class IHomePageRepository extends HomePageRepository {
  final HomePageRemoteDataSource dataSource;

  IHomePageRepository({required this.dataSource});

  @override
  Future<Either<Failure?, HomePageComponents>> getHomePageComponents() async {
    try {
      var model = await dataSource.getHomePageParts();
      var slides = model.slides
              ?.where((element) => element != null && element.imageUrl != null)
              .map<HomePageSlide>((e) => HomePageSlide.fromModel(e!))
              .toList() ??
          [];

      var options = model.options
              ?.where((element) => element != null)
              .map<HomePageOption>((e) => HomePageOption.fromModel(e!))
              .toList() ??
          [];

      var dayInfo = model.calendar
              ?.where((element) => element != null)
              .map<HomePageCalendar>((e) => HomePageCalendar.fromModel(e!))
              .toList() ??
          [];

      var latestBlogs = model.latestBlogs
              ?.where((element) => element != null && element.id != null)
              .map((e) => BlogPost.fromModel(e!))
              .toList() ??
          [];

      return Right(HomePageComponents(
        slides: slides,
        dayInfo: dayInfo,
        options: options,
        blogs: latestBlogs,
      ));
    } catch (e) {
      return Left(null);
    }
  }
}
