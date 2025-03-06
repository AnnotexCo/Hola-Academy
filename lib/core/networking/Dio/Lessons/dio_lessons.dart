import 'package:dio/dio.dart';
import 'package:hola_academy/core/constants/api_constants.dart';
import 'package:hola_academy/core/networking/ErrorHandler/api_error_handler.dart';
import 'package:hola_academy/features/classes/Data/Model/lessons_model.dart';

class DioLessons {
  final Dio _dio;

  DioLessons({required Dio dio}) : _dio = dio;

//Fetch Lessons by StartDate and end date

  Future<List<LessonModel>> getLessonsByDate(
      String startDate, String endDate) async {
    try {
      final response = await _dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.getLessonsApiByID}",
        queryParameters: {"startDate": startDate, "endDate": endDate},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => LessonModel.fromMap(json)).toList();
      }
      throw Exception("Failed to load programs");
    } catch (error) {
      throw ApiErrorHandler.handle(error).message.toString();
    }
  }

  /// Fetch all Lessons by Id's
  Future<List<LessonModel>> getLessonsByID(int traineeID, int classID) async {
    try {
      final response = await _dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.getLessonsApiByID}",
        queryParameters: {"traineeId": traineeID, "classId": classID},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => LessonModel.fromMap(json)).toList();
      }
      throw Exception("Failed to load programs");
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }

  /// Fetch a single program by ID
  Future<List<LessonModel>> getLessonsByTrainee() async {
    try {
      final response = await _dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.myLessonsApi}",
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => LessonModel.fromMap(json)).toList();
      }
      throw Exception("Failed to load program");
    } catch (error) {
      throw error.toString();
    }
  }

  Future<LessonModel> getMyNextLessons() async {
    try {
      final response = await _dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.myNextLessonsApi}",
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];

        return LessonModel.fromMapV2(data);
      }
      throw Exception("Failed to load program");
    } catch (error) {
      throw error.toString();
    }
  }
}
