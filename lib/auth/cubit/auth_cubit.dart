import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../data/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository = AuthRepository();

  AuthCubit() : super(AuthInitial()) {
    state.token is String
        ? emit(AuthAuthenticated(token: state.token))
        : emit(
            AuthNotAuthenticated(),
          );
  }

  void logIn({@required username, @required password}) async {
    emit(AuthLoginInProcess());

    try {
      String token = await _authRepository
          .logIn(username: username, password: password)
          .catchError(
        (error) {
          emit(AuthLoginFailure(errorMesage: error.message));
          return;
        },
      );

      if (token is String) {
        emit(AuthLoginSuccess());
        emit(AuthAuthenticated(token: token));
      }
    } catch (e) {
      emit(AuthLoginFailure(errorMesage: "Something went wront. Try again"));
    }
  }

  void logout() {
    emit(AuthNotAuthenticated());
  }
}
