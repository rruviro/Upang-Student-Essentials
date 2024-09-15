import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

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
  AdminExtendedBloc() : super(AdminExtendedInitial()) {
    on<CoursePageEvent>(course_page);
    on<StockPageEvent>(stock_page);
    on<NewUniformPageEvent>(newUniform_page);
    on<UniformManagePageEvent>(uniformManage_page);
    on<UniformPageEvent>(uniform_page);
    on<NotificationPageEvent>(notification_page);
    on<TransactionPageEvent>(transaction_page);
    on<NewDepartmentPageEvent>(newDepartment_page);
    on<ManagePageEvent>(manage_page);
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