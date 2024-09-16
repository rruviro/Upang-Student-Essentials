import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:use/backend/apiservice/studentApi/srepo.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagBook.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagItem.dart';
import 'package:use/backend/models/student/StudentData/Student.dart';
import 'package:use/backend/models/student/StudentData/StudentBag.dart';
import 'package:use/backend/models/student/StudentData/StudentNotifcation.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';
import 'package:use/backend/models/student/StudentNotificationData/StudentNotificationMail.dart';


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

class StudentExtendedBloc extends Bloc<StudentExtendedEvent, StudentExtendedState> {
      final Studentrepo _studentrepo;

      StudentExtendedBloc(this._studentrepo) : super(StudentExtendedInitial()) {
      on<CoursePageEvent>(course_page);
      on<StockPageEvent>(stock_page);
      on<BackpackPageEvent>(backpack_page);
      on<NotificationPageEvent>(notification_page);
      on<TransactionPageEvent>(transaction_page);

      //BY MIRO
      on<studentProfileGet>((event, emit) async {
        try {
          print("object");
          emit(SpecificStudentLoadingState());
          
          // Fetch student data
          final studentData = await _studentrepo.showStudentData(event.studentId);

          // Debugging: Print the fetched data to check if it's not null and contains the expected information
          print('Fetched student data: $studentData');
          
          // Check if studentData is not null and contains expected fields
          if (studentData != null) {
            print('Student profile: ${studentData.profile}');
            print('Student bag: ${studentData.studentBag}');
            print('Student notifications: ${studentData.notification}');
          } else {
            print('No student data received.');
          }
          
          emit(SpecificStudentLoadSuccessState(
            studentProfile: studentData.profile,
            studentBag: studentData.studentBag,
            studentNotification: studentData.notification,
          ));
        } catch (e) {
          print(e);
          emit(SpecificStudentErrorState('An error occurred: ${e.toString()}'));
        }
      });
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
