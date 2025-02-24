part of'trans_cubit.dart';


abstract class TransState {}

class TransactionsInitial extends TransState {}

class TransactionsLoading extends TransState {}

class TransactionsSuccess extends TransState {
  final TransactionsModel transactions;
  TransactionsSuccess({required this.transactions});
}

class TransactionsFailure extends TransState {
  final String error;
  TransactionsFailure({required this.error});
}