class StudentNotifcationMail {
  final int id;
  final String description;
  final String time;
  final int notificationId;

  StudentNotifcationMail({
    required this.id,
    required this.description,
    required this.time,
    required this.notificationId,
  });

  factory StudentNotifcationMail.fromJson(Map<String, dynamic> json) {
    return StudentNotifcationMail(
      id: json['id'],
      description: json['description'], 
      time: json['time'],
      notificationId: json['notificationId'], 
    );
  }
}