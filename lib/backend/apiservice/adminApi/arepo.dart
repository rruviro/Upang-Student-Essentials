import 'package:use/backend/models/admin/Announcement.dart';
import 'package:use/backend/models/admin/Book.dart';
import 'package:use/backend/models/admin/Course.dart';
import 'package:use/backend/models/admin/Department.dart';
import 'package:use/backend/models/admin/Stock.dart';
import 'package:use/backend/models/admin/Uniform.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagBook.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagItem.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';

abstract class Adminrepo {
  Future<StudentBagBook> showCodeBook(String code);
  Future<StudentBagItem> showCodeItem(String code);
  Future<void> changeStudentItemStatus(int id, String status);
  Future<void> changeStudentBookStatus(int id, String status);
  Future<List<StudentBagBook>> showStudentBagBookData();
  Future<List<StudentBagItem>> showStudentBagItemData();

  Future<List<StudentProfile>> showAllStudentProfileData();
  Future<StudentProfile> showStudentProfileData(String studentId);
  Future<void> createStudent(String firstName, String lastName, String course,
      String department, int year, String status);
  Future<void> deleteStudent(int id);
  Future<void> updateStudent(String firstName, String lastName, String course,
      String department, int year, String status, int id);

  Future<void> createAnnouncement(String department, String message);
  Future<List<announcement>> showAnnouncementData();

  // BY LANCE
  // Departments
  Future<List<department>> showDepartments();

  // Courses
  Future<List<Course>> showCourses(int departmentID);

  // BOOKS
  Future<List<Stock>> showStocks(String Course);

  // STOCK
  Future<List<Book>> showBooks(String Department);

  // UNIFORM
  Future<List<Uniform>> showUniforms(String Course, String Gender, String Type, String Body);
  // Future<void> createUniform(String Department, String Course, String Gender, String Type, String Body, String Size, int Stock);
  // Future<void> updateUniform(int id);

  Future<void> bookreservefirst(int count, String bookname);
  Future<void> uniformreservefirst(int count, String course, String gender,
      String type, String body, String size);
}
