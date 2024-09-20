import 'package:use/backend/apiservice/adminApi/arepo.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:use/backend/models/student/StudentBagData/StudentBagBook.dart';
import 'package:use/backend/models/student/StudentBagData/StudentBagItem.dart';
import 'dart:convert';

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
}