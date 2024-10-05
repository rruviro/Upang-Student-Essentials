import 'package:use/backend/models/admin/Announcement.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagBook.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagItem.dart';
import 'package:use/backend/models/student/StudentData/Student.dart';
import 'package:use/backend/models/student/StudentNotificationData/StudentNotificationMail.dart';

abstract class Studentrepo {
  Future<Student> showStudentData(String studentId);
  Future<List<StudentNotifcationMail>> showStudenNotificationMailData(int stunotification_id);
  Future<List<StudentBagBook>> showStudentBagBookData(int stubag_id, String status);
  Future<List<StudentBagItem>> showStudentBagItemData(int stubag_id, String status);
  Future<void> deleteStudentBookData(int id);
  Future<void> deleteStudentItemData(int id);
  Future<void> changeStudentItemStatus(int id, String status);
  Future<void> changeStudentBookStatus(int id, String status);
  Future<List<announcement>> showAnnouncementData(String dept);
}