import 'package:dio/dio.dart';
import 'package:hola_academy/features/personal_info/Data/Model/update_user_model.dart';
import 'package:hola_academy/features/personal_info/Data/Model/user_model.dart';
import '../../../constants/api_constants.dart';

class DioUserApi {
  final Dio _dio;

  DioUserApi({required Dio dio}) : _dio = dio;

  Future<UserModel> getMyData({required String accessToken}) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.getMyDataApi}',
        data: {
          "accessToken": accessToken,
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
        return UserModel.fromJson(response.data['data']);
        print(response.data['data']);
      }
      throw Exception('Failed to load data');
    } on DioException catch (dioError) {
      throw dioError.response?.data['message'];
    }
  }

  updateMyData({
    required UpdateUserModel updateUserModel,
  }) async {
    try {
      final response = await _dio.patch(
        '${ApiConstants.baseUrl}${ApiConstants.updateMyDataApi}',
        data: updateUserModel.toMap(),
      );
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return true;
      }
      throw Exception('Failed to update data');
    } on DioException catch (dioError) {
      throw dioError.response?.data['message'];
    }
  }
}
