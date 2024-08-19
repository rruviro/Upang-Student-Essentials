class Departments {
  final String department;
  final String imageUrl;
  final String courses;
  const Departments(this.department, this.imageUrl, this.courses);
}

List<Departments> initials = [
  Departments(
    'Health Science', 
    'assets/vanguards.png', 
    'BSN', 
  ),
  Departments(
    'Cite', 
    'assets/vanguards.png', 
    'BSIT', 
  ),
];