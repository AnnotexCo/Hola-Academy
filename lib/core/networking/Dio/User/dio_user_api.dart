import 'package:dio/dio.dart';
import 'package:hola_academy/core/local_db/save_token.dart';
import 'package:hola_academy/core/networking/ErrorHandler/api_error_handler.dart';
import 'package:hola_academy/features/profile/Data/Model/trainee_model.dart';
import 'package:hola_academy/features/profile/Data/Model/update_user_model.dart';
import 'package:hola_academy/features/profile/Data/Model/user_model.dart';
import '../../../constants/api_constants.dart';
import 'package:http_parser/http_parser.dart';

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
        print('user data: ${response.data}');
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
      final Map<String, dynamic> formDataMap = {
        'name': updateUserModel.name,
        'parentName': updateUserModel.parentName,
      };

      // ✅ Add picture only if it's provided
      if (updateUserModel.picture != null) {
        formDataMap['picture'] = await MultipartFile.fromFile(
          updateUserModel.picture!.path,
          filename: updateUserModel.picture!.path.split('/').last,
          contentType: MediaType(
              'image', 'jpeg'), // Adjust if needed (e.g., 'image/png')
        );
      }
      FormData formData = FormData.fromMap(formDataMap);

      final response = await _dio.patch(
        '${ApiConstants.baseUrl}${ApiConstants.updateMyDataApi}',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
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

  Future<AllUsersModel> fetchAllUsers({String? role}) async {
    String? token = await SaveTokenDB.getToken();
    try {
      final response = await _dio.get(
        role != null
            ? '${ApiConstants.baseUrl}${ApiConstants.fetchAllUsersApi}?role=$role'
            : '${ApiConstants.baseUrl}${ApiConstants.fetchAllUsersApi}',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return AllUsersModel.fromJson(response.data);
      }
      throw Exception('Failed to load data');
    } on DioException catch (dioError) {
      print(dioError.response?.data['message']);
      throw dioError.response?.data['message'] ?? 'Unknown error occurred';
    }
  }


  Future<AllUsersModel> fetchTraineesbyClassID(int id) async {
    String? token = await SaveTokenDB.getToken();
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.fetchTraineesbyClassIdApi}$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return AllUsersModel.fromJson(response.data);
      }
      throw Exception('Failed to load data');
    } on DioException catch (dioError) {
      throw dioError.response?.data['message'] ?? 'Unknown error occurred';
    }
  }
}
