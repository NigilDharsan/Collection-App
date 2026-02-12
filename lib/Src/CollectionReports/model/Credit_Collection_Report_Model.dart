class CreditCollectionReportModel {
  bool? status;
  List<Data>? data;
  int? pageCount;
  int? totalPages;
  int? currentPage;
  int? noOfRecords;

  CreditCollectionReportModel(
      {this.status,
      this.data,
      this.pageCount,
      this.totalPages,
      this.currentPage,
      this.noOfRecords});

  CreditCollectionReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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
    data['page_count'] = this.pageCount;
    data['total_pages'] = this.totalPages;
    data['current_page'] = this.currentPage;
    data['no_of_records'] = this.noOfRecords;
    return data;
  }
}

class Data {
  int? customerId;
  int? receiptId;
  String? customerName;
  String? invoiceNo;
  double? totalAmount;
  double? totalPaidAmount;
  double? paidAmount;
  double? discountAmount;
  double? balanceAmount;

  Data(
      {this.customerId,
      this.receiptId,
      this.customerName,
      this.invoiceNo,
      this.totalAmount,
      this.totalPaidAmount,
      this.paidAmount,
      this.discountAmount,
      this.balanceAmount});

  Data.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    receiptId = json['receipt_id'];
    customerName = json['customer_name'];
    invoiceNo = json['invoice_no'];
    totalAmount = json['total_amount'];
    totalPaidAmount = json['total_paid_amount'];
    paidAmount = json['paid_amount'];
    discountAmount = json['discount_amount'];
    balanceAmount = json['balance_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['receipt_id'] = this.receiptId;
    data['customer_name'] = this.customerName;
    data['invoice_no'] = this.invoiceNo;
    data['total_amount'] = this.totalAmount;
    data['total_paid_amount'] = this.totalPaidAmount;
    data['paid_amount'] = this.paidAmount;
    data['discount_amount'] = this.discountAmount;
    data['balance_amount'] = this.balanceAmount;
    return data;
  }
}
