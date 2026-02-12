class ENUMS {
  static const OWNED_BY = _OwnedBy();
  static const SCHEDULE_TYPE = _ScheduleType();
  static const COLLECTION_TYPE = _CollectionType();
  static const NOTIFICATION_TYPE = _NotificationType();
  static const USER_TYPE = _UserType();
  static const RECURRING_TYPE = _RecurringType();
  static const WEIGHTUOM_TYPE = _WeightUomType();
  static const UCO_TYPE = _UcoType();
  static const GRADE_TYPE = _GradeType();
  static const ISSUE_TYPE = _IssueType();
  static const ID_TYPE = _IdType();
  static const ROUTELOCATION_TYPE = _RouteLocationType();
  static const STARTINGLOCATION_TYPE = _StartingLocationType();
  static const EMAIL_TYPE = _EmailType();
  static const PUSH_TYPE = _PushType();
  static const VEHICLE_TYPE = _VehicleType();
  static const DESIGNATION_TYPE = _DesignationType();
  static const ESTABLISHMENT_TYPE = _EstablishmentType();
  static const CONTAINER_TYPE = _ContainerType();
  static const PAYMENTSTATUS_TYPE = _PaymentStatusType();
  static const VOLUMEUOM_TYPE = _VolumeUomType();
  static const DIMENSIONSUOM_TYPE = _DimensionsUomType();
  static const TAX_TYPE = _TaxType();
  static const RESTAURENTLICENSE_TYPE = _RestaurantLicenseType();
  static const CONTACT_TYPE = _ContactType();
  static const ESTIMATEDHOUR_TYPE = _EstimatedHourType();
  static const SUPPLIERCANCELORDERWITHOUTFEE_TYPE =
      _SupplierCancelOrderWithoutFeeType();
  static const DRIVERCONTACTDISPLAY_TYPE = _DriverContactDisplayType();
  static const DRIVERCANSTARTITINERARY_TYPE = _DriverCanStartItineraryType();
  static const DRIVERCANCELLINGPICKUPWITHOUTFEE_TYPE =
      _DriverCancellingPickupWithoutFeeType();
  static const CONTAINERDOCUMENT_TYPE = _ContainerDocumentType();
  static const COMPLAINTDOCUMENT_TYPE = _ComplaintDocumentType();
  static const VEHICLEREGISTRATION_TYPE = _VehicleRegistrationType();
  static const RATECONFIGURATION_TYPE = _RateConfigurationType();
  static const CANCELLATION_TYPE = _CancellationType();
  static const PAYMENTMODE_TYPE = _PaymentModeType();
  static const HOURS_TYPE = _HoursType();
  static const CONVERSATION_TYPE = _ConversationType();
  static const MESSAGE_TYPE = _MessageType();
  static const MESSAGESTATUS_TYPE = _MessageStatusType();
  static const PAYMENT_TYPE = _PaymentType();
  static const ITINERARYREASONFORCANCELLATION =
      _ItineraryReasonForCancellation();
  static const CALLLOG_TYPE = _CallLogType();
  static const CURRENCY_TYPE = _CurrencyType();
  static const ZERO_VALUE = _ZeroValue();
  static const SCHEDULESTATUSID_TYPE = _ScheduleStatusIDType();
  static const ITINERARYROUTESTATUSID_TYPE = _ItineraryRouteStatusIDType();
  static const ITINERARYSTATUSID_TYPE = _ItineraryStatusIDType();
}

// Define each category as a separate class
class _OwnedBy {
  const _OwnedBy();
  final String BYUFUEL = "ZzWaGoHqO2gYkVQADHMvWQ"; // 113001
  final String SUPPLIER = "c0oDEQIRK-VbnVvypPorsA"; // 113002
  final String DRIVER = "R_ncrOjdZ9C6s-AUEMr1ng"; // 113003
}

class _ScheduleType {
  const _ScheduleType();
  final String PICKUP = "pBm0LfbzoFUJejcA2dLeaQ"; // 106001
  final String DROPOFF = "Gog9mKQ4gtesZsgsEGB3LQ"; // 106002
}

class _CollectionType {
  const _CollectionType();
  final String PLANNED = "L8jMSD4Zk9zE8dHkS-uw4w"; // 142001
  final String COLLECTED = "J3oQW2_AMeqtgmt8YhPNdQ"; // 142002
  final String CHECKEDIN = "NKdpV5KiL8szprkwc7WClA"; // 142003
}

class _NotificationType {
  const _NotificationType();
  final String PUSH = "apdjksROgqrVAnDc3cc_Iw"; // 101001
  final String EMAIL = "jkRQwUvkr_HnirHQMVZHtQ"; // 101002
}

class _UserType {
  const _UserType();
  final String SUPPLIER = "6tfNbwAW9LPEqHBsxtrt5A"; // 102001
  final String DRIVER = "K7F2YMR5jyIqr3ZS81DjjA"; // 102002
  final String WHWORKER = "wdEVDlfdnBLZuQQHJODdzQ"; // 102003
  final String ADMIN = "jRRZh48A88c2rciAEznXFg"; // 102004
  final String TSM = "qbP0zT8eYDfVwEPtRzBQcQ"; // 102005
}

class _RecurringType {
  const _RecurringType();
  final String DAY = "08RSIBjzv03LQ3MqKqICtA"; // 103001
  final String WEEK = "Xq_1Y850wY2QFwCYE_fpAw"; // 103002
  final String MONTH = "4TPGv6VKSUQKL4ANXgg_Kg"; // 103003
}

class _WeightUomType {
  const _WeightUomType();
  final String KG = "eFrr16DcNr5z9vwwKy5qig"; // 104001
  final String TONS = "TWR4c4W-FoAHhleqn8DvgA"; // 104002
}

class _UcoType {
  const _UcoType();
  final String COOKINGOIL = "3gQMjpWal6JIy4V4AOCC9A"; // 107001
  final String VEGETABLEOIL = "rt_G4CSnYvAoSHgFfs_e5Q"; // 107002
  final String OLIVEOIL = "WxLcKm4nhX1JpVEIkZ8wZQ"; // 107003
}

class _GradeType {
  const _GradeType();
  final String A = "u_5o1pOVY37dfz6EgZNsaQ"; // 108001
  final String B = "HiM6MEP185dT6I8Goh4XSg"; // 108002
  final String C = "p8Qyqi2RKoxqKqfktQt0Vw"; // 108003
}

class _IssueType {
  const _IssueType();
  final String SLOTNOTAVAILABLE = "UolswAKj_rsL8iGhOngitw"; // 109001
  final String PAYEMENTISSUES = "HHG7f3AkME3O-4Cs02xRXw"; // 109002
  final String BILLINGISSUE = "rPvXPfEGgu2wAvLOObDe1g"; // 109003
  final String RECURRINGPICKUP = "fyfNgH7qekJLx9KFrKnwsA"; // 109004
  final String UCODETAILS = "t3eYrUPqmU4EcUFzZlEKkA"; // 109005
  final String OTHERS = "C8N4PkbGMF5HtrRXHHpyIw"; // 147010
}

class _IdType {
  const _IdType();
  final String AADHAR = "0f5Ylw8DaryOtKYfx_ckug"; // 110001
  final String PAN = "tZ7cGq8Lb_RFYo2Uv2C74w"; // 110002
  final String DRIVINGLLICENSE = "EtWF5zWTKPFk0c2iVjJhIg"; // 110003
  final String PASSPORT = "W3fYBCz_uUq8pDOQkKcKIg"; // 110004
  final String ELECTRICITYBILL = "RypBbi4D9LnpwiBY4JaAjw"; // 147009
}

class _RouteLocationType {
  const _RouteLocationType();
  final String STARTINGPOINT = "R5rBtGY3X0aSWWya7pAHcQ"; // 111001
  final String COLLECTIONPOINT = "7gkn2rEut0EzoOSeX02e2g"; // 111002
  final String DROPPINGPOINT = "ignMbwBtrNAeQJkwwmhu-w"; // 111003
}

class _StartingLocationType {
  const _StartingLocationType();
  final String DRIVER = "M7-5OWYuBuR7g2dYp3XBbQ"; // 112001
  final String WAREHOUSE = "yGJlYXCZvfdlkaZ2bwCO5Q"; // 112002
}

class _EmailType {
  const _EmailType();
  final String PROMOTIONALOFFEERS = "Aql_6mmHEsXKNJk7C1CnXQ"; // 114001
  final String REQUESTSTATUS = "-582f1y6x3r7djAFBOCJAg"; // 114002
  final String RECOMMENDATIONS = "vgjhRZqShCxmXE2I43zHSQ"; // 114003
  final String MEMBERSHIP = "n7n87MIe74ya6AePU2DACg"; // 114004
}

class _PushType {
  const _PushType();
  final String PROMOTIONALOFFEERS = "Kplj-6gCnnWeGoQl_ZSfBw"; // 115001
  final String REQUESTSTATUS = "1Z0H4UFoG2fRj-EPnBuPXQ"; // 115002
  final String RECOMMENDATIONS = "ksr6DGqoV_nYZBIxUZlOMg"; // 115003
  final String MEMBERSHIP = "mF_eztyWXyo_1iTqJDXrDw"; // 115004
}

class _VehicleType {
  const _VehicleType();
  final String TRAILER = "AghynHWBr5DHqYjEqSNRWQ"; // 116001
  final String MINITRUCK = "CgVL6kANOofxtw-94AfpQA"; // 116002
  final String COMMERCIALVEHICLE = "1WsbNyDSSauZ-GSURadgzQ"; // 116003
}

class _DesignationType {
  const _DesignationType();
  final String SUPERVISOR = "KIuFyTfz7BY_DM8Zy2DgyQ"; // 117001
  final String INSPECTOR = "dga9fmxQGlAIvDbh8oFIXQ"; // 117002
  final String LOADER = "sNDmmYKnEbgKl2IvXPWtQg"; // 117003
  final String SAFETY = "Kb_OJ20zkWwK2yLL8O3HVw"; // 140004
  final String SCANNER = "H1zvJKTlxgbHAkCkLQjVkQ"; // 147008
}

class _EstablishmentType {
  const _EstablishmentType();
  final String RESTAURANT = "EYD-5YAfb6bHVQx2-tBQPg"; // 118001
  final String COMMERCIAL = "lV5lOZgTXkiOiITVrFaBmA"; // 118002
  final String HOTEL = "0jN8vcabPAaB7wvQJdaUfQ"; // 118003
}

class _ContainerType {
  const _ContainerType();
  final String JERRYCAN = "BddHqYpz3IOVo7g2TVkOEQ"; // 119001
  final String TANKTRAILER = "Ju9lv8Y5ifuvNvFZ9CTR0w"; // 119002
  final String DRUMBARREL = "w7hfHV-apbzD_P22AOkzgg"; // 119003
  final String PLASTICBARREL = "-YUCutufUzsbwlbadZwhCA"; // 140003
  final String DRUM = "AYY5AUaAw9XLAyxqdtjqOg"; // 147007
}

class _PaymentStatusType {
  const _PaymentStatusType();
  final String PAID = "1izWx0sOsLWqAxjW8QdfXA"; // 120001
  final String UNPAID = "5vVkr1tYBNL0LyKLdX1p_g"; // 120002
  final String ALL = "foH_hiS7329Xr8p51-g4lw"; // 120003
}

class _VolumeUomType {
  const _VolumeUomType();
  final String LTR = "BY212fJspv-8RMllAjeQWw"; // 125001
}

class _CurrencyType {
  const _CurrencyType();
  final String CURRENCY = "AzkHCZ5bGSXMk09_X0-F8A";
}

class _DimensionsUomType {
  const _DimensionsUomType();
  final String CM = "l6iwT1F6W7bE-wOaxeduqA"; // 126001
}

class _TaxType {
  const _TaxType();
  final String GST = "k5ztKZ__PYq64Qog2Cn3mA"; // 127001
  final String SALESTAX = "YEtuaGIkjDijl-REFy7yNg"; // 127002
  final String VAT = "SE6zoJ4UOG8HPc4S7bKhdQ"; // 127003
}

class _RestaurantLicenseType {
  const _RestaurantLicenseType();
  final String FSSAILICENSE = "p2VttZet2cDTPwcLBs_jjw"; // 128001
  final String GSTREGISTRATION = "c9emnEXlMAh1qDn6GcEivA"; // 128002
}

class _ContactType {
  const _ContactType();
  final String WAREHOUSE = "50t7n3pfg1iq6pXRySBEzg"; // 129001
  final String PERSON = "xSe7iLxDmrp_sIMXOsykfA"; // 129002
}

class _EstimatedHourType {
  const _EstimatedHourType();
  final String HR24 = "v2-IAPOGMCzqYkdrEWIsIQ"; // 130001
}

class _SupplierCancelOrderWithoutFeeType {
  const _SupplierCancelOrderWithoutFeeType();
  final String BEFOREAPPROVINGREQUEST = "GC2rYSL_GTt-2HhdjyjWXA"; // 131001
  final String BEFOREASSIGNINGDRIVER = "mqYkSq_Nk1XgDfclYWu6zA"; // 131002
  final String BEFORESTARTTHEITINERARY = "syAQdaNUyCaiAXZjYOB7fw"; // 131003
  final String BEFOREDRIVERREACHTHEDESTINATION =
      "h-N9F75PTHV1gRHkxOGYNA"; // 131004
  final String BEFORESTARTINGITINERARY = "YLglRm1NM_33I1x5SAfpdg"; // 131005
  final String NORULE = "ZXzBlnE0FvOhSkJ2YgKsCA"; // 131006
}

class _DriverContactDisplayType {
  const _DriverContactDisplayType();
  final String AFTERDRIVERASSIGNED = "q0Os08jJ7gcf3FW3a0OrXQ"; // 132001
  final String AFTERDRIVERACCEPTSITINERARY = "0bTgQo3rm49VPlIp9a3kRw"; // 132002
  final String AFTERDRIVERSTARTSITINERARY = "Hs3uIxhXYyaA0RUPgE28vA"; // 132003
  final String AFTERDRIVERREACHESDESTINATION =
      "ruLCdWb97S7fjtKDJxOpAw"; // 132004
  final String BEFORESTARTINGITINERARY = "zKKh4Q025GlyWoiR7-u93w"; // 132005
  final String NORULE = "_3zAKJjMq7soZfHXoUcC6A"; // 132006
}

class _DriverCanStartItineraryType {
  const _DriverCanStartItineraryType();
  final String BEFORESTARTINGITINERARY = "TNn4AWEGR7qSnt15MisQjQ"; // 133002
  final String NORULE = "sYZtKDzGIbv3ZizeAIdxdg"; // 133003
}

class _DriverCancellingPickupWithoutFeeType {
  const _DriverCancellingPickupWithoutFeeType();
  final String BEFORESTARTTHEITINERARY = "YaBtt9WYTBuEYgNILSCOmg"; // 134001
  final String BEFOREDRIVERREACHTHEDESTINATION =
      "rAFmaIQs8TqYSCT3PwO0ug"; // 134002
  final String BEFORESTARTINGITINERARY = "6GWNnNKj5QdksMAnbwRdAQ"; // 134003
  final String NORULE = 'K2Cx1sRv6SjgamvyElA6Tw'; //134004
}

class _ContainerDocumentType {
  const _ContainerDocumentType();
  final String IMAGE = "gHEUZg3Cq3jxGhdxlb8M4w"; // 135001
  final String OTHERS = "mjzVjEXjeEi90sO21CeIJA"; // 135002
}

class _ComplaintDocumentType {
  const _ComplaintDocumentType();
  final String SCREENSHOT = "fhyGgEYvL8l5UamQcwsS5Q"; // 136001
  final String OTHERS = "2qDGBQfyyJerA46GfMpNQQ"; // 136002
}

class _VehicleRegistrationType {
  const _VehicleRegistrationType();
  final String REGISTRATIONCERTIFICATE = "g-xvdGyhwW6DSeePiYjVuA"; // 137001
  final String PUCCERTIFICATE = "b-gJxtNJOIg3JlvieWKAEg"; // 137002
  final String INSURANCEPOLICY = "e-Ia32zuVVCL_HOUSYvHnA"; // 137003
  final String REQUIREDPERMITS = "uI2M3io9u3sYMRz6VcUi8Q"; // 137004
  final String OTHERS = "aN-Ubt06c4kfoVgab3FGzw"; // 137005
}

class _RateConfigurationType {
  const _RateConfigurationType();
  final String OPERATIONALAREA = "xf6ct71iO1t_JF0OhGl06w"; // 138001
  final String SUPPLIER = "7G1ixgmzM4G6o439cyn_EQ"; // 138002
}

class _CancellationType {
  const _CancellationType();
  final String NOOIL = "IaPpfYqdPpVJvgzR9DyJuQ"; // 139001
  final String CUSTOMERNOTAVAILABLE = "tlnAfZnOqS_WZKrdoy1Naw"; // 139002
  final String OTHERS = "yXrUkS8GIvB7DgLOvFcGKg"; // 139003
}

class _PaymentModeType {
  const _PaymentModeType();
  final String BANK_ACCOUNT = "BUvr8Glk1MTjJ6MGjOVO7g"; // 140001
  final String VPA = "BoL0uZ4gs5WKZMre-n982w"; // 140002
}

class _HoursType {
  const _HoursType();
  final String HR_1 = "nFjIp_FSZO--X89z99WdmA"; // 141001
  final String HRS_2 = "KtRjmFPFkY6xi9QnHU35PA"; // 141002
}

class _ConversationType {
  const _ConversationType();
  final String INDIVIDUAL = "j4Tij0u0J04hkoXr7QhmsA"; // 143001
  final String GROUP = "IwRueae9fIH3T7c51Ty9CA"; // 143002
}

class _MessageType {
  const _MessageType();
  final String TEXT = "VXdwN5Lm2LgraOkb8f3CXw"; // 144001
  final String DOCUMENT = "sk5XGEnCgy9sYZkClsfK0A"; // 144002
}

class _MessageStatusType {
  const _MessageStatusType();
  final String DELIVERED = "z6W7ZkjYWeghmJyhT5894A"; // 145001
  final String READ = "7IJyNkthqZ1nEzlMMJ8eag"; // 145002
}

class _PaymentType {
  const _PaymentType();
  final String CASH = "Aldp8k-mQy1tCoeUVO0IdA"; // 146001
  final String UPI = "u_xy0apZ_yaLp8c6rkx7eg"; // 146002
  final String CARD = "EvEALALS-b2R43Zn7j3QNw"; // 146003
  final String ONLINE = "uU757kOW4vsZZL6EfFS8KA"; // 146004
}

class _ItineraryReasonForCancellation {
  const _ItineraryReasonForCancellation();
  final String UNABLETOREACHTHESUPPLIER = "UcEmUNf2IGeWxMjdfuoiBw"; // 147001
  final String VEHICLEBREAKDOWN = "1HnWhFMBDJ5DeLcJI538NQ"; // 147002
  final String INCORRECTADDRESS = "A3XkuQJk1MXrMTAdF6KrdA"; // 147003
  final String NOENTRYZONES = "zFle8V07EjdI-NyNR6zsVA"; // 147004
  final String PEDESTRIANIZATION = "4P6gKoIO1H8QOSBXUnnj2A"; // 147005
  final String DELAYINSUPPLIERREADINESS = "OooJTWuJmp9y5vTp5GBdpQ"; // 147006
}

class _CallLogType {
  const _CallLogType();
  final String SUPPLIER = "XmDNWQAcMW8KTTqQYSX8zA"; // 148001
  final String DRIVER = "tjmqeHMPPGSVTxi0-EwSLw"; // 148002
  final String CUSTOMERSUPPORT = "FQ_BcPvR5b6-tljJEvDVHw"; // 148003
}

class _ZeroValue {
  const _ZeroValue();
  final String ZERO = 'AcbAOoIIlJUYPKW04fJeig'; // 0; // 148001
}

class _ScheduleStatusIDType {
  const _ScheduleStatusIDType();

  final String REQUESTPLACED = "-jSES9ke919OHB8RA0ZfgQ"; // 110
  final String APPROVED = "EhUCqPfug8PFU5mCV6VDvw"; // 120
  final String REJECTED = "JcvSETxV9pS_I_g2JY6How"; // 130
  final String WAREHOUSEASSIGNED = "GblDytgRjF7x0DqhpH5bjQ"; // 140
  final String DRIVERASSIGNED = "5lJCvuxMNKyMXs_SY560Xg"; // 150
  final String PICKUPSTARTED = "Biatz6hHZSFicqinpOEKvg"; // 160
  final String PICKUPINPROGRESS = "i2sHy2HbXh4nSHLVUCaszA"; // 170
  final String OILCOLLECTED = "bevfVMUfaejDBrm4qMyv1w"; // 175
  final String PICKUPCOMPLETED = "jzuVOcIc8p8c6HFdTistUg"; // 180
  final String CANCELLED = "JFkBOErtg8XMaVNrX_1urA"; // 190
  final String DRIVERCANCELLED = "U_J3ARv1xvtUdJ3JhxGnWw"; // 195
  final String ARRIVEDATWAREHOUSE = "tYB8kXEyme0leTHlPi-p0A"; // 200
  final String DELIVEREDATWAREHOUSE = "k0cJXr52om9jM7Bu6-zD7A"; // 210
  final String PAYMENTINITIATED = "pKCURg2ppprYD8VvZMNKbw"; // 220
  final String PAYMENTVERIFIED = "IElW5dvfG1gdoAJgU1od7g"; // 225
  final String PAYMENTCREDITED = "PYQhaxKShIIzPaf6AV6WHg"; // 230
}


class _ItineraryRouteStatusIDType {
  const _ItineraryRouteStatusIDType();

  final String DRIVERASSIGNED = "8prQ5Bo8zmboVlcqM9zrww"; // 710
  final String PICKUPSTARTED = "YDph5nBGcDJZDdrlQjBjQg"; // 720
  final String PICKUPINPROGRESS = "iV2vw8M5G5idtAjTrpiUCQ"; // 730
  final String ARRIVED = "sCQWRaXdqeLNuduMRJqG3w"; // 740
  final String OILCOLLECTED = "2w3we-IryZHCpJzOB2rXuQ"; // 750
  final String PICKUPCOMPLETED = "aKY_RO_kHMWg6CE1lZ3Mng"; // 770
  final String DRIVERCANCELLED = "Lo0Rfv16Xu-g3fw4zxtDDA"; // 780
  final String SUPPLIERCANCELLED = "UNfUpMl7WGQFNELuAchg5g"; // 785
}

class _ItineraryStatusIDType {
  const _ItineraryStatusIDType();

  final String ITINERARYCREATED = "2lUH-l8qYxZxhRSKpXgTpg"; // 510
  final String DRIVERASSIGNED = "s9ho8sEa__y2S6aKWSV5dQ"; // 520
  final String DRIVERACCEPTED = "LgCxfRGKAhSdGU_49DiGYg"; // 530
  final String DRIVERREJECTED = "_y7ozPnCjOqYwA1_Vq7M_g"; // 540
  final String ITINERARYSTARTED = "byd64C9s5BLfiNd2PwXt6A"; // 550
  final String ARRIVEDATWAREHOUSE = "raVcA7c9jlzYC6iMjqIYyw"; // 560
  final String PENDINGINVESTIGATION = "N4Z1TXrrU2qf6efCbKztKQ"; // 563
  final String PENDINGVERIFICATION = "-f-jiAUjKG80nrl7pbyQBA"; // 566
  final String VERIFIEDANDVALIDATED = "efhmo40gFGG8HaA-ZOVhLg"; // 568
  final String DELIVEREDATWAREHOUSE = "P7Li37GQ1zLASRxy6EC2DA"; // 570
  final String COMPLETED = "55-W9dt4OdnNSKLxg3x95w"; // 575
  final String DRIVERCANCELLED = "oE-jRo5to_jYACgRwmSF7Q"; // 580
  final String SUPPLIERCANCELLED = "WVUuZTiQiA5wUmVZ5oEGzg"; // 585
}

