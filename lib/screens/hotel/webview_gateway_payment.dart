import 'package:clone_vntrip/providers/hotel_providers/detail_hotel_providers.dart';
import 'package:clone_vntrip/providers/hotel_providers/hotel_booking_provider.dart';
import 'package:clone_vntrip/providers/hotel_providers/payment_provider.dart';
import 'package:clone_vntrip/providers/hotel_providers/searcherHotelProvider.dart';
import 'package:clone_vntrip/providers/ticket_providers/payment_booking_ticket.dart';
import 'package:clone_vntrip/providers/ticket_providers/ticket_booking_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPayment extends StatelessWidget {
  static const routeName = '/webview-payment';
  int ticketOrHotel = 0;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments ;

    var provider;
    provider = Provider.of<PaymentProvider>(context);

    void clickCancel() {
      Provider.of<TicketBookingProvider>(context, listen: false).resetData();
      Provider.of<PaymentBookingTicket>(context, listen: false).clearData();
      Provider.of<DetailHotelProviders>(context, listen: false).clearData();
      Provider.of<PaymentProvider>(context, listen: false).clearData();
      Provider.of<SearchedHotelProvider>(context, listen: false).resetData();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    }

    if (args == 0){
      if (provider.responseOrderHotel == null) {
        provider.orderHotel();
      }
    } else {
      provider = Provider.of<PaymentBookingTicket>(context);
      if (provider.responseOrderHotel == null) {
        provider.orderFlightTicket();
      }
    }

    late WebViewController webController;

    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      // if (await webController.canGoBack()) {
                      //   webController.goBack();
                      // } else {
                      //   clickCancel();
                      // }
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    '',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      clickCancel();
                    },
                    child: const Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: provider.responseOrderHotel == null
                    ? const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : provider
                    .responseOrderHotel!.data != null
                      ? WebView(
                        javascriptMode: JavascriptMode.unrestricted,
                        initialUrl: provider
                            .responseOrderHotel!.data!.redirectUrlMobile!,
                        onWebViewCreated: (controller) {
                          webController = controller;
                        },
                      )
                      : const Center(child: Text('Something wrong!'),)
            ),
          ],
        ),
      ),
    );
  }
}
