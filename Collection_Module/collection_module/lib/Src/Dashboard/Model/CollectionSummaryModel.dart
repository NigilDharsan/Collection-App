class CollectionSummaryModel {
  bool? status;
  List<Data>? data;

  CollectionSummaryModel({this.status, this.data});

  CollectionSummaryModel.fromJson(Map<String, dynamic> json) {
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
  double? creditPendingAmount;
  double? creditCollectedAmount;
  double? chitCollectedAmount;

  Data(
      {this.areaId,
      this.areaName,
      this.creditPendingAmount,
      this.creditCollectedAmount,
      this.chitCollectedAmount});

  Data.fromJson(Map<String, dynamic> json) {
    areaId = json['area_id'];
    areaName = json['area_name'];
    creditPendingAmount = json['credit_pending_amount'];
    creditCollectedAmount = json['credit_collected_amount'];
    chitCollectedAmount = json['chit_collected_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area_id'] = this.areaId;
    data['area_name'] = this.areaName;
    data['credit_pending_amount'] = this.creditPendingAmount;
    data['credit_collected_amount'] = this.creditCollectedAmount;
    data['chit_collected_amount'] = this.chitCollectedAmount;
    return data;
  }
}
