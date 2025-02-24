import 'package:dio/dio.dart';
import 'package:hola_academy/core/constants/api_constants.dart';
import 'package:hola_academy/core/local_db/save_token.dart';
import 'package:hola_academy/core/networking/ErrorHandler/api_error_handler.dart';
import 'package:hola_academy/features/profile/Data/Model/transactions_model.dart';

class DioTranscations {
  final Dio _dio;

  DioTranscations({required Dio dio}) : _dio = dio;

  /// Fetch all transations
  Future<TransactionsModel> getAllTranscations() async {
    String? token = await SaveTokenDB.getToken();
    try {
      final response = await _dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.transactionsApi}",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print('responseeeeeeeeeeeeeeeeeeeeeeee${response.data}');

      if (response.statusCode == 200) {
        TransactionsModel transactionsModel =
            TransactionsModel.fromJson(response.data['data']);
        return transactionsModel;
      }
      throw Exception("Failed to load transcations");
    } catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }
}
