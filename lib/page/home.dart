import 'package:code_dc/model/color.dart';
import 'package:code_dc/model/data.dart';
import 'package:code_dc/model/dcfirestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'package:stroke_text/stroke_text.dart';
import 'package:card_swiper/card_swiper.dart';

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
    // timer = Timer.periodic(Duration(seconds: 4), (timer) {
    //   int currentPage = controller.page!.toInt();
    //   int nextPage = currentPage + 1;

    //   if (nextPage > 4) {
    //     nextPage = 0;
    //   }
    //   controller.animateToPage(nextPage,
    //       duration: Duration(milliseconds: 400), curve: Curves.linear);
    // });
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
              crossAxisAlignment: CrossAxisAlignment.center,
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
                              const Shadow(
                                  color: DCColor.dcyellow, blurRadius: 23.59),
                              const Shadow(
                                  color: DCColor.dcyellow, blurRadius: 7.86)
                            ],
                            fontSize: size.width * 0.06,
                            fontFamily: "inter",
                            fontWeight: FontWeight.w600,
                            color: DCColor.gitcolor),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 180,
                  child: Swiper(
                    autoplay: true,
                    autoplayDelay: 3000,
                    itemCount: award.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: index == 0
                                ? const Color.fromRGBO(63, 63, 63, 1)
                                : index == 1
                                    ? const Color.fromRGBO(168, 56, 255, 1)
                                    : index == 2
                                        ? const Color.fromRGBO(168, 56, 255, 1)
                                        : index == 3
                                            ? const Color.fromRGBO(
                                                34, 55, 167, 1)
                                            : index == 4
                                                ? const Color.fromRGBO(
                                                    34, 167, 111, 1)
                                                : index == 5
                                                    ? const Color.fromRGBO(
                                                        255, 63, 63, 1)
                                                    : Colors.black,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                width: 10,
                                height: 20,
                              ),
                              Text(
                                award[index]["year"].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "inter",
                                  fontWeight: FontWeight.w600,
                                  height: 1,
                                  color: index == 0
                                      ? const Color.fromRGBO(169, 169, 169, 1)
                                      : index == 1
                                          ? Color.fromARGB(197, 175, 220, 235)
                                          : index == 2
                                              ? const Color.fromRGBO(
                                                  197, 175, 220, 1)
                                              : index == 3
                                                  ? const Color.fromRGBO(
                                                      186, 205, 253, 1)
                                                  : index == 4
                                                      ? const Color.fromRGBO(
                                                          207, 246, 228, 1)
                                                      : index == 5
                                                          ? const Color
                                                                  .fromRGBO(
                                                              255, 180, 180, 1)
                                                          : Colors.black,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                                height: 6,
                              ),
                              Column(
                                children: award[index]["award"]
                                    .toString()
                                    .split(",")
                                    .asMap()
                                    .entries
                                    .map((e) => Column(
                                          children: [
                                            Text(
                                              e.value
                                                  .replaceAll("[", " ")
                                                  .replaceAll("]", " "),
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: "inter",
                                                fontWeight: FontWeight.w600,
                                                height: 1,
                                                color: index == 0
                                                    ? const Color.fromRGBO(
                                                        169, 169, 169, 1)
                                                    : index == 1
                                                        ? const Color.fromRGBO(
                                                            207, 159, 255, 1)
                                                        : index == 2
                                                            ? const Color
                                                                    .fromRGBO(
                                                                207,
                                                                159,
                                                                255,
                                                                1)
                                                            : index == 3
                                                                ? const Color
                                                                        .fromRGBO(
                                                                    186,
                                                                    205,
                                                                    253,
                                                                    1)
                                                                : index == 4
                                                                    ? const Color
                                                                            .fromRGBO(
                                                                        207,
                                                                        246,
                                                                        228,
                                                                        1)
                                                                    : index == 5
                                                                        ? const Color.fromRGBO(
                                                                            255,
                                                                            180,
                                                                            180,
                                                                            1)
                                                                        : Colors
                                                                            .black,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 1,
                                              height: 4,
                                            )
                                          ],
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    viewportFraction: 0.8,
                    scale: 0.9,
                    controller: SwiperController(),
                    pagination: const SwiperPagination(
                        alignment: Alignment.bottomCenter,
                        builder: DotSwiperPaginationBuilder(
                            color: Colors.grey, activeColor: DCColor.dcyellow)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
                  child: Column(
                    children: [
                      const ApplicationContainer(),
                      const SizedBox(
                        width: 10,
                        height: 20,
                      ),
                      const NextType(),
                      const SizedBox(
                        width: 10,
                        height: 50,
                      ),
                      Image.asset(
                        "assets/images/운영방향1.png",
                        scale: 1.2,
                      ),
                      const SizedBox(
                        width: 10,
                        height: 50,
                      ),
                      Image.asset(scale: 1.2, "assets/images/운영방향2.png"),
                      const SizedBox(
                        width: 10,
                        height: 50,
                      ),
                      Image.asset(scale: 1.2, "assets/images/운영방향3.png")
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
          border: Border.all(
              color: const Color.fromRGBO(193, 193, 193, 1), width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            width: size.width * 0.32,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                "assets/images/logo.png",
              ),
            )),
            constraints: const BoxConstraints(minHeight: 100, minWidth: 100),
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
                            color: const Color.fromRGBO(193, 193, 193, 1),
                            width: 2),
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

class NextType extends StatelessWidget {
  const NextType({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "앞으로의 운영 방향은?",
          style: DCColor().boldFontBlack(25, FontWeight.w700),
        ),
        const SizedBox(
          width: double.infinity,
          height: 8,
        ),
        Text("코드디씨는 기초향상->개인과제->팀 프로젝트 순으로",
            style: DCColor().boldFontBlack(14, FontWeight.w500)),
        const SizedBox(
          width: 10,
          height: 4,
        ),
        Text("기초적인 프로그래밍 실력을 학습 한 이후",
            style: DCColor().boldFontBlack(14, FontWeight.w500)),
        const SizedBox(
          width: 10,
          height: 4,
        ),
        Text("실제 프로젝트를 진행합니다",
            style: DCColor().boldFontBlack(14, FontWeight.w500))
      ],
    );
  }
}
