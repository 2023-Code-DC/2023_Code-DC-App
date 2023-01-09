import 'package:code_dc/model/color.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "동무!",
                  style: DCColor().boldFontBlack(30),
                ),
                Text(
                  "돌아온걸 환영합네다.",
                  style: DCColor().boldFontBlack(30),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
