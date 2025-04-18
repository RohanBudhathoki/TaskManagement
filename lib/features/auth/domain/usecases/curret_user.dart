import 'package:fpdart/fpdart.dart';
import 'package:taskmanagementapp/core/error/failure.dart';
import 'package:taskmanagementapp/core/usecase/usecases.dart';
import 'package:taskmanagementapp/features/auth/domain/entities/user_entity.dart';
import 'package:taskmanagementapp/features/auth/domain/repository/auth_repo.dart';

class UserCurrent implements UseCase<User, NoParams> {
  final AuthRepo authRepo;

  UserCurrent(this.authRepo);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepo.currentUser();
  }
}
