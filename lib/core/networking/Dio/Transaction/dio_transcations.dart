import 'package:dio/dio.dart';
import 'package:hola_academy/core/constants/api_constants.dart';
import 'package:hola_academy/core/networking/ErrorHandler/api_error_handler.dart';
import 'package:hola_academy/features/profile/Data/Model/transactions_model.dart';

class DioTranscations {
  final Dio _dio;

  DioTranscations({required Dio dio}) : _dio = dio;

  /// Fetch all transations
  Future<TransactionsModel> getAllTranscations() async {
    try {
      final response = await _dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.transactionsApi}",
        options: Options(),
      );
      if (response.statusCode == 200) {
        TransactionsModel transactionsModel =
            TransactionsModel.fromJson(response.data['data']);
        return transactionsModel;
      }
      throw Exception("Failed to load transcations");
    } catch (error) {
      if (error is DioException && error.response != null) {}
      final errorMessage = ApiErrorHandler.handle(error);
      throw errorMessage;
    }
  }

  Future<TransactionsModel> getAllTranscationsByFilter(
      {required bool isIncome}) async {
    String param = isIncome ? "INCOME" : "EXPENSE";
    try {
      final response = await _dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.transactionsApi}?case=$param",
      );
      if (response.statusCode == 200) {
        TransactionsModel transactionsModel =
            TransactionsModel.fromJson(response.data['data']);
        return transactionsModel;
      }
      throw Exception("Failed to load transcations");
    } catch (error) {
      if (error is DioException && error.response != null) {}
      throw error.toString();
    }
  }

  /// Ask for refund
  Future<dynamic> askForRefund(
      {required num amount,
      required String description,
      required String type}) async {
    try {
      final response = await _dio.post(
        "${ApiConstants.baseUrl}${ApiConstants.transactionsAskForMoney}",
        data: {"amount": amount, "description": description, "type": type},
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      throw Exception("Failed to load transcations");
    } catch (error) {
      if (error is DioException && error.response != null) {}
      throw ApiErrorHandler.handle(error).message.toString();
    }
  }
}
