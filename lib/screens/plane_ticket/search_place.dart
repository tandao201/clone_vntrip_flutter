import 'package:clone_vntrip/models/ticket/responses/response_place_flight.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/colors.dart';
import '../../providers/ticket_providers/ticket_booking_provider.dart';

class SearchPlace extends StatelessWidget {
  static const routeName = '/search-place-flights';

  TextEditingController searchController = TextEditingController();

  SearchPlace({Key? key}) : super(key: key);

  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {

    void clickCancel() {
      // Navigator.pushNamed(context, HotelBooking.routeName);
      Navigator.pop(context);
    }

    void clickPlaceItem(ResponsePlaceFlightDataDomesticRegionData itemData, int where) {
      if (itemData.isSelect == false) {
        Provider.of<TicketBookingProvider>(context, listen: false).clickPlaceItem(itemData, where);
        clickCancel();
      }
    }

    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Consumer<TicketBookingProvider>(
          builder: (context, placeProvi, child) {
            String hintText = (placeProvi.selectGoOrTo == 1)? 'Nhập điểm đi' : 'Nhập điểm đến';
            if (placeProvi.placesFlight.isEmpty) {
              placeProvi.getPlacesFlight();
            }
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 5),
                  child: Row(
                    children: [
                      Container(
                        child: GestureDetector(
                          onTap: () => clickCancel(),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: TextFormField(
                        textInputAction: TextInputAction.search,
                        onFieldSubmitted: (term) {
                          hideKeyboard();
                        },
                        onChanged: (_) {
                          placeProvi.searchByKeyword(searchController.text);
                          print(searchController.text);
                        },
                        controller: searchController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          hintText: hintText,
                          contentPadding:
                              const EdgeInsets.all(10),
                          isDense: true,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey,
                  height: 1,
                  width: double.infinity,
                ), // header
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.orange, width: 2))),
                  child: const Center(
                    child: Text(
                      'Nội địa',
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Flexible(child: Container(
                  margin: const EdgeInsets.only(bottom: 7),
                  child: ListView.builder(
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: placeProvi.placesFlight.length,
                      itemBuilder: (context, index) {
                        var itemData = placeProvi.placesFlight[index];
                        return itemData is String
                            ? itemTitle(itemData)
                            : GestureDetector(
                          onTap: () {
                            clickPlaceItem(itemData as ResponsePlaceFlightDataDomesticRegionData, placeProvi.selectGoOrTo);
                          },
                          child: itemPlace(itemData
                          as ResponsePlaceFlightDataDomesticRegionData),
                        );
                      }),
                )),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget itemPlace(ResponsePlaceFlightDataDomesticRegionData itemData) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 7),
      child: Container(
        padding: const EdgeInsets.only(top: 7, bottom: 7),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: AppColor.grayLight,
        ))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.place_outlined,
              size: 13,
              color: Colors.black,
            ),
            Container(
              padding: const EdgeInsets.only(left: 8),
              child: Text('${itemData.code} - ${itemData.provinceName}', style: TextStyle(color: itemData.isSelect == false ? Colors.black : Colors.grey),),
            )
          ],
        ),
      ),
    );
  }

  Widget itemTitle(String title) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 30, 0, 10),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
