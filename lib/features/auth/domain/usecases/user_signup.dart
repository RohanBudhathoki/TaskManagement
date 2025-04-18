import 'package:fpdart/fpdart.dart';
import 'package:taskmanagementapp/core/error/failure.dart';
import 'package:taskmanagementapp/core/usecase/usecases.dart';
import 'package:taskmanagementapp/features/auth/domain/entities/user_entity.dart';
import 'package:taskmanagementapp/features/auth/domain/repository/auth_repo.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepo authRepository;

  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authRepository.signupWitchEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;

  final String name;

  UserSignUpParams({
    required this.password,
    required this.name,
    required this.email,
  });
}
