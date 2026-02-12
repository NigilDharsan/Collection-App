class AdressListModel {
  Map<String, dynamic>? extra;
  String? filter;
  List<AddressItems>? items;
  String? orderBy;
  int? page;
  int? pageSize;
  int? totalItemCount;

  AdressListModel(
      {this.extra,
      this.filter,
      this.items,
      this.orderBy,
      this.page,
      this.pageSize,
      this.totalItemCount});

  AdressListModel.fromJson(Map<String, dynamic> json) {
    extra = json['extra'];
    filter = json['filter'];
    if (json['items'] != null) {
      items = <AddressItems>[];
      json['items'].forEach((v) {
        items!.add(new AddressItems.fromJson(v));
      });
    }
    orderBy = json['orderBy'];
    page = json['page'];
    pageSize = json['pageSize'];
    totalItemCount = json['totalItemCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['extra'] = this.extra;
    data['filter'] = this.filter;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['orderBy'] = this.orderBy;
    data['page'] = this.page;
    data['pageSize'] = this.pageSize;
    data['totalItemCount'] = this.totalItemCount;
    return data;
  }
}

class AddressItems {
  String? accountId;
  String? addressLine1;
  String? addressLine2;
  String? addressType;
  int? addressTypeId;
  String? city;
  String? countryCode;
  String? countryId;
  String? countryName;
  String? createdAt;
  String? createdBy;
  String? id;
  bool? isDefault;
  String? landmark;
  double? latitude;
  double? longitude;
  String? modifiedAt;
  String? modifiedBy;
  String? postalCode;
  String? subDivisionCode;
  int? subDivisionId;
  String? subDivisionName;
  String? userId;

  AddressItems(
      {this.accountId,
      this.addressLine1,
      this.addressLine2,
      this.addressType,
      this.addressTypeId,
      this.city,
      this.countryCode,
      this.countryId,
      this.countryName,
      this.createdAt,
      this.createdBy,
      this.id,
      this.isDefault,
      this.landmark,
      this.latitude,
      this.longitude,
      this.modifiedAt,
      this.modifiedBy,
      this.postalCode,
      this.subDivisionCode,
      this.subDivisionId,
      this.subDivisionName,
      this.userId});

  AddressItems.fromJson(Map<String, dynamic> json) {
    accountId = json['accountId'];
    addressLine1 = json['addressLine1'];
    addressLine2 = json['addressLine2'];
    addressType = json['addressType'];
    addressTypeId = json['addressTypeId'];
    city = json['city'];
    countryCode = json['countryCode'];
    countryId = json['countryId'];
    countryName = json['countryName'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    id = json['id'];
    isDefault = json['isDefault'];
    landmark = json['landmark'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    modifiedAt = json['modifiedAt'];
    modifiedBy = json['modifiedBy'];
    postalCode = json['postalCode'];
    subDivisionCode = json['subDivisionCode'];
    subDivisionId = json['subDivisionId'];
    subDivisionName = json['subDivisionName'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountId'] = this.accountId;
    data['addressLine1'] = this.addressLine1;
    data['addressLine2'] = this.addressLine2;
    data['addressType'] = this.addressType;
    data['addressTypeId'] = this.addressTypeId;
    data['city'] = this.city;
    data['countryCode'] = this.countryCode;
    data['countryId'] = this.countryId;
    data['countryName'] = this.countryName;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['id'] = this.id;
    data['isDefault'] = this.isDefault;
    data['landmark'] = this.landmark;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['modifiedAt'] = this.modifiedAt;
    data['modifiedBy'] = this.modifiedBy;
    data['postalCode'] = this.postalCode;
    data['subDivisionCode'] = this.subDivisionCode;
    data['subDivisionId'] = this.subDivisionId;
    data['subDivisionName'] = this.subDivisionName;
    data['userId'] = this.userId;
    return data;
  }
}
