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

  AddStudentBagBook(this.id, this.department, this.bookName, this.subjectCode,
      this.subjectDesc, this.status);
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

  AddStudentBagItem(
    this.department,
    this.course,
    this.gender,
    this.type,
    this.body,
    this.size,
    this.status,
    this.id,
  );
}

class createNotification extends StudentExtendedEvent {
  final int id;
  final String message;

  createNotification(this.id, this.message);
}
