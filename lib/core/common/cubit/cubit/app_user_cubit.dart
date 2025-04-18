import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanagementapp/features/auth/data/models/user_model.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  final FirebaseAuth _firebaseAuth;
  AppUserCubit(this._firebaseAuth) : super(AppUserInitial());

  void checkCurrentUser() {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser == null) {
      emit(AppUserInitial());
    } else {
      emit(AppUserLoggedIn(currentUser as UserModel));
    }
  }
}
