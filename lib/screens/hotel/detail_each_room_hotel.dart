import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../../components/currency.dart';
import '../../models/hotel/responses/response_detail_each_room.dart';
import '../../providers/hotel_providers/detail_hotel_providers.dart';

class DetailEachRoomHotel extends StatelessWidget {
  static const routeName = '/detail-each-room-hotel';

  @override
  Widget build(BuildContext context) {
    int? hotelId =
        Provider.of<DetailHotelProviders>(context, listen: false).hotelId;
    final detailProvMain = Provider.of<DetailHotelProviders>(context);
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    List<ResponseDetailEachRoomDataRoomDataPhotos?>? images = [];

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
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      color: Colors.green,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.all(3),
                        child: const Icon(
                          Icons.phone,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ), //appBar
          ),
          Expanded(
              child: SingleChildScrollView(
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
                            padding: const EdgeInsets.only(left: 10,bottom: 8),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  detailProvMain.recentlyRoom!.name!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10,bottom: 8),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.free_cancellation,
                                  size: 16,
                                ),
                                RichText(
                                  text: TextSpan(
                                      children: <TextSpan>[
                                        const TextSpan(
                                            text: 'Hủy phòng: ',
                                            style: TextStyle(color: Colors.grey)
                                        ), TextSpan(
                                            text: detailProvMain.recentlyRoom!.rates![0]!.refundable! ? 'Có hoàn hủy' : 'Không hoàn hủy',
                                            style: const TextStyle(color: Colors.green)
                                        )
                                      ]
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10,bottom: 8),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.set_meal_outlined,
                                  size: 16,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      const TextSpan(
                                        text: 'Bữa ăn: ',
                                        style: TextStyle(color: Colors.grey)
                                      ), TextSpan(
                                        text: detailProvMain.recentlyRoom!.rates![0]!.mealPlan == 'breakfast' ? 'Bao gồm ăn sáng' : 'Không bao gồm',
                                        style: const TextStyle(color: Colors.green)
                                      )
                                    ]
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 5),
                            height: heightScreen / 3,
                            width: widthScreen,
                            child: detailProvMain.recentlyRoom!.photos!.isEmpty ? Image.asset('assets/images/not_load_img.jpg', fit: BoxFit.fill,) : PageView.builder(
                                itemCount: detailProvMain.recentlyRoom!.photos!.length,
                                pageSnapping: true,
                                itemBuilder: (context, pagePosition) {
                                  images = detailProvMain.recentlyRoom!.photos;
                                  return Container(
                                      child: Image.network(
                                        images![pagePosition]!.roomImage!,
                                        fit: BoxFit.fill,
                                      ));
                                }),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                      children: <TextSpan>[
                                        const TextSpan(
                                            text: 'Giường: ',
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
                                        ),
                                        TextSpan(
                                            text: '${detailProvMain.recentlyRoom!.reformatBedTypes![0]!.bedData![0]!.count!} ${detailProvMain.recentlyRoom!.reformatBedTypes![0]!.bedData![0]!.type!}',
                                            style: const TextStyle(color: Colors.black)
                                        )
                                      ]
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                      children: <TextSpan>[
                                        const TextSpan(
                                            text: 'Diện tích phòng: ',
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
                                        ),
                                        TextSpan(
                                            text: detailProvMain.recentlyRoom!.roomArea.toString(),
                                            style: const TextStyle(color: Colors.black)
                                        )
                                      ]
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                      children: <TextSpan>[
                                        const TextSpan(
                                            text: 'Thiết bị trong phòng: ',
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
                                        ),
                                        TextSpan(
                                            text: detailProvMain.recentlyRoom!.facilities,
                                            style: const TextStyle(color: Colors.black)
                                        )
                                      ]
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Chính sách phòng: ', style: TextStyle(fontWeight: FontWeight.bold),),
                                RichText(
                                  text: TextSpan(
                                      children: <TextSpan>[
                                        const TextSpan(
                                            text: 'Hủy phòng: ',
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
                                        ),
                                        TextSpan(
                                            text: detailProvMain.recentlyRoom!.rates![0]!.cancelPolicies,
                                            style: const TextStyle(color: Colors.black)
                                        )
                                      ]
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                      children: <TextSpan>[
                                        const TextSpan(
                                            text: 'Bữa ăn: ',
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
                                        ),
                                        TextSpan(
                                            text: detailProvMain.recentlyRoom!.rates![0]!.mealPlan == 'breakfast' ? 'Bao gồm ăn sáng' : 'Không bao gồm',
                                            style: const TextStyle(color: Colors.black)
                                        )
                                      ]
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey[300]!,
                            height: 1,
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 15, 10, 7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Yêu cầu giường'),
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue, width: 1),
                                    borderRadius: BorderRadius.circular(3)
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.check_circle, size: 13, color: Colors.blue,),
                                      Container(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text('${detailProvMain.recentlyRoom!.reformatBedTypes![0]!.bedData![0]!.count!} giường'),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey[300]!,
                            height: 1,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: Currency.displayPriceFormat(detailProvMain.recentlyRoom!.minPrice!),
                                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)
                                            ),
                                            const TextSpan(
                                                text: ' / đêm',
                                                style: TextStyle(color: Colors.grey, fontSize: 8)
                                            )
                                          ]
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: const Text('Đã bao gồm thuế VAT và phí dịch vụ', style: TextStyle(color: Colors.grey, fontSize: 8),),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Tối đa'),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3, horizontal: 6),
                                          decoration: BoxDecoration(
                                            color: Colors.black54,
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            detailProvMain.recentlyRoom!.maxAdult.toString(),
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.person_outline,
                                          size: 20,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print('Booking...');
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 13),
                                    child: const Text('Đặt phòng', style: TextStyle(fontSize: 13, color: Colors.white),),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey[300]!,
                            height: 1,
                          ),
                        ],
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
              )
          )
        ],
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
}