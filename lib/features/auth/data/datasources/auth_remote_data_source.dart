import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskmanagementapp/core/error/exception.dart';
import 'package:taskmanagementapp/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  // Session? get currentUserSession;
  Future<UserModel> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> currentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl(this.firebaseAuth, this.firestore);

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw const ServerException('User is null');
      }

      // Fetch user profile data from Firestore
      final userProfile =
          await firestore
              .collection('profiles')
              .doc(userCredential.user!.uid)
              .get();
      if (!userProfile.exists) {
        throw const ServerException('User profile not found');
      }

      final userModel = UserModel.fromJson(userProfile.data()!);
      return userModel.copyWith(email: userCredential.user!.email);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw const ServerException('User is null');
      }

      // Store additional user data (name, email) in Firestore
      await firestore.collection('profiles').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
      });

      // Return the created user model
      return UserModel(
        id: userCredential.user!.uid,
        email: userCredential.user!.email!,
        name: name,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> currentUser() async {
    try {
      final currentUser = firebaseAuth.currentUser;

      if (currentUser != null) {
        // Fetch the user profile data from Firestore
        final userProfile =
            await firestore.collection('profiles').doc(currentUser.uid).get();
        if (userProfile.exists) {
          final userModel = UserModel.fromJson(userProfile.data()!);
          return userModel.copyWith(email: currentUser.email);
        }
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  // @override
  // Session? get currentUserSession {
  //   final currentUser = firebaseAuth.currentUser;
  //   return currentUser != null ? Session(user: currentUser) : null;
  // }
}
