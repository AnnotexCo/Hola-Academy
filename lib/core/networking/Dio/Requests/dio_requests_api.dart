import 'package:dio/dio.dart';
import 'package:hola_academy/features/Admin/requests/Data/Model/requests_model.dart';
import '../../../constants/api_constants.dart';
import '../../../local_db/save_token.dart';
import '../../ErrorHandler/api_error_handler.dart';

class DioRequestsApi {
  final Dio _dio;

  DioRequestsApi({required Dio dio}) : _dio = dio;

// fetch all requests
  Future<List<RequestsModel>> fetchAllRequests() async {
    try {
      final response = await _dio.get("${ApiConstants.baseUrl}${ApiConstants.requestsApi}",
       options: Options(
           headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer ${await SaveTokenDB.getToken()}",
          },
        ),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];

        return data.map((json) => RequestsModel.fromJson(json)).toList();
      }
     throw Exception("Failed to load requests");
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }

  // fetch a single request by ID
  Future<RequestsModel> fetchRequestById(int id) async {
    try {
      final response = await _dio.get("${ApiConstants.baseUrl}${ApiConstants.requestsApi}$id");
      if (response.statusCode == 200) {
        return RequestsModel.fromJson(response.data['data']);
      }
     throw Exception("Failed to load request");
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }
}