import 'package:use/backend/apiservice/adminApi/arepo.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:use/backend/models/student/StudentBagData/StudentBagBook.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagItem.dart';
import 'dart:convert';

import 'package:use/backend/models/student/StudentData/StudentProfile.dart';

  class AdminRepositoryImpl extends Adminrepo{
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  @override
  Future<StudentBagBook> showCodeBook(String code) async {
    final response = await http.get(Uri.parse('$baseUrl/bookpickup/$code'));
    if (response.statusCode == 200){
      print("gumana");
      final responseBody = json.decode(response.body)['bookCollections'];
      return StudentBagBook.fromJson(responseBody);
      
    }
    else{
      print("hindi");
      print(response.statusCode);
      throw Exception(response.statusCode);
    }
  }
  
  @override
  Future<StudentBagItem> showCodeItem(String code) async {
    final response = await http.get(Uri.parse('$baseUrl/itempickup/$code'));
    if (response.statusCode == 200){
      print("gumana");
      final responseBody = json.decode(response.body)['items'];
      return StudentBagItem.fromJson(responseBody);
    }
    else{print("hidni");
      throw Exception(response.statusCode);
    }
  }
  @override
  Future<void> changeStudentBookStatus(int id, String status) async {
    final response = await http.put(Uri.parse('$baseUrl/bookcollections/$id/$status'));
    if (response.statusCode == 200){
    }
    else{
      throw Exception('Failed');
    }
  }
  
  @override
  Future<void> changeStudentItemStatus(int id, String status) async {
    final response = await http.put(Uri.parse('$baseUrl/studentbagitems/$id/$status'));
    if (response.statusCode == 200){
    }
    else{
      throw Exception();
    }
  }

  @override
  Future<void> createStudent(String firstName, String lastName, String course, String department, int year, String status) async {
    final response = await http.post(
      Uri.parse('$baseUrl/students'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'profile': {  // Wrap properties inside the 'profile' object
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
  Future<void> updateStudent(String firstName, String lastName, String course, String department, int year, String status, int id ) async {
          final response = await http.put(Uri.parse('$baseUrl/updateprofile/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'FirstName': firstName,
          'LastName': lastName,
          'Course': course,
          'Department': department,
          'Year': year,
          'Status"': status
        }),
      );

      if (response.statusCode == 200) {
        // Handle successful update
      } else {
        throw UnimplementedError();
      }
    
  }
}