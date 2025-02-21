import 'package:dio/dio.dart';
import 'package:hola_academy/core/local_db/save_token.dart';
import 'package:hola_academy/core/networking/ErrorHandler/api_error_handler.dart';
import 'package:hola_academy/features/personal_info/Data/Model/update_user_model.dart';
import 'package:hola_academy/features/personal_info/Data/Model/user_model.dart';
import '../../../constants/api_constants.dart';

class DioUserApi {
  final Dio _dio;

  DioUserApi({required Dio dio}) : _dio = dio;

  Future<UserModel> getMyData() async {
    String? token = await SaveTokenDB.getToken();

    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.getMyDataApi}',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return UserModel.fromJson(response.data['data']);
      }
      throw Exception('Failed to load data');
    } on DioException catch (dioError) {
      throw dioError.response?.data['message'] ?? 'Unknown error occurred';
    }
  }

  Future<bool> updateMyData({
    required UpdateUserModel updateUserModel,
  }) async {
    String? token = await SaveTokenDB.getToken();

    try {
      final response = await _dio.patch(
        '${ApiConstants.baseUrl}${ApiConstants.updateMyDataApi}',
        data: updateUserModel.toMap(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return true;
      }
      throw Exception('Failed to update data');
    } catch (error) {
      final api = ApiErrorHandler.handle(error);

      throw "${api.message}";
    }
  }
}
