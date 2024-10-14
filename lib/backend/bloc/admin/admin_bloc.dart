import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:use/backend/apiservice/adminApi/arepo.dart';
import 'package:use/backend/models/admin/Announcement.dart';
import 'package:use/backend/models/admin/Book.dart';
import 'package:use/backend/models/admin/Course.dart';
import 'package:use/backend/models/admin/Department.dart';
import 'package:use/backend/models/admin/Stock.dart';
import 'package:use/backend/bloc/student/student_bloc.dart';
import 'package:use/backend/models/admin/Uniform.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagBook.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagItem.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBottomBloc extends Bloc<AdminBottomEvent, AdminBottomState> {
  AdminBottomBloc() : super(const AdminBottomInitial(tabIndex: 0)) {
    on<AdminBottomEvent>((event, emit) {
      if (event is TabChange) {
        print(event.tabIndex);
        emit(AdminBottomInitial(tabIndex: event.tabIndex));
      }
    });
  }
}

class AdminExtendedBloc extends Bloc<AdminExtendedEvent, AdminExtendedState> {
  final Adminrepo _adminrepo;

  AdminExtendedBloc(this._adminrepo) : super(AdminExtendedInitial()) {
    on<CoursePageEvent>(course_page);
    on<StockPageEvent>(stock_page);
    on<NewUniformPageEvent>(newUniform_page);
    on<UniformManagePageEvent>(uniformManage_page);
    on<UniformPageEvent>(uniform_page);
    on<NotificationPageEvent>(notification_page);
    on<TransactionPageEvent>(transaction_page);
    on<NewDepartmentPageEvent>(newDepartment_page);
    on<ManagePageEvent>(manage_page);

    on<showCodeBookData>((event, emit) async {
      try {
        final bookData = await _adminrepo.showCodeBook(event.code);
        emit(bookCodeDataLoaded(bookData));
        //print(bookData);
      } catch (e) {
        emit(bookCodeDataError(e.toString()));
        add(getStudent());
      }
    });

    on<showCodeItemData>((event, emit) async {
      try {
        final itemData = await _adminrepo.showCodeItem(event.code);
        emit(itemCodeDataLoaded(itemData));
        print(itemData.gender);
        print(itemData.claimingSchedule);
        print(itemData.code);
        print(itemData.course);
        print(itemData.dateReceived);
        print(itemData.department);
        print(itemData.id);
        print(itemData.reservationNumber);
        print(itemData.size);
        print(itemData.status);
        print(itemData.stubagId);
        print(itemData.type);
      } catch (e) {
        emit(itemCodeDataError(e.toString()));
        add(getStudent());
      }
    });

    on<changeBookStatus>((event, emit) async {
      try {
        await _adminrepo.changeStudentBookStatus(event.id, event.status);
        emit(BookStatusChanged());
        add(getStudent());
      } catch (e) {
        print('Error: $e to change Book status.');
        //add(getStudent());
      }
    });

    on<changeItemStatus>((event, emit) async {
      try {
        await _adminrepo.changeStudentItemStatus(event.id, event.status);
        emit(ItemStatusChanged());
        add(getStudent());
      } catch (e) {
        print('Error: $e to change Item status.');
        // add(getStudent());
      }
    });

    on<createStudent>((event, emit) async {
      try {
        await _adminrepo.createStudent(event.firstName, event.lastName,
            event.course, event.department, event.year, event.enrolled);
        add(getStudent());
      } catch (e) {
        print(e);
        emit(studentError('Failed to add student'));
        add(getStudent());
      }
    });

    on<deleteStudent>((event, emit) async {
      try {
        await _adminrepo.deleteStudent(event.id);
        add(getStudent());
      } catch (e) {
        emit(studentError('Error deleting student: ${e.toString()}'));
        add(getStudent());
      }
    });

    on<updateStudent>((event, emit) async {
      try {
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        print(event.enrolled);
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        await _adminrepo.updateStudent(
            event.firstName,
            event.lastName,
            event.course,
            event.department,
            event.year,
            event.enrolled,
            event.id);
        add(getStudent());
      } catch (e) {
        emit(studentError(e.toString()));
        add(getStudent());
      }
    });

    on<getStudent>((event, emit) async {
      print("getStudent triggered");
      emit(studentLoading());
      try {
        print("try");
        final students = await _adminrepo.showAllStudentProfileData();
        emit(studentLoaded(students));
        print(students);
      } catch (e) {
        print(e);
        emit(studentError(e.toString()));
      }
    });

    on<showStudent>((event, emit) async {
      emit(studentLoading());
      try {
        final student = await _adminrepo.showStudentProfileData(event.id);
        emit(specificStudentLoaded(student));
      } catch (e) {
        emit(studentError(e.toString()));
      }
    });
    on<showAnnouncement>((event, emit) async {
      emit(announcementLoadingData());
      try {
        final announcementData = await _adminrepo.showAnnouncementData();
        emit(announcementLoadSuccessData(announcementData));
      } catch (e) {
        print(e);
        emit(announcementLoadErrorData('An error occurred: ${e.toString()}'));
      }
    });

    on<createAnnouncement>((event, emit) async {
      try {
        await _adminrepo.createAnnouncement(event.department, event.message);
        add(showAnnouncement());
      } catch (e) {
        print(e);
        emit(announcementLoadErrorData('An error occurred: ${e.toString()}'));
        add(showAnnouncement());
      }
    });

    // LANCE
    // FOR DEPARTMENTS
    on<ShowDepartmentsEvent>((event, emit) async {
      emit(DepartmentsLoadingState());
      try {
        final departmentData = await _adminrepo.showDepartments();
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
        final courseData = await _adminrepo.showCourses(event.departmentID);
        emit(CoursesLoadedState(
            courses: courseData)); // Change here to pass fetched courses
      } catch (e) {
        print(e);
        emit(CoursesErrorState('An error occurred: ${e.toString()}'));
      }
    });

    // FOR STOCK
    on<ShowStocksEvent>((event, emit) async {
      emit(StocksLoadingState());
      try {
        print('Fetching data for: ${event.Course}');
        final stockData = await _adminrepo.showStocks(event.Course);
        final bookData = await _adminrepo.showBooks(event.Course);
        print('stock fetched successfully');
        emit(StocksLoadedState(stocks: stockData, books: bookData));
      } catch (e) {
        print('error fetching stocks or books: $e');
        emit(StocksErrorState('an error occured: ${e.toString()}'));
      }
    });

    // FOR UNIFORM
    on<ShowUniformsEvent>((event, emit) async {
      emit(UniformsLoadingState());
      try {
        print('fetching data for uniforms');
        final uniformData = await _adminrepo.showUniforms(
            event.Course, event.Gender, event.Type, event.Body);
        print('uniforms fetched successfully');
        emit(UniformsLoadedState(uniforms: uniformData));
      } catch (e) {
        print('error fetching stocks or books: $e');
        emit(UniformsErrorState('an error occured: ${e.toString()}'));
      }
    });

    on<bookreservefirst>((event, emit) async {
      try {
        await _adminrepo.bookreservefirst(event.count, event.bookname);
      } catch (e) {
        print('error fetching stocks or books: $e');
      }
    });

    on<itemreservefirst>((event, emit) async {
      try {
        await _adminrepo.uniformreservefirst(event.count, event.Course,
            event.Gender, event.Type, event.Body, event.Size);
        add(ShowUniformsEvent(
            event.Course, event.Gender, event.Type, event.Body));
      } catch (e) {
        print('error fetching stocks or books: $e');
      }
    });

    List<StudentBagItem>? studentBagItems;
    List<StudentBagBook>? studentBagBooks;
    bool itemsLoaded = false;
    bool booksLoaded = false;

    on<studentBagItem>((event, emit) async {
      studentBagItems = [];
      itemsLoaded = false;
      emit(studentLoading());
      try {
        final itemData = await _adminrepo.showStudentBagItemData();
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
        emit(StudentBagBookErrorState('An error occurred: ${e.toString()}'));
        itemsLoaded = false;
      }
    });

    on<studentBagBook>((event, emit) async {
      studentBagBooks = [];
      booksLoaded = false;
      print("book work");
      emit(studentLoading());
      try {
        print("book work2");
        final bookData = await _adminrepo.showStudentBagBookData();
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

    // on<createUniform>((event, emit) async {
    //   try {
    //     await _adminrepo.createUniform(event.Department,event.Course,event.Gender,event.Type,event.Body,event.Size,event.Stock,);
    //     add(ShowUniformsEvent(Course: Course));
    //   } catch (e) {
    //     print(e);
    //     emit(announcementLoadErrorData('An error occurred: ${e.toString()}'));
    //     add(showAnnouncement());
    //   }
    // });
  }

  FutureOr<void> course_page(
      CoursePageEvent event, Emitter<AdminExtendedState> emit) {
    print('Course Page');
    emit(CoursePageState());
  }

  FutureOr<void> stock_page(
      StockPageEvent event, Emitter<AdminExtendedState> emit) {
    print('Stock Page');
    emit(StockPageState());
  }

  FutureOr<void> newUniform_page(
      NewUniformPageEvent event, Emitter<AdminExtendedState> emit) {
    print('New Uniform Page');
    emit(NewUniformPageState());
  }

  FutureOr<void> uniformManage_page(
      UniformManagePageEvent event, Emitter<AdminExtendedState> emit) {
    print('Uniform Manage Page');
    emit(UniformManagePageState());
  }

  FutureOr<void> uniform_page(
      UniformPageEvent event, Emitter<AdminExtendedState> emit) {
    print('Uniform Page');
    emit(UniformPageState());
  }

  FutureOr<void> notification_page(
      NotificationPageEvent event, Emitter<AdminExtendedState> emit) {
    print('Notification Page');
    emit(NotificationPageState());
  }

  FutureOr<void> transaction_page(
      TransactionPageEvent event, Emitter<AdminExtendedState> emit) {
    print('Transaction Page');
    emit(TransactionPageState());
  }

  FutureOr<void> newDepartment_page(
      NewDepartmentPageEvent event, Emitter<AdminExtendedState> emit) {
    print('New Department Page');
    emit(NewDepartmentPageState());
  }

  FutureOr<void> manage_page(
      ManagePageEvent event, Emitter<AdminExtendedState> emit) {
    print('Manage Department Page');
    emit(ManagePageState());
  }
}
