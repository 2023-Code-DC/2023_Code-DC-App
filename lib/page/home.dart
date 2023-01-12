import 'package:code_dc/model/color.dart';
import 'package:code_dc/model/login_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
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
                }),
                child: Text("로그아웃")),
            ElevatedButton(
                onPressed: (() {
                  final _authentication = FirebaseAuth.instance.currentUser;
                  print(_authentication);
                  setState(() {});
                }),
                child: Text("현재상태"))
          ],
        ),
      )),
    );
  }
}
