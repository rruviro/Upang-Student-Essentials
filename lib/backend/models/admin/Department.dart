import 'dart:convert';

// CHANGES BY LANCE
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

  // String get photoUrl {
  //   return 'http://127.0.0.1:8000/api/departments/public/uploads/department/$photo';
  // }

  factory department.fromJson(Map<String, dynamic> json) {
    return department(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      photo: json['photo'],
    );
  }
}



// List<Departments> initials = [
//   Departments(
//     'Health Science',
//     'assets/vanguards.png',
//     'BSN',
//   ),
//   Departments(
//     'Cite',
//     'assets/vanguards.png',
//     'BSIT',
//   ),
// ];