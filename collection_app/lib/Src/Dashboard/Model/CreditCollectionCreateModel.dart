class CreditCollectionCreateModel {
  int? amount;
  String? billDate;
  int? branch;
  int? idCounter;
  int? employee;
  int? creditType;
  int? settingBillType;
  int? weight;
  int? customer;
  int? receiptType;
  String? remarks;
  int? type;
  List<CreditDetails>? creditDetails;
  List<PaymentDetails>? paymentDetails;

  CreditCollectionCreateModel(
      {this.amount,
      this.billDate,
      this.branch,
      this.idCounter,
      this.employee,
      this.creditType,
      this.settingBillType,
      this.weight,
      this.customer,
      this.receiptType,
      this.remarks,
      this.type,
      this.creditDetails,
      this.paymentDetails});

  CreditCollectionCreateModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    billDate = json['bill_date'];
    branch = json['branch'];
    idCounter = json['id_counter'];
    employee = json['employee'];
    creditType = json['credit_type'];
    settingBillType = json['setting_bill_type'];
    weight = json['weight'];
    customer = json['customer'];
    receiptType = json['receipt_type'];
    remarks = json['remarks'];
    type = json['type'];
    if (json['credit_details'] != null) {
      creditDetails = <CreditDetails>[];
      json['credit_details'].forEach((v) {
        creditDetails!.add(new CreditDetails.fromJson(v));
      });
    }
    if (json['payment_details'] != null) {
      paymentDetails = <PaymentDetails>[];
      json['payment_details'].forEach((v) {
        paymentDetails!.add(new PaymentDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['bill_date'] = this.billDate;
    data['branch'] = this.branch;
    data['id_counter'] = this.idCounter;
    data['employee'] = this.employee;
    data['credit_type'] = this.creditType;
    data['setting_bill_type'] = this.settingBillType;
    data['weight'] = this.weight;
    data['customer'] = this.customer;
    data['receipt_type'] = this.receiptType;
    data['remarks'] = this.remarks;
    data['type'] = this.type;
    if (this.creditDetails != null) {
      data['credit_details'] =
          this.creditDetails!.map((v) => v.toJson()).toList();
    }
    if (this.paymentDetails != null) {
      data['payment_details'] =
          this.paymentDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CreditDetails {
  String? discountAmount;
  int? issueId;
  String? receivedAmount;

  CreditDetails({this.discountAmount, this.issueId, this.receivedAmount});

  CreditDetails.fromJson(Map<String, dynamic> json) {
    discountAmount = json['discount_amount'];
    issueId = json['issue_id'];
    receivedAmount = json['received_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['discount_amount'] = this.discountAmount;
    data['issue_id'] = this.issueId;
    data['received_amount'] = this.receivedAmount;
    return data;
  }
}

class PaymentDetails {
  String? bank;
  Null? cardHolder;
  Null? cardNo;
  int? cardType;
  Null? chequeNo;
  Null? nbType;
  String? payDevice;
  int? paymentAmount;
  int? paymentMode;
  Null? refNo;
  int? type;

  PaymentDetails(
      {this.bank,
      this.cardHolder,
      this.cardNo,
      this.cardType,
      this.chequeNo,
      this.nbType,
      this.payDevice,
      this.paymentAmount,
      this.paymentMode,
      this.refNo,
      this.type});

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    bank = json['bank'];
    cardHolder = json['card_holder'];
    cardNo = json['card_no'];
    cardType = json['card_type'];
    chequeNo = json['cheque_no'];
    nbType = json['nb_type'];
    payDevice = json['pay_device'];
    paymentAmount = json['payment_amount'];
    paymentMode = json['payment_mode'];
    refNo = json['ref_no'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank'] = this.bank;
    data['card_holder'] = this.cardHolder;
    data['card_no'] = this.cardNo;
    data['card_type'] = this.cardType;
    data['cheque_no'] = this.chequeNo;
    data['nb_type'] = this.nbType;
    data['pay_device'] = this.payDevice;
    data['payment_amount'] = this.paymentAmount;
    data['payment_mode'] = this.paymentMode;
    data['ref_no'] = this.refNo;
    data['type'] = this.type;
    return data;
  }
}
