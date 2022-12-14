///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class ResponseCheckoutData {
/*
{
  "general_ticket_id": "36897d16-ab53-48c8-b970-fad9f54968af",
  "booking_request_id": "19be6306-07e6-4309-825c-2d9d73dfd869",
  "booking_request_hotel_suggestion_id": "c9e63fcb-cf9f-4654-965a-551a93688f7e",
  "booking_request_hotel_rate_id": "d27439b2-6a73-4a50-bcb1-5fef7b2a97a4"
}
*/

  String? generalTicketId;
  String? bookingRequestId;
  String? bookingRequestHotelSuggestionId;
  String? bookingRequestHotelRateId;

  ResponseCheckoutData({
    this.generalTicketId,
    this.bookingRequestId,
    this.bookingRequestHotelSuggestionId,
    this.bookingRequestHotelRateId,
  });
  ResponseCheckoutData.fromJson(Map<String, dynamic> json) {
    generalTicketId = json['general_ticket_id']?.toString();
    bookingRequestId = json['booking_request_id']?.toString();
    bookingRequestHotelSuggestionId = json['booking_request_hotel_suggestion_id']?.toString();
    bookingRequestHotelRateId = json['booking_request_hotel_rate_id']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['general_ticket_id'] = generalTicketId;
    data['booking_request_id'] = bookingRequestId;
    data['booking_request_hotel_suggestion_id'] = bookingRequestHotelSuggestionId;
    data['booking_request_hotel_rate_id'] = bookingRequestHotelRateId;
    return data;
  }
}

class ResponseCheckout {
/*
{
  "status": "success",
  "message": "Success",
  "data": {
    "general_ticket_id": "36897d16-ab53-48c8-b970-fad9f54968af",
    "booking_request_id": "19be6306-07e6-4309-825c-2d9d73dfd869",
    "booking_request_hotel_suggestion_id": "c9e63fcb-cf9f-4654-965a-551a93688f7e",
    "booking_request_hotel_rate_id": "d27439b2-6a73-4a50-bcb1-5fef7b2a97a4"
  }
}
*/

  String? status;
  String? message;
  ResponseCheckoutData? data;

  ResponseCheckout({
    this.status,
    this.message,
    this.data,
  });
  ResponseCheckout.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    message = json['message']?.toString();
    data = (json['data'] != null) ? ResponseCheckoutData.fromJson(json['data']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
