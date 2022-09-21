class ResponseSearchedTicketListFareDataFlightItemListSegment {
/*
{
  "id": 0,
  "airline": "QH",
  "operating": "QH",
  "startPoint": "HAN",
  "endPoint": "DIN",
  "startTime": "2022-08-26T13:20:00",
  "startTimeZoneOffset": "GMT+07:00",
  "endTime": "2022-08-26T14:20:00",
  "endTimeZoneOffset": "GMT+07:00",
  "flightNumber": "QH1692",
  "plane": "Embraer E90",
  "duration": 60,
  "class": "ECONOMYSAVER",
  "startTerminal": "T1",
  "endTerminal": "T2",
  "hasStop": false,
  "stopPoint": null,
  "stopTime": 0,
  "dayChange": false,
  "stopOvernight": false,
  "changeStation": false,
  "changeAirport": false,
  "lastItem": null,
  "handBaggage": "07 kg",
  "allowanceBaggage": "20 kg"
}
*/

  int? id;
  String? airline;
  String? operating;
  String? startPoint;
  String? endPoint;
  String? startTime;
  String? startTimeZoneOffset;
  String? endTime;
  String? endTimeZoneOffset;
  String? flightNumber;
  String? plane;
  int? duration;
  String? theClass;
  // dynamic? startTerminal;
  // dynamic? endTerminal;
  bool? hasStop;
  String? stopPoint;
  int? stopTime;
  bool? dayChange;
  bool? stopOvernight;
  bool? changeStation;
  bool? changeAirport;
  String? lastItem;
  String? handBaggage;
  String? allowanceBaggage;

  ResponseSearchedTicketListFareDataFlightItemListSegment({
    this.id,
    this.airline,
    this.operating,
    this.startPoint,
    this.endPoint,
    this.startTime,
    this.startTimeZoneOffset,
    this.endTime,
    this.endTimeZoneOffset,
    this.flightNumber,
    this.plane,
    this.duration,
    this.theClass,
    // this.startTerminal,
    // this.endTerminal,
    this.hasStop,
    this.stopPoint,
    this.stopTime,
    this.dayChange,
    this.stopOvernight,
    this.changeStation,
    this.changeAirport,
    this.lastItem,
    this.handBaggage,
    this.allowanceBaggage,
  });
  ResponseSearchedTicketListFareDataFlightItemListSegment.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    airline = json['airline']?.toString();
    operating = json['operating']?.toString();
    startPoint = json['startPoint']?.toString();
    endPoint = json['endPoint']?.toString();
    startTime = json['startTime']?.toString();
    startTimeZoneOffset = json['startTimeZoneOffset']?.toString();
    endTime = json['endTime']?.toString();
    endTimeZoneOffset = json['endTimeZoneOffset']?.toString();
    flightNumber = json['flightNumber']?.toString();
    plane = json['plane']?.toString();
    duration = json['duration']?.toInt();
    theClass = json['class']?.toString();
    // startTerminal = json['startTerminal']?.toString();
    // endTerminal = json['endTerminal']?.toString();
    hasStop = json['hasStop'];
    stopPoint = json['stopPoint']?.toString();
    stopTime = json['stopTime']?.toInt();
    dayChange = json['dayChange'];
    stopOvernight = json['stopOvernight'];
    changeStation = json['changeStation'];
    changeAirport = json['changeAirport'];
    lastItem = json['lastItem']?.toString();
    handBaggage = json['handBaggage']?.toString();
    allowanceBaggage = json['allowanceBaggage']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['airline'] = airline;
    data['operating'] = operating;
    data['startPoint'] = startPoint;
    data['endPoint'] = endPoint;
    data['startTime'] = startTime;
    data['startTimeZoneOffset'] = startTimeZoneOffset;
    data['endTime'] = endTime;
    data['endTimeZoneOffset'] = endTimeZoneOffset;
    data['flightNumber'] = flightNumber;
    data['plane'] = plane;
    data['duration'] = duration;
    data['class'] = theClass;
    // data['startTerminal'] = startTerminal;
    // data['endTerminal'] = endTerminal;
    data['hasStop'] = hasStop;
    data['stopPoint'] = stopPoint;
    data['stopTime'] = stopTime;
    data['dayChange'] = dayChange;
    data['stopOvernight'] = stopOvernight;
    data['changeStation'] = changeStation;
    data['changeAirport'] = changeAirport;
    data['lastItem'] = lastItem;
    data['handBaggage'] = handBaggage;
    data['allowanceBaggage'] = allowanceBaggage;
    return data;
  }
}

class ResponseSearchedTicketListFareDataFlightItem {
/*
{
  "flightId": 0,
  "leg": 0,
  "airline": "QH",
  "operating": "QH",
  "startPoint": "HAN",
  "endPoint": "DIN",
  "startDate": "2022-08-26T13:20:00",
  "startTimeZoneOffset": "GMT+07:00",
  "endDate": "2022-08-26T14:20:00",
  "endTimeZoneOffset": "GMT+07:00",
  "flightNumber": "QH1692",
  "stopNum": 0,
  "hasDownStop": false,
  "duration": 60,
  "noRefund": false,
  "groupClass": "ECONOMY",
  "fareClass": "ECONOMYSAVER",
  "promo": false,
  "flightValue": "QH1692|ECONOMYSAVER|HAN-DIN|20220826062000-20220826072000;ADDON_QH1;ADT_1",
  "listSegment": [
    {
      "id": 0,
      "airline": "QH",
      "operating": "QH",
      "startPoint": "HAN",
      "endPoint": "DIN",
      "startTime": "2022-08-26T13:20:00",
      "startTimeZoneOffset": "GMT+07:00",
      "endTime": "2022-08-26T14:20:00",
      "endTimeZoneOffset": "GMT+07:00",
      "flightNumber": "QH1692",
      "plane": "Embraer E90",
      "duration": 60,
      "class": "ECONOMYSAVER",
      "startTerminal": "T1",
      "endTerminal": "T2",
      "hasStop": false,
      "stopPoint": null,
      "stopTime": 0,
      "dayChange": false,
      "stopOvernight": false,
      "changeStation": false,
      "changeAirport": false,
      "lastItem": null,
      "handBaggage": "07 kg",
      "allowanceBaggage": "20 kg"
    }
  ],
  "provider": "QH",
  "session": "1660839515725"
}
*/

  int? flightId;
  int? leg;
  String? airline;
  String? operating;
  String? startPoint;
  String? endPoint;
  String? startDate;
  String? startTimeZoneOffset;
  String? endDate;
  String? endTimeZoneOffset;
  String? flightNumber;
  int? stopNum;
  bool? hasDownStop;
  int? duration;
  bool? noRefund;
  String? groupClass;
  String? fareClass;
  bool? promo;
  String? flightValue;
  List<ResponseSearchedTicketListFareDataFlightItemListSegment?>? listSegment;
  String? provider;
  String? session;

  ResponseSearchedTicketListFareDataFlightItem({
    this.flightId,
    this.leg,
    this.airline,
    this.operating,
    this.startPoint,
    this.endPoint,
    this.startDate,
    this.startTimeZoneOffset,
    this.endDate,
    this.endTimeZoneOffset,
    this.flightNumber,
    this.stopNum,
    this.hasDownStop,
    this.duration,
    this.noRefund,
    this.groupClass,
    this.fareClass,
    this.promo,
    this.flightValue,
    this.listSegment,
    this.provider,
    this.session,
  });
  ResponseSearchedTicketListFareDataFlightItem.fromJson(Map<String, dynamic> json) {
    flightId = json['flightId']?.toInt();
    leg = json['leg']?.toInt();
    airline = json['airline']?.toString();
    operating = json['operating']?.toString();
    startPoint = json['startPoint']?.toString();
    endPoint = json['endPoint']?.toString();
    startDate = json['startDate']?.toString();
    startTimeZoneOffset = json['startTimeZoneOffset']?.toString();
    endDate = json['endDate']?.toString();
    endTimeZoneOffset = json['endTimeZoneOffset']?.toString();
    flightNumber = json['flightNumber']?.toString();
    stopNum = json['stopNum']?.toInt();
    hasDownStop = json['hasDownStop'];
    duration = json['duration']?.toInt();
    noRefund = json['noRefund'];
    groupClass = json['groupClass']?.toString();
    fareClass = json['fareClass']?.toString();
    promo = json['promo'];
    flightValue = json['flightValue']?.toString();
    if (json['listSegment'] != null) {
      final v = json['listSegment'];
      final arr0 = <ResponseSearchedTicketListFareDataFlightItemListSegment>[];
      v.forEach((v) {
        arr0.add(ResponseSearchedTicketListFareDataFlightItemListSegment.fromJson(v));
      });
      listSegment = arr0;
    }
    provider = json['provider']?.toString();
    session = json['session']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['flightId'] = flightId;
    data['leg'] = leg;
    data['airline'] = airline;
    data['operating'] = operating;
    data['startPoint'] = startPoint;
    data['endPoint'] = endPoint;
    data['startDate'] = startDate;
    data['startTimeZoneOffset'] = startTimeZoneOffset;
    data['endDate'] = endDate;
    data['endTimeZoneOffset'] = endTimeZoneOffset;
    data['flightNumber'] = flightNumber;
    data['stopNum'] = stopNum;
    data['hasDownStop'] = hasDownStop;
    data['duration'] = duration;
    data['noRefund'] = noRefund;
    data['groupClass'] = groupClass;
    data['fareClass'] = fareClass;
    data['promo'] = promo;
    data['flightValue'] = flightValue;
    if (listSegment != null) {
      final v = listSegment;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['listSegment'] = arr0;
    }
    data['provider'] = provider;
    data['session'] = session;
    return data;
  }
}

class ResponseSearchedTicketListFareDataListFlightListSegment {
/*
{
  "id": 0,
  "airline": "QH",
  "operating": "QH",
  "startPoint": "HAN",
  "endPoint": "DIN",
  "startTime": "2022-08-26T13:20:00",
  "startTimeZoneOffset": "GMT+07:00",
  "endTime": "2022-08-26T14:20:00",
  "endTimeZoneOffset": "GMT+07:00",
  "flightNumber": "QH1692",
  "plane": "Embraer E90",
  "duration": 60,
  "class": "ECONOMYSAVER",
  "startTerminal": "T1",
  "endTerminal": "T2",
  "hasStop": false,
  "stopPoint": null,
  "stopTime": 0,
  "dayChange": false,
  "stopOvernight": false,
  "changeStation": false,
  "changeAirport": false,
  "lastItem": null,
  "handBaggage": "07 kg",
  "allowanceBaggage": "20 kg"
}
*/

  int? id;
  String? airline;
  String? operating;
  String? startPoint;
  String? endPoint;
  String? startTime;
  String? startTimeZoneOffset;
  String? endTime;
  String? endTimeZoneOffset;
  String? flightNumber;
  String? plane;
  int? duration;
  String? theClass;
  bool? hasStop;
  String? stopPoint;
  int? stopTime;
  bool? dayChange;
  bool? stopOvernight;
  bool? changeStation;
  bool? changeAirport;
  bool? lastItem;
  String? handBaggage;
  String? allowanceBaggage;

  ResponseSearchedTicketListFareDataListFlightListSegment({
    this.id,
    this.airline,
    this.operating,
    this.startPoint,
    this.endPoint,
    this.startTime,
    this.startTimeZoneOffset,
    this.endTime,
    this.endTimeZoneOffset,
    this.flightNumber,
    this.plane,
    this.duration,
    this.theClass,
    this.hasStop,
    this.stopPoint,
    this.stopTime,
    this.dayChange,
    this.stopOvernight,
    this.changeStation,
    this.changeAirport,
    this.lastItem,
    this.handBaggage,
    this.allowanceBaggage,
  });
  ResponseSearchedTicketListFareDataListFlightListSegment.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    airline = json['airline']?.toString();
    operating = json['operating']?.toString();
    startPoint = json['startPoint']?.toString();
    endPoint = json['endPoint']?.toString();
    startTime = json['startTime']?.toString();
    startTimeZoneOffset = json['startTimeZoneOffset']?.toString();
    endTime = json['endTime']?.toString();
    endTimeZoneOffset = json['endTimeZoneOffset']?.toString();
    flightNumber = json['flightNumber']?.toString();
    plane = json['plane']?.toString();
    duration = json['duration']?.toInt();
    theClass = json['class']?.toString();
    // startTerminal = json['startTerminal']?.toString();
    // endTerminal = json['endTerminal']?.toString();
    hasStop = json['hasStop'];
    stopPoint = json['stopPoint']?.toString();
    stopTime = json['stopTime']?.toInt();
    dayChange = json['dayChange'];
    stopOvernight = json['stopOvernight'];
    changeStation = json['changeStation'];
    changeAirport = json['changeAirport'];
    lastItem = json['lastItem'];
    handBaggage = json['handBaggage']?.toString();
    allowanceBaggage = json['allowanceBaggage']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['airline'] = airline;
    data['operating'] = operating;
    data['startPoint'] = startPoint;
    data['endPoint'] = endPoint;
    data['startTime'] = startTime;
    data['startTimeZoneOffset'] = startTimeZoneOffset;
    data['endTime'] = endTime;
    data['endTimeZoneOffset'] = endTimeZoneOffset;
    data['flightNumber'] = flightNumber;
    data['plane'] = plane;
    data['duration'] = duration;
    data['class'] = theClass;
    // data['startTerminal'] = startTerminal;
    // data['endTerminal'] = endTerminal;
    data['hasStop'] = hasStop;
    data['stopPoint'] = stopPoint;
    data['stopTime'] = stopTime;
    data['dayChange'] = dayChange;
    data['stopOvernight'] = stopOvernight;
    data['changeStation'] = changeStation;
    data['changeAirport'] = changeAirport;
    data['lastItem'] = lastItem;
    data['handBaggage'] = handBaggage;
    data['allowanceBaggage'] = allowanceBaggage;
    return data;
  }
}

class ResponseSearchedTicketListFareDataListFlight {
/*
{
  "flightId": 0,
  "leg": 0,
  "airline": "QH",
  "operating": "QH",
  "startPoint": "HAN",
  "endPoint": "DIN",
  "startDate": "2022-08-26T13:20:00",
  "startTimeZoneOffset": "GMT+07:00",
  "endDate": "2022-08-26T14:20:00",
  "endTimeZoneOffset": "GMT+07:00",
  "flightNumber": "QH1692",
  "stopNum": 0,
  "hasDownStop": false,
  "duration": 60,
  "noRefund": false,
  "groupClass": "ECONOMY",
  "fareClass": "ECONOMYSAVER",
  "promo": false,
  "flightValue": "QH1692|ECONOMYSAVER|HAN-DIN|20220826062000-20220826072000;ADDON_QH1;ADT_1",
  "listSegment": [
    {
      "id": 0,
      "airline": "QH",
      "operating": "QH",
      "startPoint": "HAN",
      "endPoint": "DIN",
      "startTime": "2022-08-26T13:20:00",
      "startTimeZoneOffset": "GMT+07:00",
      "endTime": "2022-08-26T14:20:00",
      "endTimeZoneOffset": "GMT+07:00",
      "flightNumber": "QH1692",
      "plane": "Embraer E90",
      "duration": 60,
      "class": "ECONOMYSAVER",
      "startTerminal": "T1",
      "endTerminal": "T2",
      "hasStop": false,
      "stopPoint": null,
      "stopTime": 0,
      "dayChange": false,
      "stopOvernight": false,
      "changeStation": false,
      "changeAirport": false,
      "lastItem": null,
      "handBaggage": "07 kg",
      "allowanceBaggage": "20 kg"
    }
  ],
  "provider": "QH",
  "session": "1660839515725"
}
*/

  int? flightId;
  int? leg;
  String? airline;
  String? operating;
  String? startPoint;
  String? endPoint;
  String? startDate;
  String? startTimeZoneOffset;
  String? endDate;
  String? endTimeZoneOffset;
  String? flightNumber;
  int? stopNum;
  bool? hasDownStop;
  int? duration;
  bool? noRefund;
  String? groupClass;
  String? fareClass;
  bool? promo;
  String? flightValue;
  List<ResponseSearchedTicketListFareDataListFlightListSegment?>? listSegment;
  String? provider;
  String? session;

  ResponseSearchedTicketListFareDataListFlight({
    this.flightId,
    this.leg,
    this.airline,
    this.operating,
    this.startPoint,
    this.endPoint,
    this.startDate,
    this.startTimeZoneOffset,
    this.endDate,
    this.endTimeZoneOffset,
    this.flightNumber,
    this.stopNum,
    this.hasDownStop,
    this.duration,
    this.noRefund,
    this.groupClass,
    this.fareClass,
    this.promo,
    this.flightValue,
    this.listSegment,
    this.provider,
    this.session,
  });
  ResponseSearchedTicketListFareDataListFlight.fromJson(Map<String, dynamic> json) {
    flightId = json['flightId']?.toInt();
    leg = json['leg']?.toInt();
    airline = json['airline']?.toString();
    operating = json['operating']?.toString();
    startPoint = json['startPoint']?.toString();
    endPoint = json['endPoint']?.toString();
    startDate = json['startDate']?.toString();
    startTimeZoneOffset = json['startTimeZoneOffset']?.toString();
    endDate = json['endDate']?.toString();
    endTimeZoneOffset = json['endTimeZoneOffset']?.toString();
    flightNumber = json['flightNumber']?.toString();
    stopNum = json['stopNum']?.toInt();
    hasDownStop = json['hasDownStop'];
    duration = json['duration']?.toInt();
    noRefund = json['noRefund'];
    groupClass = json['groupClass']?.toString();
    fareClass = json['fareClass']?.toString();
    promo = json['promo'];
    flightValue = json['flightValue']?.toString();
    if (json['listSegment'] != null) {
      final v = json['listSegment'];
      final arr0 = <ResponseSearchedTicketListFareDataListFlightListSegment>[];
      v.forEach((v) {
        arr0.add(ResponseSearchedTicketListFareDataListFlightListSegment.fromJson(v));
      });
      listSegment = arr0;
    }
    provider = json['provider']?.toString();
    session = json['session']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['flightId'] = flightId;
    data['leg'] = leg;
    data['airline'] = airline;
    data['operating'] = operating;
    data['startPoint'] = startPoint;
    data['endPoint'] = endPoint;
    data['startDate'] = startDate;
    data['startTimeZoneOffset'] = startTimeZoneOffset;
    data['endDate'] = endDate;
    data['endTimeZoneOffset'] = endTimeZoneOffset;
    data['flightNumber'] = flightNumber;
    data['stopNum'] = stopNum;
    data['hasDownStop'] = hasDownStop;
    data['duration'] = duration;
    data['noRefund'] = noRefund;
    data['groupClass'] = groupClass;
    data['fareClass'] = fareClass;
    data['promo'] = promo;
    data['flightValue'] = flightValue;
    if (listSegment != null) {
      final v = listSegment;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['listSegment'] = arr0;
    }
    data['provider'] = provider;
    data['session'] = session;
    return data;
  }
}

class ResponseSearchedTicketListFareData {
/*
{
  "fareDataId": 0,
  "airline": "QH",
  "itinerary": 1,
  "leg": 0,
  "promo": false,
  "currency": "VND",
  "system": "LCC",
  "adt": 1,
  "chd": 0,
  "inf": 0,
  "fareAdt": 199000,
  "fareChd": 0,
  "fareInf": 0,
  "taxAdt": 170000,
  "taxChd": 0,
  "taxInf": 0,
  "feeAdt": 417000,
  "feeChd": 0,
  "feeInf": 0,
  "serviceFeeAdt": 40000,
  "serviceFeeChd": 40000,
  "serviceFeeInf": 40000,
  "totalNetPrice": 199000,
  "totalServiceFee": 40000,
  "totalPrice": 826000,
  "listFlight": [
    {
      "flightId": 0,
      "leg": 0,
      "airline": "QH",
      "operating": "QH",
      "startPoint": "HAN",
      "endPoint": "DIN",
      "startDate": "2022-08-26T13:20:00",
      "startTimeZoneOffset": "GMT+07:00",
      "endDate": "2022-08-26T14:20:00",
      "endTimeZoneOffset": "GMT+07:00",
      "flightNumber": "QH1692",
      "stopNum": 0,
      "hasDownStop": false,
      "duration": 60,
      "noRefund": false,
      "groupClass": "ECONOMY",
      "fareClass": "ECONOMYSAVER",
      "promo": false,
      "flightValue": "QH1692|ECONOMYSAVER|HAN-DIN|20220826062000-20220826072000;ADDON_QH1;ADT_1",
      "listSegment": [
        {
          "id": 0,
          "airline": "QH",
          "operating": "QH",
          "startPoint": "HAN",
          "endPoint": "DIN",
          "startTime": "2022-08-26T13:20:00",
          "startTimeZoneOffset": "GMT+07:00",
          "endTime": "2022-08-26T14:20:00",
          "endTimeZoneOffset": "GMT+07:00",
          "flightNumber": "QH1692",
          "plane": "Embraer E90",
          "duration": 60,
          "class": "ECONOMYSAVER",
          "startTerminal": "T1",
          "endTerminal": "T2",
          "hasStop": false,
          "stopPoint": null,
          "stopTime": 0,
          "dayChange": false,
          "stopOvernight": false,
          "changeStation": false,
          "changeAirport": false,
          "lastItem": null,
          "handBaggage": "07 kg",
          "allowanceBaggage": "20 kg"
        }
      ],
      "provider": "QH",
      "session": "1660839515725"
    }
  ],
  "mapingSeatClass": "economy",
  "mapingGroupClass": "ECONOMYSAVER",
  "mapingGroupClassEng": "ECONOMYSAVER",
  "extraServiceFees": 40000,
  "comparePrice": 826000,
  "token": "flight_item_480410198304120800",
  "session": "1660839515725",
  "flightItem": {
    "flightId": 0,
    "leg": 0,
    "airline": "QH",
    "operating": "QH",
    "startPoint": "HAN",
    "endPoint": "DIN",
    "startDate": "2022-08-26T13:20:00",
    "startTimeZoneOffset": "GMT+07:00",
    "endDate": "2022-08-26T14:20:00",
    "endTimeZoneOffset": "GMT+07:00",
    "flightNumber": "QH1692",
    "stopNum": 0,
    "hasDownStop": false,
    "duration": 60,
    "noRefund": false,
    "groupClass": "ECONOMY",
    "fareClass": "ECONOMYSAVER",
    "promo": false,
    "flightValue": "QH1692|ECONOMYSAVER|HAN-DIN|20220826062000-20220826072000;ADDON_QH1;ADT_1",
    "listSegment": [
      {
        "id": 0,
        "airline": "QH",
        "operating": "QH",
        "startPoint": "HAN",
        "endPoint": "DIN",
        "startTime": "2022-08-26T13:20:00",
        "startTimeZoneOffset": "GMT+07:00",
        "endTime": "2022-08-26T14:20:00",
        "endTimeZoneOffset": "GMT+07:00",
        "flightNumber": "QH1692",
        "plane": "Embraer E90",
        "duration": 60,
        "class": "ECONOMYSAVER",
        "startTerminal": "T1",
        "endTerminal": "T2",
        "hasStop": false,
        "stopPoint": null,
        "stopTime": 0,
        "dayChange": false,
        "stopOvernight": false,
        "changeStation": false,
        "changeAirport": false,
        "lastItem": null,
        "handBaggage": "07 kg",
        "allowanceBaggage": "20 kg"
      }
    ],
    "provider": "QH",
    "session": "1660839515725"
  },
  "timeRange": "12->18",
  "medianPrice": 1150000,
  "cheapestPrice": 826000,
  "avgPrice": 1646760
}
*/

  int? fareDataId;
  String? airline;
  int? itinerary;
  int? leg;
  bool? promo;
  String? currency;
  // String? system;
  int? adt;
  int? chd;
  int? inf;
  int? fareAdt;
  int? fareChd;
  int? fareInf;
  int? taxAdt;
  int? taxChd;
  int? taxInf;
  int? feeAdt;
  int? feeChd;
  int? feeInf;
  int? serviceFeeAdt;
  int? serviceFeeChd;
  int? serviceFeeInf;
  int? totalNetPrice;
  int? totalServiceFee;
  int? totalPrice;
  List<ResponseSearchedTicketListFareDataListFlight?>? listFlight;
  String? mapingSeatClass;
  String? mapingGroupClass;
  String? mapingGroupClassEng;
  int? extraServiceFees;
  int? comparePrice;
  String? token;
  String? session;
  ResponseSearchedTicketListFareDataFlightItem? flightItem;
  String? timeRange;
  int? medianPrice;
  int? cheapestPrice;
  double? avgPrice;

  ResponseSearchedTicketListFareData({
    this.fareDataId,
    this.airline,
    this.itinerary,
    this.leg,
    this.promo,
    this.currency,
    // this.system,
    this.adt,
    this.chd,
    this.inf,
    this.fareAdt,
    this.fareChd,
    this.fareInf,
    this.taxAdt,
    this.taxChd,
    this.taxInf,
    this.feeAdt,
    this.feeChd,
    this.feeInf,
    this.serviceFeeAdt,
    this.serviceFeeChd,
    this.serviceFeeInf,
    this.totalNetPrice,
    this.totalServiceFee,
    this.totalPrice,
    this.listFlight,
    this.mapingSeatClass,
    this.mapingGroupClass,
    this.mapingGroupClassEng,
    this.extraServiceFees,
    this.comparePrice,
    this.token,
    this.session,
    this.flightItem,
    this.timeRange,
    this.medianPrice,
    this.cheapestPrice,
    this.avgPrice,
  });
  ResponseSearchedTicketListFareData.fromJson(Map<String, dynamic> json) {
    fareDataId = json['fareDataId']?.toInt();
    airline = json['airline']?.toString();
    itinerary = json['itinerary']?.toInt();
    leg = json['leg']?.toInt();
    promo = json['promo'];
    currency = json['currency']?.toString();
    // system = json['system']?.toString();
    adt = json['adt']?.toInt();
    chd = json['chd']?.toInt();
    inf = json['inf']?.toInt();
    fareAdt = json['fareAdt']?.toInt();
    fareChd = json['fareChd']?.toInt();
    fareInf = json['fareInf']?.toInt();
    taxAdt = json['taxAdt']?.toInt();
    taxChd = json['taxChd']?.toInt();
    taxInf = json['taxInf']?.toInt();
    feeAdt = json['feeAdt']?.toInt();
    feeChd = json['feeChd']?.toInt();
    feeInf = json['feeInf']?.toInt();
    serviceFeeAdt = json['serviceFeeAdt']?.toInt();
    serviceFeeChd = json['serviceFeeChd']?.toInt();
    serviceFeeInf = json['serviceFeeInf']?.toInt();
    totalNetPrice = json['totalNetPrice']?.toInt();
    totalServiceFee = json['totalServiceFee']?.toInt();
    totalPrice = json['totalPrice']?.toInt();
    if (json['listFlight'] != null) {
      final v = json['listFlight'];
      final arr0 = <ResponseSearchedTicketListFareDataListFlight>[];
      v.forEach((v) {
        arr0.add(ResponseSearchedTicketListFareDataListFlight.fromJson(v));
      });
      listFlight = arr0;
    }
    mapingSeatClass = json['mapingSeatClass']?.toString();
    mapingGroupClass = json['mapingGroupClass']?.toString();
    mapingGroupClassEng = json['mapingGroupClassEng']?.toString();
    extraServiceFees = json['extraServiceFees']?.toInt();
    comparePrice = json['comparePrice']?.toInt();
    token = json['token']?.toString();
    session = json['session']?.toString();
    flightItem = (json['flightItem'] != null) ? ResponseSearchedTicketListFareDataFlightItem.fromJson(json['flightItem']) : null;
    timeRange = json['timeRange']?.toString();
    medianPrice = json['medianPrice']?.toInt();
    cheapestPrice = json['cheapestPrice']?.toInt();
    avgPrice = json['avgPrice']?.toDouble();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fareDataId'] = fareDataId;
    data['airline'] = airline;
    data['itinerary'] = itinerary;
    data['leg'] = leg;
    data['promo'] = promo;
    data['currency'] = currency;
    // data['system'] = system;
    data['adt'] = adt;
    data['chd'] = chd;
    data['inf'] = inf;
    data['fareAdt'] = fareAdt;
    data['fareChd'] = fareChd;
    data['fareInf'] = fareInf;
    data['taxAdt'] = taxAdt;
    data['taxChd'] = taxChd;
    data['taxInf'] = taxInf;
    data['feeAdt'] = feeAdt;
    data['feeChd'] = feeChd;
    data['feeInf'] = feeInf;
    data['serviceFeeAdt'] = serviceFeeAdt;
    data['serviceFeeChd'] = serviceFeeChd;
    data['serviceFeeInf'] = serviceFeeInf;
    data['totalNetPrice'] = totalNetPrice;
    data['totalServiceFee'] = totalServiceFee;
    data['totalPrice'] = totalPrice;
    if (listFlight != null) {
      final v = listFlight;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['listFlight'] = arr0;
    }
    data['mapingSeatClass'] = mapingSeatClass;
    data['mapingGroupClass'] = mapingGroupClass;
    data['mapingGroupClassEng'] = mapingGroupClassEng;
    data['extraServiceFees'] = extraServiceFees;
    data['comparePrice'] = comparePrice;
    data['token'] = token;
    data['session'] = session;
    if (flightItem != null) {
      data['flightItem'] = flightItem!.toJson();
    }
    data['timeRange'] = timeRange;
    data['medianPrice'] = medianPrice;
    data['cheapestPrice'] = cheapestPrice;
    data['avgPrice'] = avgPrice;
    return data;
  }
}

class ResponseSearchedTicket {
/*
{
  "flightType": "domestic",
  "session": "1660839515725",
  "itinerary": 1,
  "listFareData": [
    {
      "fareDataId": 0,
      "airline": "QH",
      "itinerary": 1,
      "leg": 0,
      "promo": false,
      "currency": "VND",
      "system": "LCC",
      "adt": 1,
      "chd": 0,
      "inf": 0,
      "fareAdt": 199000,
      "fareChd": 0,
      "fareInf": 0,
      "taxAdt": 170000,
      "taxChd": 0,
      "taxInf": 0,
      "feeAdt": 417000,
      "feeChd": 0,
      "feeInf": 0,
      "serviceFeeAdt": 40000,
      "serviceFeeChd": 40000,
      "serviceFeeInf": 40000,
      "totalNetPrice": 199000,
      "totalServiceFee": 40000,
      "totalPrice": 826000,
      "listFlight": [
        {
          "flightId": 0,
          "leg": 0,
          "airline": "QH",
          "operating": "QH",
          "startPoint": "HAN",
          "endPoint": "DIN",
          "startDate": "2022-08-26T13:20:00",
          "startTimeZoneOffset": "GMT+07:00",
          "endDate": "2022-08-26T14:20:00",
          "endTimeZoneOffset": "GMT+07:00",
          "flightNumber": "QH1692",
          "stopNum": 0,
          "hasDownStop": false,
          "duration": 60,
          "noRefund": false,
          "groupClass": "ECONOMY",
          "fareClass": "ECONOMYSAVER",
          "promo": false,
          "flightValue": "QH1692|ECONOMYSAVER|HAN-DIN|20220826062000-20220826072000;ADDON_QH1;ADT_1",
          "listSegment": [
            {
              "id": 0,
              "airline": "QH",
              "operating": "QH",
              "startPoint": "HAN",
              "endPoint": "DIN",
              "startTime": "2022-08-26T13:20:00",
              "startTimeZoneOffset": "GMT+07:00",
              "endTime": "2022-08-26T14:20:00",
              "endTimeZoneOffset": "GMT+07:00",
              "flightNumber": "QH1692",
              "plane": "Embraer E90",
              "duration": 60,
              "class": "ECONOMYSAVER",
              "startTerminal": "T1",
              "endTerminal": "T2",
              "hasStop": false,
              "stopPoint": null,
              "stopTime": 0,
              "dayChange": false,
              "stopOvernight": false,
              "changeStation": false,
              "changeAirport": false,
              "lastItem": null,
              "handBaggage": "07 kg",
              "allowanceBaggage": "20 kg"
            }
          ],
          "provider": "QH",
          "session": "1660839515725"
        }
      ],
      "mapingSeatClass": "economy",
      "mapingGroupClass": "ECONOMYSAVER",
      "mapingGroupClassEng": "ECONOMYSAVER",
      "extraServiceFees": 40000,
      "comparePrice": 826000,
      "token": "flight_item_480410198304120800",
      "session": "1660839515725",
      "flightItem": {
        "flightId": 0,
        "leg": 0,
        "airline": "QH",
        "operating": "QH",
        "startPoint": "HAN",
        "endPoint": "DIN",
        "startDate": "2022-08-26T13:20:00",
        "startTimeZoneOffset": "GMT+07:00",
        "endDate": "2022-08-26T14:20:00",
        "endTimeZoneOffset": "GMT+07:00",
        "flightNumber": "QH1692",
        "stopNum": 0,
        "hasDownStop": false,
        "duration": 60,
        "noRefund": false,
        "groupClass": "ECONOMY",
        "fareClass": "ECONOMYSAVER",
        "promo": false,
        "flightValue": "QH1692|ECONOMYSAVER|HAN-DIN|20220826062000-20220826072000;ADDON_QH1;ADT_1",
        "listSegment": [
          {
            "id": 0,
            "airline": "QH",
            "operating": "QH",
            "startPoint": "HAN",
            "endPoint": "DIN",
            "startTime": "2022-08-26T13:20:00",
            "startTimeZoneOffset": "GMT+07:00",
            "endTime": "2022-08-26T14:20:00",
            "endTimeZoneOffset": "GMT+07:00",
            "flightNumber": "QH1692",
            "plane": "Embraer E90",
            "duration": 60,
            "class": "ECONOMYSAVER",
            "startTerminal": "T1",
            "endTerminal": "T2",
            "hasStop": false,
            "stopPoint": null,
            "stopTime": 0,
            "dayChange": false,
            "stopOvernight": false,
            "changeStation": false,
            "changeAirport": false,
            "lastItem": null,
            "handBaggage": "07 kg",
            "allowanceBaggage": "20 kg"
          }
        ],
        "provider": "QH",
        "session": "1660839515725"
      },
      "timeRange": "12->18",
      "medianPrice": 1150000,
      "cheapestPrice": 826000,
      "avgPrice": 1646760
    }
  ],
  "message": "OK",
  "status": true
}
*/

  String? flightType;
  String? session;
  int? itinerary;
  List<ResponseSearchedTicketListFareData?>? listFareData;
  String? message;
  bool? status;

  ResponseSearchedTicket({
    this.flightType,
    this.session,
    this.itinerary,
    this.listFareData,
    this.message,
    this.status,
  });
  ResponseSearchedTicket.fromJson(Map<String, dynamic> json) {
    flightType = json['flightType']?.toString();
    session = json['session']?.toString();
    itinerary = json['itinerary']?.toInt();
    if (json['listFareData'] != null) {
      final v = json['listFareData'];
      final arr0 = <ResponseSearchedTicketListFareData>[];
      v.forEach((v) {
        arr0.add(ResponseSearchedTicketListFareData.fromJson(v));
      });
      listFareData = arr0;
    }
    message = json['message']?.toString();
    status = json['status'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['flightType'] = flightType;
    data['session'] = session;
    data['itinerary'] = itinerary;
    if (listFareData != null) {
      final v = listFareData;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['listFareData'] = arr0;
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}
