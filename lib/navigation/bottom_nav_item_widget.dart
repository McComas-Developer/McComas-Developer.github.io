import 'package:deeplinking/navigation/scaffold_with_nav_bar_tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavItemWidget extends StatefulWidget {
  final ScaffoldWithNavBarTabItem tab;
  final bool isSelected;

  const BottomNavItemWidget({
    Key? key,
    required this.tab,
    required this.isSelected
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BottomNavItemWidgetState();
}

class BottomNavItemWidgetState extends State<BottomNavItemWidget> {

  @override
  Widget build(BuildContext context) => getAnimatedContainer();

  getAnimatedContainer({int count = 0}) => AnimatedContainer(
    width: widget.isSelected ? 102 : 50,
    height: 40,
    duration: const Duration(milliseconds: 250),
    curve: Curves.ease,
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: widget.isSelected
          ? Colors.red[700]?.withOpacity(0.2)
          : Colors.white.withOpacity(0),
      borderRadius: const BorderRadius.all(Radius.circular(50)),
    ),
    child: Container(
      alignment: Alignment.center,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: IconTheme(
                data: IconThemeData(
                    color: widget.isSelected ? Colors.red[700]
                        : CupertinoColors.systemGrey
                ),
                child: determineChild(count)
            ),
          ),
        ],
      ),
    ),
  );

  determineChild(int count) {
    if(widget.tab.isNotification) {
      return count != 0 ? Stack(
          children: <Widget>[
            const Icon(Icons.notifications, key: Key('nav_notifications')),
            Positioned(
              right: 2,
              top: 2,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: widget.isSelected ? CupertinoColors.systemGrey : Colors.red[700],
                    shape: BoxShape.circle
                ),
                constraints: const BoxConstraints(minWidth: 10, minHeight: 10),
              ),
            )
          ]
      ) : const Icon(Icons.notifications, key: Key('nav_notifications'));
    }
    return widget.isSelected
        ? widget.tab.activeIcon ?? widget.tab.icon : widget.tab.icon;
  }
}