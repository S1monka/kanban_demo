part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  final String token;
  AuthState({@required this.token});

  @override
  List<Object> get props => [token];
}

class AuthInitial extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String token;
  AuthAuthenticated({@required this.token}) : super(token: token);

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'AuthAuthenticated(token: $token)';
}

class AuthLoginInProcess extends AuthState {}

class AuthLoginSuccess extends AuthState {}

class AuthLoginFailure extends AuthState {
  final String errorMesage;

  AuthLoginFailure({
    @required this.errorMesage,
  });

  @override
  String toString() => 'AuthLoginFailure(errorMesage: $errorMesage)';
}

class AuthNotAuthenticated extends AuthState {}
