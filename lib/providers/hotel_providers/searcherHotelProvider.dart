import 'dart:typed_data';
import 'dart:ui';
import 'package:clone_vntrip/models/hotel/requests/request_search_room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../components/currency.dart';
import '../../models/hotel/responses/response_searched_hotel.dart';
import '../../services/hotel_service.dart';
import 'dart:ui' as ui;

class SearchedHotelProvider with ChangeNotifier {
  List<ResponseSearchedRoomData> hotelsMain = <ResponseSearchedRoomData>[];
  List<ResponseSearchedRoomData> hotels = <ResponseSearchedRoomData>[];
  List<ResponseSearchedRoomData> hotelsApi = <ResponseSearchedRoomData>[];
  List<ResponseSearchedRoomData>? hotelsByScreenApi;
  List<dynamic> selectSortBy = <dynamic>[];
  ResponseSearchedRoomExtData? extData;
  bool isLoading = true;
  bool isEnd = false;
  bool isFirstTime = true;
  bool isSort = false;
  String sortBy = '';
  RangeValues rangeValues = const RangeValues(1, 10);
  final Set<Marker> markers = <Marker>{};
  final Set<Polyline> polylines = <Polyline>{};
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  String googleAPIKey = "AIzaSyAFM57Hm9Xc_BE5jt7HwqDG0AQKa7A15EI";
  ResponseSearchedRoomData? mapSelected;
  List<String>? dataProvince;
  List<String>? dataRegion;
  List<String>? dataStayType;
  List<String>? dataService;
  List<String> tmp = <String>[];

  void resetData() {
    print('Reset data...');
    hotels.clear();
    hotelsMain.clear();
    isLoading = true;
    isSort = false;
    isEnd = false;
    rangeValues = const RangeValues(1, 10);
    selectSortBy.clear();
    dataProvince = null;
    dataRegion = null;
    dataService = null;
    dataStayType = null;
    hotelsByScreenApi = null;
    notifyListeners();
  }

  void changeMapSelected(ResponseSearchedRoomData hotel) {
    mapSelected = hotel;
    getMarkerForMap();
    notifyListeners();
  }

  void addMarker(Marker marker) {
    markers.add(marker);
    notifyListeners();
  }

  void getPolylinesForMap(Position currentPos) async {
    polylineCoordinates.clear();
    PointLatLng startLatLn = PointLatLng(mapSelected!.location!.lat!, mapSelected!.location!.lon!);

    PointLatLng endLatLn = PointLatLng(currentPos.latitude, currentPos.longitude);

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPIKey,
        startLatLn,
        endLatLn,
        travelMode: TravelMode.driving,
    );
    polylineCoordinates.add(LatLng(startLatLn.latitude, startLatLn.longitude));
    polylineCoordinates.add(LatLng(endLatLn.latitude, endLatLn.longitude));
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        print('polyline: ${LatLng(point.latitude, point.longitude).toString()}');
      }
    }
    _addPolyLine();
  }

  void _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates
    );
    polylines.add(polyline);

    print('polyline: ${polylines.length}');
    notifyListeners();
  }

  void changeRangeValue({required RangeValues rangeValues}) {
    int firstValue = this.rangeValues.start.toInt() * 200000;
    int secondValue = this.rangeValues.end.toInt() * 200000;
    print('Range value: ${rangeValues.start} - ${rangeValues.end}');
    print(selectSortBy.toString());
    if (rangeValues.start == 1 && rangeValues.end == 10) {
      selectSortBy.remove(firstValue);
      selectSortBy.remove(secondValue);
    }
    if (rangeValues.start != 1 || rangeValues.end != 10) {
      if (!selectSortBy.contains(firstValue)) {
        selectSortBy.add(rangeValues.start.toInt() * 200000);
      } else {
        selectSortBy.remove(rangeValues.start.toInt() * 200000);
      }

      if (!selectSortBy.contains(secondValue)) {
        selectSortBy.add(rangeValues.end.toInt() * 200000);
      }else {
        selectSortBy.remove(rangeValues.end.toInt() * 200000);
      }
    }

    this.rangeValues = rangeValues;

    notifyListeners();
  }

  void clickSortByField() async {
    isSort = true;
    int firstValue = rangeValues.start.toInt() * 200000;
    int secondValue = rangeValues.end.toInt() * 200000;
    List<ResponseSearchedRoomData> hotelsTmp = <ResponseSearchedRoomData>[];
    if (selectSortBy.isNotEmpty) {
      for (dynamic item in selectSortBy) {
        if (item is int) {
          if (item < 6) {
            print('Sort by start...');
            hotelsTmp = hotelsMain.where((hotel) => double.parse(hotel.starRate.toString()) >= item).toList();
            print(hotelsTmp.toString());
          }
        }
        if (item is String) {
          print('Sort by string...');
          hotelsTmp.addAll(hotelsMain.where((hotel) => hotel.toString().contains(item)).toList());
        }
        hotels = hotelsTmp;
      }
      if (selectSortBy.contains(firstValue)) {
        hotelsTmp = hotelsMain.where((hotel) => hotel.netPrice! >= firstValue && hotel.netPrice! <= secondValue).toList();
        hotels.addAll(hotelsTmp);
      }
    } else {
      hotels = hotelsMain;
    }
    if (selectSortBy.isEmpty){
      isSort = false;
    }
    await getMarkerForMap();
    notifyListeners();
  }


  Future<void> searchHotel(int page, RequestSearchRoom request) async {
    print('${request.checkInDate} - ${request.checkOutDate}');
    // try {
      request.page = page;
      hotelsApi.clear();
      // hotels.clear();
      http.Response response = await HotelService.searchedHotel(request);
      print('Request Search hotel api: ${request.toString()}');
      if (response.statusCode == 200) {
        print('Calling Search hotel api: ${response.statusCode}');
        print('Calling Search hotel api: ${response.body.toString()}');
        var responseSearchHotel =
            ResponseSearchedRoom.fromJson(json.decode(response.body));
        extData = responseSearchHotel.extData;
        if (responseSearchHotel.status == 'success') {
          print(responseSearchHotel.status);
          if (responseSearchHotel.data != null) {
            hotelsApi =
                responseSearchHotel.data as List<ResponseSearchedRoomData>;
            if (hotelsApi.isEmpty) {
              print('Empty...');
              isLoading = false;
              isEnd = true;
              notifyListeners();
              return ;
            }
            hotelsMain.addAll(hotelsApi);
            if (hotels.isEmpty) {
              hotels = hotelsMain;
            }
            isFirstTime = false;
            // await getMarkerForMap();
          } else {
            isEnd = true;
          }
          isLoading = false;
          notifyListeners();
        }
      }
    // } catch (e) {
    //   print("Calling Search hotel api: ${e.toString()}");
    // }
  }

  Future<void> searchHotelByScreen(RequestSearchRoom request) async {
    if (hotelsByScreenApi!= null) {
      hotelsByScreenApi!.clear();
    }
    // hotels.clear();
    http.Response response = await HotelService.searchedHotelByScreen(request);
    if (response.statusCode == 200) {
      print('Calling Search hotel for map api: ${response.statusCode}');
      print('Calling search hotel for map api: ${response.body.toString()}');
      var responseSearchHotel =
      ResponseSearchedRoom.fromJson(json.decode(response.body));
      // extData = responseSearchHotel.extData;
      if (responseSearchHotel.status == 'success') {
        print('Calling search hotel for map api: ${responseSearchHotel.data![0]!.fullAddress!}');
        print(responseSearchHotel.status);
        if (responseSearchHotel.data != null) {
          hotelsByScreenApi =
          responseSearchHotel.data as List<ResponseSearchedRoomData>;
          if (hotelsByScreenApi!.isEmpty) {
            print('Empty...');
            isLoading = false;
            isEnd = true;
            notifyListeners();
            return ;
          }
          isFirstTime = false;
          await getMarkerForMap();
          print('Search hotel for map length: ${hotelsByScreenApi!.length}');
        } else {
          isEnd = true;
        }
        isLoading = false;
        notifyListeners();
      }
    }
  }

  void sortByPrice({required String sortBy}){
    this.sortBy = sortBy;
    if (sortBy=='low') {
      hotels.sort((a,b) => a.netPrice!.compareTo(b.netPrice!));
    } else if (sortBy=='high') {
      hotels.sort((a,b) => b.netPrice!.compareTo(a.netPrice!));
    } else {
      hotels.sort((a,b) => b.reviewPoint!.compareTo(a.reviewPoint!));
    }
    notifyListeners();
  }

  void clearSortBy() {
    print('clear sort by');
    sortBy = '';
    hotels = hotelsMain;
    notifyListeners();
  }

  void addToSortByList(dynamic item){
    selectSortBy.add(item);
    notifyListeners();
  }

  void deleteFromSortByList(dynamic item){
    selectSortBy.remove(item);
    notifyListeners();
  }

  String getPriceRangeString() {
    if (rangeValues.start == 1 && rangeValues.end == 10){
      return 'Tất cả';
    }
    int firstValue = rangeValues.start.toInt() * 200000;
    int secondValue = rangeValues.end.toInt() * 200000;

    return '${Currency.displayPriceFormat(firstValue)} - ${Currency.displayPriceFormat(secondValue)}';
  }

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  Future<Uint8List> getBytesFromCanvas(String customNum, int width, int height, bool isSelect) async  {
    Color colorBg = Colors.white;
    Color colorText = Colors.black;

    if (isSelect) {
      colorBg = Colors.orange;
      colorText = Colors.white;
    }

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()
                          ..color = colorBg;
    const Radius radius = Radius.circular(5);


    canvas.clipPath(Path()
      ..moveTo(0, 0)
      ..lineTo(width.toDouble(), 0)
      ..lineTo( width.toDouble() , height *0.8)
      ..lineTo(width.toDouble()/2, height *0.8)
      ..lineTo(width /5, height.toDouble())
      ..lineTo(width*0.2, height * 0.8)
      ..lineTo(0, height *0.8)
      ..lineTo(0, 0)
      ..arcToPoint(
        Offset(width.toDouble(), 0),
      )
      ..arcToPoint(const Offset(0, 0)));


    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, width.toDouble(),  height.toDouble()),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        paint);
      canvas.drawPath(Path()
        ..moveTo(0, 0)
        ..lineTo(width.toDouble(), 0)
        ..lineTo( width.toDouble() , height *0.8)
        ..lineTo(width.toDouble()/2, height *0.8)
        ..lineTo(width /5, height.toDouble())
        ..lineTo(width*0.2, height * 0.8)
        ..lineTo(0, height *0.8)
        ..lineTo(0, 0),
          Paint()
                              ..color = Colors.black
                              ..style = ui.PaintingStyle.stroke
                              ..strokeWidth = 1
                              ..strokeCap = ui.StrokeCap.round
        ..maskFilter = MaskFilter.blur(BlurStyle.outer, convertRadiusToSigma(3)));

    TextPainter painter = TextPainter(textDirection: ui.TextDirection.ltr);
    painter.text = TextSpan(
      text: customNum.toString(), // your custom number here
      style: TextStyle(fontSize: 19, color: colorText),
    );

    painter.layout();
    painter.paint(
        canvas,
        Offset((width * 0.5) - painter.width * 0.5,
            (height * .5) - painter.height * 0.5));
    final img = await pictureRecorder.endRecording().toImage(width, height);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }
  
  Future<void> getMarkerForMap() async {
    markers.clear();
    if (hotelsByScreenApi != null && hotelsByScreenApi!.isNotEmpty) {
      try {
        mapSelected ??= hotelsByScreenApi![0];
        for (var hotel in hotelsByScreenApi!) {
          Uint8List markerIcon;
          if ( mapSelected!.id == hotel.id) {
            markerIcon = await getBytesFromCanvas(_getPriceString(hotel.netPrice!), 85, 60, true);
          } else {
            markerIcon = await getBytesFromCanvas(_getPriceString(hotel.netPrice!), 85, 60, false);
          }
          LatLng locaton = LatLng(hotel.location!.lat!, hotel.location!.lon!);
          markers.add(Marker(
            zIndex: hotel.id == mapSelected!.id ? 1 : 0,
            markerId: MarkerId(locaton.toString()),
            position: locaton,
            icon: BitmapDescriptor.fromBytes(markerIcon),
            onTap: () {
              mapSelected = hotel;
              getMarkerForMap();
              notifyListeners();
            },
            onDrag: (_) {

            },
          ));
        }

        notifyListeners();
      } catch (e) {
        print('Ex from get markers hotel: ${e.toString()}');
      }
    } else {
      print('Get markers for map hotel: trong!');
    }
  }

  String _getPriceString(int price) {
    var formatter = NumberFormat.compact(locale: "en_US");
    String money = formatter.format(price);
    String unit = money[money.length-1];
    if (unit == 'M'){
      money = '${money.substring(0, money.length-1)}TR';
    }
    return money;
  }

  void clearSelectField() async {
    print('clear select field');
    isSort = false;
    selectSortBy.clear();
    hotels = hotelsMain;
    await getMarkerForMap();
    notifyListeners();
  }

  List<String> getListString(List<dynamic>? data, String hasMore, int field) {
    List<String> result = <String>[];
    if (hasMore == '...') {
      if (data!.length>4) {
        for (int i=0 ; i<4 ; i++){
          result.add(data[i].name);
        }
        result.add('...');
      } else {
        for (int i=0 ; i<data.length ; i++){
          result.add(data[i].name);
        }
      }
    } else {
      print('click showmore');
      for (int i=0 ; i<data!.length ; i++){
        result.add(data[i].name);
      }
      if (data.length>4) {
        result.add('^');
      } else {

      }
    }
    switch (field) {
      case 2:
        dataProvince = data.cast<String>();
        break;
      case 3:
        dataRegion = data.cast<String>();
        break;
      case 4:
        dataStayType = data.cast<String>();
        break;
      case 5:
        dataService = data.cast<String>();
        break;
    }
    notifyListeners();
    return result;

  }

  List<String> getListStringInit(List<dynamic>? data, int field) {
    List<String> result = <String>[];
      if (data!.length>4) {
        for (int i=0 ; i<4 ; i++){
          result.add(data[i].name);
        }
        result.add('...');
      } else {
        for (int i=0 ; i<data.length ; i++){
          result.add(data[i].name);
        }
      }
    notifyListeners();
    return result;
  }

  void clickShowmore(int field) {
    switch (field) {
      case 2:
        dataProvince = getNameFromList(extData!.countByCities!, extData!.countByCities!.length);
        break;
      case 3:
        dataRegion = getNameFromList(extData!.countByArea!, extData!.countByArea!.length);
        break;
      case 4:
        dataStayType = getListTypeString(extData!.countByType!, 0);
        break;
      case 5:
        dataService = getNameFromList(extData!.countByFacilities!, extData!.countByFacilities!.length);
        break;
    }
    notifyListeners();
  }

  void clickShowless(int field) {
    switch (field) {
      case 2:
        dataProvince = getNameFromList(extData!.countByCities!, 4);
        break;
      case 3:
        dataRegion = getNameFromList(extData!.countByArea!, 4);
        break;
      case 4:
        dataStayType = getListTypeString(extData!.countByType!, 0);
        break;
      case 5:
        dataService = getNameFromList(extData!.countByFacilities!, 4);
        break;
    }
    notifyListeners();
  }

  List<String> getNameFromList(List<dynamic> data, int length) {
    List<String> result = <String>[];
    if (length < data.length){
      for (int i=0 ; i<length ; i++){
        result.add(data[i].name);
      }
      result.add('...');
    } else  {
      for (int i=0 ; i<data.length ; i++){
        result.add(data[i].name);
      }
      result.add('^');
    }
    return result;
  }

  void getDataFieldSort() {
    dataProvince = getListStringInit(extData!.countByCities!, 0);
    dataRegion =  getListStringInit(extData?.countByArea!, 0);
    dataStayType =  getListTypeString(extData?.countByType!,  0);
    dataService =  getListStringInit(extData?.countByFacilities!, 0);
  }


  List<String> getListTypeString(List<dynamic>? data, int type) {
    List<String> result = <String>[];
    if (data!.length>4) {
      for (int i=0 ; i<4 ; i++){
        result.add(data[i].type);
      }
      result.add('...');
    } else {
      for (int i=0 ; i<data.length ; i++){
        result.add(data[i].type);
      }
    }
    return result;
  }
}
