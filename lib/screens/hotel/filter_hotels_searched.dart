import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/colors.dart';
import '../../providers/hotel_providers/searcherHotelProvider.dart';

class FilterSearchedHotel extends StatelessWidget {
  static const routeName = '/filter-searched-hotel';

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    final searchProv = Provider.of<SearchedHotelProvider>(context);

    void clickCancel() {
      // Navigator.pushNamed(context, HotelBooking.routeName);
      Navigator.pop(context);
    }

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

    void clickItemSort(List<dynamic> data,dynamic content, int field) {

      if (content == '...') {
        print('show more');
        searchProv.clickShowmore(field);
      } else if (content == '^') {
        searchProv.clickShowless(field);
        print('show less');
      } else if (searchProv.selectSortBy.contains(content)) {
        searchProv.deleteFromSortByList(content);
        print('delete field');
      } else {
        searchProv.addToSortByList(content);
        print('add field');
      }
      print('Click click ${content.toString()} and field: $field');
    }

    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColor.grayLight,
                border: Border(
                    bottom: BorderSide(
                  width: 1,
                  color: AppColor.grayLight,
                ))),
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 15),
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
                const Text(
                  'Lọc',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                Container(),
              ],
            ), //appBar
          ),
          Expanded(child: Consumer<SearchedHotelProvider>(
            builder: (context, searchedProv, child) {
              if (searchedProv.dataRegion == null || searchedProv.dataRegion!.isEmpty) {
                searchedProv.getDataFieldSort();
              }
              return Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: heightScreen/14),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                            width: double.infinity,
                            color: AppColor.grayHintText,
                            child: Text(
                              'Lọc:',
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 15),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 13, 10, 10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey[400]!,
                                      width: 1,
                                    ))),
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Mức giá',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18)),
                                      Text(
                                        searchedProv.getPriceRangeString(),
                                        style: const TextStyle(
                                            fontSize: 16, color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ),
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackHeight: 5.0,
                                    valueIndicatorColor: Colors.green,
                                    minThumbSeparation: 4,
                                    thumbColor: Colors.white,
                                    thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 12.0),
                                    inactiveTrackColor: Colors.grey,
                                    activeTrackColor: Colors.green,
                                  ),
                                  child: RangeSlider(
                                    min: 1,
                                    max: 10,
                                    values: searchedProv.rangeValues,
                                    onChanged: (RangeValues value) {
                                      searchedProv.changeRangeValue(
                                          rangeValues: value);
                                    },
                                    // divisions: 10,
                                  ),
                                )
                              ],
                            ),
                          ),
                          itemFilter(
                              'Xếp hạng khách sạn',
                              Row(
                                children: [
                                  itemBox(
                                      itemStar(1, searchedProv), searchedProv, 1,clickItemSort, 0),
                                  itemBox(
                                      itemStar(2, searchedProv), searchedProv, 2,clickItemSort, 0),
                                  itemBox(
                                      itemStar(3, searchedProv), searchedProv, 3,clickItemSort, 0),
                                  itemBox(
                                      itemStar(4, searchedProv), searchedProv, 4,clickItemSort, 0),
                                  itemBox(
                                      itemStar(5, searchedProv), searchedProv, 5,clickItemSort, 0),
                                ],
                              )),
                          itemFilter(
                              'Chỉ có tại VNTRIP', itemFilterWrap(searchedProv,['Cam kết rẻ nhất'],clickItemSort, 1)),
                          itemFilter('Quận Huyện', itemFilterWrap(searchedProv,searchedProv.dataProvince!,clickItemSort, 2)),
                          itemFilter('Khu vực', itemFilterWrap(searchedProv,searchedProv.dataRegion!,clickItemSort, 3)),
                          searchedProv.extData?.countByType != null ? itemFilter('Loại chỗ ở', itemFilterWrap(searchedProv,searchedProv.getListTypeString(searchedProv.extData?.countByType,4),clickItemSort, 4)) : Container(),
                          itemFilter('Dịch vụ', itemFilterWrap(searchedProv,searchedProv.dataService!,clickItemSort, 5)),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Visibility(
                        visible: searchedProv.selectSortBy.isNotEmpty,
                        child:
                        sortDialog(heightScreen, context, searchedProv)),
                  ),
                ],
              );
            },
          )),
        ],
      ),
    );
  }

  Widget itemFilter(String title, Widget content) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.grey[400]!,
        width: 1,
      ))),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
          ),
          content,
        ],
      ),
    );
  }

  Widget itemBox(
      Widget widgetInside, SearchedHotelProvider searchProv, dynamic content, Function fun, int field) {
    return Container(
      padding: const EdgeInsets.only(right: 8, bottom: 8),
      child: GestureDetector(
        onTap: () {
          dynamic data;
          switch (field) {
            case 2:
              data = searchProv.extData?.countByCities!;
              break;
            case 3:
              data = searchProv.extData?.countByArea!;
              break;
            case 4:
              data = searchProv.extData?.countByType!;
              break;
            case 5:
              data = searchProv.extData?.countByFacilities!;
              break;
          }
          fun(data,content, field);
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              color: searchProv.selectSortBy.contains(content)
                  ? Colors.green
                  : Colors.white),
          padding: const EdgeInsets.all(10),
          child: widgetInside,
        ),
      ),
    );
  }

  Widget itemStar(int number, SearchedHotelProvider searchedProv) {
    return Row(
      children: [
        Text(
          number.toString(),
          style: TextStyle(
              color: searchedProv.selectSortBy.contains(number)
                  ? Colors.white
                  : Colors.orange),
        ),
        Icon(
          Icons.star,
          color: searchedProv.selectSortBy.contains(number)
              ? Colors.white
              : Colors.orange,
          size: 14,
        )
      ],
    );
  }

  Widget itemFilterWrap(SearchedHotelProvider searchedProv, List<String> content, Function fun, int field) {
    return Wrap(
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: content
          .map((item) => itemBox(
              Text(
                item,
                style: TextStyle(
                    color: searchedProv.selectSortBy.contains(item)
                        ? Colors.white
                        : Colors.black),
              ),
              searchedProv,
              item, fun, field))
          .toList(),
    );
  }

  Widget sortDialog(
      double height, BuildContext context, SearchedHotelProvider searchProv) {
    return Container(
      height: height / 12,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: GestureDetector(
                onTap: () {
                  searchProv.clickSortByField();
                  Navigator.pop(context);
                },
                child: Container(
                  color: Colors.orange,
                  margin: const EdgeInsets.only(right: 20),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: const Center(
                    child: Text(
                      'Lọc',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )),
          Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  searchProv.clearSelectField();
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1)),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: const Center(
                    child: Text(
                      'Xóa',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}
