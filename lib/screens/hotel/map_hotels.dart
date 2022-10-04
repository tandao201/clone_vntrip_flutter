import 'dart:async';
import 'package:clone_vntrip/models/hotel/requests/request_search_room.dart';
import 'package:clone_vntrip/providers/hotel_providers/searcherHotelProvider.dart';
import 'package:clone_vntrip/providers/hotel_providers/suggest_place_provider.dart';
import 'package:clone_vntrip/screens/hotel/filter_hotels_searched.dart';
import 'package:clone_vntrip/screens/hotel/searched_rooms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../components/currency.dart';
import '../../components/time.dart';
import '../../components/colors.dart';
import '../../models/hotel/responses/response_searched_hotel.dart';
import '../../providers/hotel_providers/detail_hotel_providers.dart';
import 'detail_hotel.dart';

class MapHotels extends StatelessWidget {
  static const routeName = 'map-hotels';

  LatLng showLocation = const LatLng(27.7089427, 85.3086209);
  GoogleMapController? ggMapCtl;

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

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    double physicsWidth = widthScreen * MediaQuery.of (context) .devicePixelRatio;
    double physicsHeight = heightScreen * MediaQuery.of (context) .devicePixelRatio;
    final detailProvMain = Provider.of<DetailHotelProviders>(context);
    RequestSearchRoom request =
    Provider.of<SuggestPlaceProvider>(context, listen: false)
        .requestSearchRoom!;
    final searchProvi = Provider.of<SearchedHotelProvider>(context);
    final locationProv = Provider.of<SuggestPlaceProvider>(context, listen: false);
    LatLng? upRightCorner;
    LatLng? downLeftCorner;
    LatLng? center;

    // locationProv.reloadCurrentLocation();
    Position? currentPos = locationProv.currentPos;

    Future<void> get2CornerLatLng() async {
      ScreenCoordinate screenCoordinate = ScreenCoordinate(x: physicsWidth.round(), y: 0);
      upRightCorner = await ggMapCtl!.getLatLng(screenCoordinate);
      screenCoordinate = ScreenCoordinate(x: 0, y: physicsHeight.round());
      downLeftCorner = await ggMapCtl!.getLatLng(screenCoordinate);
      screenCoordinate = ScreenCoordinate(x: (physicsWidth/2).round(), y: (physicsHeight/2).round());
      center = await ggMapCtl!.getLatLng(screenCoordinate);
      print('Width: $widthScreen, height: $heightScreen');
      print('UpRightCorner: ${upRightCorner!.toString()} - downLeftCorner: ${downLeftCorner!.toString()}' );
      print('Center: ${center!.toString()}' );

      request.location = '${center!.latitude}%2C${center!.longitude}';
      request.filterByScreen = '${upRightCorner!.latitude}%2C${upRightCorner!.longitude}%2C${downLeftCorner!.latitude}%2C${downLeftCorner!.longitude}';
      await searchProvi.searchHotelByScreen(request);
      if (currentPos == null) {
        locationProv.reloadCurrentLocation();
      } else {
        searchProvi.addMarker(
            Marker(
              markerId: const MarkerId("Current position"),
              position: LatLng(currentPos.latitude, currentPos.longitude),
              icon: BitmapDescriptor.defaultMarker,

            )
        );
        // searchProvi.getPolylinesForMap(currentPos);
      }
      // searchProvi.addMarker(
      //     Marker(
      //       markerId: const MarkerId("Current position1"),
      //       position: LatLng(upRightCorner!.latitude, upRightCorner!.longitude),
      //       icon: BitmapDescriptor.defaultMarker,
      //
      //     )
      // );
      // searchProvi.addMarker(
      //     Marker(
      //       markerId: const MarkerId("Current position2"),
      //       position: LatLng(downLeftCorner!.latitude, downLeftCorner!.longitude),
      //       icon: BitmapDescriptor.defaultMarker,
      //
      //     )
      // );
      // searchProvi.addMarker(
      //     Marker(
      //       markerId: const MarkerId("Current position3"),
      //       position: LatLng(center!.latitude, center!.longitude),
      //       icon: BitmapDescriptor.defaultMarker,
      //
      //     )
      // );

    }

    clickHotelItem(BuildContext context ,int? hotelId) {
      print('click detail: $hotelId');
      Provider.of<DetailHotelProviders>(context, listen: false).setRequest(hotelId!);
      Provider.of<DetailHotelProviders>(context, listen: false).clearData();
      Navigator.pushNamed(context, DetailHotel.routeName, arguments: hotelId);
    }



    void clickSortBtn() {
      Navigator.pushNamed(context, FilterSearchedHotel.routeName);
    }

    void clickCancel() {
      // Navigator.pushNamed(context, HotelBooking.routeName);
      Provider.of<SearchedHotelProvider>(context, listen: false).hotelsByScreenApi = null;
      Provider.of<SearchedHotelProvider>(context, listen: false).mapSelected = null;
      print('Cancel...');
      Navigator.pop(context);
    }

    bool fits(LatLngBounds fitBounds, LatLngBounds screenBounds) {
      final bool northEastLatitudeCheck = screenBounds.northeast.latitude >= fitBounds.northeast.latitude;
      final bool northEastLongitudeCheck = screenBounds.northeast.longitude >= fitBounds.northeast.longitude;
      final bool southWestLatitudeCheck = screenBounds.southwest.latitude <= fitBounds.southwest.latitude;
      final bool southWestLongitudeCheck = screenBounds.southwest.longitude <= fitBounds.southwest.longitude;
      return northEastLatitudeCheck && northEastLongitudeCheck && southWestLatitudeCheck && southWestLongitudeCheck;
    }

    Future<void> zoomToFit(GoogleMapController controller, LatLngBounds bounds, LatLng centerBounds) async {
      bool keepZoomingOut = true;
      while(keepZoomingOut) {
        final LatLngBounds screenBounds = await controller.getVisibleRegion();
        if(fits(bounds, screenBounds)){
          keepZoomingOut = false;
          final double zoomLevel = await controller.getZoomLevel() - 0.5;
          controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: centerBounds,
            zoom: zoomLevel,
          )));
          break;
        }
        else {
          // Zooming out by 0.1 zoom level per iteration
          final double zoomLevel = await controller.getZoomLevel() - 0.1;
          controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: centerBounds,
            zoom: zoomLevel,
          )));
        }
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Consumer<SearchedHotelProvider>(
          builder: (context, searchProv, child) {

            if (searchProv.markers.isEmpty) {
              searchProv.getMarkerForMap();
            }

            return Column(
              children: [
                Flexible(
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Listener(
                        behavior: HitTestBehavior.translucent,
                          onPointerUp: (e) {
                            Timer(const Duration(milliseconds: 300), () {
                              print('Moving...');
                              get2CornerLatLng();
                              print(e);
                            });
                          },

                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: searchProvi.mapSelected == null
                                ? LatLng(searchProv.hotels[0].location!.lat!,
                                  searchProv.hotels[0].location!.lon!)
                                : LatLng(searchProv.mapSelected!.location!.lat!,
                                  searchProv.mapSelected!.location!.lon!),
                              zoom: 14,
                            ),
                            mapType: MapType.normal,
                            markers: searchProv.markers,
                            polylines: searchProv.polylines,
                            zoomGesturesEnabled: true,
                            zoomControlsEnabled: false,
                            compassEnabled: false,
                            onMapCreated: (mapController) async {
                              ggMapCtl = mapController;
                              await get2CornerLatLng();
                              LatLngBounds bounds = LatLngBounds(
                                  southwest: LatLng(searchProv.hotels[0].location!.lat!,searchProv.hotels[0].location!.lon!),
                                  northeast: LatLng(currentPos!.latitude, currentPos.longitude)
                              );
                              LatLng centerBounds = LatLng(
                                  (bounds.northeast.latitude + bounds.southwest.latitude)/2,
                                  (bounds.northeast.longitude + bounds.southwest.longitude)/2
                              );

                              ggMapCtl?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                                target: centerBounds,
                                zoom: 19,
                              )));
                              zoomToFit(ggMapCtl!, bounds, centerBounds);
                            },
                          ),
                        ),
                        IgnorePointer(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 8,
                            color: Colors.transparent,
                            padding: const EdgeInsets.fromLTRB(15, 25, 15, 8),
                            child: GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(
                                    request.name,
                                    style: const TextStyle(fontSize: 17),
                                  ),
                                  Text(
                                    '${request.nights} đêm (${Time.getDayAndMonth(request.checkInDate)} - ${Time.getDayAndMonth(request.checkOutDate)})',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.blue),
                                  ),
                                ],
                              ),
                            ), //appBar
                          ),
                        ),
                        Positioned(
                          bottom: 4,
                          left: 4,
                          right: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  ggMapCtl!.animateCamera(CameraUpdate.newLatLng(LatLng(currentPos!.latitude, currentPos.longitude)));

                                  // ggMapCtl?.getVisibleRegion();
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.location_searching, color: Colors.red,),
                                  ),
                                ),
                              ),
                              Container(
                                height: heightScreen / 3.5,
                                width: widthScreen,
                                child: searchProvi.hotelsByScreenApi == null
                                    ? Container()
                                    : PageView.builder(
                                    onPageChanged: (index) {
                                      ResponseSearchedRoomData hotel = searchProvi.hotelsByScreenApi![index];
                                      print('Page hotel change: $index');
                                      searchProvi.changeMapSelected(hotel);
                                      ggMapCtl?.animateCamera(CameraUpdate.newLatLng(LatLng(hotel.location!.lat!, hotel.location!.lon!))
                                      );
                                    },
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: searchProvi.hotelsByScreenApi!.length,
                                    pageSnapping: true,
                                    itemBuilder: (context, pagePosition) {
                                      return GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onTap: () {
                                          print('Tap to hotel r');
                                          clickHotelItem(context, searchProvi.hotelsByScreenApi![pagePosition].id);
                                        },
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: heightScreen / 4.5,
                                            child: searchProv.mapSelected == null
                                                ? Container()
                                                : itemRoomSearched(widthScreen, heightScreen,
                                                searchProvi.hotelsByScreenApi![pagePosition]),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                            top: 25,
                            left: 10,
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                clickCancel();
                                print('Tap cancel');
                              },
                              child: const IgnorePointer(
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                            )),
                      ],
                    )),
                Container(
                  width: widthScreen,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.grayLight, width: 1)),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              clickSortBtn();
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
                                    'Lọc',
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
                              Navigator.pushReplacementNamed(
                                  context, SearchedRoom.routeName);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          color: AppColor.grayLight, width: 1))),
                              padding: const EdgeInsets.all(12),
                              child: const Center(
                                child: Text('Danh sách'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget itemRoomSearched(
      double width, double height, ResponseSearchedRoomData hotel) {
    String urlImg = 'assets/images/not_load_img.jpg';
    if (hotel.thumbImage != null) {
      urlImg =
          'https://i.vntrip.vn/200x400/smart/https://statics.vntrip.vn/data-v2/hotels/${hotel.id}/img_max/${hotel.thumbImage}';
    }
    return Container(
      color: Colors.white,
      height: height / 4.5,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: width * 0.25,
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
          Container(
            width:  width * 0.70 ,
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
                            maxLines: 1,
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
                            CircleAvatar(
                              backgroundColor: hotel.reviewPoint! >= 9
                                  ? Colors.orange
                                  : Colors.blue,
                              child: Text(hotel.reviewPoint.toString(),
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.white)),
                            ),
                            Text(getSubRatingString(hotel.reviewPoint!),
                                style: const TextStyle(
                                    fontSize: 9, color: Colors.black)),
                          ],
                        ),
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
                      Container(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(Currency.displayPriceFormat(hotel.netPrice!),
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
    );
  }
}
