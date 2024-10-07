import 'package:use/backend/apiservice/studentApi/srepo.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:use/backend/models/admin/Announcement.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagBook.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagItem.dart';
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';
import 'package:use/backend/models/student/StudentData/Student.dart';
import 'package:use/backend/models/student/StudentData/StudentBag.dart';
import 'package:use/backend/models/student/StudentData/StudentNotifcation.dart';
import 'dart:convert';

import 'package:use/backend/models/student/StudentNotificationData/StudentNotificationMail.dart';

class StudentRepositoryImpl extends Studentrepo {
  static const String baseUrl = 'http://127.0.0.1:8000/api';
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
  Future<void> addStudentBookData(int id, String department, String bookName,
      String subjectCode, String subjectDesc, String status) async {
    final response = await http.put(
      Uri.parse('$baseUrl/bookcollections'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'Department': department,
        'BookName': bookName,
        'SubjectCode': subjectCode,
        'SubjectDesc': subjectDesc,
        'Status': status,
        'stubag_id': id,
      }),
    );

    if (response.statusCode == 200) {
      // Handle successful update
      print("Student book data successfully added.");
    } else {
      throw Exception("Failed to add student book data: ${response.body}");
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
      String status) async {
    final response = await http.put(
      Uri.parse('$baseUrl/studentbagitems'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
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
      }),
    );

    if (response.statusCode == 200) {
      print("Student item data successfully added.");
    } else {
      throw Exception("Failed to add student item data: ${response.body}");
    }
  }

  @override
  Future<void> reserveorclaimBook(int id, String status, int stocks) async {
    final response = await http
        .put(Uri.parse('$baseUrl/bookreserveclaim/$id/$status/$stocks'));
    if (response == 200) {
    } else {
      throw Exception('Failed');
    }
  }

  @override
  Future<void> reserveorclaimItem(int id, String status, int stocks) async {
    final response = await http
        .put(Uri.parse('$baseUrl/itemreserveclaim/$id/$status/$stocks'));
    if (response == 200) {
    } else {
      throw Exception('Failed');
    }
  }
}
