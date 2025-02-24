class TransactionsModel {
  final num count;
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
  final num? id;
  final num? amount;
  final num? finalAmount;
  final num? fee;
  final String? type;
  final String? casee;
  final String? status;
  final String? userCase;
  final num? levelId;
  final num? userId;
  final String? tag;
  final String? description;
  final String? createdAt;
  final String? updatedAt;
  Transactions({
    this.id,
    this.amount,
    this.finalAmount,
    this.fee,
    this.type,
    this.casee,
    this.status,
    this.userCase,
    this.levelId,
    this.userId,
    this.tag,
    this.description,
    this.createdAt,
    this.updatedAt,
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
  final num? amount;
  final num? finalAmount;
  final num? fee;
  Sum({
    this.amount,
    this.finalAmount,
    this.fee,
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
      sum: Sum.fromJson(json['_sum']),
    );}  
}