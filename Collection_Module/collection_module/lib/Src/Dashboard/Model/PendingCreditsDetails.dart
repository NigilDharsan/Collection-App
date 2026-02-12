// class PendingCreditsDetails {
//   bool? status;
//   List<PendingCreditData>? data;

//   PendingCreditsDetails({this.status, this.data});

//   PendingCreditsDetails.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       data = <PendingCreditData>[];
//       json['data'].forEach((v) {
//         data!.add(new PendingCreditData.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class PendingCreditData {
//   int? areaId;
//   int? customerId;
//   String? name;
//   String? mobile;
//   String? image;
//   String? imageText;
//   String? areaName;
//   String? invoiceNo;
//   String? creditDueDate;
//   String? billDate;
//   double? dueAmount;

//   PendingCreditData(
//       {this.areaId,
//       this.customerId,
//       this.name,
//       this.mobile,
//       this.image,
//       this.imageText,
//       this.areaName,
//       this.invoiceNo,
//       this.creditDueDate,
//       this.billDate,
//       this.dueAmount});

//   PendingCreditData.fromJson(Map<String, dynamic> json) {
//     areaId = json['area_id'];
//     customerId = json['customer_id'];
//     name = json['name'];
//     mobile = json['mobile'];
//     image = json['image'];
//     imageText = json['image_text'];
//     areaName = json['area_name'];
//     invoiceNo = json['invoice_no'];
//     creditDueDate = json['credit_due_date'];
//     billDate = json['bill_date'];
//     dueAmount = json['due_amount'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['area_id'] = this.areaId;
//     data['customer_id'] = this.customerId;
//     data['name'] = this.name;
//     data['mobile'] = this.mobile;
//     data['image'] = this.image;
//     data['image_text'] = this.imageText;
//     data['area_name'] = this.areaName;
//     data['invoice_no'] = this.invoiceNo;
//     data['credit_due_date'] = this.creditDueDate;
//     data['bill_date'] = this.billDate;
//     data['due_amount'] = this.dueAmount;
//     return data;
//   }
// }

class PendingCreditsDetails {
  bool? status;
  List<PendingCreditData>? data;
  int? pageCount;
  int? totalPages;
  int? currentPage;
  int? noOfRecords;

  PendingCreditsDetails(
      {this.status,
      this.data,
      this.pageCount,
      this.totalPages,
      this.currentPage,
      this.noOfRecords});

  PendingCreditsDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <PendingCreditData>[];
      json['data'].forEach((v) {
        data!.add(new PendingCreditData.fromJson(v));
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

class PendingCreditData {
  int? areaId;
  int? customerId;
  String? name;
  String? mobile;
  String? image;
  String? imageText;
  String? areaName;
  String? invoiceNo;
  int? branchId;
  String? creditDueDate;
  String? billDate;
  double? dueAmount;

  PendingCreditData(
      {this.areaId,
      this.customerId,
      this.name,
      this.mobile,
      this.image,
      this.imageText,
      this.areaName,
      this.invoiceNo,
      this.branchId,
      this.creditDueDate,
      this.billDate,
      this.dueAmount});

  PendingCreditData.fromJson(Map<String, dynamic> json) {
    areaId = json['area_id'];
    customerId = json['customer_id'];
    name = json['name'];
    mobile = json['mobile'];
    image = json['image'];
    imageText = json['image_text'];
    areaName = json['area_name'];
    invoiceNo = json['invoice_no'];
    branchId = json['branch_id'];
    creditDueDate = json['credit_due_date'];
    billDate = json['bill_date'];
    dueAmount = json['due_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area_id'] = this.areaId;
    data['customer_id'] = this.customerId;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['image'] = this.image;
    data['image_text'] = this.imageText;
    data['area_name'] = this.areaName;
    data['invoice_no'] = this.invoiceNo;
    data['branch_id'] = this.branchId;
    data['credit_due_date'] = this.creditDueDate;
    data['bill_date'] = this.billDate;
    data['due_amount'] = this.dueAmount;
    return data;
  }
}
