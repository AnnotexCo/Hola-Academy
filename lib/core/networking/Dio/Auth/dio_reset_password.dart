import 'package:dio/dio.dart';
import 'package:hola_academy/core/constants/api_constants.dart';
import 'package:hola_academy/core/networking/ErrorHandler/api_error_handler.dart';

class DioResetPassword {
  final Dio _dio;

  DioResetPassword({required Dio dio}) : _dio = dio;

  Future<bool> dioResetPassword(String email , String password , int otp) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.resetPasswordApi}',
        data: {
          "email": email,
          "password": password,
          "otp": otp,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return true;
      }
      return false;
    } catch (error) {
      final api = ApiErrorHandler.handle(error);

      throw "${api.message}";
    }
  }
}
