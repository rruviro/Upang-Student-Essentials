// class stocks {
//   final String product;
//   final String stock;
//   final String image;
//   const stocks(this.product, this.stock, this.image);
// }
//
// List<stocks> products = [
//   stocks(
//     'RSO',
//     '32',
//     'assets/vanguards.png'
//   ),
//   stocks(
//     'Corporate',
//     '100',
//     'assets/vanguards.png'
//   ),
//   stocks(
//     'RSO',
//     '32',
//     'assets/vanguards.png'
//   ),
//   stocks(
//     'Corporate',
//     '100',
//     'assets/vanguards.png'
//   ),
// ];

class Stock {
  final int id;
  final String stockName;
  final String stockPhoto;
  final String Department;

  Stock({
    required this.id,
    required this.stockName,
    required this.stockPhoto,
    required this.Department,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: json['id'],
      stockName: json['stockName'],
      stockPhoto: json['stockPhoto'],
      Department: json['Department'],
    );
  }
}
