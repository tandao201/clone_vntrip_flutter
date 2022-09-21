import 'dart:convert';

import 'package:clone_vntrip/models/ticket/responses/response_reservation_status.dart';
import 'package:clone_vntrip/services/ticket_services.dart';
import 'package:flutter/material.dart';

import '../../models/hotel/responses/response_order.dart';
import '../../models/payment/payment_method.dart';
import '../../models/ticket/requests/request_flight_rate.dart';
import '../../models/ticket/responses/response_flight_rate.dart';
import '../../services/hotel_service.dart';
import 'package:http/http.dart' as http;

class PaymentBookingTicket with ChangeNotifier {

  bool isShowPaymentMethod = false;
  bool isLoading = false;
  bool isFirst = true;
  PaymentMethod? paymentMethod;
  PaymentMethodData? recentlyPaymentMethod;
  ResponseFlightRate? responseFlightRate;
  ResponseReservationStatus? reservationStatus;
  ResponseOrderHotel? responseOrderHotel;

  void changeShowPmMethod() {
    isShowPaymentMethod = !isShowPaymentMethod;
    notifyListeners();
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

  Future<void> postFlightRate(RequestFlightRate request) async {
    // try {
      http.Response response = await TicketServices.postFlightRate(request);

      if (response.statusCode == 200 || response.statusCode == 201 ) {
        print('Calling flight rate: ${response.statusCode}');
        print('Calling flight rate: ${response.body.toString()}');
        responseFlightRate =
            ResponseFlightRate.fromJson(json.decode(response.body));
        isFirst = false;
        if (responseFlightRate!.data != null){
          await postReservation(responseFlightRate!.data!.bookingRequestId!, responseFlightRate!.data!.bookingRequestSuggestionId!);
        }

        notifyListeners();
      } else {
        responseFlightRate = ResponseFlightRate();
      }
    // } catch (e) {
    //   print("Calling flight rate: ${e.toString()}");
    // }
  }

  Future<void> postReservation(String bookingId, String bookingSuggestId) async {
    try {
      http.Response response = await TicketServices.postReservation(bookingId, bookingSuggestId);
      if (response.statusCode == 200) {
        print('Calling reservation status: ${response.statusCode}');
        print('Calling reservation status: ${response.body.toString()}');
        reservationStatus =
            ResponseReservationStatus.fromJson(json.decode(response.body));
        notifyListeners();
      }
    } catch (e) {
      print("Calling reservation status: ${e.toString()}");
    }
  }

  Future<void> addPaymentMethod() async {
    try {
      http.Response response = await HotelService.pathChoosePaymentMethod(responseFlightRate!.data!.bookingRequestId!,
          recentlyPaymentMethod!.paymentMethod!,
          'person');
      if (response.statusCode == 200) {
        print('Calling add payment method: ${response.statusCode}');
        print('Calling add payment method: ${response.body.toString()}');

        notifyListeners();
      }
    } catch (e) {
      print("Calling add payment method: ${e.toString()}");
    }
  }

  Future<void> orderFlightTicket() async {
    try {
      http.Response response = await HotelService.postOrderHotel(responseFlightRate!.data!.bookingRequestId!);
      if (response.statusCode == 200) {
        print('Calling order: ${response.statusCode}');
        print('Calling order: ${response.body.toString()}');
        responseOrderHotel =
            ResponseOrderHotel.fromJson(json.decode(response.body));
        notifyListeners();
      }
    } catch (e) {
      print("Calling order : ${e.toString()}");
    }
  }

  void setRecentlyPaymentMethod(PaymentMethodData payment) {
    recentlyPaymentMethod = payment;
    notifyListeners();
  }

  void clearData() {
    responseFlightRate = null;
    responseOrderHotel = null;
    reservationStatus = null;
    paymentMethod = null;
    isShowPaymentMethod = false;
    isLoading = false;
    isFirst = true;
    recentlyPaymentMethod = null;
  }

}