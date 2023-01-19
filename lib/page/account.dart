import 'package:code_dc/model/color.dart';
import 'package:code_dc/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  User? user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;
  var result;
  bool page = false;
  ImageProvider<Object> avatorImage() {
    if (result != null) {
      return const AssetImage("assets/images/pepe.png");
    } else {
      return NetworkImage(result["image"]);
    }
  }

  Future getdata() async {
    result = await firestore.collection('userdata').doc(user!.uid).get();
    return result == null ? null : "true";
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  bool logoutbutton = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: getdata(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return SafeArea(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: (() {
                                showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        decoration: const BoxDecoration(
                                          color: DCColor.background,
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                    color: DCColor.gitcolor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                                width: 1,
                                              ),
                                              Text('메뉴 페이지 (문구 삭제예정)',
                                                  textAlign: TextAlign.center,
                                                  style: DCColor()
                                                      .boldFontBlack(
                                                          20, FontWeight.w600)),
                                              ElevatedButton(
                                                  //로그아웃버튼
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        DCColor.background,
                                                    shadowColor:
                                                        Colors.transparent,
                                                    elevation: 0,
                                                    foregroundColor:
                                                        Colors.transparent,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0)),
                                                  ),
                                                  onPressed: (() {
                                                    Navigator.pop(context);
                                                    UserAuthentication()
                                                        .SignOutWithGoogle(
                                                            context);
                                                    setState(() {});
                                                  }),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.logout,
                                                        color: DCColor.gitcolor,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                        height: 50,
                                                      ),
                                                      Text(
                                                        "로그아웃",
                                                        style: DCColor()
                                                            .boldFontBlack(
                                                                20,
                                                                FontWeight
                                                                    .w600),
                                                      )
                                                    ],
                                                  )),
                                              ElevatedButton(
                                                  //온보딩 다시보기
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        DCColor.background,
                                                    shadowColor:
                                                        Colors.transparent,
                                                    elevation: 0,
                                                    foregroundColor:
                                                        Colors.transparent,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0)),
                                                  ),
                                                  onPressed: (() async {
                                                    const storage =
                                                        FlutterSecureStorage();
                                                    await storage.delete(
                                                        key: "first");
                                                  }),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .dashboard_customize,
                                                        color: DCColor.gitcolor,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                        height: 50,
                                                      ),
                                                      Text(
                                                        "온보딩 페이지 다시보기",
                                                        style: DCColor()
                                                            .boldFontBlack(
                                                                20,
                                                                FontWeight
                                                                    .w600),
                                                      )
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }),
                              icon: const Icon(
                                Icons.menu,
                                color: DCColor.gitcolor,
                                size: 30,
                              ))
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(children: [
                          SizedBox(
                            width: 10,
                            height: size.height * 0.065,
                          ),
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: avatorImage(),
                          ),
                          const SizedBox(
                            width: 1,
                            height: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                result["name"].toString(),
                                style: DCColor()
                                    .boldFontBlack(20, FontWeight.w600),
                              ),
                              Text(user!.email.toString(),
                                  style: DCColor()
                                      .boldFontBlack(20, FontWeight.w600)),
                              Text("해킹보안과",
                                  style: DCColor()
                                      .boldFontBlack(20, FontWeight.w600))
                            ],
                          ),
                        ]),
                      ),
                    ],
                  )));
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: DCColor.dcyellow,
            ),
          );
        }
      }),
    );
  }
}
