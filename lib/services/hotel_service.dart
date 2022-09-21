import 'dart:convert';

import 'package:clone_vntrip/models/hotel/requests/request_checkout.dart';
import 'package:clone_vntrip/models/hotel/requests/request_search_room.dart';
import 'package:http/http.dart' as http;

import '../models/hotel/requests/request_detail_hotel.dart';
import '../models/hotel/requests/request_list_point_value.dart';

class HotelService {
  static const URL_SUGGEST_PLACE = 'https://test-micro-services.vntrip.vn/search-engine/search/v2/suggestion?keyword=';
  static const URL_SEARCHED_ROOM = 'https://test-micro-services.vntrip.vn/search-engine/search/vntrip-hotel-availability?request_source=app_android&province_id=66&nights=1&page=1&check_in_date=20220817';
  static const URL_DETAIL_HOTEL = 'https://test-micro-services.vntrip.vn/core-hotel-service/hotel/hotel-detail?hotel_ids=';
  static const URL_DETAIL_EACH_ROOM = 'https://test-micro-services.vntrip.vn/search-engine/v3/rooms-availability';
  static const URL_LIST_POINT_VALUE = 'https://test-micro-services.vntrip.vn/v2-user/loyalties/list_point_value';
  static const URL_CHECKOUT = 'https://test-micro-services.vntrip.vn/v3-booking/fe/checkout/collect-info';
  static const URL_BOOKING_REUQUEST = 'https://test-micro-services.vntrip.vn/v3-booking/booking-requests/';
  static const URL_PAYMENT_METHOD = 'https://test-micro-services.vntrip.vn/payment-service/fe/payment-method?request_from=ANDROID';
  static const URL_ORDER_HOTEL = 'https://test-micro-services.vntrip.vn/order-hotel/order/booking-request-fe/';


  static const REQUEST_SRC = 'app_android';
  static const TA_FROM_TYPE = 'app';

  static Future<http.Response> searchedHotelByScreen(RequestSearchRoom requestSearchRoom) async {

    String URL_SEARCH_HOTEL_BY_SCREEN = 'https://test-micro-services.vntrip.vn/search-engine/search/vntrip-hotel-availability'
        '?request_source=app_android'
        '&nights=1'
        '&location=${requestSearchRoom.location}'
        '&sort_mode=asc'
        '&filter_by_screen=${requestSearchRoom.filterByScreen}'
        '&page_size=30'
        '&sort_by=nearby_distance'
        '&page=1'
        '&check_in_date=${requestSearchRoom.checkInDate}';
    print('GET: $URL_SEARCH_HOTEL_BY_SCREEN');
    var uri = Uri.parse(URL_SEARCH_HOTEL_BY_SCREEN);
    return http.get(uri).then((http.Response response) => response);
  }

  static Future<http.Response> getSuggest(String keyword) async {
    // Map<String, String> queryParams = {
    //   'keyword': keyword,
    // };
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    return http.get(Uri.parse("$URL_SUGGEST_PLACE$keyword"), headers: headers).then((http.Response response) => response);
  }

  static Future<http.Response> searchedHotel(RequestSearchRoom requestSearchRoom) async {
    Map<String, String> queryParams = {
      'request_source': REQUEST_SRC,
      'province_id': requestSearchRoom.provinceId.toString(),
      'nights': requestSearchRoom.nights.toString(),
      'page': requestSearchRoom.page.toString(),
      'check_in_date': requestSearchRoom.checkInDate,
    };
    var uri = Uri.parse(URL_SEARCHED_ROOM);
    uri = uri.replace(queryParameters: queryParams);
    return http.get(uri).then((http.Response response) => response);
  }

  static Future<http.Response> detailHotel(int hotelId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    return http.get(Uri.parse("$URL_DETAIL_HOTEL$hotelId"), headers: headers).then((http.Response response) => response);
  }

  static Future<http.Response> detailEachRoom(RequestDetailHotel requestDetailHotel) async {
    Map<String, String> queryParams = {
      'request_from': REQUEST_SRC,
      'ta_from_type': TA_FROM_TYPE,
      'nights': requestDetailHotel.nights!.toString(),
      'checkin_date': requestDetailHotel.checkin_date.toString(),
      'hotel_id': requestDetailHotel.hotel_id.toString(),
      'room_count': requestDetailHotel.room_count.toString(),
      'adult_count': requestDetailHotel.adult_count.toString(),
      'is_international': requestDetailHotel.is_international.toString(),
    };
    var uri = Uri.parse(URL_DETAIL_EACH_ROOM);
    uri = uri.replace(queryParameters: queryParams);
    return http.get(uri).then((http.Response response) => response);
  }

  static Future<http.Response> postListPointValue(RequestListPointView request) async {
    Map<String, String> headers = {'Accept': 'application/json',
      'Content-type': 'application/json',};

    final response = await http
        .post(Uri.parse(URL_LIST_POINT_VALUE),
        body: request.toJson(), headers: headers);
    return response;
  }

  static Future<http.Response> postCheckOut(RequestCheckout request) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json',};

    final response = await http
        .post(Uri.parse(URL_CHECKOUT),
        body: jsonEncode(request.toJson()), headers: headers);
    print('POST $URL_CHECKOUT');
    print('Data: ${request.toString()}');
    return response;
  }

  static Future<http.Response> getBookingRequest(String bookingId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    print('GET $URL_BOOKING_REUQUEST$bookingId');
    return http.get(Uri.parse("$URL_BOOKING_REUQUEST$bookingId"), headers: headers).then((http.Response response) => response);
  }

  static Future<http.Response> getPaymentMethod() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8'
    };
    print('GET $URL_PAYMENT_METHOD');
    return http.get(Uri.parse(URL_PAYMENT_METHOD), headers: headers).then((http.Response response) => response);
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
        .patch(Uri.parse('$URL_BOOKING_REUQUEST$bookingRequestId/choose-payment-method'),
        body: jsonEncode(body), headers: headers);
    print('PATCH $URL_BOOKING_REUQUEST$bookingRequestId/choose-payment-method');
    print('Data: ${body.toString()}');
    return response;
  }

  static Future<http.Response> postOrderHotel( String bookingRequestId) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-type': 'application/json',};

    final response = await http
        .post(Uri.parse('$URL_ORDER_HOTEL$bookingRequestId'),
        body: jsonEncode({
          'update_order': false
        }), headers: headers);
    print('POST $URL_CHECKOUT');
    print('Data: update_order : fasle');
    return response;
  }

}