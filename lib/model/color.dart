import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DCColor {
  static const Color backgroundcolor = Color.fromARGB(255, 13, 17, 23);
  static const Color dcyellow = Color.fromARGB(255, 255, 200, 0);
  boldFontBlack(double fontsize) {
    return TextStyle(
        fontSize: fontsize,
        fontFamily: "urbanist",
        fontWeight: FontWeight.w600,
        color: Colors.black);
  }

  boldFontWhite(double fontsize) {
    return TextStyle(
        fontSize: fontsize,
        fontFamily: "urbanist",
        fontWeight: FontWeight.w600,
        color: Colors.white);
  }
}
