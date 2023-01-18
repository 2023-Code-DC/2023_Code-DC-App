import 'package:code_dc/model/color.dart';
import 'package:code_dc/model/dcfirestore.dart';
import 'package:code_dc/page/account.dart';
import 'package:code_dc/page/asked.dart';
import 'package:code_dc/page/bottom_bar.dart';
import 'package:code_dc/page/announcement.dart';
import 'package:code_dc/page/home.dart';
import 'package:code_dc/page/onboardpage.dart';
import 'package:code_dc/page/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.user});
  final user;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final storage = new FlutterSecureStorage();

  Future em() async {
    onboarding = await storage.read(key: "first");

    return onboarding == null ? null : "true";
  }

  PageController pageController = PageController(
    initialPage: 0,
  );
  @override
  void initState() {
    super.initState();
    em();
  }

  var onboarding = null;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future(() => false);
        },
        child: FutureBuilder(
          future: em(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                  backgroundColor: DCColor.background,
                  body: PageView(
                      controller: pageController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Homepage(),
                        AnnouncementPage(),
                        AskedPage(),
                        UserCheckPage(),
                        AccountPage()
                      ]),
                  bottomNavigationBar: BottomBar(
                      selectedIndex: _selectedIndex,
                      pageController: pageController));
            } else {
              return OnBoardingPage();
            }
          },
        ));
  }
}
