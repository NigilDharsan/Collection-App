class ModeWIseSummaryModel {
  bool? status;
  Data? data;

  ModeWIseSummaryModel({this.status, this.data});

  ModeWIseSummaryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? handoverOtp;
  bool? isHandoverReq;
  double? totalCollectedAmount;
  double? creditCollection;
  double? chitCollection;
  List<ModeWiseCollections>? modeWiseCollections;
  String? collectionDate;
  bool? isCollected;

  Data(
      {this.handoverOtp,
      this.isHandoverReq,
      this.totalCollectedAmount,
      this.creditCollection,
      this.chitCollection,
      this.modeWiseCollections,
      this.collectionDate,
      this.isCollected});

  Data.fromJson(Map<String, dynamic> json) {
    handoverOtp = json['handover_otp'];
    isHandoverReq = json['is_handover_req'];
    totalCollectedAmount = json['total_collected_amount'];
    creditCollection = json['credit_collection'];
    chitCollection = json['chit_collection'];
    if (json['mode_wise_collections'] != null) {
      modeWiseCollections = <ModeWiseCollections>[];
      json['mode_wise_collections'].forEach((v) {
        modeWiseCollections!.add(new ModeWiseCollections.fromJson(v));
      });
    }
    collectionDate = json['collection_date'];
    isCollected = json['is_collected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['handover_otp'] = this.handoverOtp;
    data['is_handover_req'] = this.isHandoverReq;
    data['total_collected_amount'] = this.totalCollectedAmount;
    data['credit_collection'] = this.creditCollection;
    data['chit_collection'] = this.chitCollection;
    if (this.modeWiseCollections != null) {
      data['mode_wise_collections'] =
          this.modeWiseCollections!.map((v) => v.toJson()).toList();
    }
    data['collection_date'] = this.collectionDate;
    data['is_collected'] = this.isCollected;
    return data;
  }
}

class ModeWiseCollections {
  String? modeName;
  double? amount;

  ModeWiseCollections({this.modeName, this.amount});

  ModeWiseCollections.fromJson(Map<String, dynamic> json) {
    modeName = json['mode_name'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mode_name'] = this.modeName;
    data['amount'] = this.amount;
    return data;
  }
}
