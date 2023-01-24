import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<String> list = [];
  Future em() async {
    onboarding = await storage.read(key: "first");
    List<String> docs = [];
    QuerySnapshot<Map<String, dynamic>> doc =
        await firestore.collection('notice').get();
    for (var index in doc.docs) {
      if (!docs.contains(index.id)) {
        docs.add(index.id);
      }
    }
    for (var i = 0; i < docs.length; i++) {
      DocumentSnapshot<Map<String, dynamic>> result =
          await firestore.collection('notice').doc(docs[i]).get();
      if (!list.contains(result["내용"])) {
        list.add(result["내용"]);
      }
    }
    return onboarding == null ? "false" : "true";
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
            if (snapshot.data == "true") {
              return Scaffold(
                  backgroundColor: DCColor.background,
                  body: PageView(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const Homepage(),
                        AnnouncementPage(list: list),
                        const AskedPage(),
                        const UserCheckPage(),
                        AccountPage()
                      ]),
                  bottomNavigationBar: BottomBar(
                      selectedIndex: _selectedIndex,
                      pageController: pageController));
            } else if (snapshot.data == "false") {
              return const OnBoardingPage();
            } else {
              return Scaffold(
                body: Center(
                    child: CircularProgressIndicator(
                  color: DCColor.dcyellow,
                )),
              );
            }
          },
        ));
  }
}
