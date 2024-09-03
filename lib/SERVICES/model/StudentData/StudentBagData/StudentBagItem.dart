class StudentBagItem {
  final int id;
  final String Type;
  final String Body;
  final String Size;
  final String Status;
  final String Code;
  final int Stubag_id;

  StudentBagItem({
    required this.id,
    required this.Type,
    required this.Body,
    required this.Size,
    required this.Status,
    required this.Code,
    required this.Stubag_id,
  });

  factory StudentBagItem.fromJson(Map<String, dynamic> json) {
    return StudentBagItem(
      id: json['id'],
      Type: json['Type'],
      Body: json['Body'],
      Size: json['Size'],
      Status: json['Status'],
      Code: json['code'],
      Stubag_id: json['stubag_id'],
    );
  }
}
