class EstDetailsModel {
  int? estimationId;
  String? time;
  String? entryDate;
  int? estimationFor;
  int? isApproved;
  bool? isEstimationApproveReq;
  String? estNo;
  double? salesAmount;
  double? purchaseAmount;
  double? returnAmount;
  double? totalDiscountAmount;
  double? netAmount;
  double? roundOff;
  String? createdOn;
  Null? approvedOn;
  Null? updatedOn;
  bool? sendToApproval;
  Null? deviceId;
  Null? subscriptionId;
  int? metal;
  int? idBranch;
  int? idCustomer;
  int? idEmployee;
  int? invoiceId;
  int? createdBy;
  int? approvedBy;
  int? updatedBy;
  int? pkId;
  String? branchName;
  String? customerName;
  String? customerMobile;
  String? cusType;
  String? date;
  String? tagCodes;
  String? employeeNames;
  List<SalesDetails>? salesDetails;
  List<PurchaseDetails>? purchaseDetails;
  List<ReturnDetails>? returnDetails;

  EstDetailsModel(
      {this.estimationId,
      this.time,
      this.entryDate,
      this.estimationFor,
      this.isApproved,
      this.isEstimationApproveReq,
      this.estNo,
      this.salesAmount,
      this.purchaseAmount,
      this.returnAmount,
      this.totalDiscountAmount,
      this.netAmount,
      this.roundOff,
      this.createdOn,
      this.approvedOn,
      this.updatedOn,
      this.sendToApproval,
      this.deviceId,
      this.subscriptionId,
      this.metal,
      this.idBranch,
      this.idCustomer,
      this.idEmployee,
      this.invoiceId,
      this.createdBy,
      this.approvedBy,
      this.updatedBy,
      this.pkId,
      this.branchName,
      this.customerName,
      this.customerMobile,
      this.cusType,
      this.date,
      this.tagCodes,
      this.employeeNames,
      this.salesDetails,
      this.purchaseDetails,
      this.returnDetails});

  EstDetailsModel.fromJson(Map<String, dynamic> json) {
    estimationId = json['estimation_id'];
    time = json['time'];
    entryDate = json['entry_date'];
    estimationFor = json['estimation_for'];
    isApproved = json['is_approved'];
    isEstimationApproveReq = json['is_estimation_approve_req'];
    estNo = json['est_no'];
    salesAmount = json['sales_amount'];
    purchaseAmount = json['purchase_amount'];
    returnAmount = json['return_amount'];
    totalDiscountAmount = json['total_discount_amount'];
    netAmount = json['net_amount'];
    roundOff = json['round_off'];
    createdOn = json['created_on'];
    approvedOn = json['approved_on'];
    updatedOn = json['updated_on'];
    sendToApproval = json['send_to_approval'];
    deviceId = json['device_id'];
    subscriptionId = json['subscription_id'];
    metal = json['metal'];
    idBranch = json['id_branch'];
    idCustomer = json['id_customer'];
    idEmployee = json['id_employee'];
    invoiceId = json['invoice_id'];
    createdBy = json['created_by'];
    approvedBy = json['approved_by'];
    updatedBy = json['updated_by'];
    pkId = json['pk_id'];
    branchName = json['branch_name'];
    customerName = json['customer_name'];
    customerMobile = json['customer_mobile'];
    cusType = json['cus_type'];
    date = json['date'];
    tagCodes = json['tag_codes'];
    employeeNames = json['employee_names'];
    if (json['sales_details'] != null) {
      salesDetails = <SalesDetails>[];
      json['sales_details'].forEach((v) {
        salesDetails!.add(new SalesDetails.fromJson(v));
      });
    }
    if (json['purchase_details'] != null) {
      purchaseDetails = <PurchaseDetails>[];
      json['purchase_details'].forEach((v) {
        purchaseDetails!.add(new PurchaseDetails.fromJson(v));
      });
    }
    if (json['return_details'] != null) {
      returnDetails = <ReturnDetails>[];
      json['return_details'].forEach((v) {
        returnDetails!.add(new ReturnDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['estimation_id'] = this.estimationId;
    data['time'] = this.time;
    data['entry_date'] = this.entryDate;
    data['estimation_for'] = this.estimationFor;
    data['is_approved'] = this.isApproved;
    data['is_estimation_approve_req'] = this.isEstimationApproveReq;
    data['est_no'] = this.estNo;
    data['sales_amount'] = this.salesAmount;
    data['purchase_amount'] = this.purchaseAmount;
    data['return_amount'] = this.returnAmount;
    data['total_discount_amount'] = this.totalDiscountAmount;
    data['net_amount'] = this.netAmount;
    data['round_off'] = this.roundOff;
    data['created_on'] = this.createdOn;
    data['approved_on'] = this.approvedOn;
    data['updated_on'] = this.updatedOn;
    data['send_to_approval'] = this.sendToApproval;
    data['device_id'] = this.deviceId;
    data['subscription_id'] = this.subscriptionId;
    data['metal'] = this.metal;
    data['id_branch'] = this.idBranch;
    data['id_customer'] = this.idCustomer;
    data['id_employee'] = this.idEmployee;
    data['invoice_id'] = this.invoiceId;
    data['created_by'] = this.createdBy;
    data['approved_by'] = this.approvedBy;
    data['updated_by'] = this.updatedBy;
    data['pk_id'] = this.pkId;
    data['branch_name'] = this.branchName;
    data['customer_name'] = this.customerName;
    data['customer_mobile'] = this.customerMobile;
    data['cus_type'] = this.cusType;
    data['date'] = this.date;
    data['tag_codes'] = this.tagCodes;
    data['employee_names'] = this.employeeNames;
    if (this.salesDetails != null) {
      data['sales_details'] =
          this.salesDetails!.map((v) => v.toJson()).toList();
    }
    if (this.purchaseDetails != null) {
      data['purchase_details'] =
          this.purchaseDetails!.map((v) => v.toJson()).toList();
    }
    if (this.returnDetails != null) {
      data['return_details'] =
          this.returnDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalesDetails {
  int? estItemId;
  List<StoneDetails>? stoneDetails;
  List<ChargesDetails>? chargesDetails;
  List<bool>? otherMetalDetail;
  int? catId;
  String? tagCode;
  String? oldTagCode;
  String? stoneAmount;
  String? chargesAmount;
  int? otherMetalAmt;
  double? mcAfterDiscount;
  int? itemType;
  int? isPartialSale;
  int? pieces;
  double? grossWt;
  double? lessWt;
  double? netWt;
  double? diaWt;
  double? stoneWt;
  double? wastagePercentage;
  double? wastageWeight;
  double? otherMetalWt;
  int? mcType;
  double? mcValue;
  double? flatMcValue;
  double? totalMcValue;
  double? sellRate;
  double? otherChargesAmount;
  double? otherMetalAmount;
  double? ratePerGram;
  double? taxableAmount;
  int? taxType;
  double? taxPercentage;
  double? taxAmount;
  double? cgstCost;
  double? sgstCost;
  double? igstCost;
  double? discountAmount;
  double? itemCost;
  String? wastageCalcType;
  double? wastageDiscount;
  double? mcDiscountAmount;
  int? status;
  double? wastagePercentageAfterDisc;
  double? pureWeight;
  double? purchaseTouch;
  double? purchaseWastage;
  int? estimationId;
  int? idPurity;
  int? uomId;
  int? tagId;
  int? idProduct;
  int? idDesign;
  int? idSubDesign;
  int? idSection;
  int? taxId;
  int? refEmpId;
  Null? refEmpId1;
  Null? refEmpId2;
  Null? invoiceSaleItemId;
  Null? size;
  String? isTaxCalculate;
  String? purityName;
  String? idMetal;
  String? productName;
  String? productCode;
  String? weightShowInPrint;
  String? weightShowInPrintPurity;
  String? weightShowInPrintDesign;
  String? designBasedCalculate;
  String? productDesignBasedCalculate;
  String? fixedRateType;
  String? fixwdRateType;
  String? salesMode;
  String? mcCalcType;
  String? designName;
  String? subDesignName;
  String? empName;
  String? tagGrossWeight;
  Null? tagHuid2;
  Null? tagHuid;
  Null? tagHuid3;
  Null? tagHuid4;
  String? maxGrossWeight;
  String? supplierName;

  SalesDetails(
      {this.estItemId,
      this.stoneDetails,
      this.chargesDetails,
      this.otherMetalDetail,
      this.catId,
      this.tagCode,
      this.oldTagCode,
      this.stoneAmount,
      this.chargesAmount,
      this.otherMetalAmt,
      this.mcAfterDiscount,
      this.itemType,
      this.isPartialSale,
      this.pieces,
      this.grossWt,
      this.lessWt,
      this.netWt,
      this.diaWt,
      this.stoneWt,
      this.wastageCalcType,
      this.wastagePercentage,
      this.wastageWeight,
      this.otherMetalWt,
      this.mcType,
      this.mcValue,
      this.flatMcValue,
      this.totalMcValue,
      this.sellRate,
      this.otherChargesAmount,
      this.otherMetalAmount,
      this.ratePerGram,
      this.taxableAmount,
      this.taxType,
      this.taxPercentage,
      this.taxAmount,
      this.cgstCost,
      this.sgstCost,
      this.igstCost,
      this.discountAmount,
      this.itemCost,
      this.wastageDiscount,
      this.mcDiscountAmount,
      this.status,
      this.wastagePercentageAfterDisc,
      this.pureWeight,
      this.purchaseTouch,
      this.purchaseWastage,
      this.estimationId,
      this.idPurity,
      this.uomId,
      this.tagId,
      this.idProduct,
      this.idDesign,
      this.idSubDesign,
      this.idSection,
      this.taxId,
      this.refEmpId,
      this.refEmpId1,
      this.refEmpId2,
      this.invoiceSaleItemId,
      this.size,
      this.isTaxCalculate,
      this.purityName,
      this.idMetal,
      this.productName,
      this.productCode,
      this.weightShowInPrint,
      this.weightShowInPrintPurity,
      this.weightShowInPrintDesign,
      this.designBasedCalculate,
      this.productDesignBasedCalculate,
      this.fixedRateType,
      this.fixwdRateType,
      this.salesMode,
      this.mcCalcType,
      this.designName,
      this.subDesignName,
      this.empName,
      this.tagGrossWeight,
      this.tagHuid2,
      this.tagHuid,
      this.tagHuid3,
      this.tagHuid4,
      this.maxGrossWeight,
      this.supplierName});

  SalesDetails.fromJson(Map<String, dynamic> json) {
    estItemId = json['est_item_id'];
    if (json['stone_details'] != null) {
      stoneDetails = <StoneDetails>[];
      json['stone_details'].forEach((v) {
        stoneDetails!.add(new StoneDetails.fromJson(v));
      });
    }
    if (json['charges_details'] != null) {
      chargesDetails = <ChargesDetails>[];
      json['charges_details'].forEach((v) {
        chargesDetails!.add(new ChargesDetails.fromJson(v));
      });
    }
    if (json['other_metal_detail'] != null) {
      otherMetalDetail = <bool>[];
      json['other_metal_detail'].forEach((v) {
        otherMetalDetail!.add(v);
      });
    }
    otherMetalDetail = [];
    catId = json['cat_id'];
    tagCode = json['tag_code'];
    oldTagCode = json['old_tag_code'];
    stoneAmount = json['stone_amount'];
    chargesAmount = json['charges_amount'];
    otherMetalAmt = json['other_metal_amt'];
    mcAfterDiscount = json['mc_after_discount'];
    itemType = json['item_type'];
    isPartialSale = json['is_partial_sale'];
    pieces = json['pieces'];
    grossWt = json['gross_wt'];
    lessWt = json['less_wt'];
    netWt = json['net_wt'];
    diaWt = json['dia_wt'];
    stoneWt = json['stone_wt'];
    wastagePercentage = json['wastage_percentage'];
    wastageWeight = json['wastage_weight'];
    otherMetalWt = json['other_metal_wt'];
    mcType = json['mc_type'];
    mcValue = json['mc_value'];
    flatMcValue = json['flat_mc_value'];
    totalMcValue = json['total_mc_value'];
    sellRate = json['sell_rate'];
    otherChargesAmount = json['other_charges_amount'];
    otherMetalAmount = json['other_metal_amount'];
    ratePerGram = json['rate_per_gram'];
    taxableAmount = json['taxable_amount'];
    taxType = json['tax_type'];
    taxPercentage = json['tax_percentage'];
    taxAmount = json['tax_amount'];
    cgstCost = json['cgst_cost'];
    sgstCost = json['sgst_cost'];
    igstCost = json['igst_cost'];
    discountAmount = json['discount_amount'];
    itemCost = json['item_cost'];
    wastageCalcType = json['wastage_calc_type'];
    wastageDiscount = json['wastage_discount'];
    mcDiscountAmount = json['mc_discount_amount'];
    status = json['status'];
    wastagePercentageAfterDisc = json['wastage_percentage_after_disc'];
    pureWeight = json['pure_weight'];
    purchaseTouch = json['purchase_touch'];
    purchaseWastage = json['purchase_wastage'];
    estimationId = json['estimation_id'];
    idPurity = json['id_purity'];
    uomId = json['uom_id'];
    tagId = json['tag_id'];
    idProduct = json['id_product'];
    idDesign = json['id_design'];
    idSubDesign = json['id_sub_design'];
    idSection = json['id_section'];
    taxId = json['tax_id'];
    refEmpId = json['ref_emp_id'];
    refEmpId1 = json['ref_emp_id_1'];
    refEmpId2 = json['ref_emp_id_2'];
    invoiceSaleItemId = json['invoice_sale_item_id'];
    size = json['size'];
    isTaxCalculate = json['is_tax_calculate'];
    purityName = json['purity_name'];
    idMetal = json['id_metal'];
    productName = json['product_name'];
    productCode = json['product_code'];
    weightShowInPrint = json['weight_show_in_print'];
    weightShowInPrintPurity = json['weight_show_in_print_purity'];
    weightShowInPrintDesign = json['weight_show_in_print_design'];
    designBasedCalculate = json['design_based_calculate'];
    productDesignBasedCalculate = json['product_design_based_calculate'];
    fixedRateType = json['fixed_rate_type'];
    fixwdRateType = json['fixwd_rate_type'];
    salesMode = json['sales_mode'];
    mcCalcType = json['mc_calc_type'];
    designName = json['design_name'];
    subDesignName = json['sub_design_name'];
    empName = json['emp_name'];
    tagGrossWeight = json['tagGrossWeight'];
    tagHuid2 = json['tag_huid2'];
    tagHuid = json['tag_huid'];
    tagHuid3 = json['tag_huid3'];
    tagHuid4 = json['tag_huid4'];
    maxGrossWeight = json['maxGrossWeight'];
    supplierName = json['supplier_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['est_item_id'] = this.estItemId;
    if (this.stoneDetails != null) {
      data['stone_details'] =
          this.stoneDetails!.map((v) => v.toJson()).toList();
    }
    if (this.chargesDetails != null) {
      data['charges_details'] =
          this.chargesDetails!.map((v) => v.toJson()).toList();
    }
    data['other_metal_detail'] = [];

    if (this.otherMetalDetail != null) {
      data['other_metal_detail'] = [];
    }
    data['cat_id'] = this.catId;
    data['tag_code'] = this.tagCode;
    data['old_tag_code'] = this.oldTagCode;
    data['stone_amount'] = this.stoneAmount;
    data['charges_amount'] = this.chargesAmount;
    data['other_metal_amt'] = this.otherMetalAmt;
    data['mc_after_discount'] = this.mcAfterDiscount;
    data['item_type'] = this.itemType;
    data['is_partial_sale'] = this.isPartialSale;
    data['pieces'] = this.pieces;
    data['gross_wt'] = this.grossWt;
    data['less_wt'] = this.lessWt;
    data['net_wt'] = this.netWt;
    data['dia_wt'] = this.diaWt;
    data['stone_wt'] = this.stoneWt;
    data['wastage_percentage'] = this.wastagePercentage;
    data['wastage_weight'] = this.wastageWeight;
    data['other_metal_wt'] = this.otherMetalWt;
    data['mc_type'] = this.mcType;
    data['mc_value'] = this.mcValue;
    data['flat_mc_value'] = this.flatMcValue;
    data['total_mc_value'] = this.totalMcValue;
    data['sell_rate'] = this.sellRate;
    data['other_charges_amount'] = this.otherChargesAmount;
    data['other_metal_amount'] = this.otherMetalAmount;
    data['rate_per_gram'] = this.ratePerGram;
    data['taxable_amount'] = this.taxableAmount;
    data['tax_type'] = this.taxType;
    data['tax_percentage'] = this.taxPercentage;
    data['tax_amount'] = this.taxAmount;
    data['cgst_cost'] = this.cgstCost;
    data['sgst_cost'] = this.sgstCost;
    data['igst_cost'] = this.igstCost;
    data['discount_amount'] = this.discountAmount;
    data['item_cost'] = this.itemCost;
    data['wastage_calc_type'] = this.wastageCalcType;
    data['wastage_discount'] = this.wastageDiscount;
    data['mc_discount_amount'] = this.mcDiscountAmount;
    data['status'] = this.status;
    data['wastage_percentage_after_disc'] = this.wastagePercentageAfterDisc;
    data['pure_weight'] = this.pureWeight;
    data['purchase_touch'] = this.purchaseTouch;
    data['purchase_wastage'] = this.purchaseWastage;
    data['estimation_id'] = this.estimationId;
    data['id_purity'] = this.idPurity;
    data['uom_id'] = this.uomId;
    data['tag_id'] = this.tagId;
    data['id_product'] = this.idProduct;
    data['id_design'] = this.idDesign;
    data['id_sub_design'] = this.idSubDesign;
    data['id_section'] = this.idSection;
    data['tax_id'] = this.taxId;
    data['ref_emp_id'] = this.refEmpId;
    data['ref_emp_id_1'] = this.refEmpId1;
    data['ref_emp_id_2'] = this.refEmpId2;
    data['invoice_sale_item_id'] = this.invoiceSaleItemId;
    data['size'] = this.size;
    data['is_tax_calculate'] = this.isTaxCalculate;
    data['purity_name'] = this.purityName;
    data['id_metal'] = this.idMetal;
    data['product_name'] = this.productName;
    data['product_code'] = this.productCode;
    data['weight_show_in_print'] = this.weightShowInPrint;
    data['weight_show_in_print_purity'] = this.weightShowInPrintPurity;
    data['weight_show_in_print_design'] = this.weightShowInPrintDesign;
    data['design_based_calculate'] = this.designBasedCalculate;
    data['product_design_based_calculate'] = this.productDesignBasedCalculate;
    data['fixed_rate_type'] = this.fixedRateType;
    data['fixwd_rate_type'] = this.fixwdRateType;
    data['sales_mode'] = this.salesMode;
    data['mc_calc_type'] = this.mcCalcType;
    data['design_name'] = this.designName;
    data['sub_design_name'] = this.subDesignName;
    data['emp_name'] = this.empName;
    data['tagGrossWeight'] = this.tagGrossWeight;
    data['tag_huid2'] = this.tagHuid2;
    data['tag_huid'] = this.tagHuid;
    data['tag_huid3'] = this.tagHuid3;
    data['tag_huid4'] = this.tagHuid4;
    data['maxGrossWeight'] = this.maxGrossWeight;
    data['supplier_name'] = this.supplierName;
    return data;
  }
}

class StoneDetails {
  int? estStnId;
  int? showInLwt;
  int? stonePcs;
  double? stoneWt;
  double? stoneRate;
  double? stoneAmount;
  int? stoneCalcType;
  int? estItemId;
  Null? estOldMetalItemId;
  int? idTagStnDetail;
  Null? estReturnItemId;
  int? idStone;
  int? idQualityCode;
  int? uomId;
  String? stoneType;
  String? stoneName;
  String? uomName;

  StoneDetails(
      {this.estStnId,
      this.showInLwt,
      this.stonePcs,
      this.stoneWt,
      this.stoneRate,
      this.stoneAmount,
      this.stoneCalcType,
      this.estItemId,
      this.estOldMetalItemId,
      this.idTagStnDetail,
      this.estReturnItemId,
      this.idStone,
      this.idQualityCode,
      this.uomId,
      this.stoneType,
      this.stoneName,
      this.uomName});

  StoneDetails.fromJson(Map<String, dynamic> json) {
    estStnId = json['est_stn_id'];
    showInLwt = json['show_in_lwt'];
    stonePcs = json['stone_pcs'];
    stoneWt = json['stone_wt'];
    stoneRate = json['stone_rate'];
    stoneAmount = json['stone_amount'];
    stoneCalcType = json['stone_calc_type'];
    estItemId = json['est_item_id'];
    estOldMetalItemId = json['est_old_metal_item_id'];
    idTagStnDetail = json['id_tag_stn_detail'];
    estReturnItemId = json['est_return_item_id'];
    idStone = json['id_stone'];
    idQualityCode = json['id_quality_code'];
    uomId = json['uom_id'];
    stoneType = json['stone_type'];
    stoneName = json['stone_name'];
    uomName = json['uom_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['est_stn_id'] = this.estStnId;
    data['show_in_lwt'] = this.showInLwt;
    data['stone_pcs'] = this.stonePcs;
    data['stone_wt'] = this.stoneWt;
    data['stone_rate'] = this.stoneRate;
    data['stone_amount'] = this.stoneAmount;
    data['stone_calc_type'] = this.stoneCalcType;
    data['est_item_id'] = this.estItemId;
    data['est_old_metal_item_id'] = this.estOldMetalItemId;
    data['id_tag_stn_detail'] = this.idTagStnDetail;
    data['est_return_item_id'] = this.estReturnItemId;
    data['id_stone'] = this.idStone;
    data['id_quality_code'] = this.idQualityCode;
    data['uom_id'] = this.uomId;
    data['stone_type'] = this.stoneType;
    data['stone_name'] = this.stoneName;
    data['uom_name'] = this.uomName;
    return data;
  }
}

class ChargesDetails {
  int? chargesEstItemId;
  double? chargesAmount;
  int? estItemId;
  int? idCharges;

  ChargesDetails(
      {this.chargesEstItemId,
      this.chargesAmount,
      this.estItemId,
      this.idCharges});

  ChargesDetails.fromJson(Map<String, dynamic> json) {
    chargesEstItemId = json['charges_est_item_id'];
    chargesAmount = json['charges_amount'];
    estItemId = json['est_item_id'];
    idCharges = json['id_charges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['charges_est_item_id'] = this.chargesEstItemId;
    data['charges_amount'] = this.chargesAmount;
    data['est_item_id'] = this.estItemId;
    data['id_charges'] = this.idCharges;
    return data;
  }
}

class PurchaseDetails {
  int? estOldMetalItemId;
  int? catId;
  int? pieces;
  double? touch;
  double? grossWt;
  double? lessWt;
  double? netWt;
  double? diaWt;
  double? stoneWt;
  double? dustWt;
  int? wastagePercentage;
  double? wastageWeight;
  double? pureWeight;
  double? ratePerGram;
  double? customerRate;
  double? amount;
  int? status;
  int? estimationId;
  int? idProduct;
  int? itemType;
  Null? invoiceOldMetalItemId;
  String? productName;
  String? oldMetalTypeName;
  String? oldMetalTypeCode;
  String? rateDeduction;

  PurchaseDetails(
      {this.estOldMetalItemId,
      this.catId,
      this.pieces,
      this.touch,
      this.grossWt,
      this.lessWt,
      this.netWt,
      this.diaWt,
      this.stoneWt,
      this.dustWt,
      this.wastagePercentage,
      this.wastageWeight,
      this.pureWeight,
      this.ratePerGram,
      this.customerRate,
      this.amount,
      this.status,
      this.estimationId,
      this.idProduct,
      this.itemType,
      this.invoiceOldMetalItemId,
      this.productName,
      this.oldMetalTypeName,
      this.oldMetalTypeCode,
      this.rateDeduction});

  PurchaseDetails.fromJson(Map<String, dynamic> json) {
    estOldMetalItemId = json['est_old_metal_item_id'];
    catId = json['cat_id'];
    pieces = json['pieces'];
    touch = json['touch'];
    grossWt = json['gross_wt'];
    lessWt = json['less_wt'];
    netWt = json['net_wt'];
    diaWt = json['dia_wt'];
    stoneWt = json['stone_wt'];
    dustWt = json['dust_wt'];
    wastagePercentage = json['wastage_percentage'];
    wastageWeight = json['wastage_weight'];
    pureWeight = json['pure_weight'];
    ratePerGram = json['rate_per_gram'];
    customerRate = json['customer_rate'];
    amount = json['amount'];
    status = json['status'];
    estimationId = json['estimation_id'];
    idProduct = json['id_product'];
    itemType = json['item_type'];
    invoiceOldMetalItemId = json['invoice_old_metal_item_id'];
    productName = json['product_name'];
    oldMetalTypeName = json['old_metal_type_name'];
    oldMetalTypeCode = json['old_metal_type_code'];
    rateDeduction = json['rate_deduction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['est_old_metal_item_id'] = this.estOldMetalItemId;
    data['cat_id'] = this.catId;
    data['pieces'] = this.pieces;
    data['touch'] = this.touch;
    data['gross_wt'] = this.grossWt;
    data['less_wt'] = this.lessWt;
    data['net_wt'] = this.netWt;
    data['dia_wt'] = this.diaWt;
    data['stone_wt'] = this.stoneWt;
    data['dust_wt'] = this.dustWt;
    data['wastage_percentage'] = this.wastagePercentage;
    data['wastage_weight'] = this.wastageWeight;
    data['pure_weight'] = this.pureWeight;
    data['rate_per_gram'] = this.ratePerGram;
    data['customer_rate'] = this.customerRate;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['estimation_id'] = this.estimationId;
    data['id_product'] = this.idProduct;
    data['item_type'] = this.itemType;
    data['invoice_old_metal_item_id'] = this.invoiceOldMetalItemId;
    data['product_name'] = this.productName;
    data['old_metal_type_name'] = this.oldMetalTypeName;
    data['old_metal_type_code'] = this.oldMetalTypeCode;
    data['rate_deduction'] = this.rateDeduction;
    return data;
  }
}

class ReturnDetails {
  int? estReturnItemId;
  int? pieces;
  double? grossWt;
  double? lessWt;
  double? netWt;
  double? diaWt;
  double? stoneWt;
  double? wastagePercentage;
  double? wastageWeight;
  int? mcType;
  double? mcValue;
  double? totalMcValue;
  double? sellRate;
  double? ratePerGram;
  double? taxableAmount;
  int? taxType;
  double? taxPercentage;
  double? taxAmount;
  double? cgstCost;
  double? sgstCost;
  double? igstCost;
  double? itemCost;
  int? estimationId;
  int? idPurity;
  int? uomId;
  int? tagId;
  int? idProduct;
  int? idDesign;
  int? idSubDesign;
  int? taxId;
  int? invoiceSaleItemId;
  int? invoiceReturnId;
  String? productName;
  String? purityName;

  ReturnDetails(
      {this.estReturnItemId,
      this.pieces,
      this.grossWt,
      this.lessWt,
      this.netWt,
      this.diaWt,
      this.stoneWt,
      this.wastagePercentage,
      this.wastageWeight,
      this.mcType,
      this.mcValue,
      this.totalMcValue,
      this.sellRate,
      this.ratePerGram,
      this.taxableAmount,
      this.taxType,
      this.taxPercentage,
      this.taxAmount,
      this.cgstCost,
      this.sgstCost,
      this.igstCost,
      this.itemCost,
      this.estimationId,
      this.idPurity,
      this.uomId,
      this.tagId,
      this.idProduct,
      this.idDesign,
      this.idSubDesign,
      this.taxId,
      this.invoiceSaleItemId,
      this.invoiceReturnId,
      this.productName,
      this.purityName});

  ReturnDetails.fromJson(Map<String, dynamic> json) {
    estReturnItemId = json['est_return_item_id'];
    pieces = json['pieces'];
    grossWt = json['gross_wt'];
    lessWt = json['less_wt'];
    netWt = json['net_wt'];
    diaWt = json['dia_wt'];
    stoneWt = json['stone_wt'];
    wastagePercentage = json['wastage_percentage'];
    wastageWeight = json['wastage_weight'];
    mcType = json['mc_type'];
    mcValue = json['mc_value'];
    totalMcValue = json['total_mc_value'];
    sellRate = json['sell_rate'];
    ratePerGram = json['rate_per_gram'];
    taxableAmount = json['taxable_amount'];
    taxType = json['tax_type'];
    taxPercentage = json['tax_percentage'];
    taxAmount = json['tax_amount'];
    cgstCost = json['cgst_cost'];
    sgstCost = json['sgst_cost'];
    igstCost = json['igst_cost'];
    itemCost = json['item_cost'];
    estimationId = json['estimation_id'];
    idPurity = json['id_purity'];
    uomId = json['uom_id'];
    tagId = json['tag_id'];
    idProduct = json['id_product'];
    idDesign = json['id_design'];
    idSubDesign = json['id_sub_design'];
    taxId = json['tax_id'];
    invoiceSaleItemId = json['invoice_sale_item_id'];
    invoiceReturnId = json['invoice_return_id'];
    productName = json['product_name'];
    purityName = json['purity_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['est_return_item_id'] = this.estReturnItemId;
    data['pieces'] = this.pieces;
    data['gross_wt'] = this.grossWt;
    data['less_wt'] = this.lessWt;
    data['net_wt'] = this.netWt;
    data['dia_wt'] = this.diaWt;
    data['stone_wt'] = this.stoneWt;
    data['wastage_percentage'] = this.wastagePercentage;
    data['wastage_weight'] = this.wastageWeight;
    data['mc_type'] = this.mcType;
    data['mc_value'] = this.mcValue;
    data['total_mc_value'] = this.totalMcValue;
    data['sell_rate'] = this.sellRate;
    data['rate_per_gram'] = this.ratePerGram;
    data['taxable_amount'] = this.taxableAmount;
    data['tax_type'] = this.taxType;
    data['tax_percentage'] = this.taxPercentage;
    data['tax_amount'] = this.taxAmount;
    data['cgst_cost'] = this.cgstCost;
    data['sgst_cost'] = this.sgstCost;
    data['igst_cost'] = this.igstCost;
    data['item_cost'] = this.itemCost;
    data['estimation_id'] = this.estimationId;
    data['id_purity'] = this.idPurity;
    data['uom_id'] = this.uomId;
    data['tag_id'] = this.tagId;
    data['id_product'] = this.idProduct;
    data['id_design'] = this.idDesign;
    data['id_sub_design'] = this.idSubDesign;
    data['tax_id'] = this.taxId;
    data['invoice_sale_item_id'] = this.invoiceSaleItemId;
    data['invoice_return_id'] = this.invoiceReturnId;
    data['product_name'] = this.productName;
    data['purity_name'] = this.purityName;
    return data;
  }
}
