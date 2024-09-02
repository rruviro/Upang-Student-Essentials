import 'package:use/SERVICES/model/StudentData/StudentBag.dart';
import 'package:use/SERVICES/model/StudentData/StudentNotifcation.dart';
import 'package:use/SERVICES/model/StudentData/StudentProfile.dart';

class Student {
  final int id;
  final String studentId;
  final StudentProfile profile;
  final StudentBag studentBag;
  final StudentNotification notification;

  Student({
    required this.id,
    required this.studentId,
    required this.profile,
    required this.studentBag,
    required this.notification,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      studentId: json['studentId'],
      profile: StudentProfile.fromJson(json['profile']),
      studentBag: StudentBag.fromJson(json['student_bag']),
      notification: StudentNotification.fromJson(json['notification']),
    );
  }
}