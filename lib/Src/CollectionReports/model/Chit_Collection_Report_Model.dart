class ChitCollectionReportModel {
  bool? status;
  List<Data>? data;
  List<PaymentMode>? paymentMode;
  int? pageCount;
  int? totalPages;
  int? currentPage;
  int? noOfRecords;

  ChitCollectionReportModel(
      {this.status,
      this.data,
      this.paymentMode,
      this.pageCount,
      this.totalPages,
      this.currentPage,
      this.noOfRecords});

  ChitCollectionReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    if (json['payment_mode'] != null) {
      paymentMode = <PaymentMode>[];
      json['payment_mode'].forEach((v) {
        paymentMode!.add(new PaymentMode.fromJson(v));
      });
    }
    pageCount = json['page_count'];
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
    noOfRecords = json['no_of_records'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.paymentMode != null) {
      data['payment_mode'] = this.paymentMode!.map((v) => v.toJson()).toList();
    }
    data['page_count'] = this.pageCount;
    data['total_pages'] = this.totalPages;
    data['current_page'] = this.currentPage;
    data['no_of_records'] = this.noOfRecords;
    return data;
  }
}

class Data {
  int? customerId;
  String? customerName;
  String? receiptNo;
  int? paymentId;
  double? metalWeight;
  double? paidAmount;
  int? paidInstallment;
  String? schemeName;
  String? accountName;
  String? accountNo;

  Data(
      {this.customerId,
      this.customerName,
      this.receiptNo,
      this.paymentId,
      this.metalWeight,
      this.paidAmount,
      this.paidInstallment,
      this.schemeName,
      this.accountName,
      this.accountNo});

  Data.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    receiptNo = json['receipt_no'];
    paymentId = json['payment_id'];
    metalWeight = json['metal_weight'];
    paidAmount = json['paid_amount'];
    paidInstallment = json['paid_installment'];
    schemeName = json['scheme_name'];
    accountName = json['account_name'];
    accountNo = json['account_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['customer_name'] = this.customerName;
    data['receipt_no'] = this.receiptNo;
    data['payment_id'] = this.paymentId;
    data['metal_weight'] = this.metalWeight;
    data['paid_amount'] = this.paidAmount;
    data['paid_installment'] = this.paidInstallment;
    data['scheme_name'] = this.schemeName;
    data['account_name'] = this.accountName;
    data['account_no'] = this.accountNo;
    return data;
  }
}

class PaymentMode {
  String? modeName;
  String? paymentAmount;

  PaymentMode({this.modeName, this.paymentAmount});

  PaymentMode.fromJson(Map<String, dynamic> json) {
    modeName = json['mode_name'];
    paymentAmount = json['payment_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mode_name'] = this.modeName;
    data['payment_amount'] = this.paymentAmount;
    return data;
  }
}
