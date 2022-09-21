class RequestSearchTicketListFlight {
/*
{
  "departDate": "20220820",
  "endPoint": "SGN",
  "startPoint": "HAN"
} 
*/

  String? departDate;
  String? endPoint;
  String? startPoint;

  RequestSearchTicketListFlight({
    this.departDate,
    this.endPoint,
    this.startPoint,
  });
  RequestSearchTicketListFlight.fromJson(Map<String, dynamic> json) {
    departDate = json['departDate']?.toString();
    endPoint = json['endPoint']?.toString();
    startPoint = json['startPoint']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['departDate'] = departDate;
    data['endPoint'] = endPoint;
    data['startPoint'] = startPoint;
    return data;
  }
}

class RequestSearchTicket {
/*
{
  "adultCount": 1,
  "childCount": 0,
  "infantCount": 0,
  "listFlight": [
    {
      "departDate": "20220820",
      "endPoint": "SGN",
      "startPoint": "HAN"
    }
  ]
} 
*/

  int? adultCount;
  int? childCount;
  int? infantCount;
  String? goPlace;
  String? toPlace;
  List<RequestSearchTicketListFlight?>? listFlight;


  RequestSearchTicket({
    this.adultCount,
    this.childCount,
    this.infantCount,
    this.listFlight,
    this.goPlace,
    this.toPlace
  });
  RequestSearchTicket.fromJson(Map<String, dynamic> json) {
    adultCount = json['adultCount']?.toInt();
    childCount = json['childCount']?.toInt();
    infantCount = json['infantCount']?.toInt();
    if (json['listFlight'] != null) {
      final v = json['listFlight'];
      final arr0 = <RequestSearchTicketListFlight>[];
      v.forEach((item) {
        arr0.add(RequestSearchTicketListFlight.fromJson(item));
      });
      listFlight = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['adultCount'] = adultCount;
    data['childCount'] = childCount;
    data['infantCount'] = infantCount;
    if (listFlight != null) {
      final v = listFlight;
      final arr0 = [];
      for (var item in v!) {
        arr0.add(item!.toJson());
      }
      data['listFlight'] = arr0;
    }
    return data;
  }
  @override
  String toString() {
    // TODO: implement toString
    return '$adultCount, $childCount, $infantCount, $goPlace, $toPlace, ${listFlight![0]!.departDate}';
  }
}
