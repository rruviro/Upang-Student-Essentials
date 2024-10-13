part of 'admin_bloc.dart';

@immutable
sealed class AdminBottomState {
  final int tabIndex;
  const AdminBottomState({required this.tabIndex});
}

final class AdminBottomInitial extends AdminBottomState {
  const AdminBottomInitial({required super.tabIndex});
}

@immutable
abstract class AdminExtendedState {}

abstract class AdminActionState extends AdminExtendedState {}

class AdminExtendedInitial extends AdminActionState {}

class AdminLoadingState extends AdminActionState {}

class AdminLoadSuccessState extends AdminActionState {}

class AdminErrorState extends AdminActionState {}

class CoursePageState extends AdminActionState {}

class StockPageState extends AdminActionState {}

class UniformPageState extends AdminActionState {}

class NewUniformPageState extends AdminActionState {}

class UniformManagePageState extends AdminActionState {}

class NotificationPageState extends AdminActionState {}

class TransactionPageState extends AdminActionState {}

class NewDepartmentPageState extends AdminActionState {}

class ManagePageState extends AdminActionState {}

class itemCodeDataLoading extends AdminActionState {}

class itemCodeDataLoaded extends AdminActionState {
  final StudentBagItem studentBagItem;

  itemCodeDataLoaded(this.studentBagItem);
}

class itemCodeDataError extends AdminActionState {
  final String error;
  itemCodeDataError(this.error);
}

class bookCodeDataLoading extends AdminActionState {}

class bookCodeDataLoaded extends AdminActionState {
  final StudentBagBook studentBagBook;

  bookCodeDataLoaded(this.studentBagBook);
}

class bookCodeDataError extends AdminActionState {
  final String error;
  bookCodeDataError(this.error);
}

class BookStatusChanged extends AdminActionState {}

class ItemStatusChanged extends AdminActionState {}

class studentLoading extends AdminActionState {}

class studentLoaded extends AdminActionState {
  final List<StudentProfile> students;
  studentLoaded(this.students);
}

class studentError extends AdminActionState {
  final String error;
  studentError(this.error);
}

class studentDelete extends AdminActionState {
  final int id;

  studentDelete(this.id);
}

class specificStudentLoaded extends AdminActionState {
  final StudentProfile student;

  specificStudentLoaded(this.student);
}

class studentUpdated extends AdminActionState {}

class studentCreated extends AdminActionState {}

class announcementLoadingData extends AdminActionState {}

class announcementLoadSuccessData extends AdminActionState {
  final List<announcement> Announcement;
  announcementLoadSuccessData(this.Announcement);
}

class announcementLoadErrorData extends AdminActionState {
  final String error;
  announcementLoadErrorData(this.error);
}

class StudentBagCombinedLoadSuccessState extends AdminActionState {
  final List<StudentBagItem> studentBagItems;
  final List<StudentBagBook> studentBagBooks;

  StudentBagCombinedLoadSuccessState(
      this.studentBagItems, this.studentBagBooks);
}

class StudentBagBookErrorState extends AdminActionState {
  final String error;
  StudentBagBookErrorState(this.error);
}

// LANCE
// States ng DEPARTMENTS
class DepartmentsLoadingState extends AdminActionState {}

class DepartmentsLoadedState extends AdminActionState {
  final List<department> departments;
  DepartmentsLoadedState(this.departments);
}

class DepartmentsErrorState extends AdminActionState {
  final String error;
  DepartmentsErrorState(this.error);
}

// States ng COURSES
class CoursesLoadingState extends AdminActionState {}

class CoursesLoadedState extends AdminActionState {
  final List<Course> courses;
  CoursesLoadedState({required this.courses});
}

class CoursesErrorState extends AdminActionState {
  final String error;
  CoursesErrorState(this.error);
}

// STOCKS
class StocksLoadingState extends AdminActionState {}

class StocksLoadedState extends AdminExtendedState {
  final List<Stock> stocks;
  final List<Book> books;
  StocksLoadedState({required this.stocks, required this.books});
}

class StocksErrorState extends AdminActionState {
  final String error;
  StocksErrorState(this.error);
}

// UNIFORM
class UniformsLoadingState extends AdminActionState {}

class UniformsLoadedState extends AdminExtendedState {
  final List<Uniform> uniforms;
  UniformsLoadedState({required this.uniforms});
}

class UniformsErrorState extends AdminActionState {
  final String error;
  UniformsErrorState(this.error);
}
