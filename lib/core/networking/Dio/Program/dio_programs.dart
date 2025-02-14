import 'package:dio/dio.dart';
import 'package:hola_academy/core/constants/api_constants.dart';
import 'package:hola_academy/core/networking/ErrorHandler/api_error_handler.dart';

import '../../../../features/classes/Data/Model/programs_model.dart';

class DioPrograms {
  final Dio _dio;

  DioPrograms({required Dio dio}) : _dio = dio;

  /// Fetch all programs
  Future<List<ProgramsModel>> getAllPrograms() async {
    try {
      final response = await _dio.get("${ApiConstants.baseUrl}${ApiConstants.programsApi}");

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => ProgramsModel.fromJson(json)).toList();
      }
      throw Exception("Failed to load programs");
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }

  /// Fetch a single program by ID
  Future<ProgramsModel> getProgramById(int id) async {
    try {
      final response = await _dio.get("${ApiConstants.baseUrl}${ApiConstants.programByIdApi}$id");

      if (response.statusCode == 200) {
        return ProgramsModel.fromJson(response.data['data']);
      }
      throw Exception("Failed to load program");
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }
}
