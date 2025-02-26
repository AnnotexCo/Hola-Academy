
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:hola_academy/features/Admin/requests/Data/Model/requests_model.dart';
import '../../../constants/api_constants.dart';
import '../../../local_db/save_token.dart';
import '../../ErrorHandler/api_error_handler.dart';

import 'package:http_parser/http_parser.dart';

class DioRequestsApi {
  final Dio _dio;

  DioRequestsApi({required Dio dio}) : _dio = dio;

  // Fetch all requests
  Future<List<RequestsModel>> fetchAllRequests() async {
    try {
      final response = await _dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.requestsApi}",
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
       print("Error request program: $error");

      if (error is DioException && error.response != null) {
        print("Full Response: ${error.response?.data}");
      }
      throw ApiErrorHandler.handle(error);
    }
  }

  // Fetch a single request by ID
  Future<RequestsModel> fetchRequestById(int id) async {
    try {
      final response = await _dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.requestsApi}$id",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer ${await SaveTokenDB.getToken()}",
          },
        ),
      );

      if (response.statusCode == 200) {
        return RequestsModel.fromJson(response.data['data']);
      }
      throw Exception("Failed to load request");
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }

// Booking a program with Base64-encoded image in multipart request
 Future<void> bookProgram(Map<String, dynamic> bookingProgramData, File? imageFile) async {
    try {
      String? token = await SaveTokenDB.getToken();

      FormData formData = FormData.fromMap({
        ...bookingProgramData,
        if (imageFile != null)
          "image": await MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split('/').last,
            contentType: MediaType('image', 'jpeg'), // Adjust for 'image/png' if needed
          ),
      });

      final response = await _dio.post(
        "${ApiConstants.baseUrl}${ApiConstants.requestsApi}",
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 201) {
        print("✅ Booking Successful");
      } else {
        throw Exception("Booking failed: ${response.data}");
      }
    } catch (error) {
      print("❌ Error booking program: $error");
      if (error is DioException && error.response != null) {
        print("Full Response: ${error.response?.data}");
      }
      throw ApiErrorHandler.handle(error);
    }
  }
}
