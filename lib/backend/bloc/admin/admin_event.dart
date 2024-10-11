part of 'admin_bloc.dart';

@immutable
sealed class AdminBottomEvent {}

class TabChange extends AdminBottomEvent {
  final int tabIndex;

  TabChange({required this.tabIndex});
}

@immutable
abstract class AdminExtendedEvent{}
class CoursePageEvent extends AdminExtendedEvent {}
class StockPageEvent extends AdminExtendedEvent{}
class UniformPageEvent extends AdminExtendedEvent{}
class NewUniformPageEvent extends AdminExtendedEvent{}
class UniformManagePageEvent extends AdminExtendedEvent{}
class NotificationPageEvent extends AdminExtendedEvent {}
class TransactionPageEvent extends AdminExtendedEvent{}
class NewDepartmentPageEvent extends AdminExtendedEvent{}
class ManagePageEvent extends AdminExtendedEvent{}

class showCodeBookData extends AdminExtendedEvent{
  final String code;

  showCodeBookData(this.code);
}

class showCodeItemData extends AdminExtendedEvent{
  final String code;

  showCodeItemData(this.code);
}

class changeItemStatus extends AdminExtendedEvent{
  final int id;
  final String status;

  changeItemStatus(this.id, this.status);
}

class changeBookStatus extends AdminExtendedEvent{
  final int id;
  final String status;

  changeBookStatus(this.id, this.status);
}

class getStudent extends AdminExtendedEvent {}

class showStudent extends AdminExtendedEvent {
  final String id;

  showStudent(this.id);
}

class deleteStudent extends AdminExtendedEvent {
  final int id;

  deleteStudent(this.id);
}

class updateStudent extends AdminExtendedEvent {
  final int id;
  final String firstName;
  final String lastName;
  final String department;
  final String course;
  final int year;
  final String enrolled;

  updateStudent(this.firstName, this.lastName, this.course, this.year,
      this.enrolled, this.id, this.department);
}

class createStudent extends AdminExtendedEvent {
  final String firstName;
  final String lastName;
  final String department;
  final String course;
  final int year;
  final String enrolled;

  createStudent(
      this.firstName, this.lastName, this.course, this.year, this.enrolled, this.department);
}
class showAnnouncement extends AdminExtendedEvent {}

class createAnnouncement extends AdminExtendedEvent {
  final String department;
  final String message;

  createAnnouncement(this.department, this.message);
}

// LANCE
// For Departments
class ShowDepartmentsEvent extends AdminExtendedEvent {
  // final String departments;

  ShowDepartmentsEvent();
}

// For Courses
class ShowCoursesEvent extends AdminExtendedEvent{
  final int departmentID;
  ShowCoursesEvent({required this.departmentID});
}

// For Books
class ShowBooksEvent extends AdminExtendedEvent{
  final int courseID;
  ShowBooksEvent({required this.courseID});
}

// For Stock
class ShowStockEvent extends AdminExtendedEvent{
  final int courseID;
  ShowStockEvent({required this.courseID});
}