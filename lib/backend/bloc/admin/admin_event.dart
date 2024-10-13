part of 'admin_bloc.dart';

@immutable
sealed class AdminBottomEvent {}

class TabChange extends AdminBottomEvent {
  final int tabIndex;

  TabChange({required this.tabIndex});
}

@immutable
abstract class AdminExtendedEvent {}

class CoursePageEvent extends AdminExtendedEvent {}

class StockPageEvent extends AdminExtendedEvent {}

class UniformPageEvent extends AdminExtendedEvent {}

class NewUniformPageEvent extends AdminExtendedEvent {}

class UniformManagePageEvent extends AdminExtendedEvent {}

class NotificationPageEvent extends AdminExtendedEvent {}

class TransactionPageEvent extends AdminExtendedEvent {}

class NewDepartmentPageEvent extends AdminExtendedEvent {}

class ManagePageEvent extends AdminExtendedEvent {}

class studentBagItem extends AdminExtendedEvent {}

class studentBagBook extends AdminExtendedEvent {}

class showCodeBookData extends AdminExtendedEvent {
  final String code;

  showCodeBookData(this.code);
}

class showCodeItemData extends AdminExtendedEvent {
  final String code;

  showCodeItemData(this.code);
}

class changeItemStatus extends AdminExtendedEvent {
  final int id;
  final String status;

  changeItemStatus(this.id, this.status);
}

class changeBookStatus extends AdminExtendedEvent {
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

  createStudent(this.firstName, this.lastName, this.course, this.year,
      this.enrolled, this.department);
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
class ShowCoursesEvent extends AdminExtendedEvent {
  final int departmentID;
  ShowCoursesEvent({required this.departmentID});
}

// FOR STOCK
class ShowStocksEvent extends AdminExtendedEvent {
  final String Course;
  ShowStocksEvent({required this.Course});
}

// FOR UNIFORM
class ShowUniformsEvent extends AdminExtendedEvent {
  final String Course;
  final String Gender;
  final String Type;
  final String Body;

  ShowUniformsEvent(this.Course, this.Gender, this.Type, this.Body);
}

class createUniform extends AdminExtendedEvent {
  final String Department;
  final String Course;
  final String Gender;
  final String Type;
  final String Body;
  final String Size;
  final int Stock;

  createUniform(this.Department, this.Course, this.Gender, this.Type, this.Body,
      this.Size, this.Stock);
}

class bookreservefirst extends AdminExtendedEvent {
  final int count;
  final String bookname;

  bookreservefirst(this.bookname, this.count);
}

class itemreservefirst extends AdminExtendedEvent {
  final int count;
  final String Course;
  final String Gender;
  final String Type;
  final String Body;
  final String Size;

  itemreservefirst(
      this.count, this.Course, this.Gender, this.Type, this.Body, this.Size);
}
