import 'package:dio/dio.dart';
import 'package:hola_academy/core/constants/api_constants.dart';
import 'package:hola_academy/core/local_db/save_token.dart';
import 'package:hola_academy/core/networking/ErrorHandler/api_error_handler.dart';
import 'package:hola_academy/features/classes/Data/Model/lessons_model.dart';

class DioLessons {
  final Dio _dio;

  DioLessons({required Dio dio}) : _dio = dio;

  /// Fetch all programs
  Future<List<LessonModel>> getAllLevels() async {
    try {
      final response = await _dio
          .get("${ApiConstants.baseUrl}${ApiConstants.getallLessonsApi}");

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => LessonModel.fromJson(json)).toList();
      }
      throw Exception("Failed to load programs");
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }

  /// Fetch a single program by ID
  Future<List<LessonModel>> getLessonsbytrainee() async {
    String? token = await SaveTokenDB.getToken();
    try {
      final response =
          await _dio.get("${ApiConstants.baseUrl}${ApiConstants.myLessonsApi}",
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                  'Content-Type': 'application/json',
                },
              ));

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => LessonModel.fromJson(json)).toList();
      }
      throw Exception("Failed to load program");
    } catch (error) {
      throw error.toString();
    }
  }
}
