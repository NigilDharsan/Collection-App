class PaymentModeModel {
  List<PaymentModeData>? data;

  PaymentModeModel({this.data});

  PaymentModeModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PaymentModeData>[];
      json['data'].forEach((v) {
        data!.add(new PaymentModeData.fromJson(v));
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

class PaymentModeData {
  int? idMode;
  String? modeName;
  String? shortCode;
  int? sortOrder;
  bool? showToPay;
  bool? showToPayOnRefund;
  bool? isActive;
  bool? cardNameVisibility;
  bool? cardNameMandatory;
  bool? deviceTypeVisibility;
  bool? deviceTypeMandatory;
  bool? cardNoVisibility;
  bool? cardNoMandatory;
  bool? approvalNoVisibility;
  bool? approvalNoMandatory;
  bool? bankVisibility;
  bool? bankMandatory;
  bool? payDateVisibility;
  bool? payDateMandatory;
  bool? nbTypeVisibility;
  bool? nbTypeMandatory;

  PaymentModeData(
      {this.idMode,
      this.modeName,
      this.shortCode,
      this.sortOrder,
      this.showToPay,
      this.showToPayOnRefund,
      this.isActive,
      this.cardNameVisibility,
      this.cardNameMandatory,
      this.deviceTypeVisibility,
      this.deviceTypeMandatory,
      this.cardNoVisibility,
      this.cardNoMandatory,
      this.approvalNoVisibility,
      this.approvalNoMandatory,
      this.bankVisibility,
      this.bankMandatory,
      this.payDateVisibility,
      this.payDateMandatory,
      this.nbTypeVisibility,
      this.nbTypeMandatory});

  PaymentModeData.fromJson(Map<String, dynamic> json) {
    idMode = json['id_mode'];
    modeName = json['mode_name'];
    shortCode = json['short_code'];
    sortOrder = json['sort_order'];
    showToPay = json['show_to_pay'];
    showToPayOnRefund = json['show_to_pay_on_refund'];
    isActive = json['is_active'];
    cardNameVisibility = json['card_name_visibility'];
    cardNameMandatory = json['card_name_mandatory'];
    deviceTypeVisibility = json['device_type_visibility'];
    deviceTypeMandatory = json['device_type_mandatory'];
    cardNoVisibility = json['card_no_visibility'];
    cardNoMandatory = json['card_no_mandatory'];
    approvalNoVisibility = json['approval_no_visibility'];
    approvalNoMandatory = json['approval_no_mandatory'];
    bankVisibility = json['bank_visibility'];
    bankMandatory = json['bank_mandatory'];
    payDateVisibility = json['pay_date_visibility'];
    payDateMandatory = json['pay_date_mandatory'];
    nbTypeVisibility = json['nb_type_visibility'];
    nbTypeMandatory = json['nb_type_mandatory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_mode'] = this.idMode;
    data['mode_name'] = this.modeName;
    data['short_code'] = this.shortCode;
    data['sort_order'] = this.sortOrder;
    data['show_to_pay'] = this.showToPay;
    data['show_to_pay_on_refund'] = this.showToPayOnRefund;
    data['is_active'] = this.isActive;
    data['card_name_visibility'] = this.cardNameVisibility;
    data['card_name_mandatory'] = this.cardNameMandatory;
    data['device_type_visibility'] = this.deviceTypeVisibility;
    data['device_type_mandatory'] = this.deviceTypeMandatory;
    data['card_no_visibility'] = this.cardNoVisibility;
    data['card_no_mandatory'] = this.cardNoMandatory;
    data['approval_no_visibility'] = this.approvalNoVisibility;
    data['approval_no_mandatory'] = this.approvalNoMandatory;
    data['bank_visibility'] = this.bankVisibility;
    data['bank_mandatory'] = this.bankMandatory;
    data['pay_date_visibility'] = this.payDateVisibility;
    data['pay_date_mandatory'] = this.payDateMandatory;
    data['nb_type_visibility'] = this.nbTypeVisibility;
    data['nb_type_mandatory'] = this.nbTypeMandatory;
    return data;
  }
}
