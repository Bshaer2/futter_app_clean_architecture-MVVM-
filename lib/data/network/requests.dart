class LoginRequest{
  String email;
  String password;

  LoginRequest(this.email, this.password);
}
class ForgetPasswordRequest{
  String email;
  ForgetPasswordRequest(this.email);
}