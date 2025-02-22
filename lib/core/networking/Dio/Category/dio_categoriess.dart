import 'package:dio/dio.dart';
import 'package:hola_academy/core/constants/api_constants.dart';
import 'package:hola_academy/core/networking/ErrorHandler/api_error_handler.dart';
import '../../../../features/classes/Data/Model/category_model.dart';

class DioCategoriess {
  final Dio _dio;

  DioCategoriess({required Dio dio}) : _dio = dio;

  /// Fetch all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final response = await _dio.get("${ApiConstants.baseUrl}${ApiConstants.categoriesApi}");

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => CategoryModel.fromJson(json)).toList();
      }
      throw Exception("Failed to load categories");
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }

  /// Fetch a single category by ID
  Future<CategoryModel> getCategoryById(int id) async {
    try {
      final response = await _dio.get("${ApiConstants.baseUrl}${ApiConstants.categoryByIdApi}$id");

      if (response.statusCode == 200) {
        return CategoryModel.fromJson(response.data['data']);
      }
      throw Exception("Failed to load category");
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }
}
