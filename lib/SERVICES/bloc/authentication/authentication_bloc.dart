import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<WelcomePageEvent>(welcome_page);
    on<StudentPageEvent>(student_page);
    on<AdminPageEvent>(admin_page);
  }
  
  FutureOr<void> welcome_page(
    WelcomePageEvent event, Emitter<AuthenticationState> emit) {
      print('Welcome Screen');
      emit(WelcomePageState());
  }

  FutureOr<void> student_page(
    StudentPageEvent event, Emitter<AuthenticationState> emit) {
      print('Student Authentication');
      emit(StudentPageState());
  }

  FutureOr<void> admin_page(
    AdminPageEvent event, Emitter<AuthenticationState> emit) {
      print('Admin Authentication');
      emit(AdminPageState());
  }

}
