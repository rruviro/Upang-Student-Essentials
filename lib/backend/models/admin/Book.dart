import 'dart:convert';

class Book {
  final int id;
  final String Department;
  final String BookName;
  final String SubjectCode;
  final String SubjectDesc;
  final String Status;
  final int Stock;

  Book({
    required this.id,
    required this.Department,
    required this.BookName,
    required this.SubjectCode,
    required this.SubjectDesc,
    required this.Status,
    required this.Stock,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      Department: json['Department'],
      BookName: json['BookName'],
      SubjectCode: json['SubjectCode'],
      SubjectDesc: json['SubjectDesc'],
      Status: json['Status'],
      Stock: json['Stock'],


    );
  }
}