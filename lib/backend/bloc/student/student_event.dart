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

  studentBagItem(this.stubag_id,this.status);
}

class studentBagBook extends StudentExtendedEvent {
  final int stubag_id;
  final String status;

  studentBagBook(this.stubag_id,this.status);
}

class studentNotificationMail extends StudentExtendedEvent {
  final int stunotification_id;

  studentNotificationMail(this.stunotification_id);
}

class deleteBookData extends StudentExtendedEvent{
  final int id;

  deleteBookData(this.id);
}

class deleteItemData extends StudentExtendedEvent{
  final int id;

  deleteItemData(this.id);
}

class changeItemStatus extends StudentExtendedEvent{
  final int id;
  final String status;

  changeItemStatus(this.id, this.status);
}

class changeBookStatus extends StudentExtendedEvent{
  final int id;
  final String status;

  changeBookStatus(this.id, this.status);
}

class showAnnouncementData extends StudentExtendedEvent{
  final String dept;

  showAnnouncementData(this.dept);
}

