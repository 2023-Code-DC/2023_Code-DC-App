import 'dart:math';

import 'package:code_dc/model/color.dart';
import 'package:code_dc/model/dcfirestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountPage extends StatefulWidget {
  AccountPage({super.key, required this.SignOut, required this.user});

  final SignOut;
  GoogleSignInAccount user;
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final firestore = FirebaseFirestore.instance;
  bool imageTF = false;
  String imagePath = "";
  ImageProvider<Object> avatorImage() {
    if (!imageTF) {
      return AssetImage("assets/images/pepe.png");
    } else {
      return NetworkImage(imagePath);
    }
  }

  getdata() async {
    var result =
        await firestore.collection('userdata').doc(widget.user.id).get();
    imagePath = result["image"];
    if (imagePath != "none") {
      setState(() {
        imageTF = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
      child: Container(
        width: double.infinity,
        height: size.height,
        child: Column(children: [
          ElevatedButton(
              onPressed: () {
                print(widget.user);
                UserData().addData(widget.user);
              },
              child: Text("adddata")),
          ElevatedButton(
              onPressed: () {
                UserData().getData(widget.user, "image").toString();
              },
              child: Text("getdata")),
          ElevatedButton(
              onPressed: () {
                widget.SignOut();
              },
              child: Text("로그아웃")),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: avatorImage(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.user.displayName.toString()),
                  Text(widget.user.email)
                ],
              )
            ],
          )
        ]),
      ),
    ));
  }
}
