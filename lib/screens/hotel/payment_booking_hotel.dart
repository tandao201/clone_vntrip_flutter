

import 'package:clone_vntrip/models/hotel/requests/request_checkout.dart';
import 'package:clone_vntrip/models/payment/payment_method.dart';
import 'package:clone_vntrip/providers/hotel_providers/payment_provider.dart';
import 'package:clone_vntrip/screens/hotel/webview_gateway_payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/Currency.dart';
import '../../components/Time.dart';
import '../../models/hotel/responses/response_detail_hotel.dart';
import '../../models/hotel/rooms_and_customers.dart';
import '../../providers/hotel_providers/date_pick_provider.dart';
import '../../providers/hotel_providers/detail_hotel_providers.dart';
import '../../providers/hotel_providers/hotel_booking_provider.dart';

class PaymentBookingHotel extends StatelessWidget {

  static const routeName = '/payment-booking-hotel';
  DateTimeRange? _timeRange;
  RoomsAndCustomers? _roomsAndCustomers;
  late PaymentProvider paymentProv;

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    final detailProvMain = Provider.of<DetailHotelProviders>(context);
    paymentProv = Provider.of<PaymentProvider>(context);

    DateTimeRange? timeRange = Provider.of<PickDateProvider>(context).dateRange;
    RoomsAndCustomers? room = detailProvMain.roomsAndCustomersMain;
    _timeRange = timeRange;
    _roomsAndCustomers = room;
    RequestCheckout request = Provider.of<HotelBookingProvider>(context).requestCheckout;

    void clickCancel() {
      paymentProv.clearData();
      Navigator.pop(context);
    }
    if (paymentProv.responseCheckout == null) {
      print('checkout hotel booking');
      paymentProv.requestCheckOut(request);
    } else {
      if (paymentProv.responseBookingHotel == null) {
        print('hotel booking...');
        paymentProv.bookingRequestHotel();
      }
    }

    if (paymentProv.paymentMethod == null) {
      paymentProv.getPaymentMethod();
    }

    void _launchURL(String url) async {
      await launchUrl(Uri.parse(url));
    }

    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      'Ch???n thanh to??n',
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
            paymentProv.paymentMethod == null
              ? const Center(child: CupertinoActivityIndicator(),)
              : Expanded(
              child: Container(
                color: Colors.grey[200]!,
                child: SingleChildScrollView(
                  // reverse: true,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                                Text('?????t ch???', style: TextStyle(fontSize: 12),),
                                Text('Thanh to??n', style: TextStyle(fontSize: 12),),
                                Text('Ho??n th??nh', style: TextStyle(fontSize: 12),)
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                paymentProv.changeShowPmMethod();
                              },
                              child: paymentMethod(context, widthScreen, heightScreen, 'Ph????ng th???c thanh to??n'),
                            ),
                            itemAnother(widthScreen, heightScreen, 'M?? khuy???n m???i'),
                            itemHotelInfo(widthScreen, heightScreen, detailProvMain.results, detailProvMain),
                          ],
                        ),
                      ),
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
                                const TextSpan(text: 'T???ng c???ng: ', style: TextStyle(fontSize: 11, color: Colors.black)),
                                TextSpan(text: Currency.displayPriceFormat(detailProvMain.recentlyRoom!.minPrice!), style: const TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold)),
                              ]
                          )
                      ),
                      Container(
                        child: detailProvMain.recentlyRoom!.rates![0]!.vat! == true
                            ? const Text('???? bao g???m thu??? VAT',style: TextStyle(fontSize: 11, color: Colors.grey) )
                            : const Text('Ch??a bao g???m thu??? VAT',style: TextStyle(fontSize: 11, color: Colors.grey) ),
                      ),
                      Container(
                        child: detailProvMain.recentlyRoom!.rates![0]!.priceBreakdown!.includedFee! == true
                            ? const Text('???? bao g???m ph?? d???ch v???',style: TextStyle(fontSize: 11, color: Colors.grey) )
                            : const Text('Ch??a bao g???m ph?? d???ch v???',style: TextStyle(fontSize: 11, color: Colors.grey) ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.pushNamed(context, WebviewPayment.routeName, arguments: 0);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: const Text('Ti???p t???c', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget itemHotelInfo(double width, double height, ResponseDetailHotelDataResults? results, DetailHotelProviders detailProvMain) {
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
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: const Text('?????t ch??? c???a b???n', style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          Container(
            height: height / 4,
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
                            '${_roomsAndCustomers!.custormers} ng?????i l???n, ${Time.getDateRange(_timeRange!.start, _timeRange!.end)} ????m, ${_roomsAndCustomers!.rooms} ph??ng',
                            style: const TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              minLeadingWidth: 10,
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              title: Align(
                alignment: const Alignment(-1.2, 0),
                child: Text(detailProvMain.recentlyRoom!.name!, style: const TextStyle(fontWeight: FontWeight.bold),),
              ),
              subtitle: Align(
                alignment: const Alignment(-1.2, 0),
                child: Text('Di???n t??ch ph??ng:  ${detailProvMain.recentlyRoom!.roomArea}'),
              ),
              trailing: Text('x${_roomsAndCustomers!.rooms}', style: const TextStyle(fontWeight: FontWeight.bold),),
            ),
          ),
          Divider(
            color: Colors.grey[300]!,
            height: 1,
          ),
          const SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.free_cancellation,
                  size: 16,
                  color: Colors.red,
                ),
                const SizedBox(width: 5,),
                RichText(
                  text: TextSpan(
                      children: <TextSpan>[
                        const TextSpan(
                            text: 'H???y ph??ng: ',
                            style: TextStyle(color: Colors.grey)
                        ), TextSpan(
                            text: detailProvMain.recentlyRoom!.rates![0]!.refundable! ? 'C?? ho??n h???y' : 'Kh??ng ho??n h???y',
                            style: const TextStyle(color: Colors.green)
                        )
                      ]
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.set_meal_outlined,
                  size: 16,
                ),
                const SizedBox(width: 5,),
                RichText(
                  text: TextSpan(
                      children: <TextSpan>[
                        const TextSpan(
                            text: 'B???a ??n: ',
                            style: TextStyle(color: Colors.grey)
                        ), TextSpan(
                            text: detailProvMain.recentlyRoom!.rates![0]!.mealPlan == 'breakfast' ? 'Bao g???m ??n s??ng' : 'Kh??ng bao g???m',
                            style: const TextStyle(color: Colors.green)
                        )
                      ]
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Divider(
            color: Colors.grey[300]!,
            height: 1,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'B???ng vi???c b???m TI???P T???C, t??i ?????ng ?? v???i c??c',
                        style: TextStyle(color: Colors.grey)
                    ),
                    TextSpan(
                        text: ' ??i???u kho???n s??? d???ng',
                        style: TextStyle(color: Colors.blue)
                    ),
                    TextSpan(
                        text: ' c???a Vntrip.vn',
                        style: TextStyle(color: Colors.grey)
                    )
                  ]
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemAnother(double width, double height, String content) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
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
        leading: const Icon(Icons.qr_code, color: Colors.orange,),
        title: Text(content, style: const TextStyle(fontSize: 14),),
        trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 20,),
      ),
    );
  }

  Widget paymentMethod(BuildContext context,double width, double height, String content) {
    bool isShowRecently = paymentProv.recentlyPaymentMethod != null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
                color: Colors.grey[300]!,
                width: 5,
              ))),
      child: Column(
        children: [
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.currency_exchange, color: Colors.orange,),
            title: Text(content, style: const TextStyle(fontSize: 14),),
            trailing: paymentProv.isShowPaymentMethod
              ? const Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 20,)
              : const Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 20,),
          ),
          Visibility(
            visible: paymentProv.isShowPaymentMethod,
              child: Column(
                children: paymentProv.paymentMethod!.data!.map(
                        (method) => GestureDetector(
                          onTap: () {
                            paymentProv.changeShowPmMethod();
                            paymentProv.setRecentlyPaymentMethod(method!);
                            paymentProv.addPaymentMethod();
                          },
                          child: itemPaymentMethod(width, height, method!),
                        )
                ).toList(),
              ),
          ),
          Visibility(
            visible: isShowRecently,
            child: isShowRecently
              ? itemPaymentMethod(width, height, paymentProv.recentlyPaymentMethod!)
              : Container(),
          )
        ],
      ),
    );
  }

  Widget itemPaymentMethod(double width, double height, PaymentMethodData methodData) {
    bool isSelect = paymentProv.recentlyPaymentMethod != null && paymentProv.recentlyPaymentMethod!.id == methodData.id;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isSelect
            ? Colors.orange[50]!
            : Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: isSelect
              ? Colors.orange
              : Colors.grey[200]!,
          width: 1
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
              child: Image.network(methodData.logo!, fit: BoxFit.cover,)
          ),
          const SizedBox(width: 5,),
          Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(methodData.nameVi!, style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelect
                        ? Colors.orange
                          : Colors.black
                      ),
                  ),
                  const SizedBox(height: 3,),
                  Text(methodData.shortDescVi!, style: const TextStyle(fontSize: 12, color: Colors.grey),),
                  const SizedBox(height: 3,),
                  RichText(
                    text: const TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Ph?? thanh to??n:  ',
                              style: TextStyle(color: Colors.black, fontSize: 14)
                          ), TextSpan(
                              text: '0??',
                              style: TextStyle(color: Colors.orange)
                          )
                        ]
                    ),
                  )
                ],
              )
          ),
        ],
      ),
    );
  }
}