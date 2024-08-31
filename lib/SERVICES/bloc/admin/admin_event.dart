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