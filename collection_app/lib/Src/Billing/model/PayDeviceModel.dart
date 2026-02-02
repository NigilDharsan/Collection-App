class PayDeviceModel {
  List<PayDeviceData>? data;

  PayDeviceModel({this.data});

  PayDeviceModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PayDeviceData>[];
      json['data'].forEach((v) {
        data!.add(new PayDeviceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PayDeviceData {
  int? idDevice;
  String? deviceName;

  PayDeviceData({this.idDevice, this.deviceName});

  PayDeviceData.fromJson(Map<String, dynamic> json) {
    idDevice = json['id_device'];
    deviceName = json['device_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_device'] = this.idDevice;
    data['device_name'] = this.deviceName;
    return data;
  }
}
