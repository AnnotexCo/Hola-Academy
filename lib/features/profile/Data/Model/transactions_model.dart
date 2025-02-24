class TransactionsModel {
  final int count;
  final List<Transactions> transactions;
  final Statistics statistics;
  final Statistics incomeStatistics;
  final Statistics expenseStatistics;
  TransactionsModel({
    required this.count,
    required this.transactions,
    required this.statistics,
    required this.incomeStatistics,
    required this.expenseStatistics,
  });
  
  factory TransactionsModel.fromJson(Map<String, dynamic> json){
    return TransactionsModel(
      count: json['count'],
      transactions: List.from(json['transactions']).map((e)=>Transactions.fromJson(e)).toList(),
      statistics: Statistics.fromJson(json['statistics']),
      incomeStatistics: Statistics.fromJson(json['incomeStatistics']),
      expenseStatistics: Statistics.fromJson(json['expenseStatistics']),
    );}
}

class Transactions {
  final int id;
  final int amount;
  final int finalAmount;
  final int fee;
  final String type;
  final String casee;
  final String status;
  final String userCase;
  final int levelId;
  final int userId;
  final String tag;
  final String description;
  final String createdAt;
  final String updatedAt;
  Transactions({
    required this.id,
    required this.amount,
    required this.finalAmount,
    required this.fee,
    required this.type,
    required this.casee,
    required this.status,
    required this.userCase,
    required this.levelId,
    required this.userId,
    required this.tag,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });
  
  factory Transactions.fromJson(Map<String, dynamic> json){
    return Transactions(
      id: json['id'],
      amount: json['amount'],
      finalAmount: json['finalAmount'],
      fee: json['fee'],
      type: json['type'],
      casee: json['case'],
      status: json['status'],
      userCase: json['userCase'],
      levelId: json['levelId'],
      userId: json['userId'],
      tag: json['tag'],
      description: json['description'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}


class Sum {
  final int amount;
  final int finalAmount;
  final int fee;
  Sum({
    required this.amount,
    required this.finalAmount,
    required this.fee,
  });
  factory
  Sum.fromJson(Map<String, dynamic> json){
    return Sum(
      amount: json['amount'],
      finalAmount: json['finalAmount'],
      fee: json['fee'],
    );}
}

class Statistics {
  final Sum sum;
  Statistics({
    required this.sum,
  });
  
  factory Statistics.fromJson(Map<String, dynamic> json){
    return Statistics(
      sum: Sum.fromJson(json['sum']),
    );}  
}