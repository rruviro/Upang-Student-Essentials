class StudentNotification {
  final int id;
  final String stuId;

  StudentNotification({
    required this.id,
    required this.stuId,
  });

  factory StudentNotification.fromJson(Map<String, dynamic> json) {
    return StudentNotification(
      id: json['id'],
      stuId: json['stu_id'],
    );
  }
}