// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hotel`
  String get hotel {
    return Intl.message(
      'Hotel',
      name: 'hotel',
      desc: '',
      args: [],
    );
  }

  /// `Flight ticket`
  String get ticket {
    return Intl.message(
      'Flight ticket',
      name: 'ticket',
      desc: '',
      args: [],
    );
  }

  /// `Combo`
  String get combo {
    return Intl.message(
      'Combo',
      name: 'combo',
      desc: '',
      args: [],
    );
  }

  /// `Quick stay`
  String get quick_stay {
    return Intl.message(
      'Quick stay',
      name: 'quick_stay',
      desc: '',
      args: [],
    );
  }

  /// `Relax by hour`
  String get relaxByHours {
    return Intl.message(
      'Relax by hour',
      name: 'relaxByHours',
      desc: '',
      args: [],
    );
  }

  /// `Endow of week`
  String get endowWeek {
    return Intl.message(
      'Endow of week',
      name: 'endowWeek',
      desc: '',
      args: [],
    );
  }

  /// `Hot places`
  String get hotPlace {
    return Intl.message(
      'Hot places',
      name: 'hotPlace',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get homePage {
    return Intl.message(
      'Home',
      name: 'homePage',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Room booking`
  String get titleRoomBooking {
    return Intl.message(
      'Room booking',
      name: 'titleRoomBooking',
      desc: '',
      args: [],
    );
  }

  /// `Seach more than 11.000 hotels`
  String get titlePlaceHotel {
    return Intl.message(
      'Seach more than 11.000 hotels',
      name: 'titlePlaceHotel',
      desc: '',
      args: [],
    );
  }

  /// `Check in`
  String get checkInHotel {
    return Intl.message(
      'Check in',
      name: 'checkInHotel',
      desc: '',
      args: [],
    );
  }

  /// `Check out`
  String get checkOutHotel {
    return Intl.message(
      'Check out',
      name: 'checkOutHotel',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Sort`
  String get sort {
    return Intl.message(
      'Sort',
      name: 'sort',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get map {
    return Intl.message(
      'Map',
      name: 'map',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Low to high`
  String get sortLowToHighPrice {
    return Intl.message(
      'Low to high',
      name: 'sortLowToHighPrice',
      desc: '',
      args: [],
    );
  }

  /// `High to low`
  String get sortHighToLowPrice {
    return Intl.message(
      'High to low',
      name: 'sortHighToLowPrice',
      desc: '',
      args: [],
    );
  }

  /// `By review points`
  String get sortByReviewPoint {
    return Intl.message(
      'By review points',
      name: 'sortByReviewPoint',
      desc: '',
      args: [],
    );
  }

  /// `Ticket Booking`
  String get titleTicketBooking {
    return Intl.message(
      'Ticket Booking',
      name: 'titleTicketBooking',
      desc: '',
      args: [],
    );
  }

  /// `Departure`
  String get sourcePlace {
    return Intl.message(
      'Departure',
      name: 'sourcePlace',
      desc: '',
      args: [],
    );
  }

  /// `Destination`
  String get destinationPlace {
    return Intl.message(
      'Destination',
      name: 'destinationPlace',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get startDate {
    return Intl.message(
      'Start Date',
      name: 'startDate',
      desc: '',
      args: [],
    );
  }

  /// `End Date`
  String get endDate {
    return Intl.message(
      'End Date',
      name: 'endDate',
      desc: '',
      args: [],
    );
  }

  /// `Return`
  String get returnFlight {
    return Intl.message(
      'Return',
      name: 'returnFlight',
      desc: '',
      args: [],
    );
  }

  /// `Passengers`
  String get passengers {
    return Intl.message(
      'Passengers',
      name: 'passengers',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
