import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<WelcomePageEvent>(welcome_page);
    on<StudentPageEvent>(student_page);
    on<AdminPageEvent>(admin_page);

    //BLOC BY MIRO
    on<StudentLogin>(loginStudent);
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

  //BLOC BY MIRO
  Future<void> loginStudent(
      StudentLogin event, Emitter<AuthenticationState> emit) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/auth/student/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'studentId': event.StudentId,
          'password': event.Password,
        }),
      );

      if (response.statusCode == 200) {
        emit(LoginSuccess(event.StudentId, event.Password));
      } else {
        emit(LoginFailed('Wrong Credentials'));
        print("failed");
      }
    } catch (e) {
      emit(LoginError('Error logging in: ${e.toString()}'));
    }
  }
}
