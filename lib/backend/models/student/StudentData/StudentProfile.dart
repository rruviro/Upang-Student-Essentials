class StudentProfile {
  final int id;
  final String firstName;
  final String lastName;
  final String course;
  final String department;
  final int year;
  final String status;
  final String stuId;
  final int notifcount;
  final int anncount;

  StudentProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.course,
    required this.department,
    required this.year,
    required this.status,
    required this.stuId,
    required this.notifcount,
    required this.anncount,
  });

  factory StudentProfile.fromJson(Map<String, dynamic> json) {
    return StudentProfile(
      id: json['id'],
      firstName: json['FirstName'],
      lastName: json['LastName'],
      course: json['Course'],
      department: json['Department'],
      year: json['Year'],
      status: json['Status'],
      stuId: json['stu_id'],
      notifcount: json['notifcount'],
      anncount: json['anncount'],
    );
  }
}
