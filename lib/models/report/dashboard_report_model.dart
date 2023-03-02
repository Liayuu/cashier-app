import 'dart:convert';

class DashboardReportModel {
  int transaction;
  double income;
  int soldMenu;
  double biggestTransaction;
  DashboardReportModel({
    this.transaction = 0,
    this.income = 0,
    this.soldMenu = 0,
    this.biggestTransaction = 0,
  });

  DashboardReportModel copyWith({
    int? transaction,
    double? income,
    int? soldMenu,
    double? biggestTransaction,
  }) {
    return DashboardReportModel(
      transaction: transaction ?? this.transaction,
      income: income ?? this.income,
      soldMenu: soldMenu ?? this.soldMenu,
      biggestTransaction: biggestTransaction ?? this.biggestTransaction,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'transaction': transaction,
      'income': income,
      'soldMenu': soldMenu,
      'biggestTransaction': biggestTransaction,
    };
  }

  factory DashboardReportModel.fromMap(Map<String, dynamic> map) {
    return DashboardReportModel(
      transaction: map['transaction']?.toInt(),
      income: map['income']?.toDouble(),
      soldMenu: map['soldMenu']?.toInt(),
      biggestTransaction: map['biggestTransaction']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardReportModel.fromJson(String source) =>
      DashboardReportModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DashboardReportModel(transaction: $transaction, income: $income, soldMenu: $soldMenu, biggestTransaction: $biggestTransaction)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DashboardReportModel &&
        other.transaction == transaction &&
        other.income == income &&
        other.soldMenu == soldMenu &&
        other.biggestTransaction == biggestTransaction;
  }

  @override
  int get hashCode {
    return transaction.hashCode ^ income.hashCode ^ soldMenu.hashCode ^ biggestTransaction.hashCode;
  }
}
