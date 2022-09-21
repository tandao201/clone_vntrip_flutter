import 'dart:convert';

import 'package:clone_vntrip/models/ticket/requests/request_search_ticket.dart';
import 'package:http/http.dart' as http;

import '../models/ticket/requests/request_flight_rate.dart';

class TicketServices {
  static const URL_PLACE_FLIGHTS =
      'https://test-micro-services.vntrip.vn/v1-flight/atadi-air-ports';
  static const URL_SEARCHED_TICKET_FLIGHTS =
      'https://test-micro-services.vntrip.vn/flight-service/v1/search';
  static const URL_FLIGHT_RATES =
      'https://test-micro-services.vntrip.vn/flight-service/v1/flight-rates';
  static const URL_CHECK_OUT =
      'https://test-micro-services.vntrip.vn/v3-booking/fe/checkout/review?';
  static const URL_RESERVATION_STATUS =
      ' https://test-micro-services.vntrip.vn/flight-service/v1/reservation-status';
  static const URL_CHOOSE_METHOD_PAYMENT =
      'https://test-micro-services.vntrip.vn/v3-booking/fe/checkout/payment-method/';

  static Future<http.Response> getPlace() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    return http
        .get(Uri.parse(URL_PLACE_FLIGHTS), headers: headers)
        .then((http.Response response) => response);
  }

  static Future<http.Response> postSearchedTicket(
      RequestSearchTicket request) async {
    Map<String, String> headers = {'Accept': 'application/json',
      'Content-type': 'application/json',};
    print('URL post: $URL_SEARCHED_TICKET_FLIGHTS');
    print('Body: ${request.toJson().toString()}');
    final response = await http
        .post(Uri.parse(URL_SEARCHED_TICKET_FLIGHTS),
            body: jsonEncode(request.toJson()), headers: headers)
        .timeout(const Duration(seconds: 60)).catchError((err) {
          print('Service error: $err');
    });
    print('Service data response: ${json.decode(response.body).toString()}');
    return response;
  }

  static Future<http.Response> postFlightRate(
      RequestFlightRate request) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json',};
    print('URL post: $URL_FLIGHT_RATES');
    print('Body: ${request.toJson().toString()}');
    final response = await http
        .post(Uri.parse(URL_FLIGHT_RATES),
        body: jsonEncode(request.toJson()), headers: headers);
    print('Service data response: ${json.decode(response.body).toString()}');
    return response;
  }

  static Future<http.Response> getCheckout(String bookingId, String bookingSuggestId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    return http
        .get(Uri.parse('${URL_CHECK_OUT}booking_request_id=$bookingId&booking_suggestion_id=$bookingSuggestId'), headers: headers)
        .then((http.Response response) => response);
  }

  static Future<http.Response> postReservation(
      String bookingId, String bookingSuggestId) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json',};

    Map<String, String> dataBody = {
      'bookingRequestId' : bookingId,
      'suggestionId' : bookingSuggestId
    };
    print('URL post: $URL_FLIGHT_RATES');
    print('Body: ${dataBody.toString()}');
    final response = await http
        .post(Uri.parse(URL_FLIGHT_RATES),
        body: jsonEncode(dataBody), headers: headers);
    print('Service data response: ${json.decode(response.body).toString()}');
    return response;
  }

  static Future<http.Response> pathChoosePaymentMethod(String bookingRequestId, String paymentMethod, String userType) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json',};

    Map<String, String> body = {
      'booking_request_id': bookingRequestId,
      'payment_method': paymentMethod,
      'user_type': userType
    };

    final response = await http
        .patch(Uri.parse('$URL_CHOOSE_METHOD_PAYMENT$bookingRequestId'),
        body: jsonEncode(body), headers: headers);
    print('PATCH $URL_CHOOSE_METHOD_PAYMENT$bookingRequestId');
    print('Data: ${body.toString()}');
    return response;
  }
}
