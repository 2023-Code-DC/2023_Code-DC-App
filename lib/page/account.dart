import 'package:code_dc/model/color.dart';
import 'package:code_dc/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountPage extends StatefulWidget {
  AccountPage({super.key});
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
      return AssetImage("assets/images/pepe.png");
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
                                        decoration: BoxDecoration(
                                          color: DCColor.backgroundcolor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(32.0),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              SizedBox(
                                                height: 20,
                                                width: 1,
                                              ),
                                              Text('메뉴',
                                                  textAlign: TextAlign.center,
                                                  style: DCColor()
                                                      .boldFontWhite(20)),
                                              ElevatedButton(
                                                  onPressed: (() {
                                                    UserAuthentication()
                                                        .SignOutWithGoogle(
                                                            context);
                                                    setState(() {});
                                                  }),
                                                  child: Text("로그아웃")),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }),
                              icon: Icon(
                                Icons.menu,
                                color: Colors.white,
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
                                style: DCColor().boldFontWhite(20),
                              ),
                              Text(user!.email.toString(),
                                  style: DCColor().boldFontWhite(20)),
                              Text("해킹보안과", style: DCColor().boldFontWhite(20))
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
