import 'package:clone_vntrip/components/colors.dart';
import 'package:clone_vntrip/models/hotel/requests/request_search_room.dart';
import 'package:clone_vntrip/providers/hotel_providers/suggest_place_provider.dart';
import 'package:clone_vntrip/screens/hotel/detail_hotel.dart';
import 'package:clone_vntrip/screens/hotel/map_hotels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/currency.dart';
import '../../components/time.dart';
import '../../generated/l10n.dart';
import '../../models/hotel/responses/response_searched_hotel.dart';
import '../../providers/hotel_providers/date_pick_provider.dart';
import '../../providers/hotel_providers/detail_hotel_providers.dart';
import '../../providers/hotel_providers/searcherHotelProvider.dart';
import 'filter_hotels_searched.dart';

class SearchedRoom extends StatelessWidget {
  static const routeName = '/searched-room';

  const SearchedRoom({Key? key}) : super(key: key);

  String getSubRatingString(double reviewPoint) {
    String result = "";
    if (reviewPoint >= 10) {
      result = "Xuất sắc";
    } else if (reviewPoint >= 9) {
      result = "Tuyệt hảo";
    } else if (reviewPoint >= 8) {
      result = "Tuyệt vời";
    } else if (reviewPoint >= 7) {
      result = "Tốt";
    } else {
      result = "Điểm đánh giá";
    }
    return result;
  }

  clickHotelItem(BuildContext context ,int? hotelId) {
    print('click detail: $hotelId');
    Provider.of<DetailHotelProviders>(context, listen: false).setRequest(hotelId!);
    Provider.of<DetailHotelProviders>(context, listen: false).clearData();
    Navigator.pushNamed(context, DetailHotel.routeName, arguments: hotelId);
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    ScrollController scrollController = ScrollController();
    int page = 1;

    RequestSearchRoom? request =
        Provider.of<SuggestPlaceProvider>(context, listen: false)
            .requestSearchRoom;

    void _scrollListener() {
      if (scrollController.position.extentAfter < 300) {
        print('Load more...');
        page++;
        if (Provider.of<SearchedHotelProvider>(context, listen: false)
            .hotelsApi
            .isNotEmpty) {
          Provider.of<SearchedHotelProvider>(context, listen: false)
              .searchHotel(page, request!);
        }
      }
    }

    scrollController.addListener(_scrollListener);

    void clickSortMenu(SearchedHotelProvider searchProv) {
      print('clickSortMenu...');
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return sortDialog(heightScreen, context, searchProv);
          },
          constraints: BoxConstraints(maxHeight: heightScreen * 0.25));
    }

    void pickDateResearchHotel(SearchedHotelProvider searcherProv) async {
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

      searcherProv.resetData();
      searcherProv.searchHotel(1, request!);
    }

    void _launchURL(String url) async {
      await launchUrl(Uri.parse(url));
    }

    void clickCancel(SearchedHotelProvider searcherProv) {
      // Navigator.pushNamed(context, HotelBooking.routeName);
      searcherProv.isFirstTime = true;
      // Provider.of<SearchedHotelProvider>(context, listen: false).resetData();
      Navigator.pop(context);
    }

    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          Consumer<SearchedHotelProvider>(
              builder: (context, searchedProv, child) {
            return Container(
              padding: const EdgeInsets.fromLTRB(15, 25, 15, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      clickCancel(searchedProv);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      pickDateResearchHotel(searchedProv);
                    },
                    child: Consumer<SuggestPlaceProvider>(
                      builder: (context, suggestProv, child) {
                        return Column(
                          children: [
                            Text(
                              suggestProv.requestSearchRoom!.name,
                              style: const TextStyle(fontSize: 17),
                            ),
                            Text(
                              '${suggestProv.requestSearchRoom!.nights} đêm (${Time.getDayAndMonth(suggestProv.requestSearchRoom!.checkInDate)} - ${Time.getDayAndMonth(suggestProv.requestSearchRoom!.checkOutDate)})',
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.blue),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _launchURL("tel://0963266688"),
                    child: Container(
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
              ), //appBar
            );
          }),
          Expanded(child: Consumer<SearchedHotelProvider>(
            builder: (context, searchProv, child) {
              if (searchProv.isFirstTime) {
                searchProv.resetData();
              }
              if (searchProv.hotelsMain.isEmpty) {
                searchProv.searchHotel(page, request!);
              }
              var hotels = searchProv.hotels;
              return searchProv.isLoading
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return itemLoading(widthScreen, heightScreen);
                      })
                  : Scrollbar(
                      child: ListView.builder(
                          controller: scrollController,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: hotels.length,
                          itemBuilder: (context, index) {
                            if (hotels.isNotEmpty) {
                              ResponseSearchedRoomData itemData = hotels[index];
                              return itemRoomSearched(context,
                                  widthScreen, heightScreen, itemData);
                            } else {
                              return const Center(
                                child: Text('Không tìm thấy khách sạn nào'),
                              );
                            }
                          }),
                    );
            },
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColor.grayLight, width: 1)),
              child: Consumer<SearchedHotelProvider>(
                builder: (context, searchProv, child) {
                  return Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            clickSortMenu(searchProv);
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
                                    visible: searchProv.sortBy.isNotEmpty,
                                    child: const Icon(Icons.check, color: Colors.orange,)),
                                Text(
                                  S.of(context).sort,
                                  style: TextStyle(
                                      color: searchProv.sortBy.isEmpty
                                          ? Colors.black
                                          : Colors.orange),
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
                            searchProv.getDataFieldSort();
                            Navigator.pushNamed(
                                context, FilterSearchedHotel.routeName);
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
                                    visible: searchProv.isSort,
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.orange,
                                    )),
                                Text(
                                  S.of(context).filter,
                                  style: TextStyle(
                                      color: !searchProv.isSort
                                          ? Colors.black
                                          : Colors.orange),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            searchProv.getMarkerForMap();
                            Navigator.pushNamed(context, MapHotels.routeName);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        color: AppColor.grayLight, width: 1))),
                            padding: const EdgeInsets.all(12),
                            child:  Center(
                              child: Text(S.of(context).map),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget itemRoomSearched(BuildContext context,
      double width, double height, ResponseSearchedRoomData hotel) {
    String urlImg = 'assets/images/not_load_img.jpg';
    if (hotel.thumbImage != null) {
      urlImg =
          'https://i.vntrip.vn/200x400/smart/https://statics.vntrip.vn/data-v2/hotels/${hotel.id}/img_max/${hotel.thumbImage}';
    }
    return GestureDetector(
      onTap: () {
        clickHotelItem( context,hotel.id);
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 4,
              color: Colors.grey,
            ),
            SizedBox(
              height: height / 3.2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: SizedBox(
                      width: width / 4,
                      height: height / 3.2,
                      child: hotel.thumbImage == null
                          ? Image.asset(
                        urlImg,
                        fit: BoxFit.fill,
                      )
                          : Image.network(
                        urlImg,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    width: 3 * width / 4,
                    padding: const EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                                child: Text(
                                  hotel.nameVi!,
                                  style: const TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                )),
                            Visibility(
                              visible: hotel.starRate != '0',
                              child: Container(
                                padding: const EdgeInsets.only(top: 5),
                                child: RatingBar.builder(
                                  initialRating: double.parse(hotel.starRate.toString()),
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: double.parse(hotel.starRate.toString()).toInt(),
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
                            ),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(hotel.fullAddress!,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                              ),
                            ),
                            Visibility(
                              visible: hotel.reviewPoint != (0.0),
                              child: Container(
                                padding: const EdgeInsets.only(top: 6),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(hotel.reviewPoint.toString(),
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.orange)),
                                    Text(getSubRatingString(hotel.reviewPoint!),
                                        style: const TextStyle(
                                            fontSize: 9, color: Colors.orange)),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible:
                              hotel.showPrices?.mobileRate?.theShow! ?? false,
                              child: Container(
                                padding: const EdgeInsets.only(top: 6, bottom: 5),
                                child: Row(
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
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Visibility(
                                visible: hotel.minPrice != hotel.netPrice,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      Currency.displayPriceFormat(hotel.minPrice!),
                                      style: const TextStyle(
                                          fontSize: 13,
                                          decoration: TextDecoration.lineThrough),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      padding:
                                      const EdgeInsets.only(top: 2, bottom: 2),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          color: Colors.orange),
                                      child: Text(
                                          Currency.getSalePercent(
                                              hotel.minPrice!, hotel.netPrice!),
                                          style: const TextStyle(
                                              fontSize: 13, color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                        Currency.displayPriceFormat(
                                            hotel.netPrice!),
                                        style: const TextStyle(
                                            fontSize: 17, color: Colors.orange)),
                                    Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      child: const Text('/đêm',
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget itemLoading(double width, double height) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 4,
          color: Colors.grey,
        ),
        SizedBox(
          height: height / 3.2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: SizedBox(
                  width: width / 4,
                  height: height / 3.2,
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.grey[300]!,
                      )),
                ),
              ),
              Container(
                width: 3 * width / 4,
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                            child: Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  color: Colors.grey[300]!,
                                  width: width / 2.3,
                                  height: 14,
                                ))),
                        Visibility(
                          visible: true,
                          child: Container(
                            padding: const EdgeInsets.only(top: 5),
                            child: Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  color: Colors.grey[300]!,
                                  width: 40,
                                  height: 10,
                                )),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.only(top: 6),
                            child: Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  color: Colors.grey[300]!,
                                  height: 10,
                                  width: width / 1.8,
                                )),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Visibility(
                            visible: true,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      color: Colors.grey[300]!,
                                      width: width / 4,
                                      height: 10,
                                    )),
                                Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  padding:
                                      const EdgeInsets.only(top: 2, bottom: 2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.grey[300]),
                                  child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        color: Colors.grey[300]!,
                                        height: 10,
                                        width: 10,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      color: Colors.grey[300]!,
                                      width: width / 3.5,
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget sortDialog(
      double height, BuildContext context, SearchedHotelProvider searchProv) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    if (searchProv.sortBy != 'low') {
                      searchProv.sortByPrice(sortBy: 'low');
                    } else {
                      searchProv.clearSortBy();
                    }
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Visibility(
                            visible: searchProv.sortBy == 'low',
                            child: const Icon(Icons.check, color: Colors.orange,)),
                        Text(
                          'Từ thấp tới cao',
                          style: TextStyle(fontSize: 14, color: searchProv.sortBy == 'low' ? Colors.orange : Colors.black),
                        )
                      ],
                    ),
                  ), // Từ cao tới thấp, theo điểm đánh giá
                )),
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    if (searchProv.sortBy != 'high') {
                      searchProv.sortByPrice(sortBy: 'high');
                    } else {
                      searchProv.clearSortBy();
                    }
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Visibility(
                            visible: searchProv.sortBy == 'high',
                            child: const Icon(Icons.check, color: Colors.orange,)),
                        Text(
                          'Từ cao tới thấp',
                          style: TextStyle(fontSize: 14, color: searchProv.sortBy == 'high' ? Colors.orange : Colors.black),
                        )
                      ],
                    ),
                  ), // Từ cao tới thấp, theo điểm đánh giá
                )),
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    if (searchProv.sortBy != 'rankPoint') {
                      searchProv.sortByPrice(sortBy: 'rankPoint');
                    } else {
                      searchProv.clearSortBy();
                    }
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Visibility(
                            visible: searchProv.sortBy == 'rankPoint',
                            child: const Icon(Icons.check, color: Colors.orange,)),
                        Text(
                          'Theo điểm đánh giá',
                          style: TextStyle(fontSize: 14, color: searchProv.sortBy == 'rankPoint' ? Colors.orange : Colors.black),
                        )
                      ],
                    ),
                  ), // Từ cao tới thấp, theo điểm đánh giá
                )),
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
}
