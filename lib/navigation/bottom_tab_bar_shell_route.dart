import 'package:deeplinking/navigation/scaffold_with_nav_bar.dart';
import 'package:deeplinking/navigation/scaffold_with_nav_bar_tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// ShellRoute that uses a bottom tab navigation (ScaffoldWithNavBar) with
/// separate navigators for each tab.
///
/// NOTE: This is not an optimal implementation and should ideally be
/// implemented in go_router, although in a way that doesn't use a navigator.
/// Here is a proposed implementation:
/// https://github.com/tolo/flutter_packages/tree/nested-persistent-navigation/packages/go_router
class BottomTabBarShellRoute extends ShellRoute {
  final List<ScaffoldWithNavBarTabItem> tabs;
  BottomTabBarShellRoute({
    required this.tabs,
    GlobalKey<NavigatorState>? navigatorKey,
    List<RouteBase> routes = const <RouteBase>[],
    Key? scaffoldKey = const ValueKey('ScaffoldWithNavBar'),
  }) : super(
      navigatorKey: navigatorKey,
      routes: routes,
      builder: (context, state, Widget fauxNav) {
        return Stack(children: [
          // Needed to keep the (faux) shell navigator alive
          Offstage(child: fauxNav),
          /// This check temporarily resolves the navigator issue while we wait
          /// for the official **GoRouter** implementation of this architecture
          /// https://github.com/flutter/packages/pull/2650
          (fauxNav is HeroControllerScope) ?
            ScaffoldWithNavBar(
                tabs: tabs, key: scaffoldKey,
                currentNavigator: (fauxNav).child as Navigator,
                currentRouterState: state, routes: routes) :
            ScaffoldWithNavBar(tabs: tabs, key: scaffoldKey,
                currentNavigator: (fauxNav as Navigator),
                currentRouterState: state, routes: routes)
        ]);
      }
  );
}