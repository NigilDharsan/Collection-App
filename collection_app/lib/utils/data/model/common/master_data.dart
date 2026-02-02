import 'package:get/get.dart';

class AccountType {
  final int id;
  final String type;
  final String code;
  final String name;

  AccountType(
      {required this.id,
      required this.type,
      required this.code,
      required this.name});
}

class NotificationType {
  final int id;
  final String type;

  NotificationType({
    required this.id,
    required this.type,
  });
}

class UserType {
  final int id;
  final String type;
  final String code;
  final String name;

  UserType(
      {required this.id,
      required this.type,
      required this.code,
      required this.name});
}

class RecurringType {
  final int id;
  final String type;
  final String code;

  RecurringType({required this.id, required this.type, required this.code});
}

class weekDaysType {
  final int id;
  final String type;

  weekDaysType({required this.id, required this.type});
}

class ScheduleType {
  final int id;
  final String type;
  final String code;

  ScheduleType({required this.id, required this.type, required this.code});
}

class GradeType {
  final int id;
  final String type;
  final String name;
  final String key;

  GradeType(
      {required this.id,
      required this.type,
      required this.name,
      required this.key});
}

class RouteLocationType {
  final int id;
  final String type;

  RouteLocationType({required this.id, required this.type});
}

class StartingLocationType {
  final int id;
  final String type;

  StartingLocationType({required this.id, required this.type});
}

class EmailType {
  final int id;
  final String type;

  EmailType({required this.id, required this.type});
}

class PushType {
  final int id;
  final String type;

  PushType({required this.id, required this.type});
}

class Establishment {
  final int id;
  final int code;
  final String type;
  final String name;

  Establishment({
    required this.id,
    required this.code,
    required this.type,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}

class ScheduleStatus {
  final int id;
  final String statusName;
  final String statusCode;
  final String key;

  ScheduleStatus({
    required this.id,
    required this.statusName,
    required this.statusCode,
    required this.key,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['statusName'] = this.statusName;
    data['statusCode'] = this.statusCode;
    data['key'] = this.key;
    return data;
  }
}

class CompliantStatusCode {
  final int id;
  final String code;
  final String name;

  CompliantStatusCode({
    required this.id,
    required this.code,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}

// Dropdown item model
class DropdownItem {
  int? id;
  String? name;

  DropdownItem({this.id, this.name});
}

class StatusController extends GetxController {
  // Observable list of statuses
  var statuses = <ScheduleStatus>[
    ScheduleStatus(
        id: 110,
        statusName: '110'.tr,
        statusCode: 'REQUESTPLACED',
        key: '-jSES9ke919OHB8RA0ZfgQ'),
    ScheduleStatus(
        id: 120,
        statusName: '120'.tr,
        statusCode: 'APPROVED',
        key: 'EhUCqPfug8PFU5mCV6VDvw'),
    ScheduleStatus(
        id: 130,
        statusName: '130'.tr,
        statusCode: 'REJECTED',
        key: 'JcvSETxV9pS_I_g2JY6How'),
    ScheduleStatus(
        id: 140,
        statusName: '140'.tr,
        statusCode: 'WAREHOUSEASSIGNED',
        key: 'GblDytgRjF7x0DqhpH5bjQ'),
    ScheduleStatus(
        id: 150,
        statusName: '150'.tr,
        statusCode: 'DRIVERASSIGNED',
        key: '5lJCvuxMNKyMXs_SY560Xg'),
    ScheduleStatus(
        id: 160,
        statusName: '160'.tr,
        statusCode: 'PICKUPSTARTED',
        key: 'Biatz6hHZSFicqinpOEKvg'),
    ScheduleStatus(
        id: 170,
        statusName: '170'.tr,
        statusCode: 'PICKUPINPROGRESS',
        key: 'i2sHy2HbXh4nSHLVUCaszA'),
    ScheduleStatus(
        id: 175,
        statusName: '175'.tr,
        statusCode: 'OILCOLLECTED',
        key: 'bevfVMUfaejDBrm4qMyv1w'),
    ScheduleStatus(
        id: 180,
        statusName: '180'.tr,
        statusCode: 'PICKUPCOMPLETED',
        key: 'jzuVOcIc8p8c6HFdTistUg'),
    ScheduleStatus(
        id: 190,
        statusName: '190'.tr,
        statusCode: 'CANCELLED',
        key: 'JFkBOErtg8XMaVNrX_1urA'),
    ScheduleStatus(
        id: 200,
        statusName: '200'.tr,
        statusCode: 'ARRIVEDATWAREHOUSE',
        key: 'tYB8kXEyme0leTHlPi-p0A'),
    ScheduleStatus(
        id: 210,
        statusName: '210'.tr,
        statusCode: 'DELIVEREDATWAREHOUSE',
        key: 'k0cJXr52om9jM7Bu6-zD7A'),
    ScheduleStatus(
        id: 220,
        statusName: '220'.tr,
        statusCode: 'PAYMENTINITIATED',
        key: 'pKCURg2ppprYD8VvZMNKbw'),
    ScheduleStatus(
        id: 225,
        statusName: '225'.tr,
        statusCode: 'PAYMENTVERIFIED',
        key: 'IElW5dvfG1gdoAJgU1od7g'),
    ScheduleStatus(
        id: 230,
        statusName: '230'.tr,
        statusCode: 'PAYMENTCREDITED',
        key: 'PYQhaxKShIIzPaf6AV6WHg'),
  ].obs;

  // Method to update the list with translations
  void updateStatuses() {
    statuses.value = [
      ScheduleStatus(
          id: 110,
          statusName: '110'.tr,
          statusCode: 'REQUESTPLACED',
          key: '-jSES9ke919OHB8RA0ZfgQ'),
      ScheduleStatus(
          id: 120,
          statusName: '120'.tr,
          statusCode: 'APPROVED',
          key: 'EhUCqPfug8PFU5mCV6VDvw'),
      ScheduleStatus(
          id: 130,
          statusName: '130'.tr,
          statusCode: 'REJECTED',
          key: 'JcvSETxV9pS_I_g2JY6How'),
      ScheduleStatus(
          id: 140,
          statusName: '140'.tr,
          statusCode: 'WAREHOUSEASSIGNED',
          key: 'GblDytgRjF7x0DqhpH5bjQ'),
      ScheduleStatus(
          id: 150,
          statusName: '150'.tr,
          statusCode: 'DRIVERASSIGNED',
          key: '5lJCvuxMNKyMXs_SY560Xg'),
      ScheduleStatus(
          id: 160,
          statusName: '160'.tr,
          statusCode: 'PICKUPSTARTED',
          key: 'Biatz6hHZSFicqinpOEKvg'),
      ScheduleStatus(
          id: 170,
          statusName: '170'.tr,
          statusCode: 'PICKUPINPROGRESS',
          key: 'i2sHy2HbXh4nSHLVUCaszA'),
      ScheduleStatus(
          id: 175,
          statusName: '175'.tr,
          statusCode: 'OILCOLLECTED',
          key: 'bevfVMUfaejDBrm4qMyv1w'),
      ScheduleStatus(
          id: 180,
          statusName: '180'.tr,
          statusCode: 'PICKUPCOMPLETED',
          key: 'jzuVOcIc8p8c6HFdTistUg'),
      ScheduleStatus(
          id: 190,
          statusName: '190'.tr,
          statusCode: 'CANCELLED',
          key: 'JFkBOErtg8XMaVNrX_1urA'),
      ScheduleStatus(
          id: 200,
          statusName: '200'.tr,
          statusCode: 'ARRIVEDATWAREHOUSE',
          key: 'tYB8kXEyme0leTHlPi-p0A'),
      ScheduleStatus(
          id: 210,
          statusName: '210'.tr,
          statusCode: 'DELIVEREDATWAREHOUSE',
          key: 'k0cJXr52om9jM7Bu6-zD7A'),
      ScheduleStatus(
          id: 220,
          statusName: '220'.tr,
          statusCode: 'PAYMENTINITIATED',
          key: 'pKCURg2ppprYD8VvZMNKbw'),
      ScheduleStatus(
          id: 225,
          statusName: '225'.tr,
          statusCode: 'PAYMENTVERIFIED',
          key: 'IElW5dvfG1gdoAJgU1od7g'),
      ScheduleStatus(
          id: 230,
          statusName: '230'.tr,
          statusCode: 'PAYMENTCREDITED',
          key: 'PYQhaxKShIIzPaf6AV6WHg'),
    ];

    ItineraryRouteStatusData.value = [
      ItineraryRouteStatus(
          id: 710,
          statusName: '710'.tr,
          statusCode: 'DRIVERASSIGNED',
          key: '8prQ5Bo8zmboVlcqM9zrww'),
      ItineraryRouteStatus(
          id: 720,
          statusName: '720'.tr,
          statusCode: 'PICKUPSTARTED',
          key: 'YDph5nBGcDJZDdrlQjBjQg'),
      ItineraryRouteStatus(
          id: 730,
          statusName: '730'.tr,
          statusCode: 'PICKUPINPROGRESS',
          key: 'iV2vw8M5G5idtAjTrpiUCQ'),
      ItineraryRouteStatus(
          id: 740,
          statusName: '740'.tr,
          statusCode: 'ARRIVED',
          key: 'sCQWRaXdqeLNuduMRJqG3w'),
      ItineraryRouteStatus(
          id: 750,
          statusName: '750'.tr,
          statusCode: 'OILCOLLECTED',
          key: '2w3we-IryZHCpJzOB2rXuQ'),
      ItineraryRouteStatus(
          id: 770,
          statusName: '770'.tr,
          statusCode: 'PICKUPCOMPLETED',
          key: 'aKY_RO_kHMWg6CE1lZ3Mng'),
      ItineraryRouteStatus(
          id: 780,
          statusName: '780'.tr,
          statusCode: 'CANCELLED',
          key: 'Lo0Rfv16Xu-g3fw4zxtDDA'),
    ];

    itineraryStatusData.value = [
      ItineraryStatus(
          id: 510,
          statusName: '510'.tr,
          statusCode: 'ITINERARYCREATED',
          key: '2lUH-l8qYxZxhRSKpXgTpg'),
      ItineraryStatus(
          id: 520,
          statusName: '520'.tr,
          statusCode: 'DRIVERASSIGNED',
          key: 's9ho8sEa__y2S6aKWSV5dQ'),
      ItineraryStatus(
          id: 530,
          statusName: '530'.tr,
          statusCode: 'DRIVERACCEPTED',
          key: 'LgCxfRGKAhSdGU_49DiGYg'),
      ItineraryStatus(
          id: 540,
          statusName: '540'.tr,
          statusCode: 'DRIVERREJECTED',
          key: '_y7ozPnCjOqYwA1_Vq7M_g'),
      ItineraryStatus(
          id: 550,
          statusName: '550'.tr,
          statusCode: 'ITINERARYSTARTED',
          key: 'byd64C9s5BLfiNd2PwXt6A'),
      ItineraryStatus(
          id: 560,
          statusName: '560'.tr,
          statusCode: 'ARRIVEDATWAREHOUSE',
          key: 'raVcA7c9jlzYC6iMjqIYyw'),
      ItineraryStatus(
          id: 570,
          statusName: '570'.tr,
          statusCode: 'DELIVEREDATWAREHOUSE',
          key: 'P7Li37GQ1zLASRxy6EC2DA'),
      ItineraryStatus(
          id: 580,
          statusName: '580'.tr,
          statusCode: 'CANCELLED',
          key: 'oE-jRo5to_jYACgRwmSF7Q'),
      ItineraryStatus(
          id: 563,
          statusName: '563'.tr,
          statusCode: 'PENDINGINVESTICATION',
          key: 'N4Z1TXrrU2qf6efCbKztKQ'),
      ItineraryStatus(
          id: 566,
          statusName: '566'.tr,
          statusCode: 'PENDINGVERIFICATION',
          key: '-f-jiAUjKG80nrl7pbyQBA'),
      ItineraryStatus(
          id: 568,
          statusName: '568'.tr,
          statusCode: 'VERIFIEDANDVALIDATED',
          key: 'efhmo40gFGG8HaA-ZOVhLg'),
    ];

    ItineraryRouteWHStatus.value = [
      ItineraryWHStatus(
          id: 1020, statusName: '1020'.tr, statusCode: 'SCHEDULEDFORPICKUP'),
      ItineraryWHStatus(
          id: 1030, statusName: '1030'.tr, statusCode: 'OILCOLLECTED'),
      ItineraryWHStatus(
          id: 1040, statusName: '1040'.tr, statusCode: 'INTRANSITTOWAREHOUSE'),
      ItineraryWHStatus(
          id: 1050, statusName: '1050'.tr, statusCode: 'CHECKEDIN'),
      ItineraryWHStatus(
          id: 1060, statusName: '1060'.tr, statusCode: 'VERIFIEDANDVALIDATED'),
      ItineraryWHStatus(
          id: 1070, statusName: '1070'.tr, statusCode: 'STOREDINWAREHOUSE'),
      ItineraryWHStatus(
          id: 1080, statusName: '1080'.tr, statusCode: 'CANCELLED'),
    ];

    compliantStatusCode.value = [
      CompliantStatusCode(id: 1505, code: "ISSUERAISED", name: '1505'.tr),
      CompliantStatusCode(id: 1510, code: "ISSUERESOLVED", name: '1510'.tr),
      CompliantStatusCode(id: 1513, code: "ISSUEREOPENED", name: '1513'.tr),
      CompliantStatusCode(id: 1515, code: "ISSUECLOSED", name: '1515'.tr),
      CompliantStatusCode(id: 1520, code: "ISSUECANCELLED", name: '1520'.tr),
    ];

    update();
  }

  ScheduleStatus? fetchStatusNameByCode(String code) {
    return statuses.firstWhere(
      (scheduleType) => scheduleType.statusCode == code,
      orElse: () => ScheduleStatus(
          id: 0,
          statusName: 'Unknown',
          statusCode: 'Unknown',
          key: 'Unknown'), // Use null for no match
    );
  }

  var ItineraryRouteStatusData = <ItineraryRouteStatus>[
    ItineraryRouteStatus(
        id: 710,
        statusName: '710'.tr,
        statusCode: 'DRIVERASSIGNED',
        key: '8prQ5Bo8zmboVlcqM9zrww'),
    ItineraryRouteStatus(
        id: 720,
        statusName: '720'.tr,
        statusCode: 'PICKUPSTARTED',
        key: 'YDph5nBGcDJZDdrlQjBjQg'),
    ItineraryRouteStatus(
        id: 730,
        statusName: '730'.tr,
        statusCode: 'PICKUPINPROGRESS',
        key: 'iV2vw8M5G5idtAjTrpiUCQ'),
    ItineraryRouteStatus(
        id: 740,
        statusName: '740'.tr,
        statusCode: 'ARRIVED',
        key: 'sCQWRaXdqeLNuduMRJqG3w'),
    ItineraryRouteStatus(
        id: 750,
        statusName: '750'.tr,
        statusCode: 'OILCOLLECTED',
        key: '2w3we-IryZHCpJzOB2rXuQ'),
    ItineraryRouteStatus(
        id: 770,
        statusName: '770'.tr,
        statusCode: 'PICKUPCOMPLETED',
        key: 'aKY_RO_kHMWg6CE1lZ3Mng'),
    ItineraryRouteStatus(
        id: 780,
        statusName: '780'.tr,
        statusCode: 'CANCELLED',
        key: 'Lo0Rfv16Xu-g3fw4zxtDDA'),
  ].obs;

  ItineraryRouteStatus fetchItineraryStatusNameById(String statusCode) {
    return ItineraryRouteStatusData.firstWhere(
      (itneraryStatus) => itneraryStatus.statusCode == statusCode,
      orElse: () => ItineraryRouteStatus(
          id: 0,
          statusName: 'Unknown',
          statusCode: 'Unknown',
          key: 'Unknown'), // Use null for no match
    );
  }

  var itineraryStatusData = <ItineraryStatus>[
    ItineraryStatus(
        id: 510,
        statusName: '510'.tr,
        statusCode: 'ITINERARYCREATED',
        key: '2lUH-l8qYxZxhRSKpXgTpg'),
    ItineraryStatus(
        id: 520,
        statusName: '520'.tr,
        statusCode: 'DRIVERASSIGNED',
        key: 's9ho8sEa__y2S6aKWSV5dQ'),
    ItineraryStatus(
        id: 530,
        statusName: '530'.tr,
        statusCode: 'DRIVERACCEPTED',
        key: 'LgCxfRGKAhSdGU_49DiGYg'),
    ItineraryStatus(
        id: 540,
        statusName: '540'.tr,
        statusCode: 'DRIVERREJECTED',
        key: '_y7ozPnCjOqYwA1_Vq7M_g'),
    ItineraryStatus(
        id: 550,
        statusName: '550'.tr,
        statusCode: 'ITINERARYSTARTED',
        key: 'byd64C9s5BLfiNd2PwXt6A'),
    ItineraryStatus(
        id: 560,
        statusName: '560'.tr,
        statusCode: 'ARRIVEDATWAREHOUSE',
        key: 'raVcA7c9jlzYC6iMjqIYyw'),
    ItineraryStatus(
        id: 570,
        statusName: '570'.tr,
        statusCode: 'DELIVEREDATWAREHOUSE',
        key: 'P7Li37GQ1zLASRxy6EC2DA'),
    ItineraryStatus(
        id: 580,
        statusName: '580'.tr,
        statusCode: 'CANCELLED',
        key: 'oE-jRo5to_jYACgRwmSF7Q'),
    ItineraryStatus(
        id: 563,
        statusName: '563'.tr,
        statusCode: 'PENDINGINVESTIGATION',
        key: 'N4Z1TXrrU2qf6efCbKztKQ'),
    ItineraryStatus(
        id: 566,
        statusName: '566'.tr,
        statusCode: 'PENDINGVERIFICATION',
        key: '-f-jiAUjKG80nrl7pbyQBA'),
    ItineraryStatus(
        id: 568,
        statusName: '568'.tr,
        statusCode: 'VERIFIEDANDVALIDATED',
        key: 'efhmo40gFGG8HaA-ZOVhLg'),
  ].obs;

  ItineraryStatus fetchItineraryStatusByName(String statusCode) {
    return itineraryStatusData.firstWhere(
      (itineraryStatusType) => itineraryStatusType.statusCode == statusCode,
      orElse: () => ItineraryStatus(
        id: 0,
        statusName: 'Unknown',
        statusCode: 'Unknown',
        key: 'Unknown',
      ), // Use null for no match
    );
  }

  var ItineraryRouteWHStatus = <ItineraryWHStatus>[
    ItineraryWHStatus(
        id: 1020, statusName: '1020'.tr, statusCode: 'SCHEDULEDFORPICKUP'),
    ItineraryWHStatus(
        id: 1030, statusName: '1030'.tr, statusCode: 'OILCOLLECTED'),
    ItineraryWHStatus(
        id: 1040, statusName: '1040'.tr, statusCode: 'INTRANSITTOWAREHOUSE'),
    ItineraryWHStatus(id: 1050, statusName: '1050'.tr, statusCode: 'CHECKEDIN'),
    ItineraryWHStatus(
        id: 1060, statusName: '1060'.tr, statusCode: 'VERIFIEDANDVALIDATED'),
    ItineraryWHStatus(
        id: 1070, statusName: '1070'.tr, statusCode: 'STOREDINWAREHOUSE'),
    ItineraryWHStatus(id: 1080, statusName: '1080'.tr, statusCode: 'CANCELLED'),
  ].obs;

  ItineraryWHStatus fetchItineraryRouteWHStatusNameById(String code) {
    return ItineraryRouteWHStatus.firstWhere(
      (itneraryStatus) => itneraryStatus.statusCode == code,
      orElse: () => ItineraryWHStatus(
          id: 0,
          statusName: 'Unknown',
          statusCode: 'Unknown'), // Use null for no match
    );
  }

  var compliantStatusCode = <CompliantStatusCode>[
    CompliantStatusCode(id: 1505, code: "ISSUERAISED", name: '1505'.tr),
    CompliantStatusCode(id: 1510, code: "ISSUERESOLVED", name: '1510'.tr),
    CompliantStatusCode(id: 1513, code: "ISSUEREOPENED", name: '1513'.tr),
    CompliantStatusCode(id: 1515, code: "ISSUECLOSED", name: '1515'.tr),
    CompliantStatusCode(id: 1520, code: "ISSUECANCELLED", name: '1520'.tr),
  ].obs;

  String fetchCompliantName(String code) {
    if (code == "") {
      return "";
    }
    return compliantStatusCode
        .firstWhere(
          (compliantStatus) => compliantStatus.code == code,
        )
        .name;
  }
}

class UcoStatus {
  final int id;
  final String statusName;
  final String statusCode;

  UcoStatus({
    required this.id,
    required this.statusName,
    required this.statusCode,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['statusName'] = this.statusName;
    data['statusCode'] = this.statusCode;
    return data;
  }
}

final List<UcoStatus> ucoStatusData = [
  UcoStatus(
      id: 20,
      statusName: 'Scheduled For Pickup',
      statusCode: 'SCHEDULEDFORPICKUP'),
  UcoStatus(id: 30, statusName: 'Oil Collected', statusCode: 'OILCOLLECTED'),
  UcoStatus(
      id: 40,
      statusName: 'InTransit To Warehouse',
      statusCode: 'INTRANSITTOWAREHOUSE'),
  UcoStatus(id: 50, statusName: 'Checked In', statusCode: 'CHECKEDIN'),
  UcoStatus(
      id: 60,
      statusName: 'Verified And Validated',
      statusCode: 'VERIFIEDANDVALIDATED'),
  UcoStatus(
      id: 70,
      statusName: 'Stored In Warehouse',
      statusCode: 'STOREDINWAREHOUSE'),
  UcoStatus(id: 80, statusName: 'Cancelled', statusCode: 'CANCELLED'),
];

class ItineraryStatus {
  final int id;
  final String statusName;
  final String statusCode;
  final String key;

  ItineraryStatus({
    required this.id,
    required this.statusName,
    required this.statusCode,
    required this.key,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['statusName'] = this.statusName;
    data['statusCode'] = this.statusCode;
    data['key'] = this.key;
    return data;
  }
}

class CancellationReason {
  final int id;
  final String statusName;
  final String statusCode;
  final String key;

  CancellationReason({
    required this.id,
    required this.statusName,
    required this.statusCode,
    required this.key,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['statusName'] = this.statusName;
    data['statusCode'] = this.statusCode;
    data['key'] = this.key;
    return data;
  }
}

final List<CancellationReason> cancellationStatusData = [
  CancellationReason(
      id: 147001,
      statusName: '147001'.tr,
      statusCode: 'ITINERARYREASONFORCANCELLATION',
      key: 'UcEmUNf2IGeWxMjdfuoiBw'),
  CancellationReason(
    id: 147002,
    statusName: '147002'.tr,
    statusCode: 'ITINERARYREASONFORCANCELLATION',
    key: '1HnWhFMBDJ5DeLcJI538NQ',
  ),
  CancellationReason(
    id: 147003,
    statusName: '147003'.tr,
    statusCode: 'ITINERARYREASONFORCANCELLATION',
    key: 'A3XkuQJk1MXrMTAdF6KrdA',
  ),
  CancellationReason(
      id: 147004,
      statusName: '147004'.tr,
      statusCode: 'ITINERARYREASONFORCANCELLATION',
      key: 'zFle8V07EjdI-NyNR6zsVA'),
  CancellationReason(
      id: 147005,
      statusName: '147005'.tr,
      statusCode: 'ITINERARYREASONFORCANCELLATION',
      key: '4P6gKoIO1H8QOSBXUnnj2A'),
  CancellationReason(
    id: 147006,
    statusName: '147006'.tr,
    statusCode: 'ITINERARYREASONFORCANCELLATION',
    key: 'OooJTWuJmp9y5vTp5GBdpQ',
  ),
];

class ItineraryRouteStatus {
  final int id;
  final String statusName;
  final String statusCode;
  final String key;

  ItineraryRouteStatus({
    required this.id,
    required this.statusName,
    required this.statusCode,
    required this.key,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['statusName'] = this.statusName;
    data['statusCode'] = this.statusCode;
    data['key'] = this.key;
    return data;
  }
}

class ItineraryWHStatus {
  final int id;
  final String statusName;
  final String statusCode;

  ItineraryWHStatus({
    required this.id,
    required this.statusName,
    required this.statusCode,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['statusName'] = this.statusName;
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class PaymentType {
  final int id;
  final String modeName;
  final String key;

  PaymentType({
    required this.id,
    required this.modeName,
    required this.key,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['modeName'] = this.modeName;
    return data;
  }
}

final List<AccountType> accountTypes = [
  AccountType(
      id: 100001,
      type: "100001".tr,
      code: 'etxNPB9RU8TyLKZhpkXiQA',
      name: 'Supplier'),
  AccountType(
      id: 100002,
      type: "100002".tr,
      code: '_VBYId30VUodY696Vx3TwQ',
      name: 'Driver'),
  AccountType(
      id: 100003,
      type: "100003".tr,
      code: 'BGpNC6WCaGHIyJP7C37uAA',
      name: 'WH Worker'),
  AccountType(
      id: 100004,
      type: "100004".tr,
      code: 'T9fKzcalphOzs3I5PReSeg',
      name: 'Admin'),
];

final List<NotificationType> notificationTypes = [
  NotificationType(id: 101001, type: "101001".tr),
  NotificationType(id: 101002, type: "101002".tr),
];

final List<UserType> userTypes = [
  UserType(
      id: 102001,
      type: "102001".tr,
      code: '6tfNbwAW9LPEqHBsxtrt5A',
      name: 'Supplier'),
  UserType(
      id: 102002,
      type: "102002".tr,
      code: 'K7F2YMR5jyIqr3ZS81DjjA',
      name: 'Driver'),
  UserType(
      id: 102003,
      type: "102003".tr,
      code: 'wdEVDlfdnBLZuQQHJODdzQ',
      name: 'WH Worker'),
  UserType(
      id: 102004,
      type: "102004".tr,
      code: 'jRRZh48A88c2rciAEznXFg',
      name: 'Admin'),
  UserType(
      id: 102005,
      type: "102005".tr,
      code: 'qbP0zT8eYDfVwEPtRzBQcQ',
      name: 'Sub Admin'),
];

final List<RecurringType> recurringTypes = [
  RecurringType(id: 103001, type: "103001".tr, code: "08RSIBjzv03LQ3MqKqICtA"),
  RecurringType(id: 103002, type: "103002".tr, code: "Xq_1Y850wY2QFwCYE_fpAw"),
  RecurringType(id: 103003, type: "103003".tr, code: "4TPGv6VKSUQKL4ANXgg_Kg"),
];

final List<weekDaysType> weekTypes = [
  weekDaysType(id: 1, type: "1".tr),
  weekDaysType(id: 2, type: "2".tr),
  weekDaysType(id: 3, type: "3".tr),
  weekDaysType(id: 4, type: "4".tr),
  weekDaysType(id: 5, type: "5".tr),
  weekDaysType(id: 6, type: "6".tr),
  weekDaysType(id: 7, type: "7".tr),
];

final List<ScheduleType> scheduleTypes = [
  ScheduleType(id: 106001, type: "106001".tr, code: "pBm0LfbzoFUJejcA2dLeaQ"),
  ScheduleType(id: 106002, type: "106002".tr, code: "Gog9mKQ4gtesZsgsEGB3LQ"),
];

// PICKUP: 'pBm0LfbzoFUJejcA2dLeaQ', //106001
//       DROPOFF: 'Gog9mKQ4gtesZsgsEGB3LQ', //106002

final List<GradeType> gradeTypes = [
  GradeType(
      id: 108001, type: "Grade A", name: 'A', key: 'u_5o1pOVY37dfz6EgZNsaQ'),
  // GradeType(id: 108002, type: "Grade B", name: 'B', key: 'HiM6MEP185dT6I8Goh4XSg'),
  // GradeType(id: 108003, type: "Grade C", name: 'C', key: 'p8Qyqi2RKoxqKqfktQt0Vw'),
];

final List<RouteLocationType> routeLocationTypes = [
  RouteLocationType(id: 111001, type: "111001".tr),
  RouteLocationType(id: 111002, type: "111002".tr),
  RouteLocationType(id: 111003, type: "111003".tr),
];

final List<StartingLocationType> startingLocationTypes = [
  StartingLocationType(id: 112001, type: "112001".tr),
  StartingLocationType(id: 112002, type: "112002".tr),
];

final List<EmailType> emailTypes = [
  EmailType(id: 114001, type: "114001".tr),
  EmailType(id: 114002, type: "114002".tr),
  EmailType(id: 114003, type: "114003".tr),
  EmailType(id: 114004, type: "114004".tr),
];

final List<PushType> pushTypes = [
  PushType(id: 115001, type: "115001".tr),
  PushType(id: 115002, type: "115002".tr),
  PushType(id: 115003, type: "115003".tr),
  PushType(id: 115004, type: "115004".tr),
];

final List<Establishment> establishments = [
  Establishment(
      id: 118001, code: 118, type: 'ESTABLISHMENTTYPE', name: '118001'.tr),
  Establishment(
      id: 118002, code: 119, type: 'ESTABLISHMENTTYPE', name: '118001'.tr),
  Establishment(
      id: 118003, code: 120, type: 'ESTABLISHMENTTYPE', name: '118001'.tr),
];

final List<PaymentType> paymentMode = [
  PaymentType(id: 146001, modeName: '146001'.tr, key: 'Aldp8k-mQy1tCoeUVO0IdA'),
  PaymentType(id: 146002, modeName: '146002'.tr, key: 'u_xy0apZ_yaLp8c6rkx7eg'),
  PaymentType(id: 146003, modeName: '146003'.tr, key: 'EvEALALS-b2R43Zn7j3QNw'),
  PaymentType(id: 146004, modeName: '146004'.tr, key: 'uU757kOW4vsZZL6EfFS8KA'),
];

Establishment? fetchEstablishmentByName(String name) {
  return establishments.firstWhere(
    (establishment) => establishment.name.toLowerCase() == name.toLowerCase(),
    // orElse: () => null, // Use null for no match
  );
}

UserType? fetchUserType(int id) {
  return userTypes.firstWhere(
    (user) => user.id == id,
    // orElse: () => null, // Use null for no match
  );
}

AccountType? fetchAccountType(int id) {
  return accountTypes.firstWhere(
    (account) => account.id == id,
    // orElse: () => null, // Use null for no match
  );
}

RecurringType? fetchRecurringTypeByName(String name) {
  return recurringTypes.firstWhere(
    (recurringData) => recurringData.type.toLowerCase() == name.toLowerCase(),
    // orElse: () => null, // Use null for no match
  );
}

weekDaysType? fetchWeekTypeByName(String name) {
  return weekTypes.firstWhere(
    (weekTypeData) => weekTypeData.type.toLowerCase() == name.toLowerCase(),
    orElse: () => weekDaysType(id: 0, type: ''), // Use null for no match
  );
}

ScheduleType? fetchScheduleTypeById(String code) {
  return scheduleTypes.firstWhere(
    (scheduleType) => scheduleType.code == code,
    orElse: () =>
        ScheduleType(id: 0, type: 'Unknown', code: ''), // Use null for no match
  );
}

PaymentType? fetchByPaymentId(int id) {
  return paymentMode.firstWhere(
    (payment) => payment.id == id,
    orElse: () => PaymentType(
        id: 0, modeName: 'Unknown', key: 'Unknown'), // Use null for no match
  );
}

GradeType? fetchGrades(String id) {
  return gradeTypes.firstWhere(
    (gradeTypesData) => gradeTypesData.key == id,
    orElse: () => GradeType(
        id: 0,
        type: 'unknown',
        name: 'unknown',
        key: 'unknown'), // Use null for no match
  );
}
