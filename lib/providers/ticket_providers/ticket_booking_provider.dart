import 'dart:convert';
import 'package:clone_vntrip/models/ticket/people.dart';
import 'package:clone_vntrip/models/ticket/requests/request_search_ticket.dart';
import 'package:clone_vntrip/models/ticket/responses/response_place_flight.dart';
import 'package:clone_vntrip/models/ticket/responses/response_searched_ticket.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../components/time.dart';
import '../../models/ticket/requests/request_flight_rate.dart';
import '../../models/user_info.dart';
import '../../services/ticket_services.dart';
import '../../validators/validator_login.dart';

enum Gender {
  male, female
}

enum ViewPrice {
  only, all
}

class TicketBookingProvider with ChangeNotifier {
  List<ResponsePlaceFlightDataDomesticRegionData> defaults = [
    ResponsePlaceFlightDataDomesticRegionData(
        code: 'HAN', provinceName: 'Hà Nội', name: 'Sân bay quốc tế Nội Bài'),
    ResponsePlaceFlightDataDomesticRegionData(
        code: 'CXR', provinceName: 'Khánh Hòa', name: 'Sân bay quốc tế Cam Ranh'),
    ResponsePlaceFlightDataDomesticRegionData(
        code: 'SGN', provinceName: 'TP Hồ Chí Minh', name: 'Sân bay quốc tế Tân Sơn Nhất'),
    ResponsePlaceFlightDataDomesticRegionData(
        code: 'PQC', provinceName: 'Kiên Giang', name: 'Sân bay Rạch Giá'),
  ];

  static const sortLowPrice = 'Giá thấp nhất';
  static const sortTakeOffEarly = 'Cất cánh sớm nhất';
  static const sortTakeOffLate = 'Cất cánh muộn nhất';
  static const sortLandingEarly = 'Hạ cánh sớm nhất';
  static const sortLandingLate = 'Hạ cánh muộn nhất';
  static const sortFlightTime = 'Thời gian bay ngắn nhất';
  static const FLIGHT_TYPE = 'domestic';
  static const REQUEST_FROM = 'APP_ANDROID';

  final String VIETJET = 'VJ';
  final String BAMBOO = 'QH';
  final String VIETNAMAIRLINES = 'VN';

  final String ECO_CLASS = "economy";
  final String BUSINESS = "business";

  List<dynamic> placesFlight = <dynamic>[];
  List<dynamic> placesCallingApi = <dynamic>[];
  ResponsePlaceFlightDataDomesticRegionData? goPlace;
  ResponsePlaceFlightDataDomesticRegionData? toPlace;
  People people = People(adult: 1, children: 0, baby: 0);
  People peopleMain = People(adult: 1, children: 0, baby: 0);
  String peopleString = "1 người lớn";
  int selectGoOrTo = 0;
  bool isRoundTrip = false;
  bool isLoading = true;
  bool isFirstTime = true;
  RequestSearchTicket? requestSearchTicket;
  List<ResponseSearchedTicketListFareData>? listFare;
  List<ResponseSearchedTicketListFareData>? listFareRoundTrip;
  List<ResponseSearchedTicketListFareData>? listFareMain;
  List<ResponseSearchedTicketListFareData>? listFareRoundTripMain;
  ResponseSearchedTicketListFareData? recentlyTicketViewDetail;
  ResponseSearchedTicketListFareData? recentlyTicket;
  ResponseSearchedTicketListFareData? recentlyTicketRoundTrip;
  ResponseSearchedTicket? responseSearchTicket;
  int pageSelected = 1;
  String errorValid = "";
  String errorReceiver = '';
  UserInfo? user;
  List<UserInfo>? receivers;
  bool isSelectSecondFlight = false;
  Gender gender = Gender.male;
  ViewPrice viewPrice = ViewPrice.all;
  bool isCorrectUser = false;
  bool checkBoxCheck = true;
  String sortBy= sortLowPrice;
  RequestFlightRate? requestFlightRate;
  List<String> airlines = <String>[
    'Vietjet Air',
    'Vietnam Airlines',
    'Bamboo Airways'
  ];

  Map<String, String> mapAirlines = {
    'VJ' : 'Vietjet Air',
    'VN' : 'Vietnam Airlines',
    'QH' : 'Bamboo Airways'
  };

  void changeUser(UserInfo user){
    this.user = user;
    print('Change user: ${user.email}');
  }

  void clickSortFlight() {
    listFare = listFareMain!.where((element) => airlines.contains(mapAirlines[element.airline])).toList();
    notifyListeners();
  }

  void addToAirlinesItem(String item) {
    airlines.add(item);
    notifyListeners();
  }

  void deleteAirlinesItem(String item) {
    airlines.remove(item);
    notifyListeners();
  }

  void changeSortBy(String sort) {
    sortBy = sort;
    switch (sort) {
      case sortLowPrice:
        listFare?.sort((a,b) => a.totalPrice!.compareTo(b.totalPrice!)  );
        listFareRoundTrip?.sort((a,b) => a.totalPrice!.compareTo(b.totalPrice!)  );
        print('Click $sortLowPrice');
        break;
      case sortTakeOffEarly:
        listFare?.sort((a,b) => a.flightItem!.startDate!.compareTo(b.flightItem!.startDate!)  );
        listFareRoundTrip?.sort((a,b) => a.flightItem!.startDate!.compareTo(b.flightItem!.startDate!)  );
        print('Click $sortTakeOffEarly');
        break;
      case sortTakeOffLate:
        listFare?.sort((a,b) => b.flightItem!.startDate!.compareTo(a.flightItem!.startDate!)  );
        listFareRoundTrip?.sort((a,b) => b.flightItem!.startDate!.compareTo(a.flightItem!.startDate!)  );
        print('Click $sortTakeOffLate');
        break;
      case sortLandingEarly:
        listFare?.sort((a,b) => a.flightItem!.endDate!.compareTo(b.flightItem!.endDate!)  );
        listFareRoundTrip?.sort((a,b) => a.flightItem!.endDate!.compareTo(b.flightItem!.endDate!)  );
        print('Click $sortLandingEarly');
        break;
      case sortLandingLate:
        listFare?.sort((a,b) => a.flightItem!.endDate!.compareTo(b.flightItem!.endDate!)  );
        listFareRoundTrip?.sort((a,b) => b.flightItem!.endDate!.compareTo(a.flightItem!.endDate!)  );
        print('Click $sortLandingLate');
        break;
      case sortFlightTime:
        listFare?.sort((a,b) => a.flightItem!.duration!.compareTo(b.flightItem!.duration!)  );
        listFareRoundTrip?.sort((a,b) => a.flightItem!.duration!.compareTo(b.flightItem!.duration!)  );
        print('Click $sortFlightTime');
        break;
    }
    notifyListeners();
  }

  void changeCheckBoxCheck(){
    checkBoxCheck = !checkBoxCheck;
    notifyListeners();
  }

  void updateReceiver(UserInfo userInfo){
    for(int i=0 ; i<receivers!.length ; i++){
      if (receivers![i].category == userInfo.category){
        receivers![i] = userInfo;
        notifyListeners();
        break;
      }
    }
  }

  void initReceivers() {
    print('Init receivers list');
    receivers = <UserInfo>[];
    if (responseSearchTicket!.listFareData != null && responseSearchTicket!.listFareData!.isNotEmpty) {
      for (int i=0 ; i<peopleMain.adult! ; i++) {
        receivers?.add(UserInfo(category: 'Người lớn ${i+1}', dateOfBirth: '', lastName: '', firstName: '',gender: true));
      }
      for (int i=0 ; i<peopleMain.children! ; i++) {
        receivers?.add(UserInfo(category: 'Trẻ em ${i+1}', dateOfBirth: '', lastName: '', firstName: '',gender: true));
      }
      for (int i=0 ; i<peopleMain.baby! ; i++) {
        receivers?.add(UserInfo(category: 'Em bé ${i+1}', dateOfBirth: '', lastName: '', firstName: '',gender: true));
      }
    }
    print('Receivers list: ${receivers!.length}');
  }

  void checkInputReceiver(String firstName, String lastName, String dateOfBirth){
    if (firstName.isEmpty || lastName.isEmpty || dateOfBirth.isEmpty){
      errorReceiver = 'Không để trống';
    } else {
      errorReceiver = '';
    }
    notifyListeners();
  }



  void initReceiver() {
    // receivers = <UserInfo>[];
  }

  // void clickReceiverDone(String firstName, String lastName,String dateOfBirth ,bool gender) {
  //   receiver = UserInfo(name: '$firstName $lastName', dateOfBirth: dateOfBirth, gender: gender);
  //   notifyListeners();
  // }

  // void changeDateOfBirth(String date) {
  //   receiver!.dateOfBirth = date;
  //   notifyListeners();
  // }

  void changeAnotherGender(Gender value) {
    gender = value;
    notifyListeners();
  }

  void changeAnotherViewPrice(ViewPrice value) {
    viewPrice = value;
    notifyListeners();
  }

  void changeSelectSecondFlight() {
    isSelectSecondFlight = !isSelectSecondFlight;
    notifyListeners();
  }

  void resetSelectSecondFlight() {
    isSelectSecondFlight = false;
    notifyListeners();
  }

  void changeRoundTrip() {
    isRoundTrip = !isRoundTrip;
    notifyListeners();
  }

  Future<void> getPlacesFlight() async {
    _addData('Nổi bật', defaults);
    try {
      http.Response response = await TicketServices.getPlace();
      if (response.statusCode == 200) {
        print('status: ${response.statusCode}');
        var responsePlace =
            ResponsePlaceFlight.fromJson(json.decode(response.body));
        if (responsePlace.status == 'success') {
          print('Data: ${responsePlace.data?.domestic.toString()}');
          print('Data: ${responsePlace.data?.domestic![0]!.regionData![0].toString()}');
          _addData('other', responsePlace.data?.domestic![0]!.regionData!);
          _addData('Miền Bắc', responsePlace.data?.domestic![1]!.regionData!);
          _addData('Miền Trung', responsePlace.data?.domestic![2]!.regionData!);
          _addData('Miền Nam', responsePlace.data?.domestic![3]!.regionData!);
          placesFlight = placesCallingApi;
        }
        notifyListeners();
      } else {
        print('failure');
      }
    } catch (e) {
      print("Error call api: ${e.toString()}");
    }
  }

  void _addData(
      String title, List<ResponsePlaceFlightDataDomesticRegionData?>? list) {
    placesCallingApi.add(title);
    placesCallingApi.addAll(list!);
  }

  void clickPlaceItem(
      ResponsePlaceFlightDataDomesticRegionData itemData, int where) {
    if (where == 1) {
      goPlace = itemData;
    } else {
      toPlace = itemData;
    }
    for (int i = 0; i < placesCallingApi.length; i++) {
      if (placesCallingApi[i] is ResponsePlaceFlightDataDomesticRegionData) {
        if (placesCallingApi[i].code == goPlace?.code ||
            placesCallingApi[i].code == toPlace?.code) {
          placesCallingApi[i].isSelect = true;
        } else {
          placesCallingApi[i].isSelect = false;
        }
      }
    }
    placesFlight = placesCallingApi;
    notifyListeners();
  }

  void clickSwapPlace() {
    var tmp = goPlace;
    goPlace = toPlace;
    toPlace = tmp;
    notifyListeners();
  }

  void setGoOrTo(int where) {
    selectGoOrTo = where;
    notifyListeners();
  }

  Future<void> searchByKeyword(String keyword) async {
    placesFlight.clear();
    for (int i = 0; i < placesCallingApi.length; i++) {
      if (placesCallingApi[i] is String) {
        placesFlight.add(placesCallingApi[i]);
      }
      if (placesCallingApi[i] is ResponsePlaceFlightDataDomesticRegionData) {
        if (placesCallingApi[i].provinceName.contains(keyword)) {
          placesFlight.add(placesCallingApi[i]);
        }
      }
    }
    notifyListeners();
  }

  void changeNumber(People mPeople) {
    print('Changing people...${mPeople.adult}');
    people = mPeople;
    notifyListeners();
  }

  void clickBtnSelectPeople() {
    peopleMain = people;
    peopleString = '${peopleMain.adult} người lớn';
    if (peopleMain.children != 0) {
      peopleString = '$peopleString - ${peopleMain.children} trẻ em';
    }
    if (peopleMain.baby != 0) {
      peopleString = '$peopleString - ${peopleMain.baby} em bé';
    }
    notifyListeners();
  }

  void clickPeopleChange() {
    people = peopleMain;
    notifyListeners();
  }

  void clickBtnSearchTicket(DateTimeRange dateTimeRange) {
    if (goPlace != null && toPlace != null) {
      List<RequestSearchTicketListFlight> listFlight =
          <RequestSearchTicketListFlight>[];
      if (isRoundTrip) {
        listFlight.addAll([
          RequestSearchTicketListFlight(
              departDate: Time.getDateString(dateTimeRange.start),
              endPoint: toPlace?.code,
              startPoint: goPlace?.code),
          RequestSearchTicketListFlight(
              departDate: Time.getDateString(dateTimeRange.end),
              endPoint: goPlace?.code,
              startPoint: toPlace?.code),
        ]);
      } else {
        listFlight.add(
          RequestSearchTicketListFlight(
              departDate: Time.getDateString(dateTimeRange.start),
              endPoint: toPlace?.code,
              startPoint: goPlace?.code),
        );
      }
      requestSearchTicket = RequestSearchTicket(
          adultCount: peopleMain.adult,
          childCount: peopleMain.children,
          infantCount: peopleMain.baby,
          listFlight: listFlight,
          goPlace: goPlace?.provinceName,
          toPlace: toPlace?.provinceName);
    }
    print('Request Search Ticket: $requestSearchTicket');
  }

  Future<void> searchTicket( RequestSearchTicket request) async {
    listFare = <ResponseSearchedTicketListFareData>[];
    listFareRoundTrip = <ResponseSearchedTicketListFareData>[];
    isFirstTime = false;
    print('Calling Search ticket api: .....');
    try {

    http.Response response = await TicketServices.postSearchedTicket(request);
    if (response.statusCode == 200) {
      print('Calling Search ticket api: ${response.statusCode}');
      print('Calling Search ticket api: ${response.body.toString()}');
      responseSearchTicket =
      ResponseSearchedTicket.fromJson(json.decode(response.body));
      if (responseSearchTicket!.status == true) {
        print(responseSearchTicket!.status);
        if (responseSearchTicket!.listFareData != null) {
          if (!isRoundTrip) {
            listFareMain =
            responseSearchTicket!.listFareData as List<ResponseSearchedTicketListFareData>;

            listFareMain?.sort((a,b) => a.totalPrice!.compareTo(b.totalPrice!)  );
            listFare = listFareMain;
            if (listFare!.isEmpty) {
              print('Empty... ${listFare!.length}');
              isLoading = false;
              notifyListeners();
              return ;
            }
          } else {
            listFareMain = responseSearchTicket!.listFareData?.cast<ResponseSearchedTicketListFareData>().where(
                    (element) => Time.formatTimeStringFromString(element.listFlight![0]!.startDate!) == request.listFlight![0]!.departDate
            ).toList();

            listFareRoundTripMain = responseSearchTicket!.listFareData?.cast<ResponseSearchedTicketListFareData>().where(
                    (element) => Time.formatTimeStringFromString(element.listFlight![0]!.startDate!) == request.listFlight![1]!.departDate
            ).toList();

            print('List fare lenght: ${listFareRoundTripMain!.length}');

            listFareMain?.sort((a,b) => a.totalPrice!.compareTo(b.totalPrice!)  );
            listFareRoundTripMain?.sort((a,b) => a.totalPrice!.compareTo(b.totalPrice!)  );

            listFare = listFareMain;
            listFareRoundTrip = listFareRoundTripMain;
          }
        }
        isLoading = false;
        print('Calling Search ticket api: $isSelectSecondFlight');
        notifyListeners();
      }
    }
    } catch (e) {
      print("Calling Search hotel api: ${e.toString()}");
    }
  }

  void changeRecentlyTicket(ResponseSearchedTicketListFareData ticket) {
    recentlyTicket = ticket;
    notifyListeners();
  }

  void changeRecentlyTicketViewDetail(ResponseSearchedTicketListFareData ticket) {
    recentlyTicketViewDetail = ticket;
    notifyListeners();
  }

  void changeRecentlyTicketRoundTrip(ResponseSearchedTicketListFareData ticket) {
    recentlyTicketRoundTrip = ticket;
    notifyListeners();
  }

  void resetData() {
    sortBy = sortLowPrice;
    receivers = null;
    responseSearchTicket = null;
    viewPrice = ViewPrice.all;
    checkBoxCheck = true;
    listFare = null;
    isLoading = true;
  }

  ResponsePlaceFlightDataDomesticRegionData? getPlacePoint(String code) {
    for (var item in placesFlight) {
      if (item is ResponsePlaceFlightDataDomesticRegionData) {
        if (item.code == code){
          return item;
        }
      }
    }
    return null;
  }
  void changePageSelect (int page) {
    pageSelected = page;
    notifyListeners();
  }

  void resetPageSelect() {
    pageSelected = 1;
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

  String _getTypePassenger(String category){
    if (category.contains("Người lớn")){
      return "ADT";
    }
    if (category.contains("Trẻ em")){
      return "CHD";
    }
    return "INF";
  }

  void clickPayment(){
    List<RequestFlightRateListFareData> listFare = <RequestFlightRateListFareData>[];
    List<RequestFlightRateListPassenger> listPassenger = <RequestFlightRateListPassenger>[];
    if (isRoundTrip) {
      listFare.add(RequestFlightRateListFareData.fromJson(recentlyTicket!.toJson()));
      listFare.add(RequestFlightRateListFareData.fromJson(recentlyTicketRoundTrip!.toJson()));
    } else {
      listFare.add(RequestFlightRateListFareData.fromJson(recentlyTicket!.toJson()));
    }

    for (int i=0 ; i<receivers!.length ; i++) {
      listPassenger.add(RequestFlightRateListPassenger(
        firstName: receivers![i].firstName,
        lastName: receivers![i].lastName,
        gender: receivers![i].gender,
        birthday: Time.formatDate(receivers![i].dateOfBirth!),
        index: i,
        type: _getTypePassenger(receivers![i].category!)
      ));
    }

    requestFlightRate = RequestFlightRate(
      bookable: false,
      booker: RequestFlightRateBooker(
        gender: user!.gender == true ? 1 : 2,
        phone: user!.phone,
        email: user!.email,
        lastName: user!.lastName,
        firstName: user!.firstName
      ),
      flightType: FLIGHT_TYPE,
      itinerary: isRoundTrip == true ? 2 : 1,
      requestFrom: REQUEST_FROM,
      listFareData: listFare,
      listPassenger: listPassenger
    );
  }

  void resetError() {
    errorReceiver='';
    errorValid = '';
    notifyListeners();
  }

}
