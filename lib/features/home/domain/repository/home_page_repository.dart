import 'package:dartz/dartz.dart';
import 'package:digisina/cores/error/failures.dart';
import 'package:digisina/features/home/domain/entity/home_page_parts.dart';

abstract class HomePageRepository {
  Future<Either<Failure?,HomePageComponents>> getHomePageComponents();
}