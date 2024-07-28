
import 'package:todo/auth/presentation/data/login.dart';

import '../data/register.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthRegisterLoading extends AuthState {}
class AuthLoginLoading extends AuthState {}
class ChangeVisibilityState extends AuthState {}
class ChangePasswordVisibilityState extends AuthState {}

class AuthRegisterSuccess extends AuthState {
  final AuthModel authModel;

  AuthRegisterSuccess(this.authModel);
}
class AuthLoginSuccess extends AuthState {
  final LoginModel authModel;

  AuthLoginSuccess(this.authModel);
}

class AuthRegisterError extends AuthState {
  final String error;

  AuthRegisterError(this.error);
}
class AuthLoginError extends AuthState {
  final String error;

  AuthLoginError(this.error);
}
