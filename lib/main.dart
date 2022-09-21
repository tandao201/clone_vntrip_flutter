import 'package:clone_vntrip/providers/home_provider.dart';
import 'package:clone_vntrip/providers/hotel_providers/date_pick_provider.dart';
import 'package:clone_vntrip/providers/hotel_providers/detail_hotel_providers.dart';
import 'package:clone_vntrip/providers/hotel_providers/hotel_booking_provider.dart';
import 'package:clone_vntrip/providers/hotel_providers/payment_provider.dart';
import 'package:clone_vntrip/providers/hotel_providers/recent_place_pick_provider.dart';
import 'package:clone_vntrip/providers/hotel_providers/searcherHotelProvider.dart';
import 'package:clone_vntrip/providers/hotel_providers/suggest_place_provider.dart';
import 'package:clone_vntrip/providers/login_providers.dart';
import 'package:clone_vntrip/providers/ticket_providers/payment_booking_ticket.dart';
import 'package:clone_vntrip/providers/ticket_providers/ticket_booking_provider.dart';
import 'package:clone_vntrip/providers/validation_provider.dart';
import 'package:clone_vntrip/screens/splash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'components/colors.dart';
import 'config/router.dart';

void main() {
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  GlobalKey? scaffoldKey;

  void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ValidInput(),
        ),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => PickDateProvider()),
        ChangeNotifierProvider(create: (context) => SuggestPlaceProvider()),
        ChangeNotifierProvider(create: (context) => RecentPlacePickProv()),
        ChangeNotifierProvider(create: (context) => SearchedHotelProvider()),
        ChangeNotifierProvider(create: (context) => TicketBookingProvider()),
        ChangeNotifierProvider(create: (context) => DetailHotelProviders()),
        ChangeNotifierProvider(create: (context) => HotelBookingProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => PaymentProvider()),
        ChangeNotifierProvider(create: (context) => PaymentBookingTicket()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: AppColor.orangeMain,
            textTheme: const TextTheme(bodyText2: TextStyle(fontSize: 13))),
        initialRoute: Splash.routeName,
        onGenerateRoute: (route) => RouteConfig.onGenerateRoute(route),
      ),
    );
  }
}
