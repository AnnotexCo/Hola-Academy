import 'package:dio/dio.dart';
import 'package:hola_academy/features/auth/register/Data/Model/sign_up_model.dart';
import 'package:hola_academy/features/personal_info/Data/Model/user_model.dart';
import '../../../constants/api_constants.dart';

class DioUserApi {
  final Dio _dio;

  DioUserApi({required Dio dio}) : _dio = dio;

  Future<UserModel> getMyData() async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.getMyDataApi}',
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
            return UserModel.fromJson(response.data['data']);
      }
      throw Exception('Failed to load data');
    } on DioException catch (dioError) {
      throw dioError.response?.data['message'];
    }
  }
}
