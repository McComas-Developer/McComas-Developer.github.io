import 'package:deeplinking/navigation/scaffold_with_nav_bar_tab_item.dart';
import 'package:flutter/material.dart';
import 'bottom_nav_item_widget.dart';

class RouterBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final List<ScaffoldWithNavBarTabItem> items;
  final ValueChanged<int> onItemSelected;

  const RouterBottomNavBar({
    Key? key,
    required this.items,
    required this.onItemSelected,
    required this.selectedIndex
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 2),
        ],
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: BottomNavItemWidget(
                  tab: item,
                  isSelected: index == selectedIndex,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}