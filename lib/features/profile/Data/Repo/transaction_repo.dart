import 'package:hola_academy/core/networking/Dio/Transaction/dio_transcations.dart';
import 'package:hola_academy/features/profile/Data/Model/transactions_model.dart';

class TransactionRepo {
  final DioTranscations dioTranscations;

  TransactionRepo({required this.dioTranscations});

  Future<TransactionsModel> getTransactions() async {
    return await dioTranscations.getAllTranscations();
  }

  Future<TransactionsModel> getTransactionsByFilter({required bool isIncome}) async {
    return await dioTranscations.getAllTranscationsByFilter(isIncome: isIncome);
  }
}