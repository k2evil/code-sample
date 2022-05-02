
import 'package:dartz/dartz.dart';
import 'package:digisina/cores/error/failures.dart';

abstract class UseCase<T, P>{
  Future<Either<Failure?, T>> call(P params);
}

class NoParams{}