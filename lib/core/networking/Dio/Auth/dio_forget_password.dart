import 'package:dio/dio.dart';
import 'package:hola_academy/core/constants/api_constants.dart';
import 'package:hola_academy/core/networking/ErrorHandler/api_error_handler.dart';

class DioForgetPassword {
  final Dio _dio;

  DioForgetPassword({required Dio dio}) : _dio = dio;

  Future<bool> dioForgetPassword(String email) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.forgetPasswordApi}',
        data: {
          "email": email,
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
