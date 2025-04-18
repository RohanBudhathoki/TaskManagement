import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:fpdart/fpdart.dart';
import 'package:taskmanagementapp/core/error/exception.dart';
import 'package:taskmanagementapp/core/error/failure.dart';
import 'package:taskmanagementapp/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:taskmanagementapp/features/auth/domain/entities/user_entity.dart';
import 'package:taskmanagementapp/features/auth/domain/repository/auth_repo.dart';

class AuthRepoImple implements AuthRepo {
  final AuthRemoteDataSource remoteDataSource;
  final firebase_auth.FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRepoImple(this.remoteDataSource, this.firebaseAuth, this.firestore);

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    return _getUser(
      () async => await remoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signupWitchEmailPassword({
    required String name,
    required String email,
    required String password,
  }) {
    return _getUser(
      () async => await remoteDataSource.signupWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      final user = await fn();
      return right(user);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return left(Failure(message: e.message ?? 'Authentication error'));
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final currentUser = firebaseAuth.currentUser;
      if (currentUser != null) {
        // Fetch the user profile data from Firestore
        final userProfile =
            await firestore.collection('profiles').doc(currentUser.uid).get();
        if (userProfile.exists) {
          // final user = User.fromJson(userProfile.data()!);
          // return right(user.copyWith(email: currentUser.email));
        }
      }
      return left(Failure(message: 'User not logged in!'));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
