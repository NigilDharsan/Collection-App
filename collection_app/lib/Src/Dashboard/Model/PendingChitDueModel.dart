class PendingChitDueModel {
  bool? status;
  List<Data>? data;

  PendingChitDueModel({this.status, this.data});

  PendingChitDueModel.fromJson(Map<String, dynamic> json) {
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
  int? pendingCollectionCount;
  int? customerCount;

  Data(
      {this.areaId,
      this.areaName,
      this.pendingCollectionCount,
      this.customerCount});

  Data.fromJson(Map<String, dynamic> json) {
    areaId = json['area_id'];
    areaName = json['area_name'];
    pendingCollectionCount = json['pending_collection_count'];
    customerCount = json['customer_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area_id'] = this.areaId;
    data['area_name'] = this.areaName;
    data['pending_collection_count'] = this.pendingCollectionCount;
    data['customer_count'] = this.customerCount;
    return data;
  }
}
