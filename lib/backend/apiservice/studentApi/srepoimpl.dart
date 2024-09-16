import 'package:use/backend/apiservice/studentApi/srepo.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:use/backend/models/student/StudentData/StudentProfile.dart';
import 'package:use/backend/models/student/StudentData/Student.dart';
import 'package:use/backend/models/student/StudentData/StudentBag.dart';
import 'package:use/backend/models/student/StudentData/StudentNotifcation.dart';
import 'dart:convert';



  class StudentRepositoryImpl extends Studentrepo {
  static const String baseUrl = 'http://127.0.0.1:8000/api/students';

  @override
  Future<Student> showStudentData(String studentId) async {
    final response = await http.get(Uri.parse('$baseUrl/$studentId'));

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

        final studentProfile = profileJson != null 
            ? StudentProfile.fromJson(profileJson) 
            : null;
        
        final studentBag = studentBagJson != null 
            ? StudentBag.fromJson(studentBagJson) 
            : null;
        
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
      throw Exception('Failed to load student, status code: ${response.statusCode}');
    }
  }


  @override
  Future<void> showStudenNotificationMailData(int stunotification_id) async {
    print("1");
  }

  @override
  Future<void> showStudentBagBookData(int stubag_id, String status) async{
    print("2");
  }

  @override
  Future<void> showStudentBagItemData(int stubag_id, String status) async{
    print("3");
  }


  
}