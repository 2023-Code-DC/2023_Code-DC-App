import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DCColor {
  static const Color backgroundcolor = Color.fromRGBO(30, 35, 44, 1);
  static const Color dcyellow = Color.fromRGBO(255, 208, 41, 1);
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
