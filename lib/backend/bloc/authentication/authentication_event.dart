part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class WelcomePageEvent extends AuthenticationEvent {}

class StudentPageEvent extends AuthenticationEvent {}

class AdminPageEvent extends AuthenticationEvent {}

//BLOC BY MIRO
class StudentLogin extends AuthenticationEvent {
  final String StudentId;
  final String Password;

  StudentLogin(this.StudentId, this.Password);
}

// BY LANCE
class AdminLoginLogin extends AuthenticationEvent {
  final String adminID;
  final String password;

  AdminLoginLogin(this.adminID, this.password);
}

