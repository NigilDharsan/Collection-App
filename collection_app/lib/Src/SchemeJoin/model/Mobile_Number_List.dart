class MobileListModel {
  List<Data>? data;

  MobileListModel({this.data});

  MobileListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? label;
  int? value;
  String? mobile;
  String? firstname;

  Data({this.label, this.value, this.mobile, this.firstname});

  Data.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    mobile = json['mobile'];
    firstname = json['firstname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    data['mobile'] = this.mobile;
    data['firstname'] = this.firstname;
    return data;
  }
}