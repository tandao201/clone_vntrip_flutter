import 'package:clone_vntrip/screens/hotel/map_each_hotel.dart';
import 'package:clone_vntrip/screens/hotel/pre_booking_hotel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/currency.dart';
import '../../components/Time.dart';
import '../../components/colors.dart';
import '../../models/hotel/requests/request_detail_hotel.dart';
import '../../models/hotel/responses/response_detail_each_room.dart';
import '../../models/hotel/responses/response_detail_hotel.dart';
import '../../models/hotel/rooms_and_customers.dart';
import '../../providers/hotel_providers/date_pick_provider.dart';
import '../../providers/hotel_providers/detail_hotel_providers.dart';
import '../../providers/hotel_providers/suggest_place_provider.dart';
import 'detail_each_room_hotel.dart';

class DetailHotel extends StatelessWidget {
  static const routeName = '/detail-hotel';

  @override
  Widget build(BuildContext context) {
    int? hotelId =
        Provider.of<DetailHotelProviders>(context, listen: false).hotelId;
    final detailProvMain = Provider.of<DetailHotelProviders>(context);
    List<ResponseDetailHotelDataResultsImages?>? images = [];
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    DateTimeRange? timeRange = Provider.of<PickDateProvider>(context).dateRange;
    RequestDetailHotel request = RequestDetailHotel(
        request_from: '',
        ta_from_type: '',
        nights: Time.getDateRange(timeRange!.start, timeRange.end),
        checkin_date: Time.getDateString(timeRange.start),
        hotel_id: hotelId,
        room_count: detailProvMain.roomsAndCustomersMain?.rooms,
        adult_count: detailProvMain.roomsAndCustomersMain?.custormers,
        is_international: false);

    void pickDateResearchHotel() async {
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

      Provider.of<SuggestPlaceProvider>(context, listen: false)
          .clickBtnSearch(newDateRange);

      // searcherProv.resetData();
      // searcherProv.searchHotel(1, request!);
      detailProvMain.detailEachRoom(request);
    }

    void _launchURL(String url) async {
      await launchUrl(Uri.parse(url));
    }

    void clickCancel() {
      detailProvMain.clearData();
      Navigator.pop(context);
    }

    void selectRooms(BuildContext context) {
      print('selectPassengers');
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return selectRoom(heightScreen, context);
          },
          constraints: BoxConstraints(maxHeight: heightScreen * 0.5));
    }

    List<Widget> _createRoomList() {
      return List<Widget>.generate(detailProvMain.roomDataDetail!.length,
          (int index) {
        return itemRoomHotel(context,
            widthScreen, widthScreen, detailProvMain.roomDataDetail![index]!);
      });
    }

    if (detailProvMain.isFirstTime) {
      detailProvMain.detailHotel(hotelId!);
    }

    if (detailProvMain.roomDataDetail==null || detailProvMain.roomDataDetail!.isEmpty ) {
      print('Hotel id: $hotelId');
      detailProvMain.detailEachRoom(request);
    }
    // TODO: implement build
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(15, 25, 15, 8),
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
                    'Chọn phòng',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.favorite_outline,
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
                    ),
                  ],
                ),
              ],
            ), //appBar
          ),
          Expanded(
            child: detailProvMain.isLoading
                ? Container(child: const CupertinoActivityIndicator())
                : Container(
                    color: Colors.grey[200]!,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 10, top: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        detailProvMain.results!.nameVi!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17),
                                      ),
                                      RatingBar.builder(
                                        initialRating: double.parse(
                                            detailProvMain.results!.starRate!
                                                .toString()),
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: double.parse(detailProvMain
                                                .results!.starRate!
                                                .toString())
                                            .toInt(),
                                        itemSize: 15,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.orange,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 15),
                                  height: heightScreen / 3.5,
                                  width: widthScreen,
                                  child: PageView.builder(
                                      itemCount: detailProvMain
                                          .results?.images?.length,
                                      pageSnapping: true,
                                      itemBuilder: (context, pagePosition) {
                                        images = detailProvMain.results?.images;
                                        String urlImg =
                                            'https://statics.vntrip.vn/data-v2/hotels/$hotelId/img_max/${images![pagePosition]!.slug!}';
                                        return Container(
                                            child: Image.network(
                                          urlImg,
                                          fit: BoxFit.fill,
                                        ));
                                      }),
                                ),
                                Container(
                                  // height: heightScreen/7,
                                  // width: widthScreen,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                          child: Container(
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.place_outlined,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: widthScreen * 0.65,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    maxLines: 2,
                                                    detailProvMain
                                                        .results!.fullAddress!,
                                                    style: const TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15),
                                                  ),
                                                  // Text(
                                                  //   'Hà Nội',
                                                  //   style: TextStyle(fontSize: 13),
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                      GestureDetector(
                                        onTap: () {
                                          print('tap to map');
                                          Navigator.pushNamed(
                                              context, MapEachHotel.routeName);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey,
                                                  width: 1)),
                                          child: Row(
                                            children: const [
                                              Icon(
                                                Icons
                                                    .compass_calibration_outlined,
                                                color: Colors.grey,
                                                size: 13,
                                              ),
                                              Text(
                                                'Bản đồ',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: GestureDetector(
                                      onTap: () {
                                        print('pick date');
                                        pickDateResearchHotel();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey[200]!,
                                                width: 1)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Nhận phòng',
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.grey),
                                            ),
                                            Consumer<PickDateProvider>(
                                              builder: (context, pickDateProv,
                                                  child) {
                                                return Text(
                                                    Time.formatTimeVi(
                                                        pickDateProv
                                                            .dateRange!.start),
                                                    style: const TextStyle(
                                                        color: Colors.blue));
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: GestureDetector(
                                      onTap: () {
                                        print('pick date');
                                        pickDateResearchHotel();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey[200]!,
                                                width: 1)),
                                        child: Consumer<PickDateProvider>(
                                          builder:
                                              (context, pickDateProv, child) {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                    'Trả phòng (${Time.getDateRange(pickDateProv.dateRange!.start, pickDateProv.dateRange!.end)} đêm)',
                                                    style: const TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.grey)),
                                                Text(
                                                    Time.formatTimeVi(
                                                        pickDateProv
                                                            .dateRange!.end),
                                                    style: const TextStyle(
                                                        color: Colors.blue))
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        print('pick phòng');
                                        selectRooms(context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey[200]!,
                                                width: 1)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text('Phòng',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.grey)),
                                            Text(detailProvMain
                                                .roomsAndCustomersMain!.rooms
                                                .toString()),
                                          ],
                                        ),
                                      ),
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        print('pick khách');
                                        selectRooms(context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey[200]!,
                                                width: 1)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text('Khách',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.grey)),
                                            Text(detailProvMain
                                                .roomsAndCustomersMain!
                                                .custormers
                                                .toString()),
                                          ],
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          detailProvMain.isLoadingRooms
                              ? Container(
                                  color: Colors.white,
                                  width: widthScreen,
                                  padding: const EdgeInsets.all(30),
                                  child: detailProvMain.roomDataDetail == null
                                      ? const CupertinoActivityIndicator()
                                      : detailProvMain.roomDataDetail!.isEmpty
                                        ? const Center(child: Text('Không có phòng'))
                                        : Container(),
                                )
                              : Container(
                            margin: const EdgeInsets.fromLTRB(3, 5, 3, 10),
                            child: Column(
                              children: _createRoomList(),
                            ),
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print('tapping...');
                                  detailProvMain
                                      .clickSeeMore('Tiện nghi khách sạn');
                                },
                                child: itemIntroduce(
                                    widthScreen,
                                    heightScreen,
                                    'Tiện nghi khách sạn',
                                    detailProvMain
                                            .results!.facilitiesText!.isEmpty
                                        ? 'Xin lỗi quý khách, hiện tại chúng tôi chưa có dữ liệu về khách sạn này'
                                        : detailProvMain
                                            .results!.facilitiesText!),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('tapping...');
                                  detailProvMain
                                      .clickSeeMore('Mô tả khách sạn');
                                },
                                child: itemIntroduce(
                                    widthScreen,
                                    heightScreen,
                                    'Mô tả khách sạn',
                                    detailProvMain.results!.desContent!.isEmpty
                                        ? 'Xin lỗi quý khách, hiện tại chúng tôi chưa có dữ liệu về khách sạn này'
                                        : detailProvMain.results!.desContent!),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('tapping...');
                                  detailProvMain
                                      .clickSeeMore('Chính sách khách sạn');
                                },
                                child: itemIntroduce(
                                    widthScreen,
                                    heightScreen,
                                    'Chính sách khách sạn',
                                    detailProvMain.getChekInCheckOutDate()),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget itemRoomHotel(BuildContext context,
      double width, double heigh, ResponseDetailEachRoomDataRoomData roomData) {
    return GestureDetector(
      onTap: () {
        print('tap to detail');
        Provider.of<DetailHotelProviders>(context, listen: false).setRecentlyRoom(roomData);
        Navigator.pushNamed(context, DetailEachRoomHotel.routeName);
      },
      child: Container(
        // height: heigh/3,
        // width: width,
        margin: const EdgeInsets.only(bottom: 10),
        color: Colors.white,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(3),
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width / 3.5,
                                height: 50,
                                child: roomData.photos!.isEmpty ? Image.asset('assets/images/not_load_img.jpg', fit: BoxFit.fill,) : Image.network(
                                  roomData.photos![0]!.roomImage!,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Flexible(child: Text(
                                roomData.name!,
                                style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    overflow: TextOverflow.ellipsis),
                                maxLines: 2,
                              )),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.bed,
                                size: 15,
                                color: Colors.green,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${roomData.reformatBedTypes![0]!.bedData![0]!.count!} ${roomData.reformatBedTypes![0]!.bedData![0]!.type!}',
                                style:
                                const TextStyle(color: Colors.green, fontSize: 13),
                                maxLines: 2,
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.format_shapes,
                                size: 15,
                                color: Colors.green,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                roomData.roomArea.toString(),
                                style: const TextStyle(
                                    color: Colors.green, fontSize: 13),
                                maxLines: 1,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey[200]!,
                    height: 1,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.free_cancellation,
                                    size: 16,
                                  ),
                                  Text(
                                      'Hủy phòng: ${roomData.rates![0]!.refundable! ? 'Có hoàn hủy' : 'Không hoàn hủy'}'),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.set_meal_outlined,
                                  size: 16,
                                ),
                                Text(
                                    'Bữa ăn: ${roomData.rates![0]!.mealPlan == 'breakfast' ? 'Bao gồm ăn sáng' : 'Không bao gồm'}'),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          width: width / 2.6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                child: Visibility(
                                  visible: roomData.minPrice !=
                                      roomData.rates![0]!.totalPrice,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        Currency.displayPriceFormat(
                                            roomData.minPrice!),
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 11,
                                            decoration:
                                            TextDecoration.lineThrough),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 5),
                                        padding: const EdgeInsets.only(
                                            top: 2, bottom: 2),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(4),
                                            color: Colors.redAccent),
                                        child: Text(
                                            Currency.getSalePercent(
                                                roomData.minPrice!,
                                                roomData.rates![0]!.totalPrice!),
                                            style: const TextStyle(
                                                fontSize: 11,
                                                color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  Currency.displayPriceFormat(
                                      roomData.minPrice!),
                                  style: const TextStyle(
                                      color: Colors.orange, fontSize: 16),
                                ),
                              ),
                              Visibility(
                                  visible: roomData.rates![0]!.vat!,
                                  child: Container(
                                    child: const Text(
                                      'Đã bao gồm thuế VAT và phí dịch vụ',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                      maxLines: 2,
                                    ),
                                  )),
                              Visibility(
                                visible: roomData
                                    .rates![0]!.showPrices!.mobileRate!.theShow!,
                                child: Container(
                                  padding:
                                  const EdgeInsets.only(top: 6, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: const [
                                      Icon(
                                        Icons.phone_android_sharp,
                                        size: 13,
                                        color: Colors.blue,
                                      ),
                                      Text('Ưu đãi trên điện thoại',
                                          style: TextStyle(
                                              fontSize: 10, color: Colors.blue)),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey[200]!,
                    height: 1,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text('Sức chứa: '),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 6),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                roomData.maxAdult.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const Icon(
                              Icons.person_outline,
                              size: 20,
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            print('Booking...');
                            Provider.of<DetailHotelProviders>(context, listen: false).setRecentlyRoom(roomData);
                            Navigator.pushNamed(context, PreBookingHotel.routeName);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 7),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              'Đặt phòng',
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[200]!,
              child: Visibility(
                visible: roomData.rates![0]!.roomCount! <= 2? true : false,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    color: AppColor.bg_light_yellow,
                    padding:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                    child: Text(
                      'Chỉ còn ${roomData.rates![0]!.roomCount} phòng',
                      style: TextStyle(color: AppColor.red_earth, fontSize: 13),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemIntroduce(
      double width, double height, String title, String content) {
    return Consumer<DetailHotelProviders>(
      builder: (context, detailProv, child) {
        return Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Colors.grey[200]!, width: 1))),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Icon(
                      detailProv.moreInfo.contains(title) ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              Visibility(
                  visible: detailProv.moreInfo.contains(title),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: content.contains('<strong>')
                        ? Html(
                            data: content,
                          )
                        : Text(
                            content,
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.justify,
                          ),
                  )),
            ],
          ),
        );
      },
    );
  }

  Widget selectRoom(double height, BuildContext context) {
    return Consumer<DetailHotelProviders>(
      builder: (context, detailProv, child) {
        return Container(
          padding: const EdgeInsets.only(top: 15),
          height: height * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.room_preferences,
                              size: 35,
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 5),
                              child: const Text(
                                'Phòng',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      NumberPicker(
                          minValue: 1,
                          maxValue: 5,
                          value: detailProv.roomsAndCustomers!.rooms,
                          onChanged: (value) {
                            detailProv.changeRoomAndCustomer(RoomsAndCustomers(
                                rooms: value,
                                custormers:
                                    detailProv.roomsAndCustomers!.custormers));
                          }),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.people_outline,
                              size: 35,
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 5),
                              child: const Text(
                                'Khách',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      NumberPicker(
                          minValue: 1,
                          maxValue: 30,
                          value: detailProv.roomsAndCustomers!.custormers,
                          onChanged: (value) {
                            detailProv.changeRoomAndCustomer(RoomsAndCustomers(
                                rooms: detailProv.roomsAndCustomers!.rooms,
                                custormers: value));
                          }),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.grey),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Hủy',
                            style: TextStyle(color: Colors.grey[200]!),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.orange),
                        onPressed: () {
                          detailProv.clickBtnSelectRoomCustomer();
                          Navigator.pop(context);
                        },
                        child: const Text('Chọn'),
                      ),
                    )
                  ],
                ),
              ), // button
            ],
          ),
        );
      },
    );
  }
}
