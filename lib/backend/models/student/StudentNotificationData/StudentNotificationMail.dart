class StudentNotifcationMail {
  final int id;
  final String description;
  final String time;
  final bool istapped;
  final int notificationId;
  final String redirectTo;

  StudentNotifcationMail({
    required this.id,
    required this.description,
    required this.time,
    required this.notificationId,
    required this.istapped,
    required this.redirectTo,
  });

  factory StudentNotifcationMail.fromJson(Map<String, dynamic> json) {
    return StudentNotifcationMail(
      id: json['id'],
      description: json['description'],
      time: json['time'],
      notificationId: json['notificationId'],
      istapped: json['isTapped'],
      redirectTo: json['redirectTo'],
    );
  }
}
