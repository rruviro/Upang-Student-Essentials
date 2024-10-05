import 'dart:ffi';

import 'package:use/backend/models/admin/Announcement.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagBook.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagItem.dart';
import 'package:use/backend/models/student/StudentData/CreateStudentData.dart';
import 'package:use/backend/models/student/StudentData/Student.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';

import 'package:use/backend/models/student/StudentNotificationData/StudentNotificationMail.dart';

abstract class Studentrepo {
  Future<Student> showStudentData(String studentId);
  Future<List<StudentNotifcationMail>> showStudenNotificationMailData(
      int stunotification_id);
  Future<List<StudentBagBook>> showStudentBagBookData(
      int stubag_id, String status);
  Future<List<StudentBagItem>> showStudentBagItemData(
      int stubag_id, String status);

  Future<void> addStudentBookData(int id,String department, String bookName, String subjectCode, String subjectDesc, String status);
  Future<void> addStudentItemData(int id,String department, String course,String gender,String type,String body,String size,String status);
  Future<void> deleteStudentBookData(int id);
  Future<void> deleteStudentItemData(int id);
  Future<void> changeStudentItemStatus(int id, String status);
  Future<void> changeStudentBookStatus(int id, String status);
  Future<void> reservedItemFirst(int count);
  Future<void> reservedBookFirst(int count);

  Future<List<announcement>> showAnnouncementData(String dept);
  Future<List<StudentBagBook>> showAllStudentBagBookData(int stubag_id);
  Future<List<StudentBagItem>> showAllStudentBagItemData(int stubag_id);

  Future<List<StudentProfile>> showAllStudentProfileData();
  Future<StudentProfile> showStudentProfileData(String studentId);
  Future<void> createStudent(String firstName, String lastName, String course, String department, int year, bool status);
  Future<void> deleteStudent(int id);
  Future<void> updateStudent(String firstName, String lastName, String course, String department, int year, bool status, int id);
}
