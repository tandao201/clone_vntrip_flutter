class RequestSearchRoom {
  String requestSource, checkInDate, checkOutDate, name;
  int provinceId, page, nights;
  String? location, filterByScreen;

  RequestSearchRoom(
      {required this.requestSource,
      required this.checkInDate,
      required this.checkOutDate,
      required this.provinceId,
      required this.page,
      required this.nights,
        required this.name});

  @override
  String toString() {
    // TODO: implement toString
    return 'provinceId: $provinceId, checkIn: $checkInDate, page: $page, nights:$nights, checkOut: $checkOutDate ';
  }
}
