import 'package:clone_vntrip/components/colors.dart';
import 'package:clone_vntrip/models/hotel/location.dart';
import 'package:clone_vntrip/models/hotel/responses/response_suggest.dart';
import 'package:clone_vntrip/providers/hotel_providers/recent_place_pick_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/hotel_providers/suggest_place_provider.dart';

class SuggestPlace extends StatelessWidget {
  static const routeName = '/suggest-place';

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    TextEditingController searchController = TextEditingController();

    void hideKeyboard() {
      FocusManager.instance.primaryFocus?.unfocus();
    }

    void clickCancel() {
      // Navigator.pushNamed(context, HotelBooking.routeName);
      Navigator.pop(context);
    }

    void clickItemMenu(LocationApp location, ResponseSuggestDataRegions region) {
      if (region.regionnameVi != null) {
        Provider.of<SuggestPlaceProvider>(context, listen: false).setRecentlyReion(region);
      }
      print('Click ${location.name}');
      Provider.of<SuggestPlaceProvider>(context, listen: false).pickPlace(location);
      Provider.of<SuggestPlaceProvider>(context, listen: false).initShowSuggest();
      Provider.of<RecentPlacePickProv>(context, listen: false).addToRecent(location);
      clickCancel();
    }

    void clickRecentPlace() {
      Provider.of<SuggestPlaceProvider>(context, listen: false).reloadCurrentLocation();
      clickCancel();
    }

    var listApp = [
      LocationApp(name: 'Hà nội', regionId: 66),
      LocationApp(name: 'Hà nội', regionId: 66),
      LocationApp(name: 'Hà nội', regionId: 66),
      LocationApp(name: 'Hà nội', regionId: 66),
      LocationApp(name: 'Hà nội', regionId: 66),
    ];


    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Consumer<SuggestPlaceProvider>(
          builder: (context, suggestProvi, child) {
            return ListView(
              scrollDirection: Axis.vertical,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                            textInputAction: TextInputAction.search,
                            onFieldSubmitted: (term) {
                              hideKeyboard();
                              suggestProvi.getSuggestPlace(term);
                              suggestProvi.showSuggest(term);
                            },
                            onChanged: (_) {
                              suggestProvi.getSuggestPlace(searchController.text);
                              suggestProvi.showSuggest(searchController.text);
                              print(searchController.text);
                            },
                            controller: searchController,
                            cursorColor: Colors.black,
                            decoration:  InputDecoration(
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 20,
                              ),
                              filled: true,
                              fillColor: Colors.grey[200]!,
                              contentPadding:
                              const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () => clickCancel(),
                          child: const Text(
                            'Hủy',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ), // header
                Visibility(
                  visible: !suggestProvi.isShowSuggestSearch,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          clickRecentPlace();
                        },
                        child: itemLocation(
                            'Tìm quanh vị trí hiện tại', Icons.location_searching,
                            widthScreen),
                      ),
                      Container(
                        width: double.infinity,
                        color: AppColor.grayLight,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Container(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Text('Tìm kiếm gần đây', style: TextStyle(
                                color: AppColor.grayText),),
                          ),
                        ),
                      ),
                      Consumer<RecentPlacePickProv>(
                          builder: (context, recentPlaceProv, child) {
                            recentPlaceProv.getRecent();
                            var locations = recentPlaceProv.locations;
                            return ListView.separated(
                                separatorBuilder: (_, __) => Container(),
                                shrinkWrap: true,
                                itemCount: locations.length,
                                itemBuilder: (context, index) {
                                  var itemData = locations[index];
                                  return GestureDetector(
                                    onTap: () => clickItemMenu(itemData, ResponseSuggestDataRegions()),
                                    child: itemLocation(
                                        itemData.name!, Icons.location_on_outlined,
                                        widthScreen),
                                  );
                                });
                          }
                      ),
                      Container(
                        width: double.infinity,
                        color: AppColor.grayLight,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Container(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Text('Địa điểm nổi bật', style: TextStyle(
                                color: AppColor.grayText),),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            clickItemMenu(
                                LocationApp(name: 'Hà Nội', regionId: 66), ResponseSuggestDataRegions()),
                        child: itemLocation(
                            'Hà Nội', Icons.location_on_outlined, widthScreen),
                      ),
                      GestureDetector(
                        onTap: () =>
                            clickItemMenu(
                                LocationApp(name: 'TP Hồ Chí Minh', regionId: 67), ResponseSuggestDataRegions()),
                        child: itemLocation(
                            'TP Hồ Chí Minh', Icons.location_on_outlined,
                            widthScreen),
                      ),
                      GestureDetector(
                        onTap: () =>
                            clickItemMenu(
                                LocationApp(name: 'Đà Nẵng', regionId: 68), ResponseSuggestDataRegions()),
                        child: itemLocation(
                            'Đà Nẵng', Icons.location_on_outlined, widthScreen),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: suggestProvi.isShowSuggestSearch,
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    height: heightScreen/1.2,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: suggestProvi.dataSuggest.length,
                      itemBuilder: (context, index) {
                        var dataItem = suggestProvi.dataSuggest[index];
                        return dataItem is ResponseSuggestDataRegions
                            ? GestureDetector(
                                onTap: () {
                                  clickItemMenu(LocationApp(name: dataItem.regionnameVi, regionId: int.parse(dataItem.regionid! )), dataItem);
                                },
                                child: itemLocation(dataItem.regionnameVi!, Icons.location_on_outlined , widthScreen),
                              )
                            : itemHotel((dataItem as ResponseSuggestDataHotels).nameVi!, (dataItem).address!, widthScreen);
                      }
                  ),),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget itemLocation(String content, IconData icon, double width) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      size: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(content, style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w400),),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 7),
                  width: width/1.2,
                  color: AppColor.grayText,
                  height: 1,
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 20,)
        ],
      ),
    );
  }

  Widget itemHotel(String content, String address, double width) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_city_outlined,
                      size: 20,
                    ),
                    Container(
                      width: width / 1.3,
                      height: 40,
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(content, style: const TextStyle(fontSize: 15,
                              fontWeight: FontWeight.w400),),
                          Expanded(child: Container(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(address,
                              style: const TextStyle(fontSize: 10,
                                  color: Colors.grey,
                                  overflow: TextOverflow.ellipsis),),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  width: width/1.3,
                  color: AppColor.grayText,
                  height: 1,
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 20,)
        ],
      ),
    );
  }
}
