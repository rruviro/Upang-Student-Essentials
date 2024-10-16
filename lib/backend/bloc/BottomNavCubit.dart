import 'package:flutter_bloc/flutter_bloc.dart';

// Bottom Navigation Bar Cubit
class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(0);
  void navigateTo(int pageIndex) {
    print("Navigating to page: $pageIndex");
    emit(pageIndex);
  }

  changeSelectedIndex(newIndex) => emit(newIndex);
}
