part of 'student_bloc.dart';

abstract class StudentBottomEvent {}

class TabChange extends StudentBottomEvent {
  final int tabIndex;

  TabChange({required this.tabIndex});
}

@immutable
abstract class StudentExtendedEvent {}

class CoursePageEvent extends StudentExtendedEvent {}

class StockPageEvent extends StudentExtendedEvent {}

class UniformPageEvent extends StudentExtendedEvent {}

class BackpackPageEvent extends StudentExtendedEvent {}

class NotificationPageEvent extends StudentExtendedEvent {}

class TransactionPageEvent extends StudentExtendedEvent {}

class studentProfileGet extends StudentExtendedEvent {
  final String studentId;

  studentProfileGet(this.studentId);
}

class studentBagItem extends StudentExtendedEvent {
  final int stubag_id;
  final String status;

  studentBagItem(this.stubag_id, this.status);
}

class studentBagBook extends StudentExtendedEvent {
  final int stubag_id;
  final String status;

  studentBagBook(this.stubag_id, this.status);
}

class allstudentBagItem extends StudentExtendedEvent {
  final int stubag_id;
  final String status;
  allstudentBagItem(this.stubag_id, this.status);
}

class allstudentBagBook extends StudentExtendedEvent {
  final int stubag_id;
  final String status;

  allstudentBagBook(this.stubag_id, this.status);
}

class studentNotificationMail extends StudentExtendedEvent {
  final int stunotification_id;

  studentNotificationMail(this.stunotification_id);
}

class deleteBookData extends StudentExtendedEvent {
  final int id;

  deleteBookData(this.id);
}

class deleteItemData extends StudentExtendedEvent {
  final int id;

  deleteItemData(this.id);
}

class changeItemStatus extends StudentExtendedEvent {
  final int id;
  final String status;

  changeItemStatus(this.id, this.status);
}

class changeBookStatus extends StudentExtendedEvent {
  final int id;
  final String status;

  changeBookStatus(this.id, this.status);
}

class reserveorclaimItem extends StudentExtendedEvent {
  final int id;
  final String status;
  final int stocks;

  reserveorclaimItem(this.id, this.status, this.stocks);
}

class reserveorclaimBook extends StudentExtendedEvent {
  final int id;
  final String status;
  final int stocks;

  reserveorclaimBook(this.id, this.status, this.stocks);
}

class changeReservedItemStatus extends StudentExtendedEvent {
  final int count;

  changeReservedItemStatus(this.count);
}

class changeReservedBookStatus extends StudentExtendedEvent {
  final int count;

  changeReservedBookStatus(this.count);
}

class showAnnouncementData extends StudentExtendedEvent {
  final String dept;

  showAnnouncementData(this.dept);
}

class AddStudentBagBook extends StudentExtendedEvent {
  final int id;
  final String department;
  final String bookName;
  final String subjectCode;
  final String subjectDesc;
  final String status;
  final String shift;

  AddStudentBagBook(this.id, this.department, this.bookName, this.subjectCode,
      this.subjectDesc, this.status, this.shift);
}

class AddStudentBagItem extends StudentExtendedEvent {
  final int id;
  final String department;
  final String course;
  final String gender;
  final String type;
  final String body;
  final String size;
  final String status;
  final String shift;

  AddStudentBagItem(
    this.department,
    this.course,
    this.gender,
    this.type,
    this.body,
    this.size,
    this.status,
    this.id,
    this.shift,
  );
}

class AddReserveBagBook extends StudentExtendedEvent {
  final int id;
  final String department;
  final String bookName;
  final String subjectCode;
  final String subjectDesc;
  final String status;
  final String shift;
  final int stocks;

  AddReserveBagBook(this.id, this.department, this.bookName, this.subjectCode,
      this.subjectDesc, this.status, this.shift, this.stocks);
}

class AddReserveBagItem extends StudentExtendedEvent {
  final int id;
  final String department;
  final String course;
  final String gender;
  final String type;
  final String body;
  final String size;
  final String status;
  final String shift;
  final int stocks;

  AddReserveBagItem(this.department, this.course, this.gender, this.type,
      this.body, this.size, this.status, this.id, this.shift, this.stocks);
}

class createNotification extends StudentExtendedEvent {
  final int id;
  final String message;

  createNotification(this.id, this.message);
}

class changePassword extends StudentExtendedEvent {
  final int id;
  final String password;
  final String cpassword;

  changePassword(
    this.id,
    this.password,
    this.cpassword,
  );
}

// BY LANCE
// DEPARTMENTS
class ShowDepartmentsEvent extends StudentExtendedEvent {
  ShowDepartmentsEvent();
}

// COURSES
class ShowCoursesEvent extends StudentExtendedEvent {
  final int departmentID;
  ShowCoursesEvent({required this.departmentID});
}

// BOOKS
// class ShowBooksEvent extends StudentExtendedEvent{
//   final String Department;
//   ShowBooksEvent({required this.Department});
// }

// STOCK
class ShowStocksEvent extends StudentExtendedEvent {
  final String Department;
  ShowStocksEvent({required this.Department});
}

// UNIFORM
class ShowUniformsEvent extends StudentExtendedEvent {
  final String Course;
  ShowUniformsEvent({required this.Course});
}

class itemreduceStocks extends StudentExtendedEvent {
  final int count;
  final String department;
  final String course;
  final String gender;
  final String type;
  final String body;
  final String size;

  itemreduceStocks({
    required this.count,
    required this.department,
    required this.course,
    required this.gender,
    required this.type,
    required this.body,
    required this.size,
  });
}

class bookreduceStocks extends StudentExtendedEvent {
  final int count;
  final String department;
  final String bookname;
  final String subcode;
  final String subdesc;

  bookreduceStocks(
      {required this.count,
      required this.department,
      required this.bookname,
      required this.subcode,
      required this.subdesc});
}
