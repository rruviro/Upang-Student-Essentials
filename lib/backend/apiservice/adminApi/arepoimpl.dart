import 'package:use/backend/apiservice/adminApi/arepo.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:use/backend/models/admin/Announcement.dart';
import 'package:use/backend/models/admin/Book.dart';
import 'package:use/backend/models/admin/Course.dart';
import 'package:use/backend/models/admin/Department.dart';
import 'package:use/backend/models/admin/Stock.dart';
import 'package:use/backend/models/admin/Uniform.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagBook.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagItem.dart';
import 'dart:convert';

import 'package:use/backend/models/student/StudentData/StudentProfile.dart';

class AdminRepositoryImpl extends Adminrepo {
  static const String baseUrl =
      'https://warm-hollows-72745-fdd680fc4383.herokuapp.com/api';
  // static const String baseUrl = 'http://127.0.0.1:8000/api';

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

  // STOCK
  @override
  Future<List<Stock>> showStocks(String Course) async {
    final response = await http.get(Uri.parse('$baseUrl/stocks/$Course'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Stock.fromJson(data)).toList();
    } else {
      print('Failed to load stocks, status code: ${response.statusCode}');
      throw Exception('Failed to load stock');
    }
  }

  // BOOKS
  @override
  Future<List<Book>> showBooks(String Department) async {
    final response =
        await http.get(Uri.parse('$baseUrl/item-books/$Department'));
    await http.get(Uri.parse('$baseUrl/item-books/$Department'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Book.fromJson(data)).toList();
    } else {
      print('Failed to load books, status code: ${response.statusCode}');
      throw Exception('Failed to load books');
    }
  }

  // UNIFORM (PARA SA LAHAT ITO AH, YUNG RSOS KASI NA TABLE GAMIT KO
  @override
  Future<List<Uniform>> showUniforms(
      String Course, String Gender, String Type, String Body) async {
    final response = await http
        .get(Uri.parse('$baseUrl/uniforms/$Course/$Gender/$Type/$Body'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Uniform.fromJson(data)).toList();
    } else {
      print('Failed to load Uniform, status code: ${response.statusCode}');
      throw Exception("Failed to load Uniform");
    }
  }

  @override
  Future<void> createUniform(
      String Department,
      String Course,
      String Gender,
      String Type,
      String Body,
      String Size,
      int Stock,
      int Reserved,
      ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/uniforms/create'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'Department': Department,
          'Course': Course,
          'Gender': Gender,
          'Type': Type,
          'Body': Body,
          'Size': Size,
          'Stock': Stock,
          'Reserved': Reserved,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Success: ${data['message']}');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  // DELETE UNIFORM
  Future<void> deleteUniform(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/uniforms/delete/$id'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData['message']); // Success message
    } else {
      // Handle error
    }
  }

  @override
  Future<void> updateUniform(int id, int stock) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/uniforms/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'Stock': stock,
        }),
      );
      if (response.statusCode == 200) {
        print('Uniform updated successfully: ${response.body}');
      } else {
        throw Exception("Failed to update uniform: ${response.body}");
      }
    } catch (e) {
      print('Error: $e'); // Handle errors appropriately
    }
  }

  @override
  Future<void> bookreservefirst(int count, String bookname) async {
    final response =
        await http.put(Uri.parse('$baseUrl/reservedbooks/$count/$bookname'));
    if (response.statusCode == 200) {
      print("GUMANA ITO ITO ITO ITO ITO ITO ITO ITO");
      print('$baseUrl/reservedbooks/$count/$bookname');
    } else {
      print('${response.statusCode}');
      throw Exception("Failed to load Uniform");
    }
  }

  @override
  Future<void> uniformreservefirst(int count, String course, String gender,
      String type, String body, String size) async {
    final response = await http.put(Uri.parse(
        '$baseUrl/reserveditems/$count/$course/$gender/$type/$body/$size'));
    if (response.statusCode == 200) {
      print("GUMANA ITO ITO ITO ITO ITO ITO ITO ITO");
    } else {
      print('${response.statusCode}');
      print('$baseUrl/reserveditems/$count/$course/$gender/$type/$body/$size');
      throw Exception("Failed to load Uniform");
    }
  }

  @override
  Future<List<StudentBagBook>> showStudentBagBookData() async {
    final response = await http.get(Uri.parse('$baseUrl/completebook'));
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      List<dynamic> itemsJson = responseBody['items'];
      return itemsJson.map((json) => StudentBagBook.fromJson(json)).toList();
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<List<StudentBagItem>> showStudentBagItemData() async {
    final response = await http.get(Uri.parse('$baseUrl/completeitem'));
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      List<dynamic> itemsJson = responseBody['items'];
      return itemsJson.map((json) => StudentBagItem.fromJson(json)).toList();
    } else {
      throw Exception('Empty');
    }
  }
}
