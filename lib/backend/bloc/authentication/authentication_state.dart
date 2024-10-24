part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

abstract class ActionState extends AuthenticationState {}

class WelcomePageState extends ActionState {}

class StudentPageState extends ActionState {}

class AdminPageState extends ActionState {}

abstract class AuthActionState extends AuthenticationState {}

class AuthLoadingState extends AuthActionState {}

class AuthLoadSuccessState extends AuthActionState {}

class AuthErrorState extends AuthActionState {}

//BLOC BY MIRO
class StudentLogingIn extends AuthenticationState {
  final String StudentId;
  final String Password;

  StudentLogingIn(this.StudentId, this.Password);
}

class LoginSuccess extends AuthenticationState {
  final String StudentId;
  final String Password;

  LoginSuccess(this.StudentId, this.Password);
}

class LoginFailed extends AuthenticationState {
  final String message;

  LoginFailed(this.message);
}

class LoginError extends AuthenticationState {
  final String message;

  LoginError(this.message);
}

class LoginLoading extends AuthenticationState {

}

// LANCE
class AdminStudentLogingIn extends AuthenticationState {
  final String adminID;
  final String password;

  AdminStudentLogingIn(this.adminID, this.password);
}

class AdminLoginSuccess extends AuthenticationState {
  final String adminID;
  final String password;

  AdminLoginSuccess(this.adminID, this.password);
}

class AdminLoginFailed extends AuthenticationState {
  final String message;

  AdminLoginFailed(this.message);
}

class AdminLoginError extends AuthenticationState {
  final String message;

  AdminLoginError(this.message);
}

class AdminLoginLoading extends AuthenticationState {

}


