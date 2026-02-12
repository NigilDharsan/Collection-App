class CountryModel {
  bool? status;
  List<CountryData>? data;

  CountryModel({this.status, this.data});

  CountryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CountryData>[];
      json['data'].forEach((v) {
        data!.add(new CountryData.fromJson(v));
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

class CountryData {
  int? idCountry;
  String? shortname;
  String? name;
  String? currencyName;
  String? currencyCode;
  String? mobCode;
  int? mobNoLen;
  String? dateUpd;
  bool? isDefault;

  CountryData(
      {this.idCountry,
      this.shortname,
      this.name,
      this.currencyName,
      this.currencyCode,
      this.mobCode,
      this.mobNoLen,
      this.dateUpd,
      this.isDefault});

  CountryData.fromJson(Map<String, dynamic> json) {
    idCountry = json['id_country'];
    shortname = json['shortname'];
    name = json['name'];
    currencyName = json['currency_name'];
    currencyCode = json['currency_code'];
    mobCode = json['mob_code'];
    mobNoLen = json['mob_no_len'];
    dateUpd = json['date_upd'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_country'] = this.idCountry;
    data['shortname'] = this.shortname;
    data['name'] = this.name;
    data['currency_name'] = this.currencyName;
    data['currency_code'] = this.currencyCode;
    data['mob_code'] = this.mobCode;
    data['mob_no_len'] = this.mobNoLen;
    data['date_upd'] = this.dateUpd;
    data['is_default'] = this.isDefault;
    return data;
  }
}
