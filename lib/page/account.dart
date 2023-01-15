import 'package:code_dc/model/color.dart';
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
            padding: const EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
            child: Container(
              width: double.infinity,
              height: size.height,
              child: Column(children: [
                ElevatedButton(
                    onPressed: (() {
                      print(user);
                    }),
                    child: Text("ㅁㄴㅇ")),
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
                        style: DCColor().boldFontWhite(20))
                  ],
                ),
                Drawer()
              ]),
            ),
          ));
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
