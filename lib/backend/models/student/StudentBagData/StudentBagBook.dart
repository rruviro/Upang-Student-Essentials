class StudentBagBook {
  final int id;
  final String bookName;
  final String subjectCode;
  final String subjectDesc; 
  final String code;
  final String status;
  final String claimingSchedule;
  final int stubagId;
  final DateTime? dateReceived;

  StudentBagBook({
    required this.id,
    required this.bookName,
    required this.subjectCode,
    required this.subjectDesc,
    required this.code,
    required this.status,
    required this.claimingSchedule,
    required this.stubagId,
    this.dateReceived,
  });

  factory StudentBagBook.fromJson(Map<String, dynamic> json) {
    return StudentBagBook(
      id: json['id'],
      bookName: json['BookName'] ?? '',
      subjectCode: json['SubjectCode'] ?? '',
      subjectDesc: json['SubjectDesc'] ?? '',
      code: json['code'] ?? '',
      status: json['Status'] ?? '',
      claimingSchedule: json['claiming_schedule'] ?? '',
      stubagId: json['stubag_id'] ?? 0, // Default to 0 if null
      dateReceived: json['dateReceived'] != null 
          ? DateTime.parse(json['dateReceived']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'BookName': bookName,
      'SubjectCode': subjectCode, 
      'SubjectDesc': subjectDesc, 
      'code': code,
      'Status': status,
      'claiming_schedule': claimingSchedule,
      'stubag_id': stubagId,
      'dateReceived': dateReceived?.toIso8601String(),
    };
  }
}