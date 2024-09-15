abstract class Studentrepo {
  Future<void> showStudentData(String studentId);
  Future<void> showStudenNotificationMailData(int stunotification_id);
  Future<void> showStudentBagBookData(int stubag_id, String status);
  Future<void> showStudentBagItemData(int stubag_id, String status);
}