class CreateStudent {
  final String studentId;

  final String firstName;
  final String lastName;
  final String course;
  final String department;
  final bool hasUUniform;
  final bool hasLUniform;
  final bool hasRSO;
  final bool hasBooks;
  final int year;
  final String status;
  final String stuId;

  CreateStudent({
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.course,
    required this.department,
    required this.hasUUniform,
    required this.hasLUniform,
    required this.hasRSO,
    required this.hasBooks,
    required this.year,
    required this.status,
    required this.stuId,
  });
}
