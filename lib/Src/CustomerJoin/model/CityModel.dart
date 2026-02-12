class CityModel {
  bool? status;
  List<CityData>? data;

  CityModel({this.status, this.data});

  CityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CityData>[];
      json['data'].forEach((v) {
        data!.add(new CityData.fromJson(v));
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

class CityData {
  int? idCity;
  String? name;
  bool? isDefault;
  int? state;

  CityData({this.idCity, this.name, this.isDefault, this.state});

  CityData.fromJson(Map<String, dynamic> json) {
    idCity = json['id_city'];
    name = json['name'];
    isDefault = json['is_default'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_city'] = this.idCity;
    data['name'] = this.name;
    data['is_default'] = this.isDefault;
    data['state'] = this.state;
    return data;
  }
}
