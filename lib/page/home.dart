import 'package:code_dc/model/login_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    emmmm() async {
      final storage = new FlutterSecureStorage();

      String? value = await storage.read(key: "login");
      print(value);
    }

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
          child: Container(
        height: size.height,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "홈 화면",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            ElevatedButton(
                onPressed: (() {
                  UserAuthentication().SignOutWithGoogle(context);
                  setState(() {});
                }),
                child: Text("로그아웃")),
            ElevatedButton(
                onPressed: (() {
                  final _authentication = FirebaseAuth.instance.currentUser;
                  print(_authentication);
                  emmmm();
                  setState(() {});
                }),
                child: Text("현재상태")),
            ElevatedButton(
                onPressed: (() async {
                  final storage = new FlutterSecureStorage();
                  await storage.delete(key: "first");
                  String? value = await storage.read(key: "first");

                  print(value);
                }),
                child: Text("온보딩 토큰 삭제"))
          ],
        ),
      )),
    );
  }
}
