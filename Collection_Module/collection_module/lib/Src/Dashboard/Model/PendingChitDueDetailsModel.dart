class PendingChitDueDetailsModel {
  bool? status;
  List<Data>? data;

  PendingChitDueDetailsModel({this.status, this.data});

  PendingChitDueDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? areaId;
  int? customerId;
  String? name;
  String? mobile;
  String? image;
  String? imageText;
  String? areaName;
  double? payableAmount;
  String? schemeName;
  String? accountName;
  String? accountNo;
  String? dueDate;

  Data(
      {this.areaId,
      this.customerId,
      this.name,
      this.mobile,
      this.image,
      this.imageText,
      this.areaName,
      this.payableAmount,
      this.schemeName,
      this.accountName,
      this.accountNo,
      this.dueDate});

  Data.fromJson(Map<String, dynamic> json) {
    areaId = json['area_id'];
    customerId = json['customer_id'];
    name = json['name'];
    mobile = json['mobile'];
    image = json['image'];
    imageText = json['image_text'];
    areaName = json['area_name'];
    payableAmount = json['payable_amount'];
    schemeName = json['scheme_name'];
    accountName = json['account_name'];
    accountNo = json['account_no'];
    dueDate = json['due_date'];
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
    data['payable_amount'] = this.payableAmount;
    data['scheme_name'] = this.schemeName;
    data['account_name'] = this.accountName;
    data['account_no'] = this.accountNo;
    data['due_date'] = this.dueDate;
    return data;
  }
}
