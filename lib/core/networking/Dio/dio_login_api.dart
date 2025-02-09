import 'package:dio/dio.dart';
import '../../../features/auth/login/Data/Model/login_model.dart';
import '../../constants/api_constants.dart';
import '../../local_db/save_token.dart';

class DioLoginApi {
  final Dio _dio;

  DioLoginApi({required Dio dio}) : _dio = dio;

  Future<bool> dioLogin({required LoginModel loginModel}) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.loginApi}',
        data: loginModel.toMap(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        final responseData = response.data['data'];
        String? token = responseData['access_token']; 
        String? role = responseData['role'];

        if (token != null && role != null) {
          await SaveTokenDB.saveTokenAndRole(token, role); // Save both
        }
        return true;
      }
      return false;
    } on DioException catch (dioError) {
      throw dioError.response?.data['message'];
    }
  }
}
