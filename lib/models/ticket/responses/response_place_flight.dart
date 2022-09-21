class ResponsePlaceFlightDataDomesticRegionData {
/*
{
  "id": "4f010ee1-851a-4f5c-b556-c6c9a7b89b8c",
  "name": "Sân bay Nha Trang",
  "code": "NHA",
  "province_id": 86,
  "created_at": "2021-03-26T17:03:14.419Z",
  "updated_at": null,
  "type": "domestic",
  "region": null,
  "province_name": "Khánh Hòa",
  "has_in_atadi": true,
  "region_name": null,
  "region_name_vi": null
}
*/

  String? id;
  String? name;
  String? code;
  int? provinceId;
  String? createdAt;
  String? updatedAt;
  String? type;
  String? region;
  String? provinceName;
  bool? hasInAtadi;
  String? regionName;
  String? regionNameVi;
  bool? isSelect = false;

  ResponsePlaceFlightDataDomesticRegionData({
    this.id,
    this.name,
    this.code,
    this.provinceId,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.region,
    this.provinceName,
    this.hasInAtadi,
    this.regionName,
    this.regionNameVi,
  });
  factory  ResponsePlaceFlightDataDomesticRegionData.fromJson(Map<String, dynamic> json) => ResponsePlaceFlightDataDomesticRegionData (
    id : json['id']?.toString(),
    name : json['name']?.toString(),
    code : json['code']?.toString(),
    provinceId : json['province_id']?.toInt(),
    createdAt : json['created_at']?.toString(),
    updatedAt : json['updated_at']?.toString(),
    type : json['type']?.toString(),
    region : json['region']?.toString(),
    provinceName : json['province_name']?.toString(),
    hasInAtadi : json['has_in_atadi'],
    regionName : json['region_name']?.toString(),
    regionNameVi : json['region_name_vi']?.toString(),
  );
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['province_id'] = provinceId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['type'] = type;
    data['region'] = region;
    data['province_name'] = provinceName;
    data['has_in_atadi'] = hasInAtadi;
    data['region_name'] = regionName;
    data['region_name_vi'] = regionNameVi;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return '$id, $name';
  }
}

class ResponsePlaceFlightDataDomestic {
/*
{
  "region_name": "other",
  "region_data": [
    {
      "id": "4f010ee1-851a-4f5c-b556-c6c9a7b89b8c",
      "name": "Sân bay Nha Trang",
      "code": "NHA",
      "province_id": 86,
      "created_at": "2021-03-26T17:03:14.419Z",
      "updated_at": null,
      "type": "domestic",
      "region": null,
      "province_name": "Khánh Hòa",
      "has_in_atadi": true,
      "region_name": null,
      "region_name_vi": null
    }
  ]
}
*/

  String? regionName;
  List<ResponsePlaceFlightDataDomesticRegionData?>? regionData;

  ResponsePlaceFlightDataDomestic({
    this.regionName,
    this.regionData,
  });
  ResponsePlaceFlightDataDomestic.fromJson(Map<String, dynamic> json) {
    regionName = json['region_name']?.toString();
    if (json['region_data'] != null) {
      final v = json['region_data'];
      final arr0 = <ResponsePlaceFlightDataDomesticRegionData>[];
      v.forEach((v) {
        arr0.add(ResponsePlaceFlightDataDomesticRegionData.fromJson(v));
      });
      regionData = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['region_name'] = regionName;
    if (regionData != null) {
      final v = regionData;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['region_data'] = arr0;
    }
    return data;
  }
}

class ResponsePlaceFlightData {
/*
{
  "domestic": [
    {
      "region_name": "other",
      "region_data": [
        {
          "id": "4f010ee1-851a-4f5c-b556-c6c9a7b89b8c",
          "name": "Sân bay Nha Trang",
          "code": "NHA",
          "province_id": 86,
          "created_at": "2021-03-26T17:03:14.419Z",
          "updated_at": null,
          "type": "domestic",
          "region": null,
          "province_name": "Khánh Hòa",
          "has_in_atadi": true,
          "region_name": null,
          "region_name_vi": null
        }
      ]
    }
  ]
}
*/

  List<ResponsePlaceFlightDataDomestic?>? domestic;

  ResponsePlaceFlightData({
    this.domestic,
  });
  ResponsePlaceFlightData.fromJson(Map<String, dynamic> json) {
    if (json['domestic'] != null) {
      final v = json['domestic'];
      final arr0 = <ResponsePlaceFlightDataDomestic>[];
      v.forEach((v) {
        arr0.add(ResponsePlaceFlightDataDomestic.fromJson(v));
      });
      domestic = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (domestic != null) {
      final v = domestic;
      final arr0 = [];
      v!.forEach((v) {
        arr0.add(v!.toJson());
      });
      data['domestic'] = arr0;
    }
    return data;
  }
}

class ResponsePlaceFlight {
/*
{
  "status": "success",
  "message": "Success",
  "data": {
    "domestic": [
      {
        "region_name": "other",
        "region_data": [
          {
            "id": "4f010ee1-851a-4f5c-b556-c6c9a7b89b8c",
            "name": "Sân bay Nha Trang",
            "code": "NHA",
            "province_id": 86,
            "created_at": "2021-03-26T17:03:14.419Z",
            "updated_at": null,
            "type": "domestic",
            "region": null,
            "province_name": "Khánh Hòa",
            "has_in_atadi": true,
            "region_name": null,
            "region_name_vi": null
          }
        ]
      }
    ]
  }
}
*/

  String? status;
  String? message;
  ResponsePlaceFlightData? data;

  ResponsePlaceFlight({
    this.status,
    this.message,
    this.data,
  });
  ResponsePlaceFlight.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    message = json['message']?.toString();
    data = (json['data'] != null) ? ResponsePlaceFlightData.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
