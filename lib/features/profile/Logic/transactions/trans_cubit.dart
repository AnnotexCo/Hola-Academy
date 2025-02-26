import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hola_academy/features/profile/Data/Model/transactions_model.dart';
import 'package:hola_academy/features/profile/Data/Repo/transaction_repo.dart';
part 'trans_state.dart';

class TransCubit extends Cubit<TransState> {
  final TransactionRepo transactionRepo;

  TransCubit(this.transactionRepo) : super(TransactionsInitial());

  TransactionsModel? transactions;
  Future<void> getTransactions() async {
    emit(TransactionsLoading());
    try {
      transactions = await transactionRepo.getTransactions();
      emit(TransactionsSuccess(transactions: transactions!));
    } catch (e) {
      emit(TransactionsFailure(error: e.toString()));
    }
  }

  TransactionsModel? incomeTransactions;
  TransactionsModel? expenseTransactions;
  Future<void> getTransactionsByFilter({required bool isIncome}) async {
    emit(TransactionsLoading());
    try {
      isIncome
          ? incomeTransactions =
              await transactionRepo.getTransactionsByFilter(isIncome: isIncome)
          : expenseTransactions =
              await transactionRepo.getTransactionsByFilter(isIncome: isIncome);
      TransactionsModel? filteredTransactions =
          isIncome ? incomeTransactions : expenseTransactions;
      emit(isIncome
          ? IncomeTransactionsSuccess(transactions: filteredTransactions!)
          : ExpenseTransactionsSuccess(transactions: filteredTransactions!));
    } catch (e) {
      emit(TransactionsFailure(error: e.toString()));
    }
  }
}
