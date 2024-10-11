import 'package:intl/intl.dart';

class announcement {
  final int id;
  final String department;
  final String body;
  final String date;

  announcement({ 
    required this.department, 
    required this.body, 
    required this.date, 
    required this.id, 
  });
    
  factory announcement.fromJson(Map<String, dynamic> json) {
    String createdAt = json['created_at'] ?? '';
    DateTime dateTime = createdAt.isNotEmpty ? DateTime.parse(createdAt) : DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    return announcement(
      id: json['id'] ?? 0,
      department: json['department'] ?? '', 
      body: json['body'] ?? '', 
      date: formattedDate,
    );
  }
}
