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
  //static const String baseUrl = 'http://127.0.0.1:8000/api';
  static const String baseUrl = 'http://10.0.2.2:8000/api';
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
  Future<List<StudentNotifcationMail>> showStudenNotificationMailData(int stunotification_id) async {
    final response = await http.get(Uri.parse('$baseUrl/mails/$stunotification_id'));

    if(response.statusCode == 200){
      final responseBody = json.decode(response.body);
      List<dynamic> itemsJson = responseBody['mails'];
      return itemsJson.map((json) => StudentNotifcationMail.fromJson(json)).toList();
    }
    else{
      throw Exception(response.statusCode);
    }
  }
  @override
  Future<List<StudentBagBook>> showStudentBagBookData(int stubag_id, String status) async{
    final response = await http.get(Uri.parse('$baseUrl/bookcollections/${stubag_id}/${status}'));
      if (response.statusCode == 200) {
          final responseBody = json.decode(response.body);
          List<dynamic> itemsJson = responseBody['bookCollections'];
          return itemsJson.map((json) => StudentBagBook.fromJson(json)).toList();
      } else {
        throw Exception(response.body);
      }
  }

    @override
    Future<List<StudentBagItem>> showStudentBagItemData(int stubag_id, String status) async{
    final response = await http.get(Uri.parse('$baseUrl/studentbagitems/${stubag_id}/${status}'));
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
      final response = await http.delete(Uri.parse('$baseUrl/bookcollections/$id'));
      if(response.statusCode == 200){
      }
      else{
        throw Exception('Failed');
      }
    }

    @override
    Future<void> deleteStudentItemData(int id) async {
      final response = await http.delete(Uri.parse('$baseUrl/studentbagitems/$id'));
      if(response.statusCode == 200){
      }
      else{
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
    }
    else {
      throw Exception('Failed to load announcements, status code: ${response.statusCode}');
    }
  }
  
  @override
  Future<void> changeStudentBookStatus(int id, String status) async {
    final response = await http.put(Uri.parse('$baseUrl/bookcollections/$id/$status'));
    if (response == 200){
    }
    else{
      throw Exception('Failed');
    }
  }
  
  @override
  Future<void> changeStudentItemStatus(int id, String status) async {
    final response = await http.put(Uri.parse('$baseUrl/studentbagitems/$id/$status'));
    if (response == 200){
    }
    else{
      throw Exception('Failed');
    }
  }
}