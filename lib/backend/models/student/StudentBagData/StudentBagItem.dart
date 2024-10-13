class StudentBagItem {
  final int id;
  final String department;
  final String course;
  final String gender;
  final String type;
  final String body;
  final String size;
  final String status;
  final String? code;
  final int reservationNumber;
  final String claimingSchedule;
  final int stubagId;
  final String shift;
  final DateTime? dateReceived;

  StudentBagItem({
    required this.reservationNumber,
    required this.id,
    required this.department,
    required this.course,
    required this.gender,
    required this.type,
    required this.body,
    required this.size,
    required this.status,
    required this.shift,
    this.code,
    required this.claimingSchedule,
    required this.stubagId,
    this.dateReceived,
  });

  factory StudentBagItem.fromJson(Map<String, dynamic> json) {
    return StudentBagItem(
      id: json['id'],
      department: json['Department'] ?? '',
      course: json['Course'] ?? '',
      gender: json['Gender'] ?? '',
      type: json['Type'] ?? '',
      body: json['Body'] ?? '',
      size: json['Size'] ?? '',
      status: json['Status'] ?? '',
      code: json['code'],
      claimingSchedule: json['claiming_schedule'] ?? '',
      stubagId: json['stubag_id'],
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
      'Course': course,
      'Gender': gender,
      'Type': type,
      'Body': body,
      'Size': size,
      'Status': status,
      'code': code,
      'claiming_schedule': claimingSchedule,
      'stubag_id': stubagId,
      'dateReceived': dateReceived?.toIso8601String(),
      'reservationNumber': reservationNumber,
      'shift': shift,
    };
  }
}
