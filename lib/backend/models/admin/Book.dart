class Book {
  final int id;
  final String Course;
  final String Department;
  final String BookName;
  final String SubjectCode;
  final String SubjectDesc;
  final int Stock;
  final int Reserved;

  Book({
    required this.id,
    required this.Course,
    required this.Department,
    required this.BookName,
    required this.SubjectCode,
    required this.SubjectDesc,
    required this.Stock,
    required this.Reserved,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      Course: json['Course'],
      Department: json['Department'],
      BookName: json['BookName'],
      SubjectCode: json['SubjectCode'],
      SubjectDesc: json['SubjectDesc'],
      Stock: json['Stock'],
      Reserved: json['Reserved'],
    );
  }
}
