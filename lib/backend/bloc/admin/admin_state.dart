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
abstract class AdminExtendedState{}
abstract class AdminActionState extends AdminExtendedState{}
class AdminExtendedInitial extends AdminActionState{}

class AdminLoadingState extends AdminActionState{}
class AdminLoadSuccessState extends AdminActionState{}
class AdminErrorState extends AdminActionState {}

class CoursePageState extends AdminActionState{}
class StockPageState extends AdminActionState{}
class UniformPageState extends AdminActionState{}
class NewUniformPageState extends AdminActionState{}
class UniformManagePageState extends AdminActionState{}
class NotificationPageState extends AdminActionState{}
class TransactionPageState extends AdminActionState{}
class NewDepartmentPageState extends AdminActionState{}
class ManagePageState extends AdminActionState{}

class itemCodeDataLoading extends AdminActionState {

}

class itemCodeDataLoaded extends AdminActionState {
  final StudentBagItem studentBagItem;

  itemCodeDataLoaded(this.studentBagItem);
}

class itemCodeDataError extends AdminActionState {
  final String error;
  itemCodeDataError(this.error);
}

class bookCodeDataLoading extends AdminActionState {

}

class bookCodeDataLoaded extends AdminActionState {
  final StudentBagBook studentBagBook;

  bookCodeDataLoaded(this.studentBagBook);
}

class bookCodeDataError extends AdminActionState {
  final String error;
  bookCodeDataError(this.error);
}

class BookStatusChanged extends AdminActionState{
}

class ItemStatusChanged extends AdminActionState{
}