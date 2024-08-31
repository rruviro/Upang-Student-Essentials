part of 'student_bloc.dart';

@immutable
sealed class StudentBottomState {
  final int tabIndex;
  const StudentBottomState({required this.tabIndex});
}

final class StudentBottomInitial extends StudentBottomState {
  const StudentBottomInitial({required super.tabIndex});
}

@immutable
abstract class StudentExtendedState{}
abstract class StudentActionState extends StudentExtendedState{}
class StudentExtendedInitial extends StudentActionState{}

class StudentLoadingState extends StudentActionState{}
class StudentLoadSuccessState extends StudentActionState{}
class StudentErrorState extends StudentActionState {}

class CoursePageState extends StudentActionState{}
class StockPageState extends StudentActionState{}
class UniformPageState extends StudentActionState{}
class BackpackPageState extends StudentActionState{}
class NotificationPageState extends StudentActionState{}
class TransactionPageState extends StudentActionState{}