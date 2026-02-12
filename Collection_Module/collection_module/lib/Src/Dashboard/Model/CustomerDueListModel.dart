class CustomerDueListModel {
  bool? status;
  String? message;
  List<CustomerDueListData>? data;

  CustomerDueListModel({this.status, this.message, this.data});

  CustomerDueListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CustomerDueListData>[];
      json['data'].forEach((v) {
        data!.add(new CustomerDueListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerDueListData {
  String? billNo;
  int? id;
  int? billId;
  int? branchId;
  String? billDate;
  double? issuedAmount;
  double? balanceAmount;
  double? receivedAmount;
  int? discount;
  int? amount;

  CustomerDueListData(
      {this.billNo,
      this.id,
      this.billId,
      this.branchId,
      this.billDate,
      this.issuedAmount,
      this.balanceAmount,
      this.receivedAmount,
      this.discount,
      this.amount});

  CustomerDueListData.fromJson(Map<String, dynamic> json) {
    billNo = json['bill_no'];
    id = json['id'];
    billId = json['bill_id'];
    branchId = json['branch_id'];
    billDate = json['bill_date'];
    issuedAmount = json['issued_amount'];
    balanceAmount = json['balance_amount'];
    receivedAmount = json['received_amount'];
    discount = json['discount'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bill_no'] = this.billNo;
    data['id'] = this.id;
    data['bill_id'] = this.billId;
    data['branch_id'] = this.branchId;
    data['bill_date'] = this.billDate;
    data['issued_amount'] = this.issuedAmount;
    data['balance_amount'] = this.balanceAmount;
    data['received_amount'] = this.receivedAmount;
    data['discount'] = this.discount;
    data['amount'] = this.amount;
    return data;
  }
}
