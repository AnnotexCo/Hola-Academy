import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hola_academy/features/profile/Data/Model/transactions_model.dart';
import 'package:hola_academy/features/profile/Data/Repo/transaction_repo.dart';
part 'trans_state.dart';

class TransCubit extends Cubit<TransState> {
  final TransactionRepo transactionRepo;

  TransCubit(this.transactionRepo) : super(TransactionsInitial());

  Future<void> getTransactions() async {
    emit(TransactionsLoading());
    try {
      final transactions = await transactionRepo.getTransactions();
      print('transactions: $transactions');
      emit(TransactionsSuccess(transactions: transactions));
    } catch (e) {
      print('error: $e');
      emit(TransactionsFailure(error: e.toString()));
    }
  }
}
