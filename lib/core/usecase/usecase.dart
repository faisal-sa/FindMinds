import 'package:fpdart/fpdart.dart';
import 'package:graduation_project/core/error/failures.dart';

abstract class Usecase<T, Params> {
  TaskEither<Failure, T> call(Params params);
}
