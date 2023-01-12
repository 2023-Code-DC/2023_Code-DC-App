import 'package:code_dc/HomeScreen.dart';
import 'package:code_dc/model/login_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
                  UserAuthentication().SignOutWithGoogle();
                  setState(() {});
                  Navigator.popAndPushNamed(context, "/homescreen");
                }),
                child: Text("로그아웃")),
            ElevatedButton(
                onPressed: (() {
                  final _authentication = FirebaseAuth.instance.currentUser;
                  print(_authentication);
                  emmmm();
                  setState(() {});
                }),
                child: Text("현재상태"))
          ],
        ),
      )),
    );
  }
}
