import 'package:code_dc/HomeScreen.dart';
import 'package:code_dc/model/color.dart';
import 'package:code_dc/model/dcfirestore.dart';
import 'package:code_dc/page/account.dart';
import 'package:code_dc/page/asked.dart';
import 'package:code_dc/page/bottom_bar.dart';
import 'package:code_dc/page/announcement.dart';
import 'package:code_dc/page/home.dart';
import 'package:code_dc/page/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.SignOut, required this.user});
  final SignOut;
  final user;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  PageController pageController = PageController(
    initialPage: 0,
  );
  @override
  void initState() {
    super.initState();
    UserData().addData(widget.user);
    print(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DCColor.backgroundcolor,
        body: PageView(controller: pageController, children: [
          Homepage(),
          AnnouncementPage(),
          AskedPage(),
          UserCheckPage(),
          AccountPage(
            SignOut: widget.SignOut,
            user: widget.user,
          )
        ]),
        bottomNavigationBar: BottomBar(
            selectedIndex: _selectedIndex, pageController: pageController));
  }
}
