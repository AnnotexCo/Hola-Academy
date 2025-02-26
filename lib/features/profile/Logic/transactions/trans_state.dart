part of'trans_cubit.dart';


abstract class TransState {}

class TransactionsInitial extends TransState {}

class TransactionsLoading extends TransState {}

class TransactionsSuccess extends TransState {
  final TransactionsModel transactions;
  TransactionsSuccess({required this.transactions});
}
class IncomeTransactionsSuccess extends TransState {
  final TransactionsModel transactions;
  IncomeTransactionsSuccess({required this.transactions});
}
class ExpenseTransactionsSuccess extends TransState {
  final TransactionsModel transactions;
  ExpenseTransactionsSuccess({required this.transactions});
}

class TransactionsFailure extends TransState {
  final String error;
  TransactionsFailure({required this.error});
}

class RefundSuccess extends TransState {}