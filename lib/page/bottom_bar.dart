import 'package:code_dc/model/color.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  BottomBar({super.key, required this.selectedIndex});
  int selectedIndex;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  void _onItemTapped(int item) {
    setState(() {
      widget.selectedIndex = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: DCColor.backgroundcolor,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: widget.selectedIndex,
        selectedItemColor: DCColor.dcyellow,
        unselectedItemColor: Colors.white,
        onTap: (value) {
          _onItemTapped(value);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.abc),
              label: "a",
              backgroundColor: DCColor.backgroundcolor),
          BottomNavigationBarItem(
              icon: Icon(Icons.abc),
              label: "c",
              backgroundColor: DCColor.backgroundcolor),
          BottomNavigationBarItem(
              icon: Icon(Icons.abc),
              label: "c",
              backgroundColor: DCColor.backgroundcolor),
          BottomNavigationBarItem(
              icon: Icon(Icons.abc),
              label: "c",
              backgroundColor: DCColor.backgroundcolor),
          BottomNavigationBarItem(
              icon: Icon(Icons.abc),
              label: "c",
              backgroundColor: DCColor.backgroundcolor)
        ]);
  }
}
