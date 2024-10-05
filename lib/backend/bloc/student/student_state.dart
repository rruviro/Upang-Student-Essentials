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

class ItemDataDeleted extends StudentActionState{
}

class BookStatusChanged extends StudentActionState{
}

class ItemStatusChanged extends StudentActionState{
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

//ANOUNCEMENT
class announcementLoadingData extends StudentActionState {}

class announcementLoadSuccessData extends StudentActionState {
  final List<announcement> Announcement;
  announcementLoadSuccessData(this.Announcement);
}

class announcementLoadErrorData extends StudentActionState {
  final String error;
  announcementLoadErrorData(this.error);
}

class studentLoading extends StudentExtendedState {}

class studentLoaded extends StudentExtendedState {
  final List<StudentProfile> students;
  studentLoaded(this.students);
}

class studentError extends StudentExtendedState {
  final String error;
  studentError(this.error);
}

class studentDelete extends StudentExtendedState {
  final int id;

  studentDelete(this.id);
}

class specificStudentLoaded extends StudentExtendedState {
  final StudentProfile student;

  specificStudentLoaded(this.student);
}

class studentUpdated extends StudentExtendedState {}

class studentCreated extends StudentExtendedState {}

class itemAdded extends StudentExtendedState {}

class bookAdded extends StudentExtendedState {}

class itemError extends StudentExtendedState {
  final String error;
  itemError(this.error);
}

class bookError extends StudentExtendedState {
  final String error;
  bookError(this.error);
}




