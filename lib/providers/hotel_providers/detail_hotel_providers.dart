import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/hotel/requests/request_detail_hotel.dart';
import '../../models/hotel/responses/response_detail_each_room.dart';
import '../../models/hotel/responses/response_detail_hotel.dart';
import '../../models/hotel/rooms_and_customers.dart';
import '../../services/hotel_service.dart';

// https://statics.vntrip.vn/data-v2/hotels/71686/img_max/71686_1568349953_img_4066.jpg

class DetailHotelProviders with ChangeNotifier {

  ResponseDetailHotelDataResults? results;
  RoomsAndCustomers? roomsAndCustomers = RoomsAndCustomers(rooms: 1, custormers: 2);
  RoomsAndCustomers? roomsAndCustomersMain = RoomsAndCustomers(rooms: 1, custormers: 2);
  List<ResponseDetailEachRoomDataRoomData?>? roomDataDetail = <ResponseDetailEachRoomDataRoomData>[];
  List<String> moreInfo = [];
  ResponseDetailEachRoomDataRoomData? recentlyRoom;
  int? hotelId;
  bool isLoading = true;
  bool isLoadingRooms = true;
  bool isFirstTime = true;
  final Set<Marker> markers = <Marker>{};

  Future<void> detailHotel(int hotelId) async {
    http.Response response = await HotelService.detailHotel(hotelId);
    if (response.statusCode == 200) {
      print('Calling detail hotel api: ${response.statusCode}');
      print('Calling detail hotel api: ${response.body.toString()}');
      var responseDetailHotel =
      ResponseDetailHotel.fromJson(json.decode(response.body));
      if (responseDetailHotel.status == 'success') {
        print(responseDetailHotel.status);
        if (responseDetailHotel.data != null) {
          results =
          responseDetailHotel.data?.results?[0];
          getMarkerForMap();
        } else {
          results = ResponseDetailHotelDataResults();
        }
        isFirstTime = false;
        isLoading = false;
        notifyListeners();
      }
    }
    // } catch (e) {
    //   print("Calling Search hotel api: ${e.toString()}");
    // }
  }

  Future<void> detailEachRoom(RequestDetailHotel request) async {
    try {
    isLoadingRooms = true;
    roomDataDetail?.clear();
    http.Response response = await HotelService.detailEachRoom(request);
    if (response.statusCode == 200) {
      print('Calling detail each room api: ${response.statusCode}');
      print('Calling detail each room api: ${response.body.toString()}');
      var responseDetailEachRoom =
      ResponseDetailEachRoom.fromJson(json.decode(response.body));
      if (responseDetailEachRoom.status == 'success') {
        print(responseDetailEachRoom.status);
        if (responseDetailEachRoom.data != null) {
          roomDataDetail = responseDetailEachRoom.data?[0]?.roomData!;
        } else {

        }

      }
      isLoadingRooms = false;
      notifyListeners();
    }
    } catch (e) {
      print("Calling Search hotel api: ${e.toString()}");
      roomDataDetail!.clear();
      isLoadingRooms = false;
    }
  }

  Future<void> getMarkerForMap() async {
    try {
      markers.add(Marker(
        markerId: MarkerId(results!.nameVi!.toString()),
        position: LatLng(results!.latitude!,results!.longitude!),
        icon: BitmapDescriptor.defaultMarker,
        onTap: () {
        },
        onDrag: (_) {

        },
      ));
      notifyListeners();
    } catch (e) {
      print('Ex from sort hotel: ${e.toString()}');
    }
  }

  void changeRoomAndCustomer(RoomsAndCustomers rRoomsAndCustomers) {
    roomsAndCustomers = rRoomsAndCustomers;
    notifyListeners();
  }

  void clickBtnSelectRoomCustomer() {
    roomsAndCustomersMain = roomsAndCustomers;
    notifyListeners();
  }

  void setRequest(int hotelId) {
    this.hotelId = hotelId;
    notifyListeners();
  }

  clearData() {
    results = null;
    roomsAndCustomers = RoomsAndCustomers(rooms: 1, custormers: 2);
    roomDataDetail?.clear();
    moreInfo.clear();
    isLoading = true;
    isLoadingRooms = true;
    isFirstTime = true;
    notifyListeners();
  }

  String getChekInCheckOutDate() {
    return 'Nhận phòng từ ${results!.checkInTime!} Giờ\nTrả phòng đến ${results!.checkOutTime!} Giờ';
  }

  void clickSeeMore(String title) {
    if (moreInfo.contains(title)){
      moreInfo.remove(title);
    } else {
      moreInfo.add(title);
    }
    notifyListeners();
  }

  void setRecentlyRoom(ResponseDetailEachRoomDataRoomData room) {
    recentlyRoom = room;
    notifyListeners();
  }
}