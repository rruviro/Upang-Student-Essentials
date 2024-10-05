import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:use/backend/apiservice/studentApi/srepo.dart';
import 'package:use/backend/models/admin/Announcement.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagBook.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagItem.dart';
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

class StudentExtendedBloc
    extends Bloc<StudentExtendedEvent, StudentExtendedState> {
  final Studentrepo _studentrepo;

  StudentExtendedBloc(this._studentrepo) : super(StudentExtendedInitial()) {
    on<CoursePageEvent>(course_page);
    on<StockPageEvent>(stock_page);
    on<BackpackPageEvent>(backpack_page);
    on<NotificationPageEvent>(notification_page);
    on<TransactionPageEvent>(transaction_page);

    //BY MIRO

    on<deleteBookData>((event, emit) async {
      try {
        await _studentrepo.deleteStudentBookData(event.id);
        emit(BookDataDeleted());
      } catch (e) {}
    });

    on<deleteItemData>((event, emit) async {
      try {
        await _studentrepo.deleteStudentItemData(event.id);
        emit(ItemDataDeleted());
      } catch (e) {}
    });

    on<changeBookStatus>((event, emit) async {
      try {
        await _studentrepo.changeStudentBookStatus(event.id, event.status);
        emit(BookStatusChanged());
      } catch (e) {
        print('Error: $e to change Book status.');
      }
    });

    on<changeItemStatus>((event, emit) async {
      try {
        await _studentrepo.changeStudentItemStatus(event.id, event.status);
        emit(ItemStatusChanged());
      } catch (e) {
        print('Error: $e to change Item status.');
      }
    });

    on<changeReservedBookStatus>((event, emit) async {
      try {
        await _studentrepo.reservedBookFirst(event.count);
        emit(BookStatusChanged());
      } catch (e) {
        print('Error: $e to change Book status.');
      }
    });

    on<changeReservedItemStatus>((event, emit) async {
      try {
        await _studentrepo.reservedItemFirst(event.count);
        emit(ItemStatusChanged());
      } catch (e) {
        print('Error: $e to change Item status.');
      }
    });

    on<studentProfileGet>((event, emit) async {
      try {
        emit(SpecificStudentLoadingState());
        final studentData = await _studentrepo.showStudentData(event.studentId);

        print('Student data received.');

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

    on<allstudentBagBook>((event, emit) async {
      emit(StudentBagBookLoadingState());
      try {
        final itemData =
            await _studentrepo.showAllStudentBagItemData(event.stubag_id);
        emit(StudentBagItemLoadSuccessState(itemData));
      } catch (e) {
        emit(StudentBagItemErrorState('An error occurred: ${e.toString()}'));
      }
    });

    on<allstudentBagItem>((event, emit) async {
      emit(StudentBagItemLoadingState());
      try {
        final BookData =
            await _studentrepo.showAllStudentBagBookData(event.stubag_id);
        emit(StudentBagBookLoadSuccessState(BookData));
      } catch (e) {
        emit(StudentBagBookErrorState('An error occurred: ${e.toString()}'));
      }
    });   

    List<StudentBagItem>? studentBagItems;
    List<StudentBagBook>? studentBagBooks;
    bool itemsLoaded = false;
    bool booksLoaded = false;

    on<studentBagItem>((event, emit) async {
      studentBagItems = [];
      itemsLoaded = false;

      try {
        final itemData = await _studentrepo.showStudentBagItemData(
            event.stubag_id, event.status);
        studentBagItems = itemData;
        itemsLoaded = true;

        if (itemsLoaded && booksLoaded) {
          emit(StudentBagCombinedLoadSuccessState(
            studentBagItems ?? [],
            studentBagBooks ?? [],
          ));
          print("item work");
        }
      } catch (e) {
        emit(StudentBagItemErrorState('An error occurred: ${e.toString()}'));
        itemsLoaded = false;
      }
    });

    on<studentBagBook>((event, emit) async {
      studentBagBooks = [];
      booksLoaded = false;
      print("book work");
      try {
        print("book work2");
        final bookData = await _studentrepo.showStudentBagBookData(
            event.stubag_id, event.status);
        studentBagBooks = bookData;
        booksLoaded = true;

        if (itemsLoaded && booksLoaded) {
          print("book work3");
          emit(StudentBagCombinedLoadSuccessState(
            studentBagItems ?? [],
            studentBagBooks ?? [],
          ));
          print("book work");
        }
      } catch (e) {
        print(e);
        emit(StudentBagBookErrorState('An error occurred: ${e.toString()}'));
        booksLoaded = false;
      }
    });

    on<studentNotificationMail>((event, emit) async {
      try {
        final mailData = await _studentrepo
            .showStudenNotificationMailData(event.stunotification_id);
        emit(StudentNotificationMailLoadSuccessState(mailData));
      } catch (e) {
        print(e);
      }
    });

    on<showAnnouncementData>((event, emit) async {
      emit(announcementLoadingData());
      try {
        final announcementData =
            await _studentrepo.showAnnouncementData(event.dept);
        emit(announcementLoadSuccessData(announcementData));
      } catch (e) {
        print(e);
        emit(announcementLoadErrorData('An error occurred: ${e.toString()}'));
      }
    });

    //STUDENT MANAGEMENT

    on<createStudent>((event, emit) async{
      emit(studentLoading());
      try {
        await _studentrepo.createStudent(event.firstName, event.lastName, event.course, event.department, event.year, event.enrolled);
        add(getStudent());
      } catch (e) {
        emit(studentError('Failed to add student'));
      }
    });

    on<deleteStudent>((event, emit) async{
      try {
        await _studentrepo.deleteStudent(event.id);
      } catch (e) {
        emit(studentError('Error deleting student: ${e.toString()}'));
      }
    });

    on<updateStudent>((event, emit) async{
      try {
        await _studentrepo.updateStudent(event.firstName, event.lastName, event.course, event.department, event.year, event.enrolled, event.id);
      } catch (e) {
        emit(studentError(e.toString()));
      }
    });

    on<getStudent>((event, emit) async{
      try {
        final students = await _studentrepo.showAllStudentProfileData();
        emit(studentLoaded(students));
      } catch (e) {
        emit(studentError(e.toString()));
      }
    });

    on<showStudent>((event, emit) async{
      emit(studentLoading());
      try {
        final student = await _studentrepo.showStudentProfileData(event.id);
        emit(specificStudentLoaded(student));
      } catch (e) {
        emit(studentError(e.toString()));
      }
    });

    on<AddStudentBagBook>((event, emit) async {
      try {
        await _studentrepo.addStudentBookData(event.id, event.department, event.bookName, event.subjectCode, event.subjectDesc, event.status);
      } catch (e) {
        print('$e');
        emit(bookError('An error occurred: ${e.toString()}'));
      }
    });

    on<AddStudentBagItem>((event, emit) async {
      try {
        await _studentrepo.addStudentItemData(event.id, event.department, event.course, event.gender, event.type, event.body, event.size, event.status);
      } catch (e) {
        print('$e');
        emit(itemError('An error occurred: ${e.toString()}'));
      }
    });
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
}
