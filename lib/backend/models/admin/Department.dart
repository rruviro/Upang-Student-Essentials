class department {
  final int id;
  final String name;
  final String color;
  final String photo;
  final int reserved;
  final int claim;
  final int completed;

  department({
    required this.id,
    required this.name,
    required this.color,
    required this.photo,
    required this.reserved,
    required this.claim,
    required this.completed,
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
      photo: json['photo'],
      reserved: json['reserved'],
      claim: json['claim'],
      completed: json[
          'completed'], // Should be something like 'uploads/department/filename.jpg'
    );
  }
}
