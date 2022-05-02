import 'package:dartz/dartz.dart';
import 'package:digisina/cores/error/failures.dart';
import 'package:digisina/cores/usecases/usecase.dart';
import 'package:digisina/features/home/domain/entity/home_page_parts.dart';
import 'package:digisina/features/home/domain/repository/home_page_repository.dart';

class GetHomePageComponents extends UseCase<HomePageComponents, NoParams> {
  final HomePageRepository repository;

  GetHomePageComponents({required this.repository});

  @override
  Future<Either<Failure?, HomePageComponents>> call(NoParams params) {
    return repository.getHomePageComponents();
  }
}
