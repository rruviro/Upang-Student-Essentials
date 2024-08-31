part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}
class WelcomePageEvent extends AuthenticationEvent{}
class StudentPageEvent extends AuthenticationEvent{}
class AdminPageEvent extends AuthenticationEvent{}