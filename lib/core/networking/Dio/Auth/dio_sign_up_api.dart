import 'package:dio/dio.dart';
import 'package:hola_academy/features/auth/register/Data/Model/sign_up_model.dart';
import '../../../constants/api_constants.dart';

class DioSignUpApi {
  final Dio _dio;

  DioSignUpApi({required Dio dio}) : _dio = dio;

  dioSignUp({required SignUpModel signUpModel}) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.signUpApi}',
        data: signUpModel.toMap(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return true;
      }
      throw Exception('Failed to sign up');
    } on DioException catch (dioError) {
      throw dioError.response?.data['message'];
    }
  }
}
