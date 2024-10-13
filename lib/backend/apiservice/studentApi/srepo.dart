import 'package:use/backend/models/admin/Announcement.dart';
import 'package:use/backend/models/admin/Book.dart';
import 'package:use/backend/models/admin/Course.dart';
import 'package:use/backend/models/admin/Department.dart';
import 'package:use/backend/models/admin/Stock.dart';
import 'package:use/backend/models/admin/Uniform.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagBook.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagItem.dart';
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

  Future<void> addStudentBookData(
    int id,
    // String course, //DAGDAG NI LANCE
    String department,
    String bookName,
    String subjectCode,
    String subjectDesc,
    String status,
    String shift,
  );

  Future<void> addStudentItemData(
    int id,
    String department,
    String course,
    String gender,
    String type,
    String body,
    String size,
    String status,
    String shift,
  );

  Future<void> addreserveBookData(
      int id,
      // String course, //DAGDAG NI LANCE
      String department,
      String bookName,
      String subjectCode,
      String subjectDesc,
      String status,
      String shift,
      int stock);

  Future<void> addreserveItemData(
      int id,
      String department,
      String course,
      String gender,
      String type,
      String body,
      String size,
      String status,
      String shift,
      int stock);
  Future<void> deleteStudentBookData(int id);
  Future<void> deleteStudentItemData(int id);
  Future<void> changeStudentItemStatus(int id, String status);
  Future<void> changeStudentBookStatus(int id, String status);
  Future<void> reserveorclaimItem(int id, String status);
  Future<void> reserveorclaimBook(int id, String status);
  Future<void> reservedItemFirst(int count);
  Future<void> reservedBookFirst(int count);

  Future<List<announcement>> showAnnouncementData(String dept);
  Future<List<StudentBagBook>> showAllStudentBagBookData(
      int stubag_id, String status);
  Future<List<StudentBagItem>> showAllStudentBagItemData(
      int stubag_id, String status);
  Future<void> createNotificationData(int id, String message);
  Future<void> changePasswords(int id, String password, String cpassword);

  // BY LANCE
  // DEPARTMENTS
  Future<List<department>> showDepartments();

  // COURSES
  Future<List<Course>> showCourses(int departmentID);

  // STOCKS
  Future<List<Stock>> showStocks(String Course); // change from dep to course

  //BOOKS
  Future<List<Book>> showBooks(String Course); // dep tocourse

  // UNIFORM
  Future<List<Uniform>> showUniforms(String Course, String Gender, String Type, String Body);

  Future<void> itemreduceStocks(int count, String department, String course,
      String gender, String type, String body, String size);

  Future<void> bookreduceStocks(int count, String department, String bookname,
      String subcode, String subdesc);

  Future<int?> uniformStock(String department, String course, String gender,
      String type, String body, String size);
}
