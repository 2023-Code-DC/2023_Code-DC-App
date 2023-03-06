import 'package:code_dc/model/color.dart';
import 'package:code_dc/model/login_model.dart';
import 'package:code_dc/page/terms.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart' as kakao;
import 'package:url_launcher/url_launcher.dart';

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
          return Scaffold(
            body: SafeArea(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
                    child: Column(
                      children: [
                        Column(children: [
                          SizedBox(
                            width: 10,
                            height: size.height * 0.065,
                          ),
                          CircleAvatar(
                            radius: size.width * 0.2,
                            backgroundImage: avatorImage(),
                          ),
                          const SizedBox(
                            width: 1,
                            height: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                result["name"].toString(),
                                style: DCColor().boldFontBlack(
                                    size.width * 0.06, FontWeight.w600),
                              ),
                              SizedBox(
                                width: 1,
                                height: 6,
                              ),
                              Text(user!.email.toString(),
                                  style: DCColor().boldFontBlack(
                                      size.width * 0.06, FontWeight.w600)),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                            height: 50,
                          ),
                          Container(
                            height: size.height * 0.4,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: DCColor.gitcolor, width: 2),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0)),
                                        foregroundColor: DCColor.gitcolor),
                                    onPressed: (() {
                                      Navigator.pushNamed(
                                          context, "/applicationpage");
                                    }),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.description_outlined,
                                          color: DCColor.gitcolor,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                          height: 50,
                                        ),
                                        Text(
                                          "지원서 작성",
                                          style: DCColor().boldFontBlack(
                                              20, FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0)),
                                        foregroundColor: DCColor.gitcolor),
                                    onPressed: (() {
                                      launchUrl(
                                        Uri.parse('https://codedc.co.kr/'),
                                      );
                                    }),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.web_outlined,
                                          color: DCColor.gitcolor,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                          height: 50,
                                        ),
                                        Text(
                                          "홈페이지",
                                          style: DCColor().boldFontBlack(
                                              20, FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0)),
                                        foregroundColor: DCColor.gitcolor),
                                    onPressed: (() async {
                                      Uri url = await kakao.TalkApi.instance
                                          .addChannelUrl('_jFsFxj');

                                      // 연결 페이지 URL을 브라우저에서 열기
                                      try {
                                        await kakao.launchBrowserTab(url);
                                      } catch (error) {
                                        print('카카오톡 채널 추가 실패 $error');
                                      }
                                    }),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.help_outline,
                                          color: DCColor.gitcolor,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                          height: 50,
                                        ),
                                        Text(
                                          "1 : 1 문의하기",
                                          style: DCColor().boldFontBlack(
                                              20, FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0)),
                                        foregroundColor: DCColor.gitcolor),
                                    onPressed: (() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const Terms(),
                                          ));
                                    }),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.policy_outlined,
                                          color: DCColor.gitcolor,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                          height: 50,
                                        ),
                                        Text(
                                          "약관확인",
                                          style: DCColor().boldFontBlack(
                                              20, FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(7),
                                                topLeft: Radius.circular(7))),
                                        foregroundColor: DCColor.gitcolor),
                                    onPressed: (() {
                                      UserAuthentication()
                                          .SignOutWithGoogle(context);
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
                                          style: DCColor().boldFontBlack(
                                              20, FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ]),
                      ],
                    ))),
          );
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
