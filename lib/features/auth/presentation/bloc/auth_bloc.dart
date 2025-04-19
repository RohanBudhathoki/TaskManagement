import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanagementapp/core/usecase/usecases.dart';

import 'package:taskmanagementapp/features/auth/domain/entities/user_entity.dart';

import 'package:taskmanagementapp/features/auth/domain/usecases/user_login.dart';
import 'package:taskmanagementapp/features/auth/domain/usecases/user_signout.dart';
import 'package:taskmanagementapp/features/auth/domain/usecases/user_signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final UserLogout _userlogout;

  AuthBloc({
    required UserSignUp userSignup,
    required UserLogin userLogin,
    required UserLogout userLogout,
  }) : _userSignUp = userSignup,
       _userLogin = userLogin,
       _userlogout = userLogout,

       super(AuthInitial()) {
    on<AuthEvent>((_, emit) => AuthLoading());
    on<AuthLogin>(_onAuthLogin);
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogout>(_onAuthLogOut);
  }
  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );
    response.fold(
      (l) => emit(AuthFailure(l.message)),
      (user) => emitSucesss(user, emit),
    );
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final response = await _userLogin(
      UserLoginParams(password: event.password, email: event.email),
    );
    response.fold(
      (l) => emit(AuthFailure(l.message)),
      (user) => emitSucesss(user, emit),
    );
  }

  void emitSucesss(User user, Emitter<AuthState> emit) {
    emit(AuthSucess(user));
  }

  void _onAuthLogOut(AuthLogout event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await _userlogout(NoParams());

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(AuthLogOutSucess()),
    );
  }
}
