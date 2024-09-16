part of 'student_bloc.dart';

@immutable
sealed class StudentBottomState {
  final int tabIndex;
  const StudentBottomState({required this.tabIndex});
}

final class StudentBottomInitial extends StudentBottomState {
  const StudentBottomInitial({required super.tabIndex});
}

@immutable
abstract class StudentExtendedState {}

abstract class StudentActionState extends StudentExtendedState {}

class StudentExtendedInitial extends StudentActionState {}

class StudentLoadingState extends StudentActionState {}

class StudentLoadSuccessState extends StudentActionState {}

class StudentErrorState extends StudentActionState {}

class CoursePageState extends StudentActionState {}

class StockPageState extends StudentActionState {}

class UniformPageState extends StudentActionState {}

class BackpackPageState extends StudentActionState {}

class NotificationPageState extends StudentActionState {}

class TransactionPageState extends StudentActionState {}

//BY MIRO

//SPECIFIC STUDENT
class SpecificStudentLoadingState extends StudentActionState {}

class SpecificStudentLoadSuccessState extends StudentActionState {
  final StudentProfile studentProfile;
  final StudentBag studentBag;
  final StudentNotification studentNotification;

  SpecificStudentLoadSuccessState({
    required this.studentProfile,
    required this.studentBag,
    required this.studentNotification,
  });
}

class SpecificStudentErrorState extends StudentActionState {
  final String error;
  SpecificStudentErrorState(this.error);
}

//STUDENT BAG ITEM
class StudentBagItemLoadingState extends StudentActionState {}

class StudentBagItemLoadSuccessState extends StudentActionState {
  final List<StudentBagItem> studentBagItem;

  StudentBagItemLoadSuccessState(this.studentBagItem);
}

class StudentBagItemErrorState extends StudentActionState {
  final String error;
  StudentBagItemErrorState(this.error);
}

//STUDENT BAG BOOKS
class StudentBagBookLoadingState extends StudentActionState {}

class StudentBagBookLoadSuccessState extends StudentActionState {
  final List<StudentBagBook> studentBagBook;

  StudentBagBookLoadSuccessState(this.studentBagBook);
}

class StudentBagBookErrorState extends StudentActionState {
  final String error;
  StudentBagBookErrorState(this.error);
}

class BookDataDeleted extends StudentActionState{
}

//STUDENT BAG AND ITEM
class StudentBagCombinedLoadSuccessState extends StudentExtendedState {
  final List<StudentBagItem> studentBagItems;
  final List<StudentBagBook> studentBagBooks;

  StudentBagCombinedLoadSuccessState(this.studentBagItems, this.studentBagBooks);
}

//STUDENT NOTIFICATION
class StudentNotificationMailLoadingState extends StudentActionState {}

class StudentNotificationMailLoadSuccessState extends StudentActionState {
  final List<StudentNotifcationMail> studentNotifcationMail;

  StudentNotificationMailLoadSuccessState(this.studentNotifcationMail);
}

class StudentNotificationMailErrorState extends StudentActionState {
  final String error;
  StudentNotificationMailErrorState(this.error);
}




