
import 'package:clone_vntrip/screens/hotel/searched_rooms.dart';
import 'package:clone_vntrip/screens/hotel/suggestPlace.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/time.dart';
import '../../components/colors.dart';
import '../../generated/l10n.dart';
import '../../providers/hotel_providers/date_pick_provider.dart';
import '../../providers/hotel_providers/searcherHotelProvider.dart';
import '../../providers/hotel_providers/suggest_place_provider.dart';
import '../home.dart';

class HotelBooking extends StatelessWidget {

  static const routeName = '/hotel';

  const HotelBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery
        .of(context)
        .size
        .width;
    final heightScreen = MediaQuery
        .of(context)
        .size
        .height;
    Provider.of<PickDateProvider>(context, listen: false).initDate();
    Provider.of<SuggestPlaceProvider>(context, listen: false).getCurrentLocation();

    void backToPrevious() {
      if (Navigator.canPop(context)){
        Navigator.pop(context);
      } else {
        Navigator.pushNamed(context, Home.routeName);
      }
    }

    void selectPlace() {
      debugPrint('suggest place');
      Navigator.pushNamed(context, SuggestPlace.routeName);
    }

    Future pickDateRange() async {
      DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: Provider
            .of<PickDateProvider>(context, listen: false)
            .dateRange,
        firstDate: DateTime.now().subtract(const Duration(days: 1)),
        lastDate: DateTime(2100),
      );
      if (newDateRange == null) return; //press x
      Provider.of<PickDateProvider>(context, listen: false).pickDate(
          newDateRange);
    }

    void clickBtnSearchRoom() {
      DateTimeRange timeRange = Provider.of<PickDateProvider>(context, listen: false).dateRange!;
      Provider.of<SuggestPlaceProvider>(context, listen: false)
          .clickBtnSearch(timeRange);
      Provider.of<SearchedHotelProvider>(context, listen: false)
          .resetData();
      Navigator.pushNamed(context, SearchedRoom.routeName);
    }

    void _launchURL(String url) async {
      await launchUrl(Uri.parse(url));
    }


    // TODO: implement build
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: heightScreen / 1.8,
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
                                child:  Text(S.of(context).titleRoomBooking,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),),
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
                      ),
                    ],
                  ),
                ), // Contact
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: widthScreen,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Card(
                      elevation: 8,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                selectPlace();
                              },
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 7, 0, 10),
                                      child: Text(S.of(context).titlePlaceHotel,
                                        style: TextStyle(color: AppColor.grayText,
                                            fontSize: 15),),
                                    ),
                                    Consumer<SuggestPlaceProvider>(
                                        builder: (context, suggestProvi, child) {
                                          return Container(
                                            decoration: const BoxDecoration(),
                                            margin: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 5),
                                            child: suggestProvi.address.isEmpty
                                                ? const Text('')
                                                : Text(
                                              suggestProvi.location!.name!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),),
                                          );
                                        }
                                    ),
                                    PreferredSize(
                                      preferredSize: const Size.fromHeight(2.0),
                                      child: Container(
                                        color: AppColor.grayHintText,
                                        height: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                pickDateRange();
                              },
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: Text(S.of(context).checkInHotel, style: TextStyle(
                                          color: AppColor.grayText,
                                          fontSize: 15),),
                                    ),
                                    Consumer<PickDateProvider>(
                                      builder: (context, pickDateProvi, child) {
                                        return Container(
                                          decoration: const BoxDecoration(),
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 5),
                                          child: Text(Time.formatTime(
                                              pickDateProvi.dateRange!.start),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15),),
                                        );
                                      },
                                    ),
                                    PreferredSize(
                                      preferredSize: const Size.fromHeight(2.0),
                                      child: Container(
                                        color: AppColor.grayHintText,
                                        height: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                pickDateRange();
                              },
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      child: Text(S.of(context).checkOutHotel, style: TextStyle(
                                          color: AppColor.grayText, fontSize: 15),),
                                    ),
                                    Consumer<PickDateProvider>(
                                      builder: (context, pickDateProvi, child) {
                                        return Container(
                                          decoration: const BoxDecoration(),
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 5),
                                          child: Text(Time.formatTime(
                                              pickDateProvi.dateRange!.end),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15),),
                                        );
                                      },
                                    ),
                                    PreferredSize(
                                      preferredSize: const Size.fromHeight(2.0),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(

                                  width: widthScreen,
                                  margin: const EdgeInsets.fromLTRB(
                                      0, 10, 0, 0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: AppColor.orangeMain),
                                    onPressed: () {
                                      clickBtnSearchRoom();
                                    },
                                    child: Text(S.of(context).search),

                                  ),
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
                Text(S.of(context).endowWeek,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),),
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
                          'assets/images/endow_1.png', fit: BoxFit.fill,),
                      ),
                      Container(
                        width: widthScreen,
                        padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                        child: Image.asset(
                          'assets/images/endow_2.jpg', fit: BoxFit.fill,),
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
                Text(S.of(context).hotPlace, style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),),
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
                                child: Image.asset('assets/images/hanoi.jpg',
                                  fit: BoxFit.fitHeight,)),
                            Positioned(
                              bottom: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(7, 0, 0, 8),
                                    child: const Text('Hà Nội', style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,),),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(7, 0, 0, 8),
                                    child: const Text('1000+ Khách sạn',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ),
                                ],
                              ),),
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
                                child: Image.asset('assets/images/da_nang.jpg',
                                  fit: BoxFit.fitHeight,)),
                            Positioned(
                              bottom: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(7, 0, 0, 8),
                                    child: const Text('Đà Nẵng', style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,),),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(7, 0, 0, 8),
                                    child: const Text('1000+ Khách sạn',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ),
                                ],
                              ),),
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
                                child: Image.asset('assets/images/hoian.jpg',
                                  fit: BoxFit.fitHeight,)),
                            Positioned(
                              bottom: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(7, 0, 0, 8),
                                    child: const Text('Hội An', style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,),),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(7, 0, 0, 8),
                                    child: const Text('1000+ Khách sạn',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ),
                                ],
                              ),),
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
      )
    );
  }

}