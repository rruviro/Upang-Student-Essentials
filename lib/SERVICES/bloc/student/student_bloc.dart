import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:use/SERVICES/model/StudentData/StudentBag.dart';
import 'package:use/SERVICES/model/StudentData/StudentBagData/StudentBagBook.dart';
import 'package:use/SERVICES/model/StudentData/StudentBagData/StudentBagItem.dart';
import 'package:use/SERVICES/model/StudentData/StudentNotifcation.dart';
import 'package:use/SERVICES/model/StudentData/StudentNotificationData/StudentNotificationMail.dart';
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
      on<studentBagItem>(showStudentBagItemData);
      on<studentNotificationMail>(showStudenNotificationMailData);
      on<studentBagBook>(showStudentBagBookData);
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

        if (response.statusCode == 200) {
          final responseBody = json.decode(response.body);

          if (responseBody['student'] != null) {
            final studentData = responseBody['student'];
            
            final profileJson = studentData['profile'] != null 
                ? studentData['profile'] as Map<String, dynamic> 
                : null;
            
            final studentBagJson = studentData['student_bag'] != null 
                ? studentData['student_bag'] as Map<String, dynamic> 
                : null;
            
            final notificationJson = studentData['notification'] != null 
                ? studentData['notification'] as Map<String, dynamic> 
                : null;
            
            final studentProfile = profileJson != null 
                ? StudentProfile.fromJson(profileJson) 
                : null;
            
            final studentBag = studentBagJson != null 
                ? StudentBag.fromJson(studentBagJson) 
                : null;
            
            final notification = notificationJson != null 
                ? StudentNotification.fromJson(notificationJson) 
                : null;

            if (studentProfile != null) {
            emit(SpecificStudentLoadSuccessState(studentProfile, studentBag!, notification!));

              // Print profile details
              /*print("Student ID: ${studentProfile.stuId}");
              print("Name: ${studentProfile.firstName} ${studentProfile.lastName}");
              print("Course: ${studentProfile.course}");
              print("Department: ${studentProfile.department}");
              print("Year: ${studentProfile.year}");
              print("Status: ${studentProfile.status}");
              print("Has Uniform: ${studentProfile.hasUUniform}");
              print("Has L Uniform: ${studentProfile.hasLUniform}");
              print("Has RSO: ${studentProfile.hasRSO}");
              print("Has Books: ${studentProfile.hasBooks}");*/

              // Print student bag details if available
              if (studentBag != null) {
                //print("Student Bag ID: ${studentBag.id}");
                //print("Student Bag ID: ${studentBag.stuId}");
              }

              // Print notification details if available
              if (notification != null) {
                //print("Notification ID: ${notification.id}");
                //print("Notification Student ID: ${notification.stuId}");
              }
            } else {
              emit(SpecificStudentErrorState('Student profile data is incomplete'));
              //print("Student profile data is incomplete");
            }
          } else {
            emit(SpecificStudentErrorState('No student data found'));
            //print("No student data found");
          }
        } else {
          emit(SpecificStudentErrorState('Failed to load student, status code: ${response.statusCode}'));

        }
      } catch (e) {
        //print('Exception: ${e.toString()}');
        emit(SpecificStudentErrorState('An error occurred: ${e.toString()}'));
      }
    }

    //STUDENT NOTIFICATION
    Future<void> showStudenNotificationMailData(
    studentNotificationMail event, Emitter<StudentExtendedState> emit) async {
      try {
        final response = await http.get(
          Uri.parse('http://127.0.0.1:8000/api/mails/${event.stunotification_id}'),
        );

        if (response.statusCode == 200) {
          final responseBody = json.decode(response.body);

          List<dynamic> MialsJson = responseBody['mails'];
          List<StudentNotifcationMail> mails = MialsJson.map((json) => StudentNotifcationMail.fromJson(json)).toList();
          
          print('Emitting StudentNotificationMailLoadSuccessState with ${mails.length} items');
          emit(StudentNotificationMailLoadSuccessState(mails));
        } else {
          emit(StudentNotificationMailErrorState(''));
          print('http://127.0.0.1:8000/api/mails/${event.stunotification_id}');
          print("Failed to load student, status code: ${response.statusCode}");
        }
      } catch (e) {
        emit(StudentNotificationMailErrorState('An error occurred: ${e.toString()}'));
        print(e.toString());
        print(event.stunotification_id);
      }
    }
    
    //STUDENT BAG ITEM AND BOOK
    List<StudentBagItem>? studentBagItems;
    List<StudentBagBook>? studentBagBooks;
    bool itemsLoaded = false;
    bool booksLoaded = false;

    Future<void> showStudentBagBookData(
      studentBagBook event, Emitter<StudentExtendedState> emit) async {
      studentBagBooks = [];
      booksLoaded = false;

      try {
        final response = await http.get(
          Uri.parse('http://127.0.0.1:8000/api/bookcollections/${event.stubag_id}/${event.status}'),
        );

        if (response.statusCode == 200) {
          final responseBody = json.decode(response.body);
          List<dynamic> itemsJson = responseBody['bookCollections'];
          studentBagBooks = itemsJson.map((json) => StudentBagBook.fromJson(json)).toList();
          booksLoaded = true;
        } else {
          emit(StudentBagBookErrorState('Failed to load bag books'));
          booksLoaded = true;
        }

        if (itemsLoaded && booksLoaded) {
          emit(StudentBagCombinedLoadSuccessState(
            studentBagItems ?? [], 
            studentBagBooks ?? [],
          ));
        }
      } catch (e) {
        emit(StudentBagBookErrorState('An error occurred: ${e.toString()}'));
        booksLoaded = false;
      }
    }

    Future<void> showStudentBagItemData(
      studentBagItem event, Emitter<StudentExtendedState> emit) async {
      studentBagItems = [];
      itemsLoaded = false;
      try {
        final response = await http.get(
          Uri.parse('http://127.0.0.1:8000/api/studentbagitems/${event.stubag_id}/${event.status}'),
        );

        if (response.statusCode == 200) {
          final responseBody = json.decode(response.body);
          List<dynamic> itemsJson = responseBody['items'];
          studentBagItems = itemsJson.map((json) => StudentBagItem.fromJson(json)).toList();
          itemsLoaded = true;
        } else {
          emit(StudentBagItemErrorState('Failed to load bag items'));
          itemsLoaded = true;
        }

        if (itemsLoaded && booksLoaded) {
          emit(StudentBagCombinedLoadSuccessState(
            studentBagItems ?? [], 
            studentBagBooks ?? [],
          ));
        }
      } catch (e) {
        emit(StudentBagItemErrorState('An error occurred: ${e.toString()}'));
        itemsLoaded = false;
      }
    }
}
