import 'dart:developer';
import 'package:deeplinking/navigation/router_bottom_nav_bar.dart';
import 'package:deeplinking/navigation/scaffold_with_nav_bar_tab_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
/// CREDIT: This implementation would not have been possible without the help of:
/// https://gist.github.com/tolo/f7e6c30cad3ac76085d75255ba509f10
class ScaffoldWithNavBar extends StatefulWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.currentNavigator,
    required this.currentRouterState,
    required this.tabs,
    required this.routes,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  /// The navigator for the currently active tab
  final Navigator currentNavigator;

  /// The pages for the current route
  List<Page<dynamic>> get pagesForCurrentRoute => currentNavigator.pages;

  /// The current router state
  final GoRouterState currentRouterState;

  /// The tabs
  final List<ScaffoldWithNavBarTabItem> tabs;

  /// The routes
  final List<RouteBase> routes;

  @override
  State<StatefulWidget> createState() => ScaffoldWithNavBarState();
}

/// State for ScaffoldWithNavBar
class ScaffoldWithNavBarState extends State<ScaffoldWithNavBar>
    with SingleTickerProviderStateMixin {
  late final List<_NavBarTabNavigator> _tabs;
  int _currentIndex = 0;
  bool shouldHideBottomBar = false;
  final PageController _pageController = PageController(initialPage: 0);

  //
  int _locationToTabIndex(String location) {
    final int index = _tabs.indexWhere(
            (_NavBarTabNavigator t) => location.startsWith(t.rootRoutePath));
    return index < 0 ? 0 : index;
  }

  @override
  void initState() {
    super.initState();
    _tabs = widget.tabs
        .map((ScaffoldWithNavBarTabItem e) => _NavBarTabNavigator(e))
        .toList();
  }

  @override
  void didUpdateWidget(covariant ScaffoldWithNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateForCurrentTab();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateForCurrentTab();
  }

  void _updateForCurrentTab() {
    final int previousIndex = _currentIndex;
    final location = GoRouter.of(context).location;
    _currentIndex = _locationToTabIndex(location);

    if(location.contains("register")) {
      shouldHideBottomBar = true;
    } else {
      shouldHideBottomBar = false;
    }

    final _NavBarTabNavigator tabNav = _tabs[_currentIndex];
    tabNav.pages = widget.pagesForCurrentRoute;
    tabNav.lastLocation = location;
    if(previousIndex != _currentIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _pageController.jumpToPage(_currentIndex);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    log("ScaffoldNavBar: build()");
    return Scaffold(
      body: PageView(
        key: const Key("nav_page_view"),
        controller: _pageController,
        onPageChanged: (index) => _onItemTapped(index, context),
        children: _tabs
            .map((_NavBarTabNavigator tab) => tab.buildNavigator(context))
            .toList(),
      ),
      bottomNavigationBar: shouldHideBottomBar ? null : RouterBottomNavBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) => _onItemTapped(index, context),
        items: _tabs.map((_NavBarTabNavigator e) => e.bottomNavigationTab)
            .toList(),
      ),
    );
  }

  void _onItemTapped(int index, BuildContext context) {
    GoRouter.of(context).go(_tabs[index].currentLocation);
  }
}

/// Class representing a tab along with its navigation logic
class _NavBarTabNavigator {
  _NavBarTabNavigator(this.bottomNavigationTab);

  final ScaffoldWithNavBarTabItem bottomNavigationTab;

  String? lastLocation;

  String get currentLocation =>
      lastLocation != null ? lastLocation! : rootRoutePath;

  String get rootRoutePath => bottomNavigationTab.rootRoutePath;
  Key? get navigatorKey => bottomNavigationTab.navigatorKey;
  List<Page<dynamic>> pages = <Page<dynamic>>[];

  Widget buildNavigator(BuildContext context) {
    if (pages.isNotEmpty) {
      return Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: (Route<dynamic> route, dynamic result) {
          if (pages.length == 1 || !route.didPop(result)) {
            return false;
          }
          GoRouter.of(context).pop();
          return true;
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}