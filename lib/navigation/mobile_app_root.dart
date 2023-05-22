import 'package:deeplinking/navigation/scaffold_with_nav_bar_tab_item.dart';
import 'package:deeplinking/ui/feed.dart';
import 'package:deeplinking/ui/profile.dart';
import 'package:deeplinking/ui/settings.dart';
import 'package:deeplinking/ui/url_error.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'bottom_tab_bar_shell_route.dart';
import 'nav_keys.dart';


class MobileAppRoot extends StatefulWidget {
  const MobileAppRoot({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MobileAppRootState();
}

class MobileAppRootState extends State<MobileAppRoot> {
  late GoRouter _router;

  final List<Widget> tabChildren = [
    const Settings(),
    const Feed(),
    const Profile(),
  ];

  @override
  void initState() {
    super.initState();
    _router = setRouter();
  }

  final List<ScaffoldWithNavBarTabItem> _tabs =
      <ScaffoldWithNavBarTabItem>[
        ScaffoldWithNavBarTabItem(
            rootRoutePath: '/settings',
            navigatorKey: NavKeys.settingsNavigatorKey,
            icon: const Icon(Icons.settings, key: Key('nav_settings')),
            initialLocation: "/settings"
        ),
        ScaffoldWithNavBarTabItem(
            rootRoutePath: '/feed',
            navigatorKey: NavKeys.feedNavigatorKey,
            icon: const Icon(Icons.feed, key: Key('nav_feed')),
            initialLocation: "/feed"
        ),
        ScaffoldWithNavBarTabItem(
            rootRoutePath: '/profile',
            navigatorKey: NavKeys.profileNavigatorKey,
            icon: const Icon(Icons.person, key: Key('nav_profile')),
            initialLocation: "/profile"),
      ];

  setRouter() {
    return GoRouter(
      navigatorKey: NavKeys.rootNavigatorKey,
      initialLocation: '/feed',
      errorBuilder: (context, state) => UrlError(url: state.location),
      routes: <RouteBase>[
        BottomTabBarShellRoute(
          tabs: _tabs,
          navigatorKey: NavKeys.bottomBarNavigatorKey,
          routes: <RouteBase>[

            /// 1st bottom navigation tab root: SETTINGS
            GoRoute(
              path: '/settings',
              builder: (context, state) => tabChildren[0],
            ),
            /// 2nd bottom navigation tab root: FEED
            GoRoute(
              path: '/feed',
              builder: (context, state) => tabChildren[1],
            ),
            /// 3rd bottom navigation tab root: PROFILE
            GoRoute(
              path: '/profile',
              builder: (context, state) => tabChildren[2],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      debugShowCheckedModeBanner: true,
      builder: (context, child) => child!
    );
  }
}