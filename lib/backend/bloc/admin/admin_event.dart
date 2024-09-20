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