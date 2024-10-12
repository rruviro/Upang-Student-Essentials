import 'package:use/backend/apiservice/studentApi/srepo.dart';
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
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';
import 'package:use/backend/models/student/StudentData/Student.dart';
import 'package:use/backend/models/student/StudentData/StudentBag.dart';
import 'package:use/backend/models/student/StudentData/StudentNotifcation.dart';
import 'dart:convert';

import 'package:use/backend/models/student/StudentNotificationData/StudentNotificationMail.dart';

class StudentRepositoryImpl extends Studentrepo {
  static const String baseUrl =
      'https://floating-cliffs-62090-6c6c2af6e00a.herokuapp.com/api';
  // static const String baseUrl = 'http://10.0.2.2:8000/api';
  //static const String baseUrl = 'http://localhost:8000/api';

  @override
  Future<Student> showStudentData(String studentId) async {
    final response = await http.get(Uri.parse('$baseUrl/students/$studentId'));
    print(response);
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);

      if (responseBody['student'] != null) {
        final studentData = responseBody['student'];

        final profileJson = studentData['profile'] != null
            ? studentData['profile'] as Map<String, dynamic>
            : null;

        final studentBagJson = studentData['student_bag'] != null
            ? studentData['student_bag'] as Map<String, dynamic>
            : null;

        final notificationJson = studentData['notification'] != null
            ? studentData['notification'] as Map<String, dynamic>
            : null;

        final studentProfile =
            profileJson != null ? StudentProfile.fromJson(profileJson) : null;

        final studentBag =
            studentBagJson != null ? StudentBag.fromJson(studentBagJson) : null;

        final notification = notificationJson != null
            ? StudentNotification.fromJson(notificationJson)
            : null;

        if (studentProfile != null) {
          return Student(
            id: studentData['id'],
            studentId: studentId,
            profile: studentProfile,
            studentBag: studentBag!,
            notification: notification!,
          );
        } else {
          throw Exception('Student profile data is incomplete');
        }
      } else {
        throw Exception('No student data found');
      }
    } else {
      throw Exception(
          'Failed to load student, status code: ${response.statusCode}');
    }
  }

  @override
  Future<List<StudentNotifcationMail>> showStudenNotificationMailData(
      int stunotification_id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/mails/$stunotification_id'));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      List<dynamic> itemsJson = responseBody['mails'];
      return itemsJson
          .map((json) => StudentNotifcationMail.fromJson(json))
          .toList();
    } else {
      throw Exception(response.statusCode);
    }
  }

  @override
  Future<List<StudentBagBook>> showStudentBagBookData(
      int stubag_id, String status) async {
    final response = await http
        .get(Uri.parse('$baseUrl/bookcollections/${stubag_id}/${status}'));
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      List<dynamic> itemsJson = responseBody['bookCollections'];
      return itemsJson.map((json) => StudentBagBook.fromJson(json)).toList();
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<List<StudentBagItem>> showStudentBagItemData(
      int stubag_id, String status) async {
    final response = await http
        .get(Uri.parse('$baseUrl/studentbagitems/${stubag_id}/${status}'));
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      List<dynamic> itemsJson = responseBody['items'];
      return itemsJson.map((json) => StudentBagItem.fromJson(json)).toList();
    } else {
      throw Exception('Empty');
    }
  }

  @override
  Future<void> deleteStudentBookData(int id) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/bookcollections/$id'));
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed');
    }
  }

  @override
  Future<void> deleteStudentItemData(int id) async {
    final response =
        await http.delete(Uri.parse('$baseUrl/studentbagitems/$id'));
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed');
    }
  }

  @override
  Future<List<announcement>> showAnnouncementData(String dept) async {
    final response = await http.get(Uri.parse('$baseUrl/announcements/$dept'));
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      List<dynamic> itemsJson = responseBody['announcement'];
      return itemsJson.map((json) => announcement.fromJson(json)).toList();
    } else {
      throw Exception(
          'Failed to load announcements, status code: ${response.statusCode}');
    }
  }

  @override
  Future<void> changeStudentBookStatus(int id, String status) async {
    final response =
        await http.put(Uri.parse('$baseUrl/bookcollections/$id/$status'));
    if (response == 200) {
    } else {
      throw Exception('Failed');
    }
  }

  @override
  Future<void> changeStudentItemStatus(int id, String status) async {
    final response =
        await http.put(Uri.parse('$baseUrl/studentbagitems/$id/$status'));
    if (response == 200) {
    } else {
      throw Exception('Failed');
    }
  }

  @override
  Future<List<StudentBagBook>> showAllStudentBagBookData(
      int stubag_id, String status) async {
    final response = await http
        .get(Uri.parse('$baseUrl/showallbooks/${stubag_id}/${status}'));
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      List<dynamic> itemsJson = responseBody['bookCollections'];
      return itemsJson.map((json) => StudentBagBook.fromJson(json)).toList();
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<List<StudentBagItem>> showAllStudentBagItemData(
      int stubag_id, String status) async {
    final response = await http
        .get(Uri.parse('$baseUrl/showallitems/${stubag_id}/${status}'));
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      List<dynamic> itemsJson = responseBody['items'];
      return itemsJson.map((json) => StudentBagItem.fromJson(json)).toList();
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<void> reservedBookFirst(int count) async {
    final response =
        await http.put(Uri.parse('$baseUrl/studentbagitems/$count'));
    if (response == 200) {
    } else {
      throw Exception('Failed');
    }
  }

  @override
  Future<void> reservedItemFirst(int count) async {
    final response =
        await http.put(Uri.parse('$baseUrl/studentbagitems/$count'));
    if (response == 200) {
    } else {
      throw Exception('Failed');
    }
  }

  @override
  Future<void> addStudentBookData(
    int id,
    String department,
    String bookName,
    String subjectCode,
    String subjectDesc,
    String status,
    String shift,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/bookcollections/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'Department': department,
        'BookName': bookName,
        'SubjectCode': subjectCode,
        'SubjectDesc': subjectDesc,
        'status': status,
        'stubag_id': id,
        'shift': shift,
      }),
    );

    if (response.statusCode == 200) {
      print("Student book data successfully added.");
    } else if (response.statusCode == 409) {
      final errorMessage =
          json.decode(response.body)['message'] ?? 'Conflict occurred';
      print(errorMessage);
      throw Exception(errorMessage);
    } else {
      print(response.body);
      throw Exception(response.body);
    }
  }

  @override
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
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/studentbagitems'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'Department': department,
        'Course': course,
        'Gender': gender,
        'Type': type,
        'Body': body,
        'Size': size,
        'Status': status,
        'stubag_id': id,
        'shift': shift,
      }),
    );

    if (response.statusCode == 200) {
      print("Student item data successfully added.");
    } else {
      print(response.statusCode);
      print(response.body);
      throw Exception("Failed to add student item data: ${response.body}");
    }
  }

  @override
  Future<void> addreserveBookData(
      int id,
      String department,
      String bookName,
      String subjectCode,
      String subjectDesc,
      String status,
      String shift,
      int stock) async {
    final response = await http.post(
      Uri.parse('$baseUrl/requestbook/$stock'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'Department': department,
        'BookName': bookName,
        'SubjectCode': subjectCode,
        'SubjectDesc': subjectDesc,
        'status': status,
        'stubag_id': id,
        'shift': shift,
      }),
    );

    if (response.statusCode == 200) {
      // Handle successful update
      print("Student book data successfully added.");
    } else if (response.statusCode == 409) {
      print(response.body);
    } else {
      print(response.body);
      throw Exception(response.body);
    }
  }

  @override
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
      int stock) async {
    final response = await http.post(
      Uri.parse('$baseUrl/requestitem/$stock'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'Department': department,
        'Course': course,
        'Gender': gender,
        'Type': type,
        'Body': body,
        'Size': size,
        'Status': status,
        'stubag_id': id,
        'shift': shift,
      }),
    );

    if (response.statusCode == 200) {
      print("Student item data successfully added.");
    } else {
      print(response.statusCode);
      print(response.statusCode);
      throw Exception("Failed to add student item data: ${response.body}");
    }
  }

  @override
  Future<void> reserveorclaimBook(int id, String status) async {
    final response =
        await http.put(Uri.parse('$baseUrl/bookreserveclaim/$id/$status'));
    if (response == 200) {
      print("!!!!!!!!!!!!!!!!!!!!");
    } else {
      print(response.statusCode);
      print('$baseUrl/bookreserveclaim/$id/$status');
      throw Exception('Failed');
    }
  }

  @override
  Future<void> reserveorclaimItem(int id, String status) async {
    final response =
        await http.put(Uri.parse('$baseUrl/itemreserveclaim/$id/$status'));
    if (response.statusCode == 200) {
      print("!!!!!!!!!!!!!!!!!!!!");
    } else {
      print(response.statusCode);
      print('$baseUrl/itemreserveclaim/$id/$status');
      throw Exception('Failed');
    }
  }

  @override
  Future<void> createNotificationData(int id, String message) async {
    final response = await http.post(
      Uri.parse('$baseUrl/mails'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'description': message,
        'time': 0,
        'redirectTo': "None",
        'notificationId': id,
      }),
    );

    if (response == 200) {
      print("hello");
    } else {
      print("bye");
      throw Exception("${response.statusCode}");
    }
  }

  @override
  Future<void> changePasswords(
      int id, String password, String cpassword) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/students/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'password': password,
          'confirm_password': cpassword,
        }),
      );

      if (response.statusCode == 200) {
        print(response.body);
      } else {
        throw Exception("Failed to Change Password: ${response.body}");
      }
    } catch (e) {}
  }

  // BY LANCE
  // DEPARTMENTS
  Future<List<department>> showDepartments() async {
    final response = await http.get(Uri.parse('$baseUrl/departments'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => department.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load departments');
    }
  }

  // COURSES
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

  // BOOKS
  @override
  Future<List<Book>> showBooks(String Department) async {
    final response =
        await http.get(Uri.parse('$baseUrl/item-books/$Department'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Book.fromJson(data)).toList();
    } else {
      print('Failed to load books, status code: ${response.statusCode}');
      throw Exception('Failed to load books');
    }
  }

// STOCK
  @override
  Future<List<Stock>> showStocks(String Department) async {
    final response = await http.get(Uri.parse('$baseUrl/stocks/$Department'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Stock.fromJson(data)).toList();
    } else {
      print('Failed to load stocks, status code: ${response.statusCode}');
      throw Exception('Failed to load stock');
    }
  }

  // UNIFORM (PARA SA LAHAT ITO AH, YUNG RSOS KASI NA TABLE GAMIT KO
  @override
  Future<List<Uniform>> showUniforms(String Course) async {
    final response = await http.get(Uri.parse('$baseUrl/uniforms/$Course'));
    if (response.statusCode == 200) {
      final List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Uniform.fromJson(data)).toList();
    } else {
      print('Failed to load Uniform, status code: ${response.statusCode}');
      throw Exception("Failed to load Uniform");
    }
  }

  @override
  Future<void> itemreduceStocks(int count, String department, String course,
      String gender, String type, String body, String size) async {
    final response = await http.put(Uri.parse(
        '$baseUrl/uniforms/reducestock/$count/$department/$course/$gender/$type/$body/$size'));
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to reduce stock: ${response.statusCode}');
    }
  }

  @override
  Future<void> bookreduceStocks(int count, String department, String bookname,
      String subcode, String subdesc) async {
    final response = await http.put(Uri.parse(
        '$baseUrl/books/reducestock/$count/$department/$bookname/$subcode/$subdesc'));
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to reduce stock: ${response.statusCode}');
    }
  }

  @override
  Future<int?> uniformStock(String department, String course, String gender,
      String type, String body, String size) async {
    final response = await http.put(Uri.parse(
        '$baseUrl/uniforms/stock/$department/$course/$gender/$type/$body/$size'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['stock'];
    } else {
      throw Exception('Failed to reduce stock: ${response.statusCode}');
    }
  }
}
