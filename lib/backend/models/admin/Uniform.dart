class Uniform {
  final int id;
  final String Department;
  final String Course;
  final String Gender;
  final String Type;
  final String Body;
  final String Size;
  final int Stock;

  Uniform({
    required this.id,
    required this.Department,
    required this.Course,
    required this.Gender,
    required this.Type,
    required this.Body,
    required this.Size,
    required this.Stock,
  });

  factory Uniform.fromJson(Map<String, dynamic> json) {
    return Uniform(
      id: json['id'],
      Department: json['Department'],
      Course: json['Course'],
      Gender: json['Gender'],
      Type: json['Type'],
      Body: json['Body'],
      Size: json['Size'],
      Stock: json['Stock'],
    );
  }
}