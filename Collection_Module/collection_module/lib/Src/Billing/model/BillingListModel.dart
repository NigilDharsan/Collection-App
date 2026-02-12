class BillingListModel {
  List<BillingListData>? data;
  int? pageCount;
  int? totalPages;
  int? currentPage;
  int? noOfRecords;

  BillingListModel(
      {this.data,
      this.pageCount,
      this.totalPages,
      this.currentPage,
      this.noOfRecords});

  BillingListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BillingListData>[];
      json['data'].forEach((v) {
        data!.add(new BillingListData.fromJson(v));
      });
    }
    pageCount = json['page_count'];
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
    noOfRecords = json['no_of_records'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

class BillingListData {
  int? erpInvoiceId;
  String? branchName;
  String? date;
  String? customerName;
  String? customerMobile;
  String? invNo;

  BillingListData(
      {this.erpInvoiceId,
      this.branchName,
      this.date,
      this.customerName,
      this.customerMobile,
      this.invNo});

  BillingListData.fromJson(Map<String, dynamic> json) {
    erpInvoiceId = json['erp_invoice_id'];
    branchName = json['branch_name'];
    date = json['date'];
    customerName = json['customer_name'];
    customerMobile = json['customer_mobile'];
    invNo = json['inv_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['erp_invoice_id'] = this.erpInvoiceId;
    data['branch_name'] = this.branchName;
    data['date'] = this.date;
    data['customer_name'] = this.customerName;
    data['customer_mobile'] = this.customerMobile;
    data['inv_no'] = this.invNo;
    return data;
  }
}
