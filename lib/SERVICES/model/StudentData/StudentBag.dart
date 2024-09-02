class StudentBag {
  final int id;
  final String stuId;

  StudentBag({
    required this.id,
    required this.stuId,
  });

  factory StudentBag.fromJson(Map<String, dynamic> json) {
    return StudentBag(
      id: json['id'],
      stuId: json['stu_id'],
    );
  }
}