class StudentBagBook {
  final int id;
  final String department;
  final String bookName;
  final String subjectCode;
  final String subjectDesc;
  final String code;
  final String status;
  final String claimingSchedule;
  final int reservationNumber;
  final int stubagId;
  final String shift;
  final DateTime? dateReceived;

  StudentBagBook({
    required this.reservationNumber,
    required this.id,
    required this.department,
    required this.bookName,
    required this.subjectCode,
    required this.subjectDesc,
    required this.code,
    required this.status,
    required this.claimingSchedule,
    required this.stubagId,
    required this.shift,
    this.dateReceived,
  });

  factory StudentBagBook.fromJson(Map<String, dynamic> json) {
    return StudentBagBook(
      id: json['id'],
      department: json['Department'] ?? '',
      bookName: json['BookName'] ?? '',
      subjectCode: json['SubjectCode'] ?? '',
      subjectDesc: json['SubjectDesc'] ?? '',
      code: json['code'] ?? '',
      status: json['Status'] ?? '',
      claimingSchedule: json['claiming_schedule'] ?? '',
      stubagId: json['stubag_id'] ?? 0,
      dateReceived: json['dateReceived'] != null
          ? DateTime.parse(json['dateReceived'])
          : null,
      reservationNumber: json['reservationNumber'] ?? 0,
      shift: json['shift'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Department': department,
      'BookName': bookName,
      'SubjectCode': subjectCode,
      'SubjectDesc': subjectDesc,
      'code': code,
      'Status': status,
      'claiming_schedule': claimingSchedule,
      'stubag_id': stubagId,
      'dateReceived': dateReceived?.toIso8601String(),
      'reservationNumber': reservationNumber,
      'shift': shift,
    };
  }
}
