import 'package:code_dc/model/color.dart';
import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        "코드디씨에서는 \n약관따위는 필요없습니다.",
        textAlign: TextAlign.center,
        style: DCColor().boldFontBlack(30, FontWeight.w700),
      )),
    );
  }
}
