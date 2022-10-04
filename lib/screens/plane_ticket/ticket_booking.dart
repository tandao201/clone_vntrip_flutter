import 'package:clone_vntrip/screens/plane_ticket/search_place.dart';
import 'package:clone_vntrip/screens/plane_ticket/searched_flight_ticket.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/time.dart';
import '../../components/colors.dart';
import '../../generated/l10n.dart';
import '../../providers/hotel_providers/date_pick_provider.dart';
import '../../providers/ticket_providers/ticket_booking_provider.dart';
import 'package:clone_vntrip/models/ticket/people.dart';

import '../home.dart';

class TicketBooking extends StatelessWidget {
  static const routeName = '/ticket-booking';

  const TicketBooking({Key? key}) : super(key: key);
  void clickCancel(BuildContext context) {
    // Navigator.pushNamed(context, HotelBooking.routeName);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    Provider.of<PickDateProvider>(context).initDate();
    bool roundTrip = false;

    void _launchURL(String url) async {
      await launchUrl(Uri.parse(url));
    }

    void selectPassengers(BuildContext context) {
      print('selectPassengers');
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return selectPassenger(heightScreen,context);
          },
          constraints: BoxConstraints(maxHeight: heightScreen * 0.7));
    }


    void selectPlace(int where) {
      Provider.of<TicketBookingProvider>(context, listen: false)
          .setGoOrTo(where);
      Navigator.pushNamed(context, SearchPlace.routeName);
    }

    void swapPlace() {
      Provider.of<TicketBookingProvider>(context, listen: false)
          .clickSwapPlace();
    }

    Future pickDateRange(bool isRoundTrip) async {
      if (isRoundTrip) {
        DateTimeRange? newDateRange = await showDateRangePicker(
          context: context,
          initialDateRange:
              Provider.of<PickDateProvider>(context, listen: false).dateRange,
          firstDate: DateTime.now().subtract(const Duration(days: 1)),
          lastDate: DateTime(2100),
        );
        if (newDateRange == null) return; //press x
        Provider.of<PickDateProvider>(context, listen: false)
            .pickDate(newDateRange);
      } else {
        DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: Provider.of<PickDateProvider>(context, listen: false)
                .dateRange!
                .start,
            firstDate: DateTime.now().subtract(const Duration(days: 1)),
            lastDate: DateTime(2100),
            initialEntryMode: DatePickerEntryMode.calendar);
        DateTimeRange dateRange = DateTimeRange(
            start: newDate!,
            end: DateTime(newDate.year, newDate.month, newDate.day + 1));
        if (newDate == null) return; //press x
        Provider.of<PickDateProvider>(context, listen: false)
            .pickDate(dateRange);
      }
    }

    void backToPrevious() {
      if (Navigator.canPop(context)){
        Navigator.pop(context);
      } else {
        Navigator.pushNamed(context, Home.routeName);
      }
    }

    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Consumer<TicketBookingProvider>(
          builder: (context, ticketProvi, child) {
            return ListView(
              children: [
                SizedBox(
                  height: heightScreen / 1.2,
                  child: Stack(
                    children: [
                      Image.asset("assets/images/hotel_banner.png"), // banner bg
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => backToPrevious(),
                                  child: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    S.of(context).titleTicketBooking,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )),
                            GestureDetector(
                              onTap:  () {
                                _launchURL("tel://0963266688");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColor.bg_contact,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.phone,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      Text(
                                        '096 326 6688',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ), // Contact
                      Positioned(
                        top: 110,
                        child: Container(
                          width: widthScreen,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Card(
                            elevation: 8,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        color: Colors.white,
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: GestureDetector(
                                                onTap: () {
                                                  selectPlace(1);
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                      child:  Text(
                                                        S.of(context).sourcePlace,
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                    Text(
                                                      ticketProvi.goPlace?.code ??
                                                          '--.--',
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight.w500),
                                                    ),
                                                    Text(
                                                      ticketProvi.goPlace
                                                          ?.provinceName ??
                                                          '--',
                                                      style: const TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: GestureDetector(
                                                onTap: () {
                                                  swapPlace();
                                                },
                                                child: const Icon(
                                                  Icons
                                                      .swap_horizontal_circle_outlined,
                                                  color: Colors.grey,
                                                  size: 40,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: GestureDetector(
                                                onTap: () {
                                                  selectPlace(2);
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                        child:  Text(
                                                          S.of(context).destinationPlace,
                                                          style: const TextStyle(
                                                              fontSize: 13,
                                                              color: Colors.grey),
                                                        )),
                                                    Text(
                                                      ticketProvi.toPlace?.code ??
                                                          '--.--',
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight.w500),
                                                    ),
                                                    Text(
                                                      ticketProvi.toPlace
                                                          ?.provinceName ??
                                                          '--',
                                                      style: const TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      PreferredSize(
                                        preferredSize:
                                            const Size.fromHeight(2.0),
                                        child: Container(
                                          color: AppColor.grayHintText,
                                          height: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      pickDateRange(roundTrip);
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 10),
                                                    child: Text(
                                                      S.of(context).startDate,
                                                      style: TextStyle(
                                                          color:
                                                          AppColor.grayText,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  Consumer<PickDateProvider>(
                                                    builder: (context,
                                                        pickDateProvi, child) {
                                                      return Container(
                                                        decoration:
                                                        const BoxDecoration(),
                                                        margin: const EdgeInsets
                                                            .fromLTRB(0, 0, 0, 5),
                                                        child: Text(
                                                          Time.formatTime(
                                                              pickDateProvi
                                                                  .dateRange!
                                                                  .start),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              fontSize: 15),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 5),
                                                    child: Text(
                                                      S.of(context).returnFlight,
                                                      style: TextStyle(
                                                          color:
                                                          AppColor.grayText,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration:
                                                    const BoxDecoration(),
                                                    margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 5),
                                                    child: Consumer<
                                                        TicketBookingProvider>(
                                                      builder: (context,
                                                          ticketProvi, child) {
                                                        return CupertinoSwitch(
                                                          value: ticketProvi
                                                              .isRoundTrip,
                                                          onChanged:
                                                              (bool value) {
                                                            roundTrip = value;
                                                            ticketProvi
                                                                .changeRoundTrip();
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          PreferredSize(
                                            preferredSize:
                                            const Size.fromHeight(2.0),
                                            child: Container(
                                              color: AppColor.grayHintText,
                                              height: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Consumer<TicketBookingProvider>(
                                    builder: (context, ticketProvi, child) {
                                      return Visibility(
                                          visible: ticketProvi.isRoundTrip,
                                          child: GestureDetector(
                                            onTap: () {
                                              pickDateRange(true);
                                            },
                                            child: Container(
                                              color: Colors.white,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 10),
                                                    child: Text(
                                                      S.of(context).endDate,
                                                      style: TextStyle(
                                                          color:
                                                          AppColor.grayText,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                  Consumer<PickDateProvider>(
                                                    builder: (context,
                                                        pickDateProvi, child) {
                                                      return Container(
                                                        decoration:
                                                        const BoxDecoration(),
                                                        margin: const EdgeInsets
                                                            .fromLTRB(0, 0, 0, 5),
                                                        child: Text(
                                                          Time.formatTime(
                                                              pickDateProvi
                                                                  .dateRange!
                                                                  .end),
                                                          style: const TextStyle(
                                                              fontWeight:
                                                              FontWeight.w500,
                                                              fontSize: 15),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  PreferredSize(
                                                    preferredSize:
                                                    const Size.fromHeight(
                                                        2.0),
                                                    child: Container(
                                                      color:
                                                      AppColor.grayHintText,
                                                      height: 1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ));
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      ticketProvi.clickPeopleChange();
                                      selectPassengers(context);
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Text(
                                              S.of(context).passengers,
                                              style: TextStyle(
                                                  color: AppColor.grayText,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          Container(
                                            decoration: const BoxDecoration(),
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 5),
                                            child: Text(
                                              ticketProvi.peopleString,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          PreferredSize(
                                            preferredSize:
                                            const Size.fromHeight(2.0),
                                            child: Container(
                                              color: AppColor.grayHintText,
                                              height: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Consumer<PickDateProvider>(
                                        builder: (context, datePickProv, child) {
                                          return Container(
                                            width: widthScreen,
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: AppColor.orangeMain),
                                              onPressed: () {
                                                if (ticketProvi.goPlace != null && ticketProvi.toPlace != null) {
                                                  ticketProvi.clickBtnSearchTicket(datePickProv.dateRange!);
                                                  Navigator.pushNamed(context, SearchedFlightTicket.routeName);
                                                }
                                              },
                                              child: Text(S.of(context).search),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ), // booking
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 22, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        S.of(context).endowWeek,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8)),
                        height: heightScreen / 3.4,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              width: widthScreen,
                              padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                              child: Image.asset(
                                'assets/images/endow_1.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              width: widthScreen,
                              padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                              child: Image.asset(
                                'assets/images/endow_2.jpg',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 22, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        S.of(context).hotPlace,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: heightScreen / 3,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              width: widthScreen / 2.3,
                              padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                              child: Stack(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                      ),
                                      height: heightScreen / 3,
                                      child: Image.asset(
                                        'assets/images/hanoi.jpg',
                                        fit: BoxFit.fitHeight,
                                      )),
                                  Positioned(
                                    bottom: 10,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              7, 0, 0, 8),
                                          child: const Text(
                                            'Hà Nội',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              7, 0, 0, 8),
                                          child: const Text('1000+ Khách sạn',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: widthScreen / 2.3,
                              padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                              child: Stack(
                                children: [
                                  SizedBox(
                                      height: heightScreen / 3,
                                      child: Image.asset(
                                        'assets/images/da_nang.jpg',
                                        fit: BoxFit.fitHeight,
                                      )),
                                  Positioned(
                                    bottom: 10,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              7, 0, 0, 8),
                                          child: const Text(
                                            'Đà Nẵng',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              7, 0, 0, 8),
                                          child: const Text('1000+ Khách sạn',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: widthScreen / 2.3,
                              padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                              child: Stack(
                                children: [
                                  SizedBox(
                                      height: heightScreen / 3,
                                      child: Image.asset(
                                        'assets/images/hoian.jpg',
                                        fit: BoxFit.fitHeight,
                                      )),
                                  Positioned(
                                    bottom: 10,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              7, 0, 0, 8),
                                          child: const Text(
                                            'Hội An',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              7, 0, 0, 8),
                                          child: const Text('1000+ Khách sạn',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget selectPassenger(double height, BuildContext context ) {
    return Scaffold(
      body: Consumer<TicketBookingProvider>(
        builder: (context, ticketProv, child) {
          return SizedBox(
            height: height * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                          border:
                          Border(bottom: BorderSide(color: Colors.grey, width: 1))),
                      child: const Center(
                        child: Text(
                          'Thay đổi hành khách',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                          border:
                          Border(bottom: BorderSide(color: Colors.grey, width: 1))),
                      child: Column(
                        children: [
                          const Center(
                            child: Text(
                              'Bạn có muốn đặt khách đoàn',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 4),
                            child: const Center(
                              child: Text(
                                'Hãy liên hệ với VNTRIP.VN',
                                style: TextStyle(fontSize: 12, color: Colors.blue),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: height/3,
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            child: Image.asset(
                              'assets/images/adult.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            child: const Text(
                              'người lớn',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            child: const Text(
                              'Trên 12 tuổi',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.only(top: 10),
                              child: NumberPicker(
                                  minValue: 1,
                                  maxValue: 6,
                                  value: ticketProv.people.adult!,
                                  onChanged: (value) {
                                    ticketProv.changeNumber(People(adult: value,children: ticketProv.people.children!,baby: ticketProv.people.baby!));
                                  }),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            child: Image.asset(
                              'assets/images/child.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            child: const Text(
                              'trẻ em',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            child: const Text(
                              '2 đến 12 tuổi',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Flexible(child: Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: NumberPicker(
                                minValue: 0,
                                maxValue: 5,
                                value: ticketProv.people.children!,
                                onChanged: (value) {
                                  ticketProv.changeNumber(People(adult: ticketProv.people.adult!,children: value,baby: ticketProv.people.baby!));
                                }),
                          )),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            child: Image.asset(
                              'assets/images/baby.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            child: const Text(
                              'em bé',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            child: const Text(
                              'Dưới 2 tuổi',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.only(top: 10),
                              child: NumberPicker(
                                  minValue: 0,
                                  maxValue: 2,
                                  value: ticketProv.people.baby!,
                                  onChanged: (value) {
                                    ticketProv.changeNumber(People(adult: ticketProv.people.adult!,children: ticketProv.people.children!,baby: value));
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.grey
                            ),
                            onPressed: () {
                              clickCancel(context);
                            },
                            child: Text('Hủy', style: TextStyle(color: AppColor.grayLight),),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.orange
                          ),
                          onPressed: () { ticketProv.clickBtnSelectPeople();
                            clickCancel(context) ;},
                          child: Text('Chọn'),
                        ),
                      )
                    ],
                  ),
                ),// button
              ],
            ),
          );
        },
      ),
    );
  }
}
