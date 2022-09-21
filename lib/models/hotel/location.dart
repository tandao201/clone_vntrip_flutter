import 'dart:convert';

class LocationApp {

  String? name, latitude, longtitude;
  int? regionId;

  LocationApp({this.name, this.regionId});

  factory LocationApp.fromJson(Map<String, dynamic> jsonData) {
    return LocationApp(
      name: jsonData['name'],
      regionId: jsonData['regionId'],
    );
  }

  static Map<String, dynamic> toMap(LocationApp location) => {
    'name': location.name,
    'regionId': location.regionId
  };

  static String encode(List<LocationApp> locations) => json.encode(
    locations
        .map<Map<String, dynamic>>((location) => LocationApp.toMap(location))
        .toList(),
  );

  static List<LocationApp> decode(String locations) =>
      (json.decode(locations) as List<dynamic>)
          .map<LocationApp>((item) => LocationApp.fromJson(item))
          .toList();

}