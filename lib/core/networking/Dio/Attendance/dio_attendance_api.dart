import 'package:dio/dio.dart';
import 'package:hola_academy/core/constants/api_constants.dart';
import 'package:hola_academy/core/local_db/save_token.dart';
import 'package:hola_academy/core/networking/ErrorHandler/api_error_handler.dart';

class DioAttendance {
  final Dio _dio;

  DioAttendance({required Dio dio}): _dio = dio;

  Future<dynamic> markAttendance({required String qrCode}) async {
    String? token = await SaveTokenDB.getToken();
    try {
      final response = await _dio.post(
        "${ApiConstants.baseUrl}${ApiConstants.attendanceMarkApi}$qrCode",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      throw Exception("Failed to load Attendance");
    } catch (error) {
      if (error is DioException && error.response != null) {}
      //print(error.toString());
      //throw error.toString();
      throw ApiErrorHandler.handle(error).message.toString();
    }
    
  }
  
}
