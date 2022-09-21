import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/Currency.dart';
import '../../components/Time.dart';
import '../../models/payment/payment_method.dart';
import '../../models/ticket/requests/request_flight_rate.dart';
import '../../models/ticket/responses/response_searched_ticket.dart';
import '../../providers/ticket_providers/payment_booking_ticket.dart';
import '../../providers/ticket_providers/ticket_booking_provider.dart';
import '../hotel/webview_gateway_payment.dart';
import 'detail_flight_ticket.dart';

class PaymentTicket extends StatelessWidget {
  static const routeName = '/payment-ticket';
  int totalPrice = 0;
  PaymentBookingTicket? paymentProv;

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    final ticketProv = Provider.of<TicketBookingProvider>(context);
    paymentProv = Provider.of<PaymentBookingTicket>(context);

    RequestFlightRate request = ticketProv.requestFlightRate!;

    if (ticketProv.isSelectSecondFlight) {
      totalPrice = ticketProv.recentlyTicket!.totalPrice! +  ticketProv.recentlyTicketRoundTrip!.totalPrice!;
    } else {
      totalPrice = ticketProv.recentlyTicket!.totalPrice!;
    }

    if (paymentProv!.responseFlightRate == null){
      paymentProv!.postFlightRate(request);
    }

    if (paymentProv!.paymentMethod == null) {
      paymentProv!.getPaymentMethod();
    }

    void clickViewDetail(ResponseSearchedTicketListFareData? itemData) {
      ticketProv.changeRecentlyTicketViewDetail(itemData!);
      Navigator.pushNamed(context, DetailFightTicket.routeName);
    }

    void clickCancel() {
      paymentProv!.clearData();
      Navigator.pop(context);
    }

    void _launchURL(String url) async {
      await launchUrl(Uri.parse(url));
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
              paymentProv!.paymentMethod == null
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
                                      Text('Đặt chỗ', style: TextStyle(fontSize: 12),),
                                      Text('Thanh toán', style: TextStyle(fontSize: 12),),
                                      Text('Hoàn thành', style: TextStyle(fontSize: 12),)
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      paymentProv!.changeShowPmMethod();
                                    },
                                    child: paymentMethod(context, widthScreen, heightScreen, 'Phương thức thanh toán'),
                                  ),
                                  itemAnother(widthScreen, heightScreen, 'Mã khuyến mại'),
                                ],
                              ),
                            ),
                            Consumer<TicketBookingProvider>(
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
                                  ],
                                );
                              },
                            )
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
                        Navigator.pushNamed(context, WebviewPayment.routeName, arguments: 1);
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
    bool isShowRecently = paymentProv!.recentlyPaymentMethod != null;

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
            trailing: paymentProv!.isShowPaymentMethod
                ? const Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 20,)
                : const Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 20,),
          ),
          Visibility(
            visible: paymentProv!.isShowPaymentMethod,
            child: Column(
              children: paymentProv!.paymentMethod!.data!.map(
                      (method) => GestureDetector(
                    onTap: () {
                      paymentProv!.changeShowPmMethod();
                      paymentProv!.setRecentlyPaymentMethod(method!);
                      paymentProv!.addPaymentMethod();
                    },
                    child: itemPaymentMethod(width, height, method!),
                  )
              ).toList(),
            ),
          ),
          Visibility(
            visible: isShowRecently,
            child: isShowRecently
                ? itemPaymentMethod(width, height, paymentProv!.recentlyPaymentMethod!)
                : Container(),
          )
        ],
      ),
    );
  }

  Widget itemPaymentMethod(double width, double height, PaymentMethodData methodData) {
    bool isSelect = paymentProv!.recentlyPaymentMethod != null && paymentProv!.recentlyPaymentMethod!.id == methodData.id;

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
                              text: 'Phí thanh toán:  ',
                              style: TextStyle(color: Colors.black, fontSize: 14)
                          ), TextSpan(
                              text: '0đ',
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
}