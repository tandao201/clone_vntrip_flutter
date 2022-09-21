import 'package:clone_vntrip/models/hotel/location.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentPlacePickProv with ChangeNotifier {
  final RESTORE_KEY = "location_key";
  List<LocationApp> locations = <LocationApp>[];

  Future<void> getRecent() async {
    // print("getting....${locations[0]}");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Fetch and decode data
    String? locationString = prefs.getString(RESTORE_KEY);
    if (locationString!=null) {
      locations = LocationApp.decode(locationString);
      notifyListeners();
    }
  }

  Future<void> storageDataRecent(List<LocationApp>? locations) async {
    // print("storing....${locations?.length}");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final encodedData = LocationApp.encode(locations!);
    await prefs.setString(RESTORE_KEY, encodedData);
  }

  Future<void> addToRecent(LocationApp locationApp) async {
    print("adding....${locationApp.name}");
    if (locations.isNotEmpty) {
      for (int i = 0; i < 5; i++) {
        if (locations.length!=5) {
          break ;
        }
        if (locations[i].name == locationApp.name) {
          return;
        }
      }
      if (locations.length == 5) {
        locations.removeAt(0);
      }
      locations.add(locationApp);

      print("In adding: ${locations.last}");
      storageDataRecent(locations);
      notifyListeners();
    } else {
      locations.add(locationApp);

      print("In adding: ${locations.last}");
      storageDataRecent(locations);
      notifyListeners();
    }
  }
}
