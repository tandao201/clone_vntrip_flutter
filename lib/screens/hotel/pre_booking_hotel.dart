import 'package:clone_vntrip/components/format_string.dart';
import 'package:clone_vntrip/components/time.dart';
import 'package:clone_vntrip/models/hotel/responses/response_detail_hotel.dart';
import 'package:clone_vntrip/models/login/profile_user.dart';
import 'package:clone_vntrip/providers/login_providers.dart';
import 'package:clone_vntrip/screens/hotel/payment_booking_hotel.dart';
import 'package:clone_vntrip/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/currency.dart';
import '../../models/hotel/responses/response_detail_each_room.dart';
import '../../models/hotel/rooms_and_customers.dart';
import '../../models/login/detail_account.dart';
import '../../providers/hotel_providers/date_pick_provider.dart';
import '../../providers/hotel_providers/detail_hotel_providers.dart';
import '../../providers/hotel_providers/hotel_booking_provider.dart';

class PreBookingHotel extends StatelessWidget {
  static const routeName = '/pre-booking-hotel';

  GlobalKey globalKey = GlobalKey();
  ScrollController singleScrollCtl = ScrollController();
  DateTimeRange? _timeRange;
  RoomsAndCustomers? _roomsAndCustomers;
  ProfileUser? _account;
  bool isInit = false;

  final TextEditingController _firstNameCtl = TextEditingController();
  final TextEditingController _nameCtl = TextEditingController();
  final TextEditingController _regionCtl = TextEditingController();
  final TextEditingController _phoneCtl = TextEditingController();
  final TextEditingController _emailCtl = TextEditingController();

  final TextEditingController _firstNameCtlAnother = TextEditingController();
  final TextEditingController _nameCtlAnother = TextEditingController();
  final TextEditingController _regionCtlAnother = TextEditingController();
  final TextEditingController _phoneCtlAnother = TextEditingController();
  final TextEditingController _emailCtlAnother = TextEditingController();

  void initData() {
    if (_account != null){
      _firstNameCtl.text = _account!.data!.firstName!;
      _nameCtl.text = _account!.data!.lastName!;
      _phoneCtl.text = _account!.data!.phone!;
      _emailCtl.text = _account!.data!.email!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    final detailProvMain = Provider.of<DetailHotelProviders>(context);
    final bookingHotelProv = Provider.of<HotelBookingProvider>(context);
    _account = Provider.of<LoginProvider>(context).profileUser;



    DateTimeRange? timeRange = Provider.of<PickDateProvider>(context).dateRange;
    RoomsAndCustomers? room = detailProvMain.roomsAndCustomersMain;
    _timeRange = timeRange;
    _roomsAndCustomers = room;

    if (!isInit) {
      initData();
      isInit = true;
    }

    void clickCancel() {
      Navigator.pop(context);
    }

    void _launchURL(String url) async {
      await launchUrl(Uri.parse(url));
    }

    void clickContinueBooking() {
      if (bookingHotelProv.checkIn == CheckIn.me) {
        // _account ??= ProfileUser(
        //     data: ProfileUserData(
        //         firstName: _firstNameCtl.text,
        //         lastName: _nameCtl.text,
        //         phone: _phoneCtl.text,
        //         email:_emailCtl.text,
        //         gender: 1
        //     ),
        //   );
        bookingHotelProv.clickContinueBooking(_firstNameCtl.text, _nameCtl.text, _phoneCtl.text, _emailCtl.text,
            detailProvMain.recentlyRoom!, _account!);
      }
      Navigator.pushNamed(context, PaymentBookingHotel.routeName);
    }

    // TODO: implement build
    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
              Expanded(
                child: Container(
                  color: Colors.grey[200]!,
                  child: SingleChildScrollView(
                    // reverse: true,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
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
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 3), // changes position of shadow
                                                ),
                                              ],
                                              borderRadius: BorderRadius.circular(30)
                                          ),
                                          child: Icon(
                                            size: 12,
                                            Icons.check,
                                            color: Colors.white,
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
                        itemHotelInfo(widthScreen, heightScreen, detailProvMain.results),
                        // _account == null
                        //   ? GestureDetector(
                        //     onTap: () {
                        //       Navigator.pushNamed(context, Login.routeName);
                        //     },
                        //     child: Container(
                        //       color: Colors.white,
                        //       width: widthScreen,
                        //       child: Container(
                        //         margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        //         padding: const EdgeInsets.all(20),
                        //         decoration: BoxDecoration(
                        //             color: Colors.orange,
                        //             borderRadius: BorderRadius.circular(5)
                        //         ),
                        //         child: const Center(child: Text('Đăng nhập để đặt phòng', style: TextStyle(color: Colors.white),),),
                        //       ),
                        //     ),
                        //   )
                        //   :
                        itemInfoBooker(context,bookingHotelProv,widthScreen, heightScreen),
                        itemAnother(widthScreen, heightScreen, 'Yêu cầu giường', detailProvMain.recentlyRoom),
                        itemAnother(widthScreen, heightScreen, 'Hoàn tiền Vntrip.vn',detailProvMain.recentlyRoom,8100),
                      ],
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
                                  TextSpan(text: Currency.displayPriceFormat(detailProvMain.recentlyRoom!.minPrice!), style: const TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold)),
                                ]
                            )
                        ),
                        Container(
                          child: detailProvMain.recentlyRoom!.rates![0]!.vat! == true
                              ? const Text('Đã bao gồm thuế VAT',style: TextStyle(fontSize: 11, color: Colors.grey) )
                              : const Text('Chưa bao gồm thuế VAT',style: TextStyle(fontSize: 11, color: Colors.grey) ),
                        ),
                        Container(
                          child: detailProvMain.recentlyRoom!.rates![0]!.priceBreakdown!.includedFee! == true
                              ? const Text('Đã bao gồm phí dịch vụ',style: TextStyle(fontSize: 11, color: Colors.grey) )
                              : const Text('Chưa bao gồm phí dịch vụ',style: TextStyle(fontSize: 11, color: Colors.grey) ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        bookingHotelProv.resetError();
                        if (bookingHotelProv.checkIn == CheckIn.me) {
                          await bookingHotelProv.checkInput(_firstNameCtl.text, _nameCtl.text, _phoneCtl.text, _emailCtl.text);
                        } else {
                          await bookingHotelProv.checkInput(_firstNameCtlAnother.text, _nameCtlAnother.text, _phoneCtlAnother.text, _emailCtlAnother.text);
                        }
                        if (bookingHotelProv.errorValid.isEmpty){
                          clickContinueBooking();
                        }
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

  Widget itemHotelInfo(double width, double height, ResponseDetailHotelDataResults? results) {
    String urlImg = 'assets/images/not_load_img.jpg';
    if (results?.thumbImage != null) {
      urlImg =
      'https://i.vntrip.vn/200x400/smart/https://statics.vntrip.vn/data-v2/hotels/${results?.id}/img_max/${results?.thumbImage}';
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
            color: Colors.grey[300]!,
            width: 5,
          ))),
      height: height / 4,
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Container(
                child: results?.thumbImage == null
                    ? Image.asset(
                  urlImg,
                  fit: BoxFit.fill,
                )
                    : Image.network(
                  urlImg,
                  fit: BoxFit.fill,
                ),
              )),
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      results!.nameVi!,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Container(
                    child: RatingBar.builder(
                      initialRating: double.parse(
                          results.starRate!
                              .toString()),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: double.parse(results.starRate!
                          .toString()).toInt(),
                      itemSize: 11,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                  Flexible(
                      child: Container(
                    child: Text(
                      results.fullAddress!,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
                  Container(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Time.getDayAndMonthVi(_timeRange!.start),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: Text(
                                        Time.getYearAndDateVi(_timeRange!.start),
                                        style: const TextStyle(
                                            fontSize: 13, color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 1,
                                  height: 20,
                                  color: Colors.black,
                                )
                              ],
                            )),
                        Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.only(left: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Time.getDayAndMonthVi(_timeRange!.end),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Text(
                                          Time.getYearAndDateVi(_timeRange!.end),
                                          style: const TextStyle(
                                              fontSize: 13, color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_right,
                                    size: 20,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    child: Text(
                      '${_roomsAndCustomers!.custormers} người lớn, ${Time.getDateRange(_timeRange!.start, _timeRange!.end)} đêm, ${_roomsAndCustomers!.rooms} phòng',
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemInfoBooker(BuildContext context, HotelBookingProvider bookingProvider,double width, double height) {

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
            color: Colors.grey[300]!,
            width: 5,
          ))),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          formInput('Thông tin người đặt phòng', _firstNameCtl,_nameCtl,_regionCtl,_phoneCtl,_emailCtl, context),
          Container(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 24.0,
                        width: 24.0,
                        child: Radio(
                          value: CheckIn.me,
                          groupValue: bookingProvider.checkIn,
                          onChanged: (CheckIn? value) {
                            bookingProvider.changeAnotherCheckIn(value!);
                          },
                        ),
                      ),
                      const SizedBox(width: 10,),
                      GestureDetector(
                        onTap: () {
                          if (bookingProvider.checkIn == CheckIn.me) {
                            bookingProvider.changeAnotherCheckIn(CheckIn.another);
                          } else {
                            bookingProvider.changeAnotherCheckIn(CheckIn.me);
                          }
                        },
                        child: Text(
                          'Tôi là người nhận phòng',
                          style: TextStyle(
                              fontSize: 14,
                              color: bookingProvider.checkIn == CheckIn.me ? Colors.blue : Colors.black
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24.0,
                        width: 24.0,
                        child: Radio(
                          value: CheckIn.another,
                          groupValue: bookingProvider.checkIn,
                          onChanged: (CheckIn? value) {
                            bookingProvider.changeAnotherCheckIn(value!);
                          },
                        ),
                      ),
                      const SizedBox(width: 10,),
                      GestureDetector(
                        onTap: () {
                          if (bookingProvider.checkIn == CheckIn.me) {
                            bookingProvider.changeAnotherCheckIn(CheckIn.another);
                          } else {
                            bookingProvider.changeAnotherCheckIn(CheckIn.me);
                          }
                        },
                        child: Text(
                          'Người khác sẽ nhận phòng',
                          style: TextStyle(
                              fontSize: 14,
                              color: bookingProvider.checkIn == CheckIn.another ? Colors.blue : Colors.black
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: bookingProvider.checkIn == CheckIn.another,
              child: Container(
                child: formInput('Thông tin người nhận phòng',_firstNameCtlAnother,_nameCtlAnother,_regionCtlAnother,_phoneCtlAnother,_emailCtlAnother, context),
              )
          ),
          Container(
            child: Row(
              children: [
                SizedBox(
                  height: 24.0,
                  width: 24.0,
                  child: Checkbox(
                    value: bookingProvider.hasMoreReq,
                    onChanged: (bool? value) {
                      bookingProvider.changeHasMoreReq();
                    },
                  ),
                ),
                const SizedBox(width: 10,),
                GestureDetector(
                  onTap: () {
                    bookingProvider.changeHasMoreReq();
                  },
                  child: Text('Tôi có thêm yêu cầu khác', style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: bookingProvider.hasMoreReq ? Colors.blue : Colors.black
                  ),),
                )
              ],
            ),
          ),
          Visibility(
              visible: bookingProvider.hasMoreReq,
              child: Container(
                padding: const EdgeInsets.only(top: 10),
                child: const TextField(
                  minLines: 4, // any number you need (It works as the rows for the textarea)
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }

  Widget formInput(String title, TextEditingController firstNameCtl, TextEditingController nameCtl, TextEditingController regionCtl,
      TextEditingController phoneCtl, TextEditingController emailCtl, BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 30),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      height: 1,
                      color: Colors.orange,
                    )),
                Expanded(
                    flex: 1,
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                    ))
              ],
            ),
          ),
          inputField(context, firstNameCtl, 'Họ và tên đệm'),
          inputField(context, nameCtl, 'Tên'),
          inputField(context, regionCtl, 'Quốc gia/ Mã vùng'),
          inputField(context, phoneCtl, 'Số điện thoại'),
          inputField(context, emailCtl, 'Email'),
        ],
      ),
    );
  }

  Widget inputField(BuildContext context ,TextEditingController controller, String title) {
    return Consumer<HotelBookingProvider>(
      builder: (context, bookingProv, child) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Visibility(
                        visible: bookingProv.errorValid.isNotEmpty && bookingProv.errorValid.contains(title),
                        child: Text(bookingProv.errorValid, style: TextStyle(color: Colors.red, fontSize: 12),)
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                child: title == 'Quốc gia/ Mã vùng'
                    ? const TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.only( left: 10),
                    suffixIcon : Icon(Icons.keyboard_arrow_down, size: 30,),
                    suffixIconConstraints: BoxConstraints(
                        minHeight: 38,
                        minWidth: 38
                    ),
                    hintText: '+84',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                )
                    : TextField(
                  onTap: ()async{
                    bookingProv.resetError();
                    await Future.delayed(const Duration(milliseconds: 500));
                    RenderObject? object = globalKey.currentContext?.findRenderObject();
                    object?.showOnScreen();
                  },
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: title,
                      isDense: true,
                      contentPadding: const EdgeInsets.all(10),
                      border: const OutlineInputBorder(
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
          ),
        );
      },
    );
  }

  Widget itemAnother(double width, double height, String content, [ResponseDetailEachRoomDataRoomData? room, int? refund]) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
                color: Colors.grey[300]!,
                width: 5,
              ))),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200]!,
          child: Icon(Icons.local_hotel_outlined, color: Colors.orange,),
        ),
        title: Text(content, style: TextStyle(fontSize: 14),),
        subtitle: content == 'Hoàn tiền Vntrip.vn'
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tích lũy',style: TextStyle(fontSize: 12),),
                  Text(Currency.displayPriceFormat(refund!), style: TextStyle(color: Colors.grey, fontSize: 11),),
                ],
              )
            : Text(room!.reformatBedTypes![0]!.bedData![0]!.type!,style: TextStyle(fontSize: 12),),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18,),
      ),
    );
  }


}
