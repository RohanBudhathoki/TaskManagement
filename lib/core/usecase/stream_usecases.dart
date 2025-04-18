import 'package:fpdart/fpdart.dart';
import 'package:taskmanagementapp/core/error/failure.dart';

abstract class StreamUseCase<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}
