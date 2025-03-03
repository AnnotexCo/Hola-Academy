import 'package:dio/dio.dart';
import 'package:hola_academy/core/constants/api_constants.dart';
import 'package:hola_academy/core/local_db/save_token.dart';
import 'package:hola_academy/core/networking/ErrorHandler/api_error_handler.dart';
import 'package:hola_academy/features/classes/Data/Model/lessons_model.dart';

class DioSkills {
  final Dio _dio;

  DioSkills({required Dio dio}) : _dio = dio;

  Future<List<LessonModel>> getSkillsbyLessonID(int lessonID) async {
    String? token = await SaveTokenDB.getToken();
    try {
      final response = await _dio.get(
          "${ApiConstants.baseUrl}${ApiConstants.getSkillsbyLessonsID}",
          data: {
            "lessonId": lessonID,
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          ));

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => LessonModel.fromMap(json)).toList();
      }
      throw Exception("Failed to load program");
    } catch (error) {
      throw ApiErrorHandler.handle(error).message.toString();
    }
  }
}
