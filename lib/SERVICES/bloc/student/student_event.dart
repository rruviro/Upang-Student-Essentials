part of 'student_bloc.dart';

@immutable
sealed class StudentBottomEvent {}

class TabChange extends StudentBottomEvent {
  final int tabIndex;

  TabChange({required this.tabIndex});
}

@immutable
abstract class StudentExtendedEvent{}
class CoursePageEvent extends StudentExtendedEvent {}
class StockPageEvent extends StudentExtendedEvent{}
class UniformPageEvent extends StudentExtendedEvent{}
class BackpackPageEvent extends StudentExtendedEvent {}
class NotificationPageEvent extends StudentExtendedEvent {}
class TransactionPageEvent extends StudentExtendedEvent{}