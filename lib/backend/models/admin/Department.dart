class department {
  final int id;
  final String name;
  final String color;
  final String photo;

  department({
    required this.id,
    required this.name,
    required this.color,
    required this.photo,
  });

  // Build the correct URL
  String get photoUrl {
    return 'http://127.0.0.1:8000/$photo'; // No need to concatenate 'uploads/department/' twice
  }

  factory department.fromJson(Map<String, dynamic> json) {
    return department(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      photo: json['photo'], // Should be something like 'uploads/department/filename.jpg'
    );
  }
}
