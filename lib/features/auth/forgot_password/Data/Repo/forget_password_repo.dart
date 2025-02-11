import 'package:hola_academy/core/networking/Dio/Auth/dio_forget_password.dart';

class ForgetPasswordRepo {
  final DioForgetPassword dioForgetPassword;

  ForgetPasswordRepo({required this.dioForgetPassword});

  Future<void> forgetPassword(
    String email,
  ) async {
    await dioForgetPassword.dioForgetPassword(email);
  }
}
