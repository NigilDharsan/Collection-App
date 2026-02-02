class StateModel {
  bool? status;
  List<StateData>? data;

  StateModel({this.status, this.data});

  StateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <StateData>[];
      json['data'].forEach((v) {
        data!.add(new StateData.fromJson(v));
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

class StateData {
  int? idState;
  String? name;
  bool? isDefault;
  String? stateCode;
  int? country;

  StateData({this.idState, this.name, this.isDefault, this.stateCode, this.country});

  StateData.fromJson(Map<String, dynamic> json) {
    idState = json['id_state'];
    name = json['name'];
    isDefault = json['is_default'];
    stateCode = json['state_code'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_state'] = this.idState;
    data['name'] = this.name;
    data['is_default'] = this.isDefault;
    data['state_code'] = this.stateCode;
    data['country'] = this.country;
    return data;
  }
}
