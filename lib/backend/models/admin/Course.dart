// class course {
//   final String bs;
//   final String bachelor;
//   const course(this.bs, this.bachelor);
// }
//
// List<course> details = [
//   course(
//     'BSN',
//     'Bachelor of Science in Nursing',
//   ),
// ];

// CHANGES BY LANCE
class Course {
  final int id;
  final int departmentID;
  final String courseName;
  final String courseDescription;

  Course({
    required this.id,
    required this.departmentID,
    required this.courseName,
    required this.courseDescription,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      departmentID: json['departmentID'],
      courseName: json['courseName'],
      courseDescription: json['courseDescription'],
    );
  }
}
