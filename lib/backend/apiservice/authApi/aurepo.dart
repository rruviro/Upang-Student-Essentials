abstract class AuthenticationRepository {
  Future<void> studentLogin(String studentNum, String password);
}