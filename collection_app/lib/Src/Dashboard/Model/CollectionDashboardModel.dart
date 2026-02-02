class CollectionDashboardModel {
  int? allocatedArea;
  int? totalCustomers;
  String? salesCreditAmount;
  int? chitUnpaidCount;
  String? todayChitCollected;
  String? totalCreditCollection;
  String? todayChitCashCollected;
  String? totalCreditCashCollection;
  String? totalCashCollection;

  CollectionDashboardModel(
      {this.allocatedArea,
      this.totalCustomers,
      this.salesCreditAmount,
      this.chitUnpaidCount,
      this.todayChitCollected,
      this.totalCreditCollection,
      this.todayChitCashCollected,
      this.totalCreditCashCollection,
      this.totalCashCollection});

  CollectionDashboardModel.fromJson(Map<String, dynamic> json) {
    allocatedArea = json['allocated_area'];
    totalCustomers = json['total_customers'];
    salesCreditAmount = json['sales_credit_amount'];
    chitUnpaidCount = json['chit_unpaid_count'];
    todayChitCollected = json['today_chit_collected'];
    totalCreditCollection = json['total_credit_collection'];
    todayChitCashCollected = json['today_chit_cash_collected'];
    totalCreditCashCollection = json['total_credit_cash_collection'];
    totalCashCollection = json['total_cash_collection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allocated_area'] = this.allocatedArea;
    data['total_customers'] = this.totalCustomers;
    data['sales_credit_amount'] = this.salesCreditAmount;
    data['chit_unpaid_count'] = this.chitUnpaidCount;
    data['today_chit_collected'] = this.todayChitCollected;
    data['total_credit_collection'] = this.totalCreditCollection;
    data['today_chit_cash_collected'] = this.todayChitCashCollected;
    data['total_credit_cash_collection'] = this.totalCreditCashCollection;
    data['total_cash_collection'] = this.totalCashCollection;
    return data;
  }
}
