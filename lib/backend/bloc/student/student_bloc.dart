import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:use/backend/apiservice/studentApi/srepo.dart';
import 'package:use/backend/bloc/admin/admin_bloc.dart';
import 'package:use/backend/models/admin/Announcement.dart';
import 'package:use/backend/models/admin/Book.dart';
import 'package:use/backend/models/admin/Course.dart';
import 'package:use/backend/models/admin/Department.dart';
import 'package:use/backend/models/admin/Stock.dart';
import 'package:use/backend/models/admin/Uniform.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagBook.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagItem.dart';
import 'package:use/backend/models/student/StudentData/StudentBag.dart';
import 'package:use/backend/models/student/StudentData/StudentNotifcation.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';
import 'package:use/backend/models/student/StudentNotificationData/StudentNotificationMail.dart';
import 'package:use/frontend/student/profile/uniforms.dart';

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

    on<reserveorclaimBook>((event, emit) async {
      try {
        await _studentrepo.reserveorclaimBook(event.id, event.status);
        emit(BookStatusChanged());
      } catch (e) {
        print('Error: $e to change Book status.');
      }
    });

    on<reserveorclaimItem>((event, emit) async {
      try {
        await _studentrepo.reserveorclaimItem(event.id, event.status);
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
        final BookData = await _studentrepo.showAllStudentBagBookData(
            event.stubag_id, event.status);
        emit(StudentBagBookLoadSuccessState(BookData));
      } catch (e) {
        emit(StudentBagItemErrorState('An error occurred: ${e.toString()}'));
      }
    });

    on<allstudentBagItem>((event, emit) async {
      emit(StudentBagItemLoadingState());
      try {
        final itemData = await _studentrepo.showAllStudentBagItemData(
            event.stubag_id, event.status);

        emit(StudentBagItemLoadSuccessState(itemData));
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

    on<AddStudentBagBook>((event, emit) async {
      try {
        await _studentrepo.addStudentBookData(
          event.id,
          // event.course, //DAGDAG NI LANCE
          event.department,
          event.bookName,
          event.subjectCode,
          event.subjectDesc,
          event.status,
          event.shift,
        );
      } catch (e) {
        print("Error adding book: $e");
        emit(StocksErrorState(e.toString()));
      }
    });

    on<AddStudentBagItem>((event, emit) async {
      try {
        await _studentrepo.addStudentItemData(
            event.id,
            event.department,
            event.course,
            event.gender,
            event.type,
            event.body,
            event.size,
            event.status,
            event.shift);
      } catch (e) {
        emit(itemError('An error occurred: ${e.toString()}'));
      }
    });

    on<AddReserveBagBook>((event, emit) async {
      try {
        await _studentrepo.addreserveBookData(
            event.id,
            // event.course, //DAG DAG NI LANCE
            event.department,
            event.bookName,
            event.subjectCode,
            event.subjectDesc,
            event.status,
            event.shift,
            event.stocks);
        add(ShowStocksEvent(Course: event.course)); //EDITED NI LANCE
        add(allstudentBagBook(event.id, "All"));
      } catch (e) {
        print("ERROR");
        emit(bookError(e.toString()));
        add(ShowStocksEvent(Course: event.course)); // EDITED NI LANCE
      }
    });

    on<AddReserveBagItem>((event, emit) async {
      try {
        await _studentrepo.addreserveItemData(
            event.id,
            event.department,
            event.course,
            event.gender,
            event.type,
            event.body,
            event.size,
            event.status,
            event.shift,
            event.stocks);
      } catch (e) {
        emit(itemError('An error occurred: ${e.toString()}'));
      }
    });

    on<createNotification>((event, emit) async {
      try {
        await _studentrepo.createNotificationData(event.id, event.message);
      } catch (e) {
        print(e);
      }
    });

    on<changePassword>((event, emit) async {
      try {
        await _studentrepo.changePasswords(
            event.id, event.password, event.cpassword);
        print("done");
      } catch (e) {
        print("Shit na malagkit");
      }
    });

    // LANCE
    // FOR DEPARTMENTS
    on<ShowDepartmentsEvent>((event, emit) async {
      emit(DepartmentsLoadingState());
      try {
        final departmentData = await _studentrepo.showDepartments();
        emit(DepartmentsLoadedState(departmentData));
      } catch (e) {
        print(e);
        emit(DepartmentsErrorState('An error occurred: ${e.toString()}'));
      }
    });

    // FOR COURSES
    on<ShowCoursesEvent>((event, emit) async {
      emit(CoursesLoadingState());
      try {
        final courseData = await _studentrepo.showCourses(event.departmentID);
        emit(CoursesLoadedState(courses: courseData));
      } catch (e) {
        print(e);
        emit(CoursesErrorState('An error occurred: ${e.toString()}'));
      }
    });

    // FOR BOOKS
    // on<ShowBooksEvent>((event, emit) async {
    //   emit(BooksLoadingState());
    //   try {
    //     final bookData = await _studentrepo.showBooks(event.Department);
    //     emit(BooksLoadedState(books: bookData));
    //   } catch (e) {
    //     print(e);
    //     emit(BooksErrorState('An error occurred: ${e.toString()}'));
    //   }
    // });

    // FOR STOCK
    on<ShowStocksEvent>((event, emit) async {
      emit(StocksLoadingState());
      try {
        print('Fetching data for department: ${event.Course}'); // PINALITAN KO YUNG COURSES, DEPARTMENT DATI
        final stockData = await _studentrepo.showStocks(event.Course);
        final bookData = await _studentrepo.showBooks(event.Course);
        print('Stocks and books fetched successfully');
        emit(StocksLoadedState(stocks: stockData, books: bookData));
      } catch (e) {
        print('Error fetching stocks or books: $e');
        emit(StocksErrorState('An error occurred: ${e.toString()}'));
      }
    });
    // FOR UNIFORM
    on<ShowUniformsEvent>((event, emit) async {
      emit(UniformsLoadingState());
      try {
        final uniformData = await _studentrepo.showUniforms(event.Course, event.Gender, event.Type, event.Body);
        emit(UniformsLoadedState(uniforms: uniformData));
      } catch (e) {
        emit(UniformsErrorState('An error occurred: ${e.toString()}'));
      }
    });

    on<itemreduceStocks>((event, emit) async {
      try {
        await _studentrepo.itemreduceStocks(event.count, event.department,
            event.course, event.gender, event.type, event.body, event.size);
      } catch (e) {
        print('Error reducing stocks: $e');
      }
    });

    on<bookreduceStocks>((event, emit) async {
      try {
        await _studentrepo.bookreduceStocks(event.count, event.department,
            event.bookname, event.subcode, event.subdesc);
      } catch (e) {
        print('Error reducing stocks: $e');
      }
    });

    on<itemStocks>((event, emit) async {
      emit(ItemStockLoading());

      try {
        final stock = await _studentrepo.uniformStock(
          event.department,
          event.course,
          event.gender,
          event.type,
          event.body,
          event.size,
        );

        if (stock != null) {
          emit(ItemStockLoaded(stock: stock));
        } else {
          emit(ItemStockError('Stock not found'));
        }
      } catch (e) {
        emit(ItemStockError(e.toString()));
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
