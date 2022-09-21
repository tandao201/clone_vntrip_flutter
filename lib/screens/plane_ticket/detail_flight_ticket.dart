import 'package:clone_vntrip/components/currency.dart';
import 'package:clone_vntrip/models/ticket/requests/request_search_ticket.dart';
import 'package:clone_vntrip/providers/ticket_providers/ticket_booking_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/Time.dart';
import '../../models/ticket/price_ticket_type_passenger.dart';
import '../../models/ticket/responses/response_place_flight.dart';
import '../../models/ticket/responses/response_searched_ticket.dart';

class DetailFightTicket extends StatelessWidget {
  static const routeName = 'detail-flight-ticket';

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    final ticketProv = Provider.of<TicketBookingProvider>(context);
    print('Number flight: ${ticketProv.recentlyTicketViewDetail!.listFlight!.length}');

    PageController controller =
        PageController(initialPage: ticketProv.pageSelected - 1);
    List<Widget> _list = <Widget>[
      detailItem(ticketProv, context, heightScreen, ticketProv.recentlyTicketViewDetail!),
      infoTicketItem(ticketProv, context, heightScreen, ticketProv.recentlyTicketViewDetail!),
    ];

    void clickCancel() {
      ticketProv.resetPageSelect();
      Navigator.pop(context);
    }

    // TODO: implement build
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  'Thông tin chuyến bay',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Container(),
              ],
            ), //appBar
          ),
          ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          if (ticketProv.pageSelected != 1) {
                            ticketProv.changePageSelect(1);
                            controller.animateToPage(0,
                                curve: Curves.easeInOut,
                                duration: const Duration(milliseconds: 300));
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: ticketProv.pageSelected == 1
                              ? const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.orange, width: 2)))
                              : BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey[200]!, width: 1))),
                          child: Center(
                            child: Text('Chi tiết chuyến bay', style: TextStyle(
                              color: ticketProv.pageSelected == 1 ? Colors.orange : Colors.black
                            ),),
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          if (ticketProv.pageSelected != 2) {
                            ticketProv.changePageSelect(2);
                            controller.animateToPage(1,
                                curve: Curves.easeInOut,
                                duration: const Duration(milliseconds: 300));
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: ticketProv.pageSelected == 2
                              ? const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.orange, width: 2)))
                              : BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey[200]!, width: 1))),
                          child: Center(
                            child: Text('Thông tin vé' ,style: TextStyle(
                            color: ticketProv.pageSelected == 2 ? Colors.orange : Colors.black
                            )),
                          ),
                        ),
                      )),
                ],
              ),
              Container(
                width: widthScreen,
                height: heightScreen / 1.4,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  controller: controller,
                  onPageChanged: (num) {
                    // if (num == ticketProv.pageSelected) {
                    ticketProv.changePageSelect(num + 1);
                    // }
                  },
                  children: _list,
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('Booking...');
                },
                child: Container(
                  width: widthScreen,
                  height: heightScreen / 14,
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(4)),
                  child: const Center(
                    child: Text(
                      'Chọn',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }

  Widget detailItem(
    TicketBookingProvider ticketProv,
    BuildContext context,
    double height,
    ResponseSearchedTicketListFareData ticket,
  ) {
    List<Widget> _createTicketList() {
      return List<Widget>.generate(
          ticketProv.recentlyTicketViewDetail!.listFlight![0]!.listSegment!.length,
          (int index) {
        return flightItemDetail(ticketProv, height,
            ticketProv.recentlyTicketViewDetail!.listFlight![0]!, index);
      });
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Divider(
            color: Colors.grey[300]!,
            height: 1,
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${ticket.listFlight![0]!.startPoint!} - ${ticket.listFlight![0]!.endPoint!}',
                  style: const TextStyle(fontSize: 14),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 12,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: 'Thời gian bay: ',
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          text:
                              '${Time.changeMinuteToHourString(ticket.listFlight![0]!.duration!)}m',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black))
                    ])),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[300]!,
            height: 1,
          ),
          Column(
            children: _createTicketList(),
          ),
        ],
      ),
    );
  }

  Widget flightItemDetail(TicketBookingProvider ticketProv, double height,
      ResponseSearchedTicketListFareDataListFlight ticket, int segmentIndex) {
    ResponsePlaceFlightDataDomesticRegionData? goPlace = ticketProv
        .getPlacePoint(ticket.listSegment![segmentIndex]!.startPoint!);
    ResponsePlaceFlightDataDomesticRegionData? toPlace =
        ticketProv.getPlacePoint(ticket.listSegment![segmentIndex]!.endPoint!);

    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20, top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: const Icon(Icons.flight_takeoff),
                ),
                Container(
                  width: 1,
                  height: height / 3.8,
                  color: Colors.grey[300]!,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: const Icon(Icons.flight_land),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: Time.getTimeHourAndMinute(
                            ticket.listSegment![segmentIndex]!.startTime!),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                    TextSpan(
                        text:
                            '   ${Time.formatTimeFromString(ticket.listSegment![segmentIndex]!.startTime!)}',
                        style: const TextStyle(color: Colors.grey))
                  ])),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    '${goPlace!.code} - ${goPlace.provinceName}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    '${goPlace.name}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey[300]!,
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(6)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: [
                            ticket.airline == 'VJ'
                                ? Image.asset(
                                    'assets/images/vietjet.png',
                                    fit: BoxFit.fill,
                                    width: 40,
                                    height: 10,
                                  )
                                : ticket.airline == 'VN'
                                    ? Image.asset(
                                        'assets/images/vnairlines.png',
                                        fit: BoxFit.fill,
                                        width: 18,
                                        height: 15,
                                      )
                                    : Image.asset(
                                        'assets/images/bamboo.png',
                                        fit: BoxFit.fill,
                                        width: 40,
                                        height: 10,
                                      ),
                            Container(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                _getAirline(ticket, segmentIndex),
                                style: const TextStyle(fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          'Hạng chỗ: ${ticket.listSegment![segmentIndex]!.theClass}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          'Máy bay: ${ticket.listSegment![segmentIndex]!.plane}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          'Hành lý: ${ticket.listSegment![segmentIndex]!.handBaggage} hành lí xách tay',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      Text(
                        'Hành lý kí gửi: ${ticket.listSegment![segmentIndex]!.allowanceBaggage ?? 'Không'}',
                        style: const TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: Time.getTimeHourAndMinute(
                            ticket.listSegment![segmentIndex]!.endTime!),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                    TextSpan(
                        text:
                            '   ${Time.formatTimeFromString(ticket.listSegment![segmentIndex]!.endTime!)}',
                        style: const TextStyle(color: Colors.grey))
                  ])),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    '${toPlace!.code} - ${toPlace.provinceName}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    '${toPlace.name}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget infoTicketItem(TicketBookingProvider ticketProv, BuildContext context,
      double height, ResponseSearchedTicketListFareData ticket) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Tổng giá vé đi',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    Currency.displayPriceFormat(ticket.totalPrice!),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ],
              ),
            ),
            ticket.adt != 0
                ? itemPriceTicket(ticket, 'người lớn')
                : Container(),
            ticket.chd != 0 ? itemPriceTicket(ticket, 'trẻ em') : Container(),
            ticket.inf != 0
                ? itemPriceTicket(ticket, 'trẻ sơ sinh')
                : Container(),
            Container(
              margin: const EdgeInsets.only(bottom: 10, top: 10),
              child: const Text(
                'Điều kiện',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            conditionTicket(
                '- Hoàn vé: Liện hệ với Vntrip để biết thêm chi tiết.'),
            conditionTicket(
                '- Đổi Ngày Giờ chuyến bay: Liện hệ với Vntrip để biết thêm chi tiết.'),
            conditionTicket(
                '- Đổi Hành Trình: Liện hệ với Vntrip để biết thêm chi tiết.'),
            conditionTicket('- Đổi tên Hành Khách: Không được phép.'),
            conditionTicket(
                '- Điểm Cộng Dặm: Liện hệ với Vntrip để biết thêm chi tiết.'),
          ],
        ),
      ),
    );
  }

  Widget itemPriceTicket(
      ResponseSearchedTicketListFareData ticket, String typePassenger) {
    PriceTicketTypePassenger ticketPrice = PriceTicketTypePassenger();
    if (typePassenger == 'người lớn') {
      ticketPrice = PriceTicketTypePassenger(
          quantity: ticket.adt,
          price: ticket.fareAdt,
          tax: ticket.taxAdt! + ticket.feeAdt!,
          serviceFee: ticket.serviceFeeAdt);
    } else if (typePassenger == 'trẻ em') {
      ticketPrice = PriceTicketTypePassenger(
          quantity: ticket.chd,
          price: ticket.fareChd,
          tax: ticket.taxChd! + ticket.feeChd!,
          serviceFee: ticket.serviceFeeChd);
    } else {
      ticketPrice = PriceTicketTypePassenger(
          quantity: ticket.inf,
          price: ticket.fareInf,
          tax: ticket.taxInf! + ticket.feeInf!,
          serviceFee: ticket.serviceFeeInf);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!, width: 1),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Giá vé $typePassenger (x${ticketPrice.quantity})',
                ),
                Text(
                  Currency.displayPriceFormat(ticketPrice.price! * ticketPrice.quantity!),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Thuế và phí (x${ticketPrice.quantity})',
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
                Text(
                  Currency.displayPriceFormat(ticketPrice.tax! * ticketPrice.quantity!),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chi phí và vận hành (x${ticketPrice.quantity})',
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
                Text(
                  Currency.displayPriceFormat(ticketPrice.serviceFee! * ticketPrice.quantity!),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget conditionTicket(String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Text(
        content,
        style: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );
  }

  String _getAirline(
      ResponseSearchedTicketListFareDataListFlight tickets, int index) {
    String nameAirline = '';
    switch (tickets.airline) {
      case 'VJ':
        nameAirline = 'VietJet Air';
        break;
      case 'VN':
        nameAirline = 'Vietnam Airlines';
        break;
      case 'QH':
        nameAirline = 'Bamboo Airways';
        break;
    }
    return '$nameAirline ${tickets.listSegment![index]!.flightNumber}';
  }
}
