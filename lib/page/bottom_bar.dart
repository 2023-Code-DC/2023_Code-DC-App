import 'package:code_dc/model/color.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  BottomBar(
      {super.key, required this.selectedIndex, required this.pageController});
  int selectedIndex;
  PageController pageController;
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  void _onItemTapped(int item) {
    setState(() {
      widget.selectedIndex = item;
      widget.pageController.jumpToPage(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.white, width: 0.1)),
      ),
      child: BottomNavigationBar(
          backgroundColor: DCColor.backgroundcolor,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: widget.selectedIndex,
          selectedItemColor: DCColor.dcyellow,
          unselectedItemColor: Colors.white,
          enableFeedback: false,
          onTap: (value) {
            _onItemTapped(value);
          },
          iconSize: 30,
          items: [
            BottomNavigationBarItem(
                icon: Icon(widget.selectedIndex == 0
                    ? Icons.home
                    : Icons.home_outlined),
                label: "a",
                tooltip: "",
                backgroundColor: DCColor.backgroundcolor),
            BottomNavigationBarItem(
                icon: Icon(Icons.abc),
                label: "c",
                tooltip: "",
                backgroundColor: DCColor.backgroundcolor),
            BottomNavigationBarItem(
                icon: Icon(Icons.abc),
                label: "c",
                tooltip: "",
                backgroundColor: DCColor.backgroundcolor),
            BottomNavigationBarItem(
                icon: Icon(Icons.abc),
                label: "c",
                tooltip: "",
                backgroundColor: DCColor.backgroundcolor),
            BottomNavigationBarItem(
                icon: Icon(widget.selectedIndex == 4
                    ? Icons.account_circle_sharp
                    : Icons.account_circle),
                label: "c",
                tooltip: "",
                backgroundColor: DCColor.backgroundcolor)
          ]),
    );
  }
}
