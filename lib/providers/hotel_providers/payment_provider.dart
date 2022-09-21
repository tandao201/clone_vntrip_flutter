import 'dart:convert';

import 'package:clone_vntrip/models/hotel/responses/response_booking_hotel.dart';
import 'package:clone_vntrip/models/hotel/responses/response_order.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../models/hotel/requests/request_checkout.dart';
import '../../models/hotel/responses/response_checkout.dart';
import '../../models/payment/payment_method.dart';
import '../../services/hotel_service.dart';

class PaymentProvider with ChangeNotifier {

  bool isShowPaymentMethod = false;
  bool isLoading = false;
  ResponseCheckout? responseCheckout;
  ResponseBookingHotel? responseBookingHotel;
  PaymentMethod? paymentMethod;
  PaymentMethodData? recentlyPaymentMethod;
  ResponseOrderHotel? responseOrderHotel;


  void changeShowPmMethod() {
    isShowPaymentMethod = !isShowPaymentMethod;
    notifyListeners();
  }

  Future<void> requestCheckOut(RequestCheckout request) async {
    try {
      isLoading = true;
      http.Response response = await HotelService.postCheckOut(request);
      if (response.statusCode == 200) {
        print('Calling post check out: ${response.statusCode}');
        print('Calling post check out: ${response.body.toString()}');
        responseCheckout =
        ResponseCheckout.fromJson(json.decode(response.body));
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print("Calling post check out: ${e.toString()}");
    }
  }

  Future<void> bookingRequestHotel() async {
    try {
      http.Response response = await HotelService.getBookingRequest(responseCheckout!.data!.bookingRequestId!);
      if (response.statusCode == 200) {
        print('Calling booking request: ${response.statusCode}');
        print('Calling booking request: ${response.body.toString()}');
        responseBookingHotel =
            ResponseBookingHotel.fromJson(json.decode(response.body));
        notifyListeners();
      }
    } catch (e) {
      print("Calling booking request: ${e.toString()}");
    }
  }

  Future<void> getPaymentMethod() async {
    try {
      http.Response response = await HotelService.getPaymentMethod();
      if (response.statusCode == 200) {
        print('Calling payment method: ${response.statusCode}');
        print('Calling payment method: ${response.body.toString()}');
        paymentMethod =
            PaymentMethod.fromJson(json.decode(response.body));
        notifyListeners();
      }
    } catch (e) {
      print("Calling payment method: ${e.toString()}");
    }
  }

  Future<void> orderHotel() async {
    // try {
      http.Response response = await HotelService.postOrderHotel(responseCheckout!.data!.bookingRequestId!);
      if (response.statusCode == 200) {
        print('Calling order: ${response.statusCode}');
        print('Calling order: ${response.body.toString()}');
        responseOrderHotel =
            ResponseOrderHotel.fromJson(json.decode(response.body));
        notifyListeners();
      }
    // } catch (e) {
    //   print("Calling order : ${e.toString()}");
    // }
  }

  Future<void> addPaymentMethod() async {
    try {
      http.Response response = await HotelService.pathChoosePaymentMethod(responseCheckout!.data!.bookingRequestId!,
                                                                            recentlyPaymentMethod!.paymentMethod!,
                                                                            'person');
      if (response.statusCode == 200) {
        print('Calling add payment method: ${response.statusCode}');
        print('Calling add payment method: ${response.body.toString()}');
        bookingRequestHotel();
        notifyListeners();
      }
    } catch (e) {
      print("Calling add payment method: ${e.toString()}");
    }
  }

  void setRecentlyPaymentMethod(PaymentMethodData payment) {
    recentlyPaymentMethod = payment;
    notifyListeners();
  }

  void clearData() {
    paymentMethod = null;
    responseCheckout = null;
    responseBookingHotel = null;
    isShowPaymentMethod = false;
    isLoading = false;
    recentlyPaymentMethod = null;
    responseOrderHotel = null;
  }
}