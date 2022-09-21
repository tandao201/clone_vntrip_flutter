class RequestDetailHotel {
  String? request_from;
  String? ta_from_type;
  int? nights;
  String? checkin_date;
  int? hotel_id;
  int? room_count;
  int? adult_count;
  bool? is_international;

  RequestDetailHotel(
  {this.request_from,
    this.ta_from_type,
    this.nights,
    this.checkin_date,
    this.hotel_id,
    this.room_count,
    this.adult_count,
    this.is_international});
}