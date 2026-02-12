class AreaModel {
  bool? status;
  List<AreaData>? data;

  AreaModel({this.status, this.data});

  AreaModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AreaData>[];
      json['data'].forEach((v) {
        data!.add(new AreaData.fromJson(v));
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

class AreaData {
  int? areaId;
  String? areaName;
  // int? pincode;

  AreaData({this.areaId, this.areaName});

  AreaData.fromJson(Map<String, dynamic> json) {
    areaId = json['area_id'];
    areaName = json['area_name'];
    // pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area_id'] = this.areaId;
    data['area_name'] = this.areaName;
    // data['pincode'] = this.pincode;
    return data;
  }
}
