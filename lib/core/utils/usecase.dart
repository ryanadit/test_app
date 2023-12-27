import 'package:dartz/dartz.dart';
import 'package:test_app_project/core/utils/failure.dart';

abstract class UseCase<ReturnType, Params> {
  const UseCase();
  Future<Either<Failure, ReturnType>> call(Params params);
}