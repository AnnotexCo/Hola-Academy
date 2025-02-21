import 'package:hola_academy/core/networking/Dio/Auth/dio_check_otp.dart';

class CheckOtpRepo {
  final DioCheckOTP dioCheckOTP;

  CheckOtpRepo({required this.dioCheckOTP});

  Future<void> checkOtp(String email,String otp) async {
    await dioCheckOTP.dioCheckOTP(email, otp);
  }
}
