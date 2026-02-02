class PendingCreditsModel {
  bool? status;
  List<Data>? data;

  PendingCreditsModel({this.status, this.data});

  PendingCreditsModel.fromJson(Map<String, dynamic> json) {
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
  String? areaName;
  int? creditPendingCount;
  double? creditPendingAmount;
  int? customerCount;

  Data(
      {this.areaId,
      this.areaName,
      this.creditPendingCount,
      this.creditPendingAmount,
      this.customerCount});

  Data.fromJson(Map<String, dynamic> json) {
    areaId = json['area_id'];
    areaName = json['area_name'];
    creditPendingCount = json['credit_pending_count'];
    creditPendingAmount = json['credit_pending_amount'];
    customerCount = json['customer_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area_id'] = this.areaId;
    data['area_name'] = this.areaName;
    data['credit_pending_count'] = this.creditPendingCount;
    data['credit_pending_amount'] = this.creditPendingAmount;
    data['customer_count'] = this.customerCount;
    return data;
  }
}
