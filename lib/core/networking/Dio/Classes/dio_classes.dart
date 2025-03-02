import 'package:dio/dio.dart';
import 'package:hola_academy/core/constants/api_constants.dart';
import 'package:hola_academy/core/local_db/save_token.dart';
import 'package:hola_academy/features/classes/Data/Model/classs_model.dart';
import 'package:hola_academy/features/classes/Data/Model/myclass_model.dart';

class DioClasses {
  final Dio _dio;

  DioClasses({required Dio dio}) : _dio = dio;

  Future<List<ClasssModel>> getAllClasses() async {
    try {
      final response =
          await _dio.get("${ApiConstants.baseUrl}${ApiConstants.classesApi}");

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => ClasssModel.fromMap(json)).toList();
      }
      throw Exception("Failed to load classes");
    } catch (error) {
      rethrow;
    }
  }

  Future<ClasssModel> getClassesyById(int id) async {
    try {
      final response = await _dio
          .get("${ApiConstants.baseUrl}${ApiConstants.categoryByIdApi}$id");

      if (response.statusCode == 200) {
        return ClasssModel.fromMap(response.data['data']);
      }
      throw Exception("Failed to load Class");
    } catch (error) {
      rethrow;
    }
  }

  Future<List<ClasssModel>> getClassesByLevel(int id) async {
    try {
      final response = await _dio.get(
          "${ApiConstants.baseUrl}${ApiConstants.classesApi}",
          queryParameters: {"levelId": id});

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => ClasssModel.fromMap(json)).toList();
      }
      throw Exception("Failed to load classes");
    } catch (error) {
      rethrow;
    }
  }

  Future<List<MyClassModel>> getmyClasses() async {
    String? token = await SaveTokenDB.getToken();
    try {
      final response =
          await _dio.get("${ApiConstants.baseUrl}${ApiConstants.myclassesApi}",
              options: Options(
                headers: {
                  'Authorization': 'Bearer $token',
                  'Content-Type': 'application/json',
                },
              ));
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => MyClassModel.fromJson(json)).toList();
      }
      throw Exception("Failed to load classes");
    } catch (error) {
      rethrow;
    }
  }
}
