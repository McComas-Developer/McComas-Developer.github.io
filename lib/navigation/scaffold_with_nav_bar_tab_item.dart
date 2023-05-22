import 'package:flutter/cupertino.dart';

/// Representation of a tab item in a [ScaffoldWithNavBar]
class ScaffoldWithNavBarTabItem {
   /// The initial location/path
  final String rootRoutePath;

  /// Optional navigatorKey
  final GlobalKey<NavigatorState> navigatorKey;

  final String initialLocation;
  final Widget icon;
  final Widget? activeIcon;
  final bool isNotification;

  /// Constructs an [ScaffoldWithNavBarTabItem].
  const ScaffoldWithNavBarTabItem({
    required this.initialLocation,
    required this.icon,
    this.activeIcon,
    this.isNotification = false,
    required this.rootRoutePath,
    required this.navigatorKey,
  });
}