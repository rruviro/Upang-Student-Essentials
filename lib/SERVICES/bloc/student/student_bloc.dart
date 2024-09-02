import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:use/SERVICES/model/StudentData/StudentProfile.dart';
import 'package:use/SERVICES/model/admin/Student.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBottomBloc extends Bloc<StudentBottomEvent, StudentBottomState> {
  StudentBottomBloc() : super(const StudentBottomInitial(tabIndex: 0)) {
    on<StudentBottomEvent>((event, emit) {
      if (event is TabChange) {
        print(event.tabIndex);
        emit(StudentBottomInitial(tabIndex: event.tabIndex));
      }
    });
  }
}

class StudentExtendedBloc
    extends Bloc<StudentExtendedEvent, StudentExtendedState> {
  StudentExtendedBloc() : super(StudentExtendedInitial()) {
    on<CoursePageEvent>(course_page);
    on<StockPageEvent>(stock_page);
    on<UniformPageEvent>(uniform_page);
    on<BackpackPageEvent>(backpack_page);
    on<NotificationPageEvent>(notification_page);
    on<TransactionPageEvent>(transaction_page);

    //BY MIRO
    on<studentProfileGet>(showStudentData);
  }

  FutureOr<void> course_page(
      CoursePageEvent event, Emitter<StudentExtendedState> emit) {
    print('Course Page');
    emit(CoursePageState());
  }

  FutureOr<void> stock_page(
      StockPageEvent event, Emitter<StudentExtendedState> emit) {
    print('Stocks Page');
    emit(StockPageState());
  }

  FutureOr<void> uniform_page(
      UniformPageEvent event, Emitter<StudentExtendedState> emit) {
    print('Uniform Page');
    emit(UniformPageState());
  }

  FutureOr<void> backpack_page(
      BackpackPageEvent event, Emitter<StudentExtendedState> emit) {
    print('Backpack Page');
    emit(BackpackPageState());
  }

  FutureOr<void> notification_page(
      NotificationPageEvent event, Emitter<StudentExtendedState> emit) {
    print('Notification Page');
    emit(NotificationPageState());
  }

  FutureOr<void> transaction_page(
      TransactionPageEvent event, Emitter<StudentExtendedState> emit) {
    print('Transaction Page');
    emit(TransactionPageState());
  }

  //BLOC BY MIRO
  Future<void> showStudentData(
      studentProfileGet event, Emitter<StudentExtendedState> emit) async {
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/students/${event.studentId}'),
      );

      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = json.decode(response.body);

        if (responseBody['student'] != null &&
            responseBody['student']['profile'] != null) {
          Map<String, dynamic> profileJson = responseBody['student']['profile'];
          StudentProfile student = StudentProfile.fromJson(profileJson);
          emit(SpecificStudentLoadSuccessState(student));

          print("Student ID: ${student.stuId}");
          print("Name: ${student.firstName} ${student.lastName}");
          print("Course: ${student.course}");
          print("Department: ${student.department}");
          print("Year: ${student.year}");
          print("Status: ${student.status}");
          print("Has Uniform: ${student.hasUUniform}");
          print("Has L Uniform: ${student.hasLUniform}");
          print("Has RSO: ${student.hasRSO}");
          print("Has Books: ${student.hasBooks}");
        } else {
          emit(SpecificStudentErrorState('No student profile data found'));
          print("No student profile data found");
        }
      } else {
        emit(SpecificStudentErrorState('Failed to load student'));
        print("Failed to load student");
      }
    } catch (e) {
      print(e.toString());
      print(event.studentId);
      emit(SpecificStudentErrorState(e.toString()));
    }
  }
}
