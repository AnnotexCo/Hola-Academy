import 'package:hola_academy/core/networking/Dio/Auth/dio_reset_password.dart';

class ResetPasswordRepo {
  final DioResetPassword dioResetPassword;

  ResetPasswordRepo({required this.dioResetPassword});

  Future<void> resetPassword(String email, String newPassword,String otp) async {
    await dioResetPassword.dioResetPassword(email, newPassword, otp);
  }
}
