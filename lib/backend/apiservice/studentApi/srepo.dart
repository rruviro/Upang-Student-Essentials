import 'package:use/backend/models/student/StudentData/Student.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';

abstract class Studentrepo {
  Future<Student> showStudentData(String studentId);
  Future<void> showStudenNotificationMailData(int stunotification_id);
  Future<void> showStudentBagBookData(int stubag_id, String status);
  Future<void> showStudentBagItemData(int stubag_id, String status);
}