class HandoverCollectionModel {
  bool? status;
  String? message;
  Data? data;

  HandoverCollectionModel({this.status, this.message, this.data});

  HandoverCollectionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? handoverOtp;
  bool? isHandoverReq;

  Data({this.handoverOtp, this.isHandoverReq});

  Data.fromJson(Map<String, dynamic> json) {
    handoverOtp = json['handover_otp'];
    isHandoverReq = json['is_handover_req'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['handover_otp'] = this.handoverOtp;
    data['is_handover_req'] = this.isHandoverReq;
    return data;
  }
}