import 'package:fpdart/fpdart.dart';
import 'package:taskmanagementapp/core/error/failure.dart';
import 'package:taskmanagementapp/features/auth/domain/entities/user_entity.dart';

abstract interface class AuthRepo {
  Future<Either<Failure, User>> signupWitchEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> currentUser();
}
