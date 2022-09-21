import 'package:clone_vntrip/components/Currency.dart';
import 'package:clone_vntrip/components/colors.dart';
import 'package:clone_vntrip/models/ticket/requests/request_search_ticket.dart';
import 'package:clone_vntrip/models/ticket/responses/response_searched_ticket.dart';
import 'package:clone_vntrip/providers/ticket_providers/ticket_booking_provider.dart';
import 'package:clone_vntrip/screens/plane_ticket/pre_booking_ticket.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../components/Time.dart';
import 'detail_flight_ticket.dart';

class SearchedFlightTicket extends StatelessWidget {
  const SearchedFlightTicket({Key? key}) : super(key: key);
  static const routeName = '/searched-flight-ticket';

  @override
  Widget build(BuildContext context) {
    RequestSearchTicket? request =
        Provider.of<TicketBookingProvider>(context, listen: false)
            .requestSearchTicket;


    final ticketProv = Provider.of<TicketBookingProvider>(context);
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;


    void clickCancel() {
      // Navigator.pushNamed(context, HotelBooking.routeName);
      if (!ticketProv.isSelectSecondFlight) {
        Provider.of<TicketBookingProvider>(context, listen: false).isFirstTime =
        true;
        ticketProv.resetData();
      }
      ticketProv.resetSelectSecondFlight();
      print('reset select ${ticketProv.isSelectSecondFlight}');
      Navigator.pop(context);
    }

    void clickRechoice() {
      // Navigator.pushNamed(context, HotelBooking.routeName);
      if (!ticketProv.isSelectSecondFlight) {
        Provider.of<TicketBookingProvider>(context, listen: false).isFirstTime =
        true;
      }
      ticketProv.resetSelectSecondFlight();
      print('reset select ${ticketProv.isSelectSecondFlight}');
      Navigator.pushReplacementNamed(context, SearchedFlightTicket.routeName);
    }

    void clickTicketItem(ResponseSearchedTicketListFareData itemData) {
      if (ticketProv.isSelectSecondFlight) {
        print('Select 2 ticket done...');
        ticketProv.changeRecentlyTicketRoundTrip(itemData);
        Navigator.pushNamed(context, PreBookingTicket.routeName);
        return ;
      }
      if (ticketProv.responseSearchTicket!.itinerary == 1){
        ticketProv.changeRecentlyTicket(itemData);
        print('not round trip!');
        Navigator.pushNamed(context, PreBookingTicket.routeName);
      } else {
        if (!ticketProv.isSelectSecondFlight) {
          ticketProv.changeRecentlyTicket(itemData);
        }
        ticketProv.changeSelectSecondFlight();
        print('round trip ${ticketProv.responseSearchTicket!.itinerary }');
        Navigator.pushNamed(context, SearchedFlightTicket.routeName);

      }
    }

    void clickSortMenu() {
      print('clickSortMenu...');
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return sortDialog(heightScreen, context, ticketProv);
          },
          constraints: BoxConstraints(maxHeight: heightScreen * 0.75));
    }

    void clickFilterMenu() {
      print('clickFilterMenu...');
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return filterDialog(heightScreen, context, ticketProv);
          },
          constraints: BoxConstraints(maxHeight: heightScreen));
    }

    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: AppColor.grayLight,
                      ))),
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  Column(
                    children: [
                      Text(
                        '${ticketProv.requestSearchTicket!.goPlace} - ${ticketProv.requestSearchTicket!.toPlace}',
                        style: const TextStyle(fontSize: 17),
                      ),
                      Text(
                        Time.getFullDateString(
                            ticketProv.requestSearchTicket!.listFlight![0]!.departDate!),
                        style: const TextStyle(fontSize: 12, color: Colors.blue),
                      ),
                    ],
                  ),
                  Container(),
                ],
              ), //appBar
            ),
            Visibility(
                visible: ticketProv.isSelectSecondFlight && ticketProv.recentlyTicket!=null,
                child: itemFlightGo(ticketProv,widthScreen, heightScreen, clickCancel)
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: AppColor.grayLight,
                      ))),
              padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
              child: Center(
                child: Text(
                  ticketProv.isSelectSecondFlight ? 'Chọn vé cho chuyến bay về' : 'Chọn vé cho chuyến bay đi',
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
              ), //appBar
            ),
            Flexible(
              child: Consumer<TicketBookingProvider>(
                builder: (context, ticketProv, child) {
                  if (ticketProv.isFirstTime) {
                    ticketProv.resetData();
                  }
                  if (ticketProv.listFare == null) {
                    print('Request calling...');
                    ticketProv.searchTicket(ticketProv.requestSearchTicket!);
                  }
                  List<ResponseSearchedTicketListFareData> listFare =
                  ticketProv.isSelectSecondFlight ? ticketProv.listFareRoundTrip! : ticketProv.listFare!;
                  return ticketProv.isLoading
                      ? ListView.builder(
                      itemCount: 7,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return itemLoading(widthScreen, heightScreen);
                      })
                      : Container(
                    child: ticketProv.listFare!.isEmpty
                        ? const Center(
                      child: Text(
                        'Không tìm thấy vé máy bay nào',
                        style: TextStyle(
                            color: Colors.black, fontSize: 14),
                      ),
                    )
                        : CupertinoScrollbar(
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics:
                          const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: listFare.length,
                          itemBuilder: (context, index) {
                            if (listFare.isNotEmpty) {
                              ResponseSearchedTicketListFareData
                              itemData = listFare[index];
                              return GestureDetector(
                                onTap: () {
                                  clickTicketItem(itemData);
                                },
                                child: itemTicket(
                                    widthScreen,
                                    heightScreen,
                                    itemData,
                                    context,
                                    ticketProv),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.grayLight, width: 1)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          clickSortMenu();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      color: AppColor.grayLight, width: 1))),
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Visibility(
                                  visible: ticketProv.sortBy != TicketBookingProvider.sortLowPrice,
                                  child: const Icon(Icons.check, color: Colors.orange,)),
                              Text(
                                'Sắp xếp',
                                style: TextStyle(
                                    color: ticketProv.sortBy == TicketBookingProvider.sortLowPrice
                                        ? Colors.black
                                        : Colors.orange
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          clickFilterMenu();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      color: AppColor.grayLight, width: 1))),
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Visibility(
                                  visible: ticketProv.airlines.length !=3,
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.orange,
                                  )),
                              Text(
                                'Lọc',
                                style: TextStyle(
                                    color: ticketProv.airlines.length==3 ? Colors.black : Colors.orange
                              ),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // ResponseSearchedTicketListFareData itemData
  Widget itemTicket(
      double width,
      double height,
      ResponseSearchedTicketListFareData itemData,
      BuildContext context,
      TicketBookingProvider ticketProv) {

    int price = 0;
    if (ticketProv.checkBoxCheck == true) {
      price = itemData.totalPrice!;
      if (ticketProv.viewPrice == ViewPrice.only) {
        price = itemData.fareAdt! + itemData.taxAdt! + itemData.feeAdt! + itemData.serviceFeeAdt!;
      }
    } else {
      if (ticketProv.viewPrice == ViewPrice.only) {
        price = itemData.fareAdt!;
      } else {
        price = itemData.fareAdt! * itemData.adt! +  itemData.fareChd! * itemData.chd! + itemData.fareInf! * itemData.inf!;
      }
    }

    String imgPath = '';
    String moreInfo = '${itemData.flightItem?.flightNumber}';
    if (itemData.airline == 'QH') imgPath = 'assets/images/bamboo.png';
    if (itemData.airline == 'VN') imgPath = 'assets/images/vietnamairlines.png';
    if (itemData.airline == 'VJ') imgPath = 'assets/images/vietjet.png';

    if (itemData.itinerary == 1) moreInfo = '$moreInfo - Bay thẳng';
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
            width: 1,
            color: AppColor.grayLight,
          ))),
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: itemData.airline == 'VN' ? 140 : 110,
                  height: 20,
                  child: Image.asset(
                    imgPath,
                    fit: BoxFit.fill,
                  )),
              GestureDetector(
                onTap: () {
                  ticketProv.changeRecentlyTicketViewDetail(itemData);
                  Navigator.pushNamed(context, DetailFightTicket.routeName);
                },
                child: const SizedBox(
                  height: 20,
                  child: Text(
                    'Chi tiết',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width / 2.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          Time.getTimeHourAndMinute(
                              itemData.flightItem!.startDate!),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 13),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Icon(
                              Icons.arrow_right_alt,
                              size: 13,
                              color: AppColor.grayHintText,
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                Time.changeMinuteToHourString(
                                    itemData.flightItem!.duration!),
                                style: TextStyle(
                                    color: AppColor.grayHintText, fontSize: 11),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Text(
                          Time.getTimeHourAndMinute(
                              itemData.flightItem!.endDate!),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Text(
                    Currency.displayPriceFormat(price),
                    style: const TextStyle(color: Colors.green, fontSize: 15),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              moreInfo,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemLoading(double width, double height) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        width: 1,
        color: AppColor.grayLight,
      ))),
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: Colors.grey[300]!,
                  width: 140,
                  height: 20,
                ),
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: Colors.grey[300]!,
                  width: 40,
                  height: 20,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width / 2.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.grey[300]!,
                          width: 20,
                          height: 13,
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.grey[300]!,
                          width: 13,
                          height: 13,
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.grey[300]!,
                          width: 20,
                          height: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    color: Colors.grey[300]!,
                    width: 60,
                    height: 15,
                  ),
                ),
              ],
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              color: Colors.grey[300]!,
              width: 110,
              height: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget itemFlightGo(TicketBookingProvider tickProv ,double width, double height, Function clickChangeFlightGo) {
    String imgPath = '';
    if (tickProv.recentlyTicket != null) {
      if (tickProv.recentlyTicket!.airline == 'QH') imgPath = 'assets/images/bamboo.png';
      if (tickProv.recentlyTicket!.airline == 'VN') imgPath = 'assets/images/vnairlines.png';
      if (tickProv.recentlyTicket!.airline == 'VJ') imgPath = 'assets/images/vietjet.png';
    }

    return tickProv.recentlyTicket == null
        ? Container()
        : Container(
      decoration: BoxDecoration(
          color: Colors.grey[200]!,
          border: Border(
              bottom: BorderSide(
                width: 1,
                color: Colors.grey[300]!,
              ))),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(Time.formatTimeStringFromStringApi(tickProv.recentlyTicket!.listFlight![0]!.startDate!), style: const TextStyle(color: Colors.grey),),
              const SizedBox(height: 5,),
              Row(
                children: [
                  Image.asset(
                    imgPath,
                    fit: BoxFit.fill,
                    width: tickProv.recentlyTicket!.airline == 'VN' ? 25 : 40,
                    height: tickProv.recentlyTicket!.airline == 'VN' ? 25 : 15,
                  ),
                  const SizedBox(width: 6,),
                  Text(Currency.displayPriceFormat(tickProv.recentlyTicket!.totalPrice!), style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(tickProv.goPlace!.code!, style: const TextStyle(color: Colors.grey),),
              const SizedBox(height: 5,),
              Text(Time.getTimeHourAndMinute(tickProv.recentlyTicket!.listFlight![0]!.startDate!), style: const TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(tickProv.toPlace!.code!, style: const TextStyle(color: Colors.grey),),
              const SizedBox(height: 5,),
              Text(Time.getTimeHourAndMinute(tickProv.recentlyTicket!.listFlight![0]!.endDate!), style: const TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
          GestureDetector(
            onTap: () {
              clickChangeFlightGo();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 1)
                  ),
                  child: const Text('Đổi chuyến bay đi', style: TextStyle(color: Colors.blue, fontSize: 12),),
                )
              ],
            ),
          )
        ],
      ), //appBar
    );
  }

  Widget sortDialog(
      double height, BuildContext context, TicketBookingProvider ticketProv) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: itemSort(context, 'Giá thấp nhất', ticketProv)
            ),
            Expanded(
                flex: 1,
                child: itemSort(context, 'Cất cánh sớm nhất', ticketProv)
            ),
            Expanded(
                flex: 1,
                child: itemSort(context, 'Cất cánh muộn nhất', ticketProv)
            ),
            Expanded(
                flex: 1,
                child: itemSort(context, 'Hạ cánh sớm nhất', ticketProv)
            ),
            Expanded(
                flex: 1,
                child: itemSort(context, 'Hạ cánh muộn nhất', ticketProv)
            ),
            Expanded(
                flex: 1,
                child: itemSort(context, 'Thời gian bay ngắn nhất', ticketProv)
            ),

            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: const Center(
                    child: Text(
                      'Đóng',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ), // Từ cao tới thấp, theo điểm đánh giá
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget filterDialog(
      double height, BuildContext context, TicketBookingProvider ticketProv) {
    void clickCancel() {
      Navigator.pop(context);
    }

    return Scaffold(
      body: Container(
        height: height,
        color: Colors.white,
        padding: EdgeInsets.only(
            top: MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top),

        child: Consumer<TicketBookingProvider>(
          builder: (context, ticketPro, child) {
            return Column(
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
                        'Lọc chuyến bay',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Container(),
                    ],
                  ), //appBar
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: const Text('Chế độ hiển thị giá', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 24.0,
                              width: 24.0,
                              child: Radio(
                                activeColor: Colors.orange,
                                value: ViewPrice.only,
                                groupValue: ticketPro.viewPrice,
                                onChanged: (ViewPrice? value) {
                                  ticketProv.changeAnotherViewPrice(value!);
                                },
                              ),
                            ),
                            const SizedBox(width: 10,),
                            GestureDetector(
                              onTap: () {
                                if (ticketProv.viewPrice == ViewPrice.only) {
                                  ticketProv.changeAnotherViewPrice(ViewPrice.all);
                                } else {
                                  ticketProv.changeAnotherViewPrice(ViewPrice.only);
                                }
                              },
                              child: Text(
                                'Mỗi hành khách',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: ticketProv.viewPrice == ViewPrice.only ? Colors.orange : Colors.grey
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 24.0,
                              width: 24.0,
                              child: Radio(
                                activeColor: Colors.orange,
                                value: ViewPrice.all,
                                groupValue: ticketPro.viewPrice,
                                onChanged: (ViewPrice? value) {
                                  ticketProv.changeAnotherViewPrice(value!);
                                },
                              ),
                            ),
                            const SizedBox(width: 10,),
                            GestureDetector(
                              onTap: () {
                                if (ticketProv.viewPrice == ViewPrice.only) {
                                  ticketProv.changeAnotherViewPrice(ViewPrice.all);
                                } else {
                                  ticketProv.changeAnotherViewPrice(ViewPrice.only);
                                }
                              },
                              child: Text(
                                'Tất cả hành khách',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: ticketProv.viewPrice == ViewPrice.all ? Colors.orange : Colors.grey
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 24.0,
                              width: 24.0,
                              child: Checkbox(
                                activeColor: Colors.orange,
                                value: ticketPro.checkBoxCheck,
                                onChanged: (_) {
                                  ticketProv.changeCheckBoxCheck();
                                },
                              ),
                            ),
                            const SizedBox(width: 10,),
                            GestureDetector(
                              onTap: () {
                                ticketProv.changeCheckBoxCheck();
                              },
                              child: Text(
                                'Bao gồm thuế phí',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: ticketPro.checkBoxCheck ? Colors.orange : Colors.grey
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: const Text('Hãng hàng không', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                ),
                Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: SizedBox(
                        height: height/3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (ticketPro.airlines.contains('Vietjet Air')) {
                                  ticketPro.deleteAirlinesItem('Vietjet Air');
                                } else {
                                  ticketPro.addToAirlinesItem('Vietjet Air');
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.fromLTRB(15, 13, 0, 13),
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    color: ticketPro.airlines.contains('Vietjet Air') ? Colors.lightGreen  : Colors.white,
                                    borderRadius: BorderRadius.circular(3),
                                    border: ticketPro.airlines.contains('Vietjet Air') ? null : Border.all(color: Colors.grey, width: 1)
                                ),
                                child: Text('Vietjet Air', style: TextStyle(
                                    color: ticketPro.airlines.contains('Vietjet Air') ? Colors.white : Colors.black
                                ),),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (ticketPro.airlines.contains('Vietnam Airlines')) {
                                  ticketPro.deleteAirlinesItem('Vietnam Airlines');
                                } else {
                                  ticketPro.addToAirlinesItem('Vietnam Airlines');
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.fromLTRB(15, 13, 0, 13),
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    color: ticketPro.airlines.contains('Vietnam Airlines') ? Colors.lightGreen  : Colors.white,
                                    borderRadius: BorderRadius.circular(3),
                                    border: ticketPro.airlines.contains('Vietnam Airlines') ? null : Border.all(color: Colors.grey, width: 1)
                                ),
                                child: Text('Vietnam Airlines', style: TextStyle(
                                    color: ticketPro.airlines.contains('Vietnam Airlines') ? Colors.white : Colors.black
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (ticketPro.airlines.contains('Bamboo Airways')) {
                                  ticketPro.deleteAirlinesItem('Bamboo Airways');
                                } else {
                                  ticketPro.addToAirlinesItem('Bamboo Airways');
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.fromLTRB(15, 13, 0, 13),
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    color: ticketPro.airlines.contains('Bamboo Airways') ? Colors.lightGreen  : Colors.white,
                                    borderRadius: BorderRadius.circular(3),
                                    border: ticketPro.airlines.contains('Bamboo Airways') ? null : Border.all(color: Colors.grey, width: 1)
                                ),
                                child: Text('Bamboo Airways', style: TextStyle(
                                    color: ticketPro.airlines.contains('Bamboo Airways') ? Colors.white : Colors.black
                                ),),
                              ),
                            ),
                          ],
                        ),
                      ),
                )),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 10,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Colors.grey[200]!,
                                ),
                                child: const Center(
                                  child: Text('Hủy bỏ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                                ),
                              ),
                            )
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Expanded(
                            flex: 10,
                            child: GestureDetector(
                              onTap: () {
                                ticketProv.clickSortFlight();
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Colors.orange,
                                ),
                                child: const Center(
                                  child: Text('Lọc', style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white
                                  ),),
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget itemSort(BuildContext context, String title, TicketBookingProvider ticketProv) {
    return GestureDetector(
      onTap: () {
        ticketProv.changeSortBy(title);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Visibility(
              visible: ticketProv.sortBy == title,
                child: const Icon(Icons.check, color: Colors.orange,)),
            Text(
              title,
              style: TextStyle(fontSize: 14, color: ticketProv.sortBy == title ? Colors.orange : Colors.black),
            )
          ],
        ),
      ), // Từ cao tới thấp, theo điểm đánh giá
    );
  }
}
