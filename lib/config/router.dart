import 'package:clone_vntrip/components/custom_page%20_route.dart';
import 'package:clone_vntrip/screens/home.dart';
import 'package:clone_vntrip/screens/hotel/detail_hotel.dart';
import 'package:clone_vntrip/screens/hotel/filter_hotels_searched.dart';
import 'package:clone_vntrip/screens/hotel/hotel.dart';
import 'package:clone_vntrip/screens/hotel/map_each_hotel.dart';
import 'package:clone_vntrip/screens/hotel/map_hotels.dart';
import 'package:clone_vntrip/screens/hotel/payment_booking_hotel.dart';
import 'package:clone_vntrip/screens/hotel/webview_gateway_payment.dart';
import 'package:clone_vntrip/screens/plane_ticket/pre_booking_ticket.dart';
import 'package:clone_vntrip/screens/plane_ticket/ticket_booking.dart';
import 'package:clone_vntrip/screens/splash.dart';
import 'package:flutter/material.dart';
import '../screens/combo.dart';
import '../screens/hotel/detail_each_room_hotel.dart';
import '../screens/hotel/pre_booking_hotel.dart';
import '../screens/hotel/searched_rooms.dart';
import '../screens/hotel/suggestPlace.dart';
import '../screens/login.dart';
import '../screens/plane_ticket/detail_flight_ticket.dart';
import '../screens/plane_ticket/payment_ticket.dart';
import '../screens/plane_ticket/search_place.dart';
import '../screens/plane_ticket/searched_flight_ticket.dart';
import '../screens/quick_stay.dart';

class RouteConfig {

  static Route onGenerateRoute(RouteSettings settings) {

    switch (settings.name) {

      case Splash.routeName:
        return MaterialPageRoute(builder: (context) => Splash());
      case Home.routeName:
        return CustomPageRoute(page: Home(), direction: AxisDirection.left, settings: settings);
      case PreBookingTicket.routeName:
        return CustomPageRoute(page: PreBookingTicket(), direction: AxisDirection.left, settings: settings);
      case PaymentBookingHotel.routeName:
        return CustomPageRoute(page: PaymentBookingHotel(), direction: AxisDirection.left, settings: settings);
      case PaymentTicket.routeName:
        return CustomPageRoute(page: PaymentTicket(), direction: AxisDirection.left, settings: settings);
      case WebviewPayment.routeName:
        return CustomPageRoute(page: WebviewPayment(), direction: AxisDirection.left, settings: settings);
      case DetailFightTicket.routeName:
        return CustomPageRoute(page: DetailFightTicket(), direction: AxisDirection.left, settings: settings);
      case PreBookingHotel.routeName:
        return CustomPageRoute(page: PreBookingHotel(), direction: AxisDirection.left, settings: settings);
      case MapEachHotel.routeName:
        return CustomPageRoute(page: MapEachHotel(), direction: AxisDirection.up, settings: settings);
      case Combo.routeName:
        return CustomPageRoute(page: Combo(), direction: AxisDirection.up, settings: settings);
      case QuickStay.routeName:
        return CustomPageRoute(page: QuickStay(), direction: AxisDirection.up, settings: settings);
      case DetailEachRoomHotel.routeName:
        return CustomPageRoute(page: DetailEachRoomHotel(), direction: AxisDirection.left, settings: settings);
      case DetailHotel.routeName:
        return CustomPageRoute(page: DetailHotel(), direction: AxisDirection.left, settings: settings);
      case MapHotels.routeName:
        return CustomPageRoute(page: MapHotels(), direction: AxisDirection.up, settings: settings);
      case Login.routeName:
        return CustomPageRoute(page: const Login(), direction: AxisDirection.left, settings: settings);
      case HotelBooking.routeName:
        return CustomPageRoute(page: const HotelBooking(), direction: AxisDirection.left, settings: settings);
      case TicketBooking.routeName:
        return CustomPageRoute(page: const TicketBooking(), direction: AxisDirection.left, settings: settings);
      case SuggestPlace.routeName:
        return CustomPageRoute(page: SuggestPlace(), direction: AxisDirection.left, settings: settings);
      case SearchedRoom.routeName:
        return CustomPageRoute(page: const SearchedRoom(), direction: AxisDirection.left, settings: settings);
      case SearchPlace.routeName:
        return CustomPageRoute(page: SearchPlace(), direction: AxisDirection.up, settings: settings);
      case SearchedFlightTicket.routeName:
        return CustomPageRoute(page: const SearchedFlightTicket(), direction: AxisDirection.left, settings: settings);
      case FilterSearchedHotel.routeName:
        return CustomPageRoute(page: FilterSearchedHotel(), direction: AxisDirection.left, settings: settings);

      default:
        return MaterialPageRoute(builder: (context) => Home());
    }
  }
}