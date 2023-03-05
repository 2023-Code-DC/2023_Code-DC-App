import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_dc/model/color.dart';
import 'package:code_dc/model/data.dart';
import 'package:code_dc/model/dcfirestore.dart';
import 'package:code_dc/model/login_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'package:stroke_text/stroke_text.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  User? user = FirebaseAuth.instance.currentUser;
  Timer? timer;
  PageController controller = PageController(
    initialPage: 0,
  );
  List award = Award().AllAward();

  ad() async {
    var result = await firestore
        .collection('userdata')
        .doc(user!.uid)
        .get()
        .then((value) => value.exists == true ? null : UserData().firstData());
  }

  @override
  void initState() {
    super.initState();
    ad();
    timer = Timer.periodic(Duration(seconds: 4), (timer) {
      int currentPage = controller.page!.toInt();
      int nextPage = currentPage + 1;

      if (nextPage > 4) {
        nextPage = 0;
      }
      controller.animateToPage(nextPage,
          duration: Duration(milliseconds: 400), curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    emmmm() async {
      final storage = new FlutterSecureStorage();

      String? value = await storage.read(key: "login");
    }

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
                      child: StrokeText(
                        text: "CODE D.C. 동아리",
                        strokeColor: DCColor.dcyellow,
                        strokeWidth: 3,
                        textStyle: TextStyle(
                            shadows: [
                              Shadow(
                                  color: DCColor.dcyellow, blurRadius: 23.59),
                              Shadow(color: DCColor.dcyellow, blurRadius: 7.86)
                            ],
                            fontSize: size.width * 0.06,
                            fontFamily: "inter",
                            fontWeight: FontWeight.w600,
                            color: DCColor.gitcolor),
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.white, width: 0.2))),
                  width: double.infinity,
                  height: 130,
                  child: PageView(
                    controller: controller,
                    children: award
                        .asMap()
                        .entries
                        .map(
                          (e) => Container(
                              color: Color.fromRGBO(66, 115, 207, 1),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      e.value["year"].toString(),
                                      textAlign: TextAlign.center,
                                      style: DCColor()
                                          .boldFontWhite(20, FontWeight.w700),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: e.value["award"]
                                        .toString()
                                        .split(",")
                                        .asMap()
                                        .entries
                                        .map((e) => Text(
                                              e.value
                                                  .replaceAll("[", " ")
                                                  .replaceAll("]", " "),
                                              textAlign: TextAlign.left,
                                              style: DCColor().boldFontWhite(
                                                  14, FontWeight.w500),
                                            ))
                                        .toList(),
                                  )
                                ],
                              )),
                        )
                        .toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                        width: 1,
                      ),
                      ApplicationContainer(),
                      ElevatedButton(
                          onPressed: (() {
                            UserAuthentication().SignOutWithGoogle(context);
                          }),
                          child: const Text("로그아웃")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class ApplicationContainer extends StatefulWidget {
  const ApplicationContainer({super.key});

  @override
  State<ApplicationContainer> createState() => _ApplicationContainerState();
}

class _ApplicationContainerState extends State<ApplicationContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.2,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color.fromRGBO(193, 193, 193, 1), width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            width: size.width * 0.32,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                "assets/images/logo.png",
              ),
            )),
            constraints: BoxConstraints(minHeight: 100, minWidth: 100),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                    width: size.width * 0.5,
                    height: size.width * 0.07,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromRGBO(193, 193, 193, 1), width: 2),
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text(
                        "6기 동아리 부원 모집",
                        style: DCColor().boldFontBlack(
                            size.width * 0.0355, FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 1,
                    height: 10,
                  ),
                  RichText(
                      text: TextSpan(
                          text: "코드디씨는 ",
                          style: DCColor().boldFontBlack(
                              size.width * 0.0352, FontWeight.w500),
                          children: [
                        TextSpan(
                            text: "개발동아리",
                            style: DCColor().boldFontBlack(
                                size.width * 0.0352, FontWeight.w700)),
                        TextSpan(
                            text: "로 재학생이라면",
                            style: DCColor().boldFontBlack(
                                size.width * 0.0352, FontWeight.w500))
                      ])),
                  Text(
                    "누구나 지원할 수 있습니다",
                    style: DCColor()
                        .boldFontBlack(size.width * 0.0352, FontWeight.w500),
                  )
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shadowColor: const Color(0x00000000),
                      elevation: 0,
                      minimumSize: Size(size.width * 0.3, size.width * 0.08),
                      backgroundColor: DCColor.dcyellow,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  onPressed: (() {
                    Navigator.pushNamed(context, "/applicationpage");
                  }),
                  child: Center(
                      child: Text(
                    "지원하기",
                    style: DCColor()
                        .boldFontBlack(size.width * 0.0355, FontWeight.w700),
                  )))
            ],
          )
        ],
      ),
    );
  }
}
