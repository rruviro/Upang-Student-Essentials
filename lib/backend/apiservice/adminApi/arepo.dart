import 'package:use/backend/models/admin/Announcement.dart';
import 'package:use/backend/models/admin/Book.dart';
import 'package:use/backend/models/admin/Course.dart';
import 'package:use/backend/models/admin/Department.dart';
import 'package:use/backend/models/admin/Stock.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagBook.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagItem.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';

abstract class Adminrepo {
  Future<StudentBagBook> showCodeBook(String code);
  Future<StudentBagItem> showCodeItem(String code);
  Future<void> changeStudentItemStatus(int id, String status);
  Future<void> changeStudentBookStatus(int id, String status);

  Future<List<StudentProfile>> showAllStudentProfileData();
  Future<StudentProfile> showStudentProfileData(String studentId);
  Future<void> createStudent(String firstName, String lastName, String course, String department, int year, String status);
  Future<void> deleteStudent(int id);
  Future<void> updateStudent(String firstName, String lastName, String course, String department, int year, String status, int id);

  Future<void> createAnnouncement(String department, String message);
  Future<List<announcement>> showAnnouncementData();

  // BY LANCE
  // Departments
  Future<List<department>> showDepartments();

  // Courses
  Future<List<Course>> showCourses(int departmentID);

  // Books
  Future<List<Book>> showBooks(int courseID);

  // Stock (uniform)
  Future<List<Stock>> showStock(int courseID);
}