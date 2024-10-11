import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:use/backend/apiservice/authApi/aurepo.dart';

class AuthenticationImplementation extends AuthenticationRepository {
  static const String baseUrl = 'http://127.0.0.1:8000/api';
  // static const String baseUrl = 'http://10.0.2.2:8000/api';
  //static const String baseUrl = 'http://localhost:8000/api';
  @override
  Future<void> studentLogin(String studentNum, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/auth/student/login'),
    headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'studentId': studentNum,
          'password': password,
        }),
      );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      Aurepo.accessToken = data['access_token'];
      Aurepo.refreshToken = data['refresh_token'];
      return data;
    } else {
      throw Exception('Invalid credentials');
    }
  }
}

class Aurepo {
  static var accessToken;
  static var refreshToken;
}