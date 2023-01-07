import 'package:code_dc/model/color.dart';
import 'package:code_dc/page/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DCColor.backgroundcolor,
        body: PageView(children: []),
        bottomNavigationBar: BottomBar(selectedIndex: _selectedIndex));
  }
}
