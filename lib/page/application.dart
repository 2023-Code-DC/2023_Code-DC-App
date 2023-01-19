import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_dc/model/color.dart';
import 'package:code_dc/page/FormWrite.dart';
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
  DateTime dday = DateTime(2023, 4, 15);
  DateTime startday = DateTime(2023, 3, 3);
  double progbar = 0;
  Future getdata() async {
    result = await firestore.collection('Form').doc(user!.uid).get();
    return result == null ? null : "true";
  }

  @override
  void initState() {
    super.initState();
    getdata();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      var now = DateTime.now();
      var aday = now.difference(dday);
      var sday = dday.difference(now);
      setState(() {
        finday = sday;
        progbar = aday.inSeconds / sday.inSeconds + 1;
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
    return SafeArea(
      child: Scaffold(
          backgroundColor: DCColor.background,
          body: FutureBuilder(
            future: getdata(),
            builder: (context, snapshot) {
              if (snapshot.hasData == true) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "신청서 페이지",
                            style: DCColor().boldFontBlack(
                                size.width * 0.09, FontWeight.w800),
                          ),
                          InkWell(
                            onTap: () {
                              if (result.exists == true) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          title: Text(
                                            "신청서가 이미 존재합니다",
                                            textAlign: TextAlign.center,
                                            style: DCColor().boldFontBlack(
                                                size.width * 0.05,
                                                FontWeight.w700),
                                          ),
                                          actionsAlignment:
                                              MainAxisAlignment.center,
                                          actions: [
                                            ElevatedButton(
                                                onPressed: (() {
                                                  Navigator.pop(context);
                                                }),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      DCColor.dcyellow,
                                                ),
                                                child: Text(
                                                  "수정하기",
                                                  style: DCColor()
                                                      .boldFontBlack(
                                                          size.width * 0.05,
                                                          FontWeight.w700),
                                                ))
                                          ],
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
                                      color: const Color.fromRGBO(
                                          217, 217, 217, 1),
                                      width: 2),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "신청서 \n작성하기",
                                            style: DCColor().boldFontBlack(
                                                size.width * 0.08,
                                                FontWeight.w800),
                                          ),
                                          Text(
                                            "웹에서도 작성할 수 있어요!",
                                            style: DCColor().boldFontYellow(
                                                size.width * 0.032,
                                                FontWeight.w700),
                                          ),
                                        ]),
                                    Container(
                                      height: double.infinity,
                                      width: size.width * 0.4,
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
                          Container(
                            height: size.height * 0.2,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color:
                                        const Color.fromRGBO(217, 217, 217, 1),
                                    width: 2),
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "신청서 \n수정하기",
                                          style: DCColor().boldFontBlack(
                                              size.width * 0.08,
                                              FontWeight.w800),
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
                                    height: double.infinity,
                                    width: size.width * 0.4,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/edit.png"))),
                                  ),
                                ],
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
                                  "~ 4/15",
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
                                else
                                  SizedBox(
                                    width: double.infinity,
                                    height: 20,
                                    child: LinearPercentIndicator(
                                      animation: true,
                                      lineHeight: 20.0,
                                      animationDuration: 2500,
                                      percent: progbar,
                                      barRadius: const Radius.circular(6),
                                      center: Text(
                                        finday.toString().substring(0, 10),
                                        style: DCColor().boldFontBlack(
                                            size.width * 0.033,
                                            FontWeight.w600),
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
