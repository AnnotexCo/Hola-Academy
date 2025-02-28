import 'package:dio/dio.dart';
import 'package:hola_academy/core/constants/api_constants.dart';
import 'package:hola_academy/core/networking/ErrorHandler/api_error_handler.dart';
import 'package:hola_academy/features/classes/Data/Model/levels_model.dart';

class DioLevels {
  final Dio _dio;

  DioLevels({required Dio dio}) : _dio = dio;

  /// Fetch all programs
  Future<List<LevelsModel>> getAllLevels() async {
    try {
      final response =
          await _dio.get("${ApiConstants.baseUrl}${ApiConstants.getAllLevels}");

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => LevelsModel.fromMap(json)).toList();
      }
      throw Exception("Failed to load programs");
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }

  /// Fetch a single program by ID
  Future<List<LevelsModel>> getLevelsbyId(int id) async {
    try {
      final response = await _dio.get(
          "${ApiConstants.baseUrl}${ApiConstants.getAllLevels}",
          queryParameters: {
            "programId": id,
          });

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => LevelsModel.fromMap(json)).toList();
      }
      throw Exception("Failed to load program");
    } catch (error) {
      throw error.toString();
    }
  }
}
