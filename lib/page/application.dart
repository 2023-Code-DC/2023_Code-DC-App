import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_dc/model/color.dart';
import 'package:code_dc/wirte/write_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  Timer? timer;
  var finday;
  User? user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;
  late DocumentSnapshot<Map<String, dynamic>> result;
  DateTime dday = DateTime(2023, 3, 9);
  DateTime startday = DateTime(2023, 1, 20);
  double progbar = 0;
  Future getdata() async {
    result = await firestore.collection('Form').doc(user!.uid).get();
    return result == null ? null : "true";
  }

  final _toDay = DateTime.now();
  String date = "20230309";

  @override
  void initState() {
    super.initState();
    var now = DateTime.now();
    var mday = dday.difference(startday);
    var aday = now.difference(dday);
    progbar = aday.inSeconds / mday.inSeconds + 1;
    getdata();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      var now = DateTime.now();
      var sday = dday.difference(now);
      setState(() {
        finday = sday;
      });
    });
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int difference =
        int.parse(_toDay.difference(DateTime.parse(date)).inDays.toString());
    return SafeArea(
      child: Scaffold(
          body: FutureBuilder(
        future: getdata(),
        builder: (context, snapshot) {
          if (snapshot.hasData == true) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back)),
                        ],
                      ),
                      Text(
                        "신청서 페이지",
                        style: DCColor()
                            .boldFontBlack(size.width * 0.09, FontWeight.w800),
                      ),
                      const SizedBox(
                        width: 10,
                        height: 50,
                      ),
                      InkWell(
                        onTap: () {
                          if (difference > 0) {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      title: Text(
                                        "신청서 작성기간이 지났습니다. ",
                                        textAlign: TextAlign.center,
                                        style: DCColor().boldFontBlack(
                                            size.width * 0.05, FontWeight.w700),
                                      ),
                                      actionsAlignment:
                                          MainAxisAlignment.center,
                                      actions: [
                                        ElevatedButton(
                                            onPressed: (() {
                                              Navigator.pop(context);
                                            }),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: DCColor.dcyellow,
                                            ),
                                            child: Text(
                                              "확인",
                                              style: DCColor().boldFontBlack(
                                                  size.width * 0.05,
                                                  FontWeight.w700),
                                            ))
                                      ],
                                    ));
                          } else if (result.exists == true) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => ShowDialogs(
                                      title: "신청서가 이미 존재합니다",
                                      text: "수정하기",
                                      routes: "/modifyformpage",
                                    ));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const FormWritePage())));
                          }
                        },
                        child: Container(
                          height: size.height * 0.2,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color.fromRGBO(217, 217, 217, 1),
                                  width: 2),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "신청서 \n작성하기",
                                        style: DCColor().boldFontBlack(
                                            size.width * 0.08, FontWeight.w800),
                                      ),
                                      const SizedBox(
                                        width: 1,
                                        height: 8,
                                      ),
                                      Text(
                                        "웹에서도 작성할 수 있어요!",
                                        style: DCColor().boldFontYellow(
                                            size.width * 0.032,
                                            FontWeight.w700),
                                      ),
                                    ]),
                                Container(
                                  width: size.width * 0.35,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/write.png"))),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (() {
                          if (result.exists == true) {
                            Navigator.pushNamed(context, "/modifyformpage");
                          } else if (difference < 0) {
                            showDialog(
                                context: context,
                                builder: (context) => ShowDialogs(
                                      title: "신청서를 먼저 작성해주세요",
                                      text: "작성하기",
                                      routes: "/writeformpage",
                                    ));
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      title: Text(
                                        "신청서 작성기간이 지났습니다. ",
                                        textAlign: TextAlign.center,
                                        style: DCColor().boldFontBlack(
                                            size.width * 0.05, FontWeight.w700),
                                      ),
                                      actionsAlignment:
                                          MainAxisAlignment.center,
                                      actions: [
                                        ElevatedButton(
                                            onPressed: (() {
                                              Navigator.pop(context);
                                            }),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: DCColor.dcyellow,
                                            ),
                                            child: Text(
                                              "확인",
                                              style: DCColor().boldFontBlack(
                                                  size.width * 0.05,
                                                  FontWeight.w700),
                                            ))
                                      ],
                                    ));
                          }
                        }),
                        child: Container(
                          height: size.height * 0.2,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: const Color.fromRGBO(217, 217, 217, 1),
                                  width: 2),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "신청서 \n수정하기",
                                        style: DCColor().boldFontBlack(
                                            size.width * 0.08, FontWeight.w800),
                                      ),
                                      const SizedBox(
                                        width: 1,
                                        height: 8,
                                      ),
                                      Text(
                                        "웹에서도 수정할 수 있어요!",
                                        style: DCColor().boldFontYellow(
                                            size.width * 0.032,
                                            FontWeight.w700),
                                      ),
                                    ]),
                                const SizedBox(
                                  height: 20,
                                  width: 1,
                                ),
                                Container(
                                  width: size.width * 0.35,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/edit.png"))),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: size.height * 0.25,
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "신청서 작성기간",
                              style: DCColor().boldFontYellow(
                                  size.width * 0.07, FontWeight.w700),
                            ),
                            Text(
                              "~ 3/9",
                              style: DCColor().boldFontBlack(
                                  size.width * 0.065, FontWeight.w600),
                            ),
                            SizedBox(
                              width: 1,
                              height: size.width * 0.07,
                            ),
                            if (finday == null)
                              Text(
                                "로딩중...",
                                style: DCColor().boldFontBlack(
                                    size.width * 0.07, FontWeight.w600),
                              )
                            else if (difference > 0)
                              Text(
                                "신청서 작성기간이 아닙니다",
                                style: DCColor().boldFontBlack(
                                    size.width * 0.07, FontWeight.w600),
                              )
                            else
                              SizedBox(
                                width: double.infinity,
                                height: 25,
                                child: LinearPercentIndicator(
                                  animation: true,
                                  lineHeight: size.height * 0.1,
                                  animationDuration: 1000,
                                  percent: progbar,
                                  barRadius: const Radius.circular(6),
                                  center: Text(
                                    finday.toString().substring(0, 9),
                                    style: DCColor().boldFontBlack(
                                        size.width * 0.033, FontWeight.w600),
                                  ),
                                  progressColor: DCColor.dcyellow,
                                ),
                              ),
                          ],
                        )),
                      )
                    ]),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      )),
    );
  }
}

class ShowDialogs extends StatefulWidget {
  const ShowDialogs(
      {super.key,
      required this.title,
      required this.routes,
      required this.text});
  final String title, routes, text;
  @override
  State<ShowDialogs> createState() => _ShowDialogsState();
}

class _ShowDialogsState extends State<ShowDialogs> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text(
        widget.title,
        textAlign: TextAlign.center,
        style: DCColor().boldFontBlack(size.width * 0.05, FontWeight.w700),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
            onPressed: (() {
              Navigator.popAndPushNamed(context, widget.routes);
            }),
            style: ElevatedButton.styleFrom(
              backgroundColor: DCColor.dcyellow,
            ),
            child: Text(
              widget.text,
              style:
                  DCColor().boldFontBlack(size.width * 0.05, FontWeight.w700),
            ))
      ],
    );
  }
}
