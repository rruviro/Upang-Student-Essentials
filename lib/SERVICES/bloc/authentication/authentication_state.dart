part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}
final class AuthenticationInitial extends AuthenticationState {}
abstract class ActionState extends AuthenticationState{}
class WelcomePageState extends ActionState{}
class StudentPageState extends ActionState{}
class AdminPageState extends ActionState{}

abstract class AuthActionState extends AuthenticationState{}
class AuthLoadingState extends AuthActionState{}
class AuthLoadSuccessState extends AuthActionState{}
class AuthErrorState extends AuthActionState {}