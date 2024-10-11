import 'package:use/backend/apiservice/adminApi/arepo.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:use/backend/models/admin/Announcement.dart';
import 'package:use/backend/models/admin/Book.dart';
import 'package:use/backend/models/admin/Course.dart';
import 'package:use/backend/models/admin/Department.dart';
import 'package:use/backend/models/admin/Stock.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagBook.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagItem.dart';
import 'dart:convert';

import 'package:use/backend/models/student/StudentData/StudentProfile.dart';

class AdminRepositoryImpl extends Adminrepo {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  @override
  Future<StudentBagBook> showCodeBook(String code) async {
    final response = await http.get(Uri.parse('$baseUrl/bookpickup/$code'));
    if (response.statusCode == 200) {
      print("gumana");
      final responseBody = json.decode(response.body)['bookCollections'];
      return StudentBagBook.fromJson(responseBody);
    } else {
      print("hindi");
      print(response.statusCode);
      throw Exception(response.statusCode);
    }
  }

  @override
  Future<StudentBagItem> showCodeItem(String code) async {
    final response = await http.get(Uri.parse('$baseUrl/itempickup/$code'));
    if (response.statusCode == 200) {
      print("gumana");
      final responseBody = json.decode(response.body)['items'];
      return StudentBagItem.fromJson(responseBody);
    } else {
      print("hidni");
      throw Exception(response.statusCode);
    }
  }

  @override
  Future<void> changeStudentBookStatus(int id, String status) async {
    final response =
        await http.put(Uri.parse('$baseUrl/bookcollections/$id/$status'));
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed');
    }
  }

  @override
  Future<void> changeStudentItemStatus(int id, String status) async {
    final response =
        await http.put(Uri.parse('$baseUrl/studentbagitems/$id/$status'));
    if (response.statusCode == 200) {
      print(
          "~~~~~`~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    } else {
      print(response.statusCode);
      print(response.body);
      throw Exception();
    }
  }

  @override
  Future<void> createStudent(String firstName, String lastName, String course,
      String department, int year, String status) async {
    final response = await http.post(
      Uri.parse('$baseUrl/students'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'profile': {
          'FirstName': firstName,
          'LastName': lastName,
          'Course': course,
          'Department': department,
          'Year': year,
          'Status': status,
        }
      }),
    );

    if (response.statusCode == 200) {
      print("Student created successfully");
    } else {
      print("Failed to create student: ${response.statusCode}");
      throw Exception('Failed to create student');
    }
  }

  @override
  Future<void> deleteStudent(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/students/$id'));
    if (response.statusCode == 200) {
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<List<StudentProfile>> showAllStudentProfileData() async {
    final response = await http.get(Uri.parse('$baseUrl/profiles'));

    if (response.statusCode == 200) {
      List<dynamic> studentsJson = json.decode(response.body)['profiles'];
      return studentsJson.map((json) => StudentProfile.fromJson(json)).toList();
    } else {
      throw response.statusCode;
    }
  }

  @override
  Future<StudentProfile> showStudentProfileData(String studentId) async {
    final response = await http.get(Uri.parse('$baseUrl/profiles/$studentId'));
    if (response.statusCode == 200) {
      Map<String, dynamic> studentJson = json.decode(response.body)['profile'];
      StudentProfile student = StudentProfile.fromJson(studentJson);
      return student;
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<void> updateStudent(String firstName, String lastName, String course,
      String department, int year, String status, int id) async {
    final response = await http.put(
      Uri.parse('$baseUrl/updateprofile/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'FirstName': firstName,
        'LastName': lastName,
        'Course': course,
        'Department': department,
        'Year': year,
        'Status': status
      }),
    );

    if (response.statusCode == 200) {
      // Handle successful update
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<void> createAnnouncement(String department, String message) async {
    print('Department: $department');
    print('Message: $message');
    final response = await http.post(
      Uri.parse('$baseUrl/createannouncements'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'department': department,
        'body': message,
      }),
    );

    if (response.statusCode == 200) {
      print("Announcement created successfully");
    } else {
      print('Error: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception(
          'Failed to create announcement, status code: ${response.statusCode}');
    }
  }

  @override
  Future<List<announcement>> showAnnouncementData() async {
    final response = await http.get(Uri.parse('$baseUrl/announcements'));
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      List<dynamic> itemsJson = responseBody['announcement'];
      return itemsJson.map((json) => announcement.fromJson(json)).toList();
    } else {
      throw Exception(
          'Failed to load announcements, status code: ${response.statusCode}');
    }
  }

  // BY LANCE
  // Departments
  @override
  Future<List<department>> showDepartments() async {
    final response = await http.get(Uri.parse('$baseUrl/departments'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => department.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load departments');
    }
  }

  // Courses
  @override
  Future<List<Course>> showCourses(int departmentID) async {
    final response =
        await http.get(Uri.parse('$baseUrl/courses/$departmentID'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Course.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  // Books
  @override
  Future<List<Book>> showBooks(int courseID) async {
    final response = await http.get(Uri.parse('$baseUrl/books/$courseID'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Book.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  // Stocks
  @override
  Future<List<Stock>> showStock(int courseID) async {
    final response = await http.get(Uri.parse('$baseUrl/stocks/$courseID'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Stock.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load stock');
    }
  }
}
