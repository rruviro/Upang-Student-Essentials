class backpack {
  
  final String department;
  final String image;
  final String product;
  final String year;
  final String course;
  final String size;
  final String quantity;

  const backpack(
    this.department, 
    this.image,
    this.product,
    this.year,
    this.course,
    this.size,
    this.quantity,
  );

}

List<backpack> details = [
  backpack(
    'Cite', 
    'assets/vanguards.png', 
    'Corporate Top',
    'First Year',
    'BSIT',
    'XL',
    '1'
  ),
  backpack(
    'Cite', 
    'assets/vanguards.png', 
    'Rso Top',
    'First Year',
    'BSIT',
    'XL',
    '1'
  ),
];