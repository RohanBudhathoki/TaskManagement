import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanagementapp/core/common/cubit/cubit/app_user_cubit.dart';
import 'package:taskmanagementapp/features/auth/domain/entities/user_entity.dart';
import 'package:taskmanagementapp/features/auth/domain/usecases/curret_user.dart';
import 'package:taskmanagementapp/features/auth/domain/usecases/user_login.dart';
import 'package:taskmanagementapp/features/auth/domain/usecases/user_signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final UserCurrent _userCurrent;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignUp userSignup,
    required UserLogin userLogin,
    required UserCurrent userCurrent,
    required AppUserCubit appUser,
  }) : _userSignUp = userSignup,
       _userLogin = userLogin,
       _userCurrent = userCurrent,
       _appUserCubit = appUser,
       super(AuthInitial()) {
    on<AuthEvent>((_, emit) => AuthLoading());
    on<AuthLogin>(_onAuthLogin);
    on<AuthSignUp>(_onAuthSignUp);
    // on<AuthisUserLoggedIn>(_onIsUserLoggedIn);
  }
  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
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
    final response = await _userLogin(
      UserLoginParams(password: event.password, email: event.email),
    );
    response.fold(
      (l) => emit(AuthFailure(l.message)),
      (user) => emitSucesss(user, emit),
    );
  }

  // void _onIsUserLoggedIn(
  //   AuthisUserLoggedIn event,
  //   Emitter<AuthState> emit,
  // ) async {
  //   final res = await _userCurrent(NoParams());

  //   res.fold((l) => emit(AuthFailure(l.message)), (user) {
  //     emitSucesss(user, emit);
  //   });
  // }

  void emitSucesss(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSucess(user));
  }
}
