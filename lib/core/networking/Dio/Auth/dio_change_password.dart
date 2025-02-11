import 'package:dio/dio.dart';
import 'package:hola_academy/core/constants/api_constants.dart';
import 'package:hola_academy/core/networking/ErrorHandler/api_error_handler.dart';

class DioChangePassword {
  final Dio _dio;

  DioChangePassword({required Dio dio}) : _dio = dio;

  Future<bool> dioChangePassword(String oldPassword, String newPassword) async {
    try {
      final response = await _dio.patch(
        '${ApiConstants.baseUrl}${ApiConstants.forgetPasswordApi}',
        data: {
          "oldPassword": oldPassword,
          "newPassword": newPassword,
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
