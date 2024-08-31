import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
  StudentExtendedBloc() : super(StudentExtendedInitial()) {
    on<CoursePageEvent>(course_page);
    on<StockPageEvent>(stock_page);
    on<UniformPageEvent>(uniform_page);
    on<BackpackPageEvent>(backpack_page);
    on<NotificationPageEvent>(notification_page);
    on<TransactionPageEvent>(transaction_page);
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


