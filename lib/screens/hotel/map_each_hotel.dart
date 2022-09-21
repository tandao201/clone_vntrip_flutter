import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/hotel_providers/detail_hotel_providers.dart';

class MapEachHotel extends StatelessWidget {
  static const routeName = 'map-each-hotel';

  @override
  Widget build(BuildContext context) {
    final detailProvMain = Provider.of<DetailHotelProviders>(context);

    void _launchURL(String url) async {
      await launchUrl(Uri.parse(url));
    }

    void clickCancel() {
      Navigator.pop(context);
    }
    // TODO: implement build
    return Scaffold(
      body: Column(
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
                Flexible(child: Container(padding: EdgeInsets.only(left: 5),
                  child: Text(
                    detailProvMain.results!.nameVi!,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17), overflow: TextOverflow.ellipsis,
                  ),
                )),
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
          ),
          Expanded(child: GoogleMap(
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            compassEnabled: false,
            initialCameraPosition: CameraPosition(
              target: LatLng(detailProvMain.results!.latitude!,
                  detailProvMain.results!.longitude!),
              zoom: 14,
            ),
            mapType: MapType.normal,
            markers: detailProvMain.markers,
            onMapCreated: (mapController) {

            },
          )),
        ],
      ),
    );
  }
}