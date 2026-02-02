class ActivebankModel {
  List<ActiveBankData>? data;

  ActivebankModel({this.data});

  ActivebankModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ActiveBankData>[];
      json['data'].forEach((v) {
        data!.add(new ActiveBankData.fromJson(v));
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

class ActiveBankData {
  int? idBank;
  String? bankName;

  ActiveBankData({this.idBank, this.bankName});

  ActiveBankData.fromJson(Map<String, dynamic> json) {
    idBank = json['id_bank'];
    bankName = json['bank_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_bank'] = this.idBank;
    data['bank_name'] = this.bankName;
    return data;
  }
}
