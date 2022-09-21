import 'dart:convert';

import 'package:clone_vntrip/models/hotel/requests/request_search_room.dart';
import 'package:clone_vntrip/models/hotel/responses/response_suggest.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../../components/time.dart';
import '../../models/hotel/location.dart';
import '../../services/hotel_service.dart';

class SuggestPlaceProvider with ChangeNotifier {
  final REQUEST_SOURCE = "app_android";

  LocationApp? location;
  Position? currentPos;
  ResponseSuggestDataRegions? recentlyRegion;
  String address = '';
  List<dynamic> dataSuggest = <dynamic>[];
  bool isShowSuggestSearch = false;
  RequestSearchRoom? requestSearchRoom;

  void setRecentlyReion(ResponseSuggestDataRegions region) {
    recentlyRegion = region;
    notifyListeners();
  }

  void getCurrentLocation() async {
    if (location == null) {
      Position position = await _getGeoLocationPosition();
      await getAddressFromLatLong(position);
      location = LocationApp(name: address, regionId: 66);
      print('From provider: $address');
      notifyListeners();
    }
  }

  void reloadCurrentLocation() async {
    Position position = await _getGeoLocationPosition();
    currentPos = position;
    await getAddressFromLatLong(position);
    location = LocationApp(name: address, regionId: 66);
    print('From provider: $address');
    notifyListeners();
  }

  void pickPlace(LocationApp location) {
    this.location = location;
    address = location.name!;
    print('Provider: ${this.location!.name!}');
    notifyListeners();
  }

  Future<void> getSuggestPlace(String keyword) async {
    if (keyword.isNotEmpty) {
      try {
        http.Response response = await HotelService.getSuggest(keyword);
        if (response.statusCode == 200) {
          print('status: ${response.statusCode}');
          var responseSuggest =
              ResponseSuggest.fromJson(json.decode(response.body));
          print(responseSuggest.status);
          List<ResponseSuggestDataRegions?>? regions =
              responseSuggest.data?.regions;
          List<ResponseSuggestDataHotels?>? hotels =
              responseSuggest.data?.hotels;
          dataSuggest.clear();
          for (int i = 0; i < 10; i++) {
            dataSuggest.add(regions![i]);
          }
          for (int i = 0; i < 10; i++) {
            dataSuggest.add(hotels![i]);
          }
          print(dataSuggest.length);
          notifyListeners();
        } else {
          print('failure');
        }
      } catch (e) {
        print("Error call api: ${e.toString()}");
      }
    }
  }

  void showSuggest(String input) {
    if (dataSuggest.isNotEmpty) {
      isShowSuggestSearch = !isShowSuggestSearch;
    } else {
      isShowSuggestSearch = false;
    }
    notifyListeners();
  }

  void initShowSuggest() {
    isShowSuggestSearch = false;
    notifyListeners();
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    address = '${place.subAdministrativeArea}, ${place.administrativeArea}';
    // notifyListeners();
  }

  void clickBtnSearch(DateTimeRange timeRange) {
    print('Searching hotel...');
    requestSearchRoom = RequestSearchRoom(
        requestSource: REQUEST_SOURCE,
        checkInDate: Time.getDateString(timeRange.start),
        checkOutDate: Time.getDateString(timeRange.end),
        provinceId: location!.regionId!,
        page: 1,
        name: location!.name!,
        nights: Time.getDateRange(timeRange.start, timeRange.end));
    // requestSearchRoom?.location = '${recentlyRegion!.location!.lat!}%2C${recentlyRegion!.location!.lon}';

    notifyListeners();
  }
}
