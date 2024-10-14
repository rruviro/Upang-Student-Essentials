import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:use/backend/apiservice/authApi/aurepo.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authrepo;
  AuthenticationBloc(this._authrepo) : super(AuthenticationInitial()) {
    on<WelcomePageEvent>(welcome_page);
    on<StudentPageEvent>(student_page);
    on<AdminPageEvent>(admin_page);

    //BLOC BY MIRO
    on<StudentLogin>((event, emit) async {
      final SharedPreferences login = await SharedPreferences.getInstance();
      emit(LoginLoading());
      try {
        await _authrepo.studentLogin(event.StudentId, event.Password);

        login.setString('StudentId', event.StudentId);
        login.setString('Password', event.Password);
        login.setBool('isLogin', true);
        login.setBool('isAdmin', false);
        emit(LoginSuccess(event.StudentId, event.Password));
      } catch (e) {
        emit(LoginError('Error logging in: ${e.toString()}'));
      }
    });

    // BY LANCE
    on<AdminLoginLogin>((event, emit) async {
      final SharedPreferences login = await SharedPreferences.getInstance();
      emit(AdminLoginLoading());
      try {
        await _authrepo.adminLogin(event.adminID, event.password);

        login.setString('adminID', event.adminID);
        login.setString('1Password', event.password);
        login.setBool('isLogin', true);
        login.setBool('isAdmin', true);
        emit(AdminLoginSuccess(event.adminID, event.password));
      } catch (e){
        emit(AdminLoginError('Error logging in: ${e.toString()}'));
      }
    });
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

  //BLOC BY MIR
}
