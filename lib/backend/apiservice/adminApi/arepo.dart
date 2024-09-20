import 'package:use/backend/models/student/StudentBagData/StudentBagBook.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagItem.dart';

abstract class Adminrepo {
  Future<StudentBagBook> showCodeBook(String code);
  Future<StudentBagItem> showCodeItem(String code);
  Future<void> changeStudentItemStatus(int id, String status);
  Future<void> changeStudentBookStatus(int id, String status);
}