class SchemeModel {
  bool? status;
  String? message;
  List<SchemeData>? data;

  SchemeModel({this.status, this.message, this.data});

  SchemeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SchemeData>[];
      json['data'].forEach((v) {
        data!.add(SchemeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SchemeData {
  int? idAccScheme;
  String? schemeName;
  int? schemeType;
  String? termsAndConds;
  bool? customerReferral;
  bool? employeeReferral;
  String? schemeDescription;
  bool? needKycVerification;
  bool? isCustomerKycVerified;
  String? schemeCode;
  int? schemeVis;

  SchemeData(
      {this.idAccScheme,
      this.schemeName,
      this.schemeType,
      this.termsAndConds,
      this.customerReferral,
      this.employeeReferral,
      this.schemeDescription,
      this.needKycVerification,
      this.isCustomerKycVerified,
      this.schemeCode,
      this.schemeVis});

  SchemeData.fromJson(Map<String, dynamic> json) {
    idAccScheme = json['scheme_id'];
    schemeName = json['name'];
    schemeType = json['scheme_type'];
    termsAndConds = json['terms_and_conds'];
    customerReferral = json['customer_referral'];
    employeeReferral = json['employee_referral'];
    schemeDescription = json['scheme_description'];
    needKycVerification = json['need_kyc_verification'];
    isCustomerKycVerified = json['is_customer_kyc_verified'];
    schemeCode = json['scheme_code'];
    schemeVis = json['scheme_vis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['scheme_id'] = idAccScheme;
    data['name'] = schemeName;
    data['scheme_type'] = schemeType;
    data['terms_and_conds'] = this.termsAndConds;
    data['customer_referral'] = this.customerReferral;
    data['employee_referral'] = this.employeeReferral;
    data['scheme_description'] = this.schemeDescription;
    data['need_kyc_verification'] = this.needKycVerification;
    data['is_customer_kyc_verified'] = this.isCustomerKycVerified;
    data['scheme_code'] = this.schemeCode;
    data['scheme_vis'] = this.schemeVis;

    return data;
  }
}
