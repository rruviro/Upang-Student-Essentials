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
    return 'https://floating-cliffs-62090-6c6c2af6e00a.herokuapp.com/uploads/department/$photo';
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
