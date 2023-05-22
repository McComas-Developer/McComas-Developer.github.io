import 'package:flutter/cupertino.dart';

class NavKeys {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'rootNavigatorKey');
  static final GlobalKey<NavigatorState> bottomBarNavigatorKey =
  GlobalKey<NavigatorState>(debugLabel: 'bottomBarNavigatorKey');
  static final GlobalKey<NavigatorState> settingsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'auctionNavigatorKey');
  static final GlobalKey<NavigatorState> feedNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'favoritesNavigatorKey');
  static final GlobalKey<NavigatorState> profileNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'profileNavigatorKey');
}