abstract class AuthenticationRepository {
  Future<void> studentLogin(String studentNum, String password);
  Future<void> adminLogin(String adminID, String password);
}