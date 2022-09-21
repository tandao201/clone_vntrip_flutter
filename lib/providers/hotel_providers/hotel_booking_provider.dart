import 'package:clone_vntrip/models/hotel/requests/request_checkout.dart';
import 'package:clone_vntrip/models/hotel/requests/request_list_point_value.dart';
import 'package:clone_vntrip/models/hotel/responses/list_point_view.dart';
import 'package:clone_vntrip/models/hotel/responses/response_checkout.dart';
import 'package:flutter/material.dart';

import '../../models/hotel/responses/response_detail_each_room.dart';
import '../../models/login/profile_user.dart';
import '../../validators/validator_login.dart';

enum CheckIn {me, another}

class HotelBookingProvider with ChangeNotifier {

  static const REQUEST_FROM = 'APP_ANDROID';

  String errorValid = "";
  CheckIn checkIn = CheckIn.me;
  bool hasMoreReq = false;
  ListPointValue? listPointValue;
  RequestCheckout requestCheckout = RequestCheckout();

  Future <void> getListPointValue(RequestListPointView request) async {
    try {

    } catch (e) {
      print("Ex form call list point view: ${e.toString()}");
    }
  }

  void changeHasMoreReq() {
    hasMoreReq = !hasMoreReq;
    notifyListeners();
  }

  void changeAnotherCheckIn(CheckIn value) {
    checkIn = value;
    notifyListeners();
  }

  Future<void> checkInput(String firstName, String name, String phone, String email) async  {
    if (ValidatorLogin.isEmpty(firstName)) {
      errorValid = "Họ và tên đệm không để trống";
      print('Validating: ${errorValid}');
      notifyListeners();
      return ;
    }
    if (ValidatorLogin.isEmpty(name)) {
      errorValid = "Tên không để trống";
      print('Validating: ${errorValid}');
      notifyListeners();
      return ;
    }
    if (ValidatorLogin.isEmpty(phone)) {
      errorValid = "Số điện thoại không để trống";
      print('Validating: ${errorValid}');
      notifyListeners();
      return ;
    }
    if (!ValidatorLogin.isValidPhone(phone)) {
      errorValid = "Số điện thoại không đúng định dạng!";
      print('Validating: ${errorValid}');
      notifyListeners();
      return ;
    }

    if (ValidatorLogin.isEmpty(email)) {
      errorValid = "Email không để trống";
      print('Validating: ${errorValid}');
      notifyListeners();
      return ;
    }

    if (!ValidatorLogin.isValidEmail(email)) {
      errorValid = "Email không đúng định dạng!";
      print('Validating: ${errorValid}');
      notifyListeners();
      return ;
    }

    print('Validating: ${errorValid}');
  }

  void resetError() {
    errorValid = '';
    notifyListeners();
  }

  void clickContinueBooking(String firstName, String lastName, String phone, String email, ResponseDetailEachRoomDataRoomData room, ProfileUser user) {
    print('Request check out: $firstName - $lastName');
    List<RequestCheckoutHotelReceiverData> receiverData = <RequestCheckoutHotelReceiverData>[];
    receiverData.add(RequestCheckoutHotelReceiverData(
      countryCode: '84',
      firstName: firstName,
      lastName: lastName,
      phone: phone,
    ));

    requestCheckout = RequestCheckout(
      bookerData: RequestCheckoutBookerData(
        firstName: user.data!.firstName,
        lastName: user.data!.lastName,
        phone: user.data!.phone,
        email: user.data!.email,
        gender: user.data!.gender
      ),
      hotel: RequestCheckoutHotel(
        bedTypeGroupId: 0,
        receiverData: receiverData,
        tokenId: room.rates![0]!.availToken
      ),
      requestFrom: REQUEST_FROM,
      userId: user.data!.userId
    );

    notifyListeners();
  }
}