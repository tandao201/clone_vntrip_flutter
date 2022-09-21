
import 'package:clone_vntrip/models/login/profile_user.dart';
import 'package:clone_vntrip/models/ticket/responses/response_searched_ticket.dart';
import 'package:clone_vntrip/screens/plane_ticket/payment_ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/Currency.dart';
import '../../components/Time.dart';
import '../../models/user_info.dart';
import '../../providers/login_providers.dart';
import '../../providers/ticket_providers/ticket_booking_provider.dart';
import 'detail_flight_ticket.dart';

class PreBookingTicket extends StatelessWidget {
  static const routeName = '/pre-booking-ticket';
  GlobalKey globalKey = GlobalKey();

  final TextEditingController _firstNameCtl = TextEditingController();
  final TextEditingController _nameCtl = TextEditingController();
  final TextEditingController _phoneCtl = TextEditingController();
  final TextEditingController _emailCtl = TextEditingController();

  final TextEditingController _firstNameReceiverCtl = TextEditingController();
  final TextEditingController _nameReceiverCtl = TextEditingController();
  final TextEditingController _dateOfBirthReceiverCtl = TextEditingController();

  TicketBookingProvider? _ticketBookingProvider;
  int totalPrice = 0;
  bool isBinding = false;

  @override
  Widget build(BuildContext context) {

    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    final ticketProv = Provider.of<TicketBookingProvider>(context);
    final loginProv = Provider.of<LoginProvider>(context);
    _ticketBookingProvider = ticketProv;

    UserInfo user = UserInfo();
    if (ticketProv.user == null) {
      user = UserInfo(gender: true, firstName: '', lastName: '', category: '', dateOfBirth: '',
          email: '', phone: '', isValid: false);
      print('user main null');
      ticketProv.changeUser(user);
    } else {
      print('user main khac null');
      user = ticketProv.user!;
    }

    // if (loginProv.profileUser !=null) {
    //   ProfileUser profileUser = loginProv.profileUser!;
    //   user = UserInfo(firstName: profileUser.data!.firstName!, phone: profileUser.data!.phone!, email: profileUser.data!.email!
    //       ,dateOfBirth: profileUser.data!.birthday!, lastName: profileUser.data!.lastName!,
    //       category: 'Liên hệ', isValid: false);
    //   print('user login khac null');
    //   ticketProv.changeUser(user);
    //   print('Email: ${ticketProv.user!.email}');
    //
    // } else {
    //   loginProv.getProfileUser();
    // }

    if (ticketProv.isSelectSecondFlight) {
      totalPrice = ticketProv.recentlyTicket!.totalPrice! +  ticketProv.recentlyTicketRoundTrip!.totalPrice!;
    } else {
      totalPrice = ticketProv.recentlyTicket!.totalPrice!;
    }



    if (ticketProv.receivers == null) {
      ticketProv.initReceivers();
    }

    void clickCancel() {

      Navigator.pop(context);
    }

    void clickViewDetail(ResponseSearchedTicketListFareData? itemData) {
      ticketProv.changeRecentlyTicketViewDetail(itemData!);
      Navigator.pushNamed(context, DetailFightTicket.routeName);
    }

    void _launchURL(String url) async {
      await launchUrl(Uri.parse(url));
    }

    void inputFormContact(BuildContext context) {
      print('selectPassengers');
      user.isFirstPick = false;
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return formContact(heightScreen,context);
          },
          constraints: BoxConstraints(maxHeight: heightScreen));
    }

    void inputFormReceiver(BuildContext context, UserInfo receiver) {
      print('selectPassengers');
      receiver.isFirstPick = false;
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return formReceiver(heightScreen,context, receiver);
          },
          constraints: BoxConstraints(maxHeight: heightScreen));
    }

    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        clickCancel();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      child: const Text(
                        'Nhập thông tin',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _launchURL("tel://0963266688"),
                      child: Container(
                        margin: const EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.all(3),
                        child: const Icon(
                          Icons.phone,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ), //appBar
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(
                          color: Colors.grey[300]!,
                          width: 5,
                        ))),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    color: Colors.green[300]!,
                                    height: 4,
                                  )
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    color: Colors.grey[300]!,
                                    height: 4,
                                  )
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.green[300]!,
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                child:  Icon(
                                  size: 12,
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.green[300]!,
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                child:  Icon(
                                  size: 12,
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                height: 25,
                                width: 25,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green[300]!,
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Đặt chỗ', style: TextStyle(fontSize: 12),),
                        Text('Thanh toán', style: TextStyle(fontSize: 12),),
                        Text('Hoàn thành', style: TextStyle(fontSize: 12),)
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.grey[200]!,
                  child: SingleChildScrollView(
                    // reverse: true,
                    physics: const BouncingScrollPhysics(),
                    child: Consumer<TicketBookingProvider>(
                      builder: (context, ticketPro, child){
                        return Column(
                          children: [
                            itemInfoTicket(widthScreen, heightScreen, 'Chiều đi', ticketProv, ticketProv.recentlyTicket!, clickViewDetail),
                            ticketProv.recentlyTicketRoundTrip == null
                                ? Container()
                                : Visibility(
                              visible: ticketProv.isSelectSecondFlight,
                              child: itemInfoTicket(widthScreen, heightScreen, 'Chiều về', ticketProv,ticketProv.recentlyTicketRoundTrip! , clickViewDetail),
                            ),
                            GestureDetector(
                              onTap: () {
                                inputFormContact(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        top: BorderSide(
                                          color: Colors.grey[300]!,
                                          width: 5,
                                        )
                                    )
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Thông tin liên hệ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                        ticketPro.user!.isFirstPick == true
                                            ? const Icon(Icons.add)
                                            : ticketPro.user!.isValid! == true
                                            ? const Icon(Icons.check, size: 16, color: Colors.green,)
                                            : const Icon(Icons.error_outline, size: 16, color: Colors.red,)
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('${ticketPro.user!.lastName!} ${ticketPro.user!.firstName!}',style: const TextStyle(fontSize: 14),),
                                        Text(ticketPro.user!.phone!, style: const TextStyle(color: Colors.grey, fontSize: 14),),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: widthScreen,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      top: BorderSide(
                                        color: Colors.grey[300]!,
                                        width: 5,
                                      )
                                  )
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Thông tin hành khách', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                  const SizedBox(height: 10,),
                                  Column(
                                    children: ticketProv.receivers!.map(
                                            (receiver) => GestureDetector(
                                          onTap: () {
                                            inputFormReceiver(context, receiver);
                                          },
                                          child: itemReceiver(receiver),
                                        )
                                    ).toList(),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      top: BorderSide(
                                        color: Colors.grey[300]!,
                                        width: 5,
                                      )
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text('Mua thêm hành lý', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                  Icon(Icons.arrow_forward_ios, size: 19, color: Colors.grey,)
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(
                          color: Colors.grey[300]!,
                          width: 5,
                        ))),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text:  TextSpan(
                                children: [
                                  const TextSpan(text: 'Tổng cộng: ', style: TextStyle(fontSize: 11, color: Colors.black)),
                                  TextSpan(text: Currency.displayPriceFormat(
                                    totalPrice
                                  ), style: const TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold)),
                                ]
                            )
                        ),
                        Container(
                          child: true
                              ? const Text('Đã bao gồm thuế VAT',style: TextStyle(fontSize: 11, color: Colors.grey) )
                              : const Text('Chưa bao gồm thuế VAT',style: TextStyle(fontSize: 11, color: Colors.grey) ),
                        ),
                        Container(
                          child: true
                              ? const Text('Đã bao gồm phí dịch vụ',style: TextStyle(fontSize: 11, color: Colors.grey) )
                              : const Text('Chưa bao gồm phí dịch vụ',style: TextStyle(fontSize: 11, color: Colors.grey) ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        print('Tap continue');
                        ticketProv.clickPayment();
                        Navigator.pushNamed(context, PaymentTicket.routeName);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: const Text('Tiếp tục', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget itemReceiver(UserInfo receiver) {
    String personType = '(người lớn)';
    if (receiver.category!.contains('Trẻ em')){
      personType = '(trẻ em)';
    } else if (receiver.category!.contains('Em bé')) {
      personType = '(em bé)';
    }
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                receiver.firstName!.isEmpty
                  ? receiver.category!
                  : '${receiver.lastName!} ${receiver.firstName! }',
                style: const TextStyle(fontSize: 15),),
              const SizedBox(height: 5,),
              Text(
                  personType, style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          receiver.isFirstPick == true
            ? const Icon(Icons.add)
              : receiver.dateOfBirth!.isEmpty
                ? const Icon(Icons.error_outline, color: Colors.red,)
                : Text(receiver.dateOfBirth!, style: const TextStyle(color: Colors.grey),)

        ],
      ),
    );
  }

  Widget itemInfoTicket(double width, double height, String title, TicketBookingProvider? ticketProv,ResponseSearchedTicketListFareData itemData,  Function clickItem) {
    String imgPath = '';
    String moreInfo = '';
    if (itemData.airline == 'QH') imgPath = 'assets/images/bamboo.png';
    if (itemData.airline == 'VN') imgPath = 'assets/images/vietnamairlines.png';
    if (itemData.airline == 'VJ') imgPath = 'assets/images/vietjet.png';

    List<String> flightNums = (itemData.listFlight![0]!.flightNumber!.split(','));
    if ( flightNums.length <2 ) {
      moreInfo = 'Bay thẳng';
    } else {
      moreInfo = '${flightNums.length-1} chặng';
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
                color: Colors.grey[300]!,
                width: 5,
              ))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              Text(Time.formatTimeFromString(itemData.listFlight![0]!.startDate!), style: const TextStyle(fontSize: 14, color: Colors.grey),),
              GestureDetector(
                onTap: () {
                  print('Click view detail');
                  clickItem(itemData);
                },
                child: const Text('Chi tiết', style: TextStyle(fontSize: 12, color: Colors.blue),),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  width: itemData.airline == 'VN' ? 120 : 70,
                  height: 20,
                  child: Image.asset(
                    imgPath,
                    fit: BoxFit.fill,
                  )
              ),
              const SizedBox(width: 10,),
              Text(itemData.listFlight![0]!.flightNumber!, style: const TextStyle(fontSize: 13, color: Colors.grey),)
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey[200]!
            ),
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ticketProv!.isSelectSecondFlight ? ticketProv.toPlace!.code! :ticketProv.goPlace!.code!,
                  style: const TextStyle(color: Colors.grey),
                ),
                    const SizedBox(height: 5,),
                    Text(Time.getTimeHourAndMinute(itemData.listFlight![0]!.startDate!), style: const TextStyle(fontSize: 15)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${Time.changeMinuteToHourString(itemData.listFlight![0]!.duration!)}m', style: const TextStyle(color: Colors.grey, fontSize: 12),),
                    const Icon(Icons.arrow_right_alt, color: Colors.grey, size: 11,),
                    Text(moreInfo, style: const TextStyle(color: Colors.grey, fontSize: 12),),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(ticketProv.toPlace!.code!, style: const TextStyle(color: Colors.grey),),
                    const SizedBox(height: 5,),
                    Text(Time.getTimeHourAndMinute(itemData.listFlight![0]!.endDate!), style: const TextStyle(fontSize: 15)),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget formContact(double height, BuildContext context) {
    void clickCancel() {
      _ticketBookingProvider!.resetError();
      Navigator.pop(context);
    }
    UserInfo user = _ticketBookingProvider!.user!;

    if (_ticketBookingProvider!.user == null) {
      print('user from form contact null');
      user = UserInfo(gender: true, firstName: '', lastName: '', category: '', dateOfBirth: '',
          email: '', phone: '', isValid: false);
      _ticketBookingProvider!.changeUser(user);
    } else {
      print('user from form contact khac null');
      user = _ticketBookingProvider!.user!;
    }

    // if (user.firstName!.isEmpty) {
    //   user = UserInfo(firstName: profileUser.data!.firstName!, phone: profileUser.data!.phone!, email: profileUser.data!.email!
    //       ,dateOfBirth: profileUser.data!.birthday!, lastName: profileUser.data!.lastName!,
    //       category: 'Liên hệ', isValid: false);
    // }

    if (!isBinding){
      _firstNameCtl.text = user.firstName!;
      _nameCtl.text = user.lastName!;
      _phoneCtl.text = user.phone!;
      _emailCtl.text = user.email!;
      isBinding = true;
    }

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(
              top: MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top),
          child: Consumer<TicketBookingProvider>(
            builder: (context, ticketProv, child) {
              return SingleChildScrollView(
                child: SizedBox(
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                clickCancel();
                              },
                              child: const Icon(
                                Icons.close,
                                size: 25,
                                color: Colors.black,
                              ),
                            ),
                            const Text(
                              'Thông tin liên hệ',
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            Container(),
                          ],
                        ), //appBar
                      ),
                      formInput( _firstNameCtl, _nameCtl, _phoneCtl, _emailCtl, context),
                      GestureDetector(
                        onTap: () {
                          ticketProv.checkInput(_firstNameCtl.text, _nameCtl.text, _phoneCtl.text, _emailCtl.text);
                          if (ticketProv.errorValid.isEmpty){
                            ticketProv.changeUser(UserInfo(
                              isValid: true,
                              isFirstPick: false,
                              firstName: _firstNameCtl.text,
                              lastName: _nameCtl.text,
                              phone: _phoneCtl.text,
                              email: _emailCtl.text
                            ));
                            clickCancel();
                          }
                          print('Click hoan tat');
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(4)
                          ),
                          child: const Center(
                            child: Text('Hoàn tất', style: TextStyle(fontSize: 16, color: Colors.white),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget formReceiver(double height, BuildContext context, UserInfo receiver) {
    void clickCancel() {
      Navigator.pop(context);
    }

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(
              top: MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top),
          child: Consumer<TicketBookingProvider>(
            builder: (context, ticketProv, child) {
              return SingleChildScrollView(
                child: SizedBox(
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                clickCancel();
                              },
                              child: const Icon(
                                Icons.close,
                                size: 25,
                                color: Colors.black,
                              ),
                            ),
                            const Text(
                              'Thông tin hành khách',
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            Container(),
                          ],
                        ), //appBar
                      ),
                      formInputReceiver(ticketProv, _firstNameReceiverCtl, _nameReceiverCtl,_dateOfBirthReceiverCtl, context, receiver),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget formInputReceiver(TicketBookingProvider ticketProv ,TextEditingController firstNameCtl, TextEditingController nameCtl,TextEditingController dateOfBirthCtl,  BuildContext context, UserInfo receiver) {
    void clickPickDateOfBirth() async {
      var datePicked = await DatePicker.showSimpleDatePicker(
        context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime(2100),
        dateFormat: "dd/MM/yyyy",
        locale: DateTimePickerLocale.en_us,
        looping: true,
      );
      dateOfBirthCtl.text = Time.getFullDateString(datePicked.toString());
      // ticketProv.changeDateOfBirth(Time.getFullDateString(datePicked.toString()));
      print('Time: ${Time.getFullDateString(datePicked.toString())}');
    }

    // _firstNameReceiverCtl.text = FormatString.getFirstName(ticketProv.receiver!.name!);
    // _nameReceiverCtl.text = FormatString.getSubAndName(ticketProv.receiver!.name!);


    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
                color: Colors.grey[300]!,
                width: 2,
              )
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: _ticketBookingProvider!.errorReceiver.isNotEmpty,
              child: Text(_ticketBookingProvider!.errorReceiver, style: const TextStyle(color: Colors.red, fontSize: 12),)
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(receiver.category!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                Row(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 24.0,
                            width: 24.0,
                            child: Radio(
                              value: Gender.male,
                              groupValue: ticketProv.gender,
                              onChanged: (Gender? value) {
                                ticketProv.changeAnotherGender(value!);
                              },
                            ),
                          ),
                          const SizedBox(width: 10,),
                          GestureDetector(
                            onTap: () {
                              if (ticketProv.gender == Gender.male) {
                                ticketProv.changeAnotherGender(Gender.female);
                              } else {
                                ticketProv.changeAnotherGender(Gender.male);
                              }
                            },
                            child: Text(
                              'Nam',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: ticketProv.gender == Gender.male ? Colors.blue : Colors.black
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 24.0,
                            width: 24.0,
                            child: Radio(
                              value: Gender.female,
                              groupValue: ticketProv.gender,
                              onChanged: (Gender? value) {
                                ticketProv.changeAnotherGender(value!);
                              },
                            ),
                          ),
                          const SizedBox(width: 10,),
                          GestureDetector(
                            onTap: () {
                              if (ticketProv.gender == Gender.female) {
                                ticketProv.changeAnotherGender(Gender.male);
                              } else {
                                ticketProv.changeAnotherGender(Gender.female);
                              }
                            },
                            child: Text(
                              'Nữ',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: ticketProv.gender == Gender.female ? Colors.blue : Colors.black
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          inputField(context, firstNameCtl, 'Họ (giống CMND, không dấu)'),
          inputField(context, nameCtl, 'Tên đệm & tên (giống CMND, không dấu)'),
          GestureDetector(
            onTap: () {
              clickPickDateOfBirth();
            },
            child: inputField(context, dateOfBirthCtl, 'Ngày sinh', receiver),
          ),
          GestureDetector(
            onTap: () {
              // ticketProv.clickReceiverDone(_firstNameReceiverCtl.text, _nameReceiverCtl.text, _dateOfBirthReceiverCtl.text, true);
              ticketProv.checkInputReceiver(_firstNameReceiverCtl.text, _nameReceiverCtl.text, _dateOfBirthReceiverCtl.text);
              if (ticketProv.errorReceiver.isEmpty) {
                ticketProv.updateReceiver(UserInfo(
                  firstName: _firstNameReceiverCtl.text,
                  lastName: _nameReceiverCtl.text,
                  dateOfBirth: _dateOfBirthReceiverCtl.text,
                  category: receiver.category,
                  email: receiver.email,
                  phone: receiver.phone,
                  isValid: true,
                  gender: receiver.gender,
                  isFirstPick: false
                ));
                Navigator.pop(context);
              }

            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric( vertical: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(4)
              ),
              child: const Center(
                child: Text('Hoàn tất', style: TextStyle(fontSize: 16, color: Colors.white),),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget formInput( TextEditingController firstNameCtl, TextEditingController nameCtl,
      TextEditingController phoneCtl, TextEditingController emailCtl, BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
                color: Colors.grey[300]!,
                width: 2,
              )
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: _ticketBookingProvider!.errorValid.isNotEmpty,
              child: Text(_ticketBookingProvider!.errorValid, style: const TextStyle(color: Colors.red, fontSize: 12),)
          ),
          inputField(context, firstNameCtl, 'Họ (giống CMND, không dấu)'),
          inputField(context, nameCtl, 'Tên đệm & tên (giống CMND, không dấu)'),
          inputField(context, phoneCtl, 'Số điện thoại'),
          inputField(context, emailCtl, 'Email'),
        ],
      ),
    );
  }

  Widget inputField(BuildContext context ,TextEditingController controller, String title, [UserInfo? receiver]) {
    return Consumer<TicketBookingProvider>(
      builder: (context, bookingProv, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: title,
                        style: const TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      const TextSpan(
                        text: ' *',
                        style: TextStyle(fontSize: 15, color: Colors.red),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: title == 'Quốc gia/ Mã vùng' || title == 'Ngày sinh'
                  ?  TextField(
                onChanged: (String item) {
                  print(item);
                  controller.text = item;
                },
                controller: controller,
                enabled: false,
                decoration:  InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.only( left: 10),
                  suffixIcon : const Icon(Icons.keyboard_arrow_down, size: 30,),
                  suffixIconConstraints: BoxConstraints(
                      minHeight: 38,
                      minWidth: 38
                  ),
                  hintStyle: const TextStyle(color: Colors.black),
                  hintText: title == 'Ngày sinh' ? receiver!.dateOfBirth! : '+84',
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              )
                  : TextField(
                onTap: ()async{
                  bookingProv.resetError();
                  await Future.delayed(const Duration(milliseconds: 200));
                  RenderObject? object = globalKey.currentContext?.findRenderObject();
                  object?.showOnScreen();
                },
                controller: controller,
                decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
              ),
            ),
            Visibility(
                visible: title == 'Email',
                child: Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 15),
                  child: const Text('Email xác nhận đặt phòng sẽ được gửi tới địa chỉ này', style: TextStyle(color: Colors.grey, fontSize: 13),),
                )
            )
          ],
        );
      },
    );
  }
}