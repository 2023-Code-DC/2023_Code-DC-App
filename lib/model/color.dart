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

  loginGOregFontBlack(double fontsize) {
    return TextStyle(
        fontSize: fontsize,
        fontFamily: "urbanist",
        fontWeight: FontWeight.w700,
        color: Colors.black);
  }

  blodFontgrey(double fontsize) {
    return TextStyle(
        fontSize: fontsize,
        fontFamily: "urbanist",
        fontWeight: FontWeight.w700,
        color: const Color.fromRGBO(106, 112, 124, 1));
  }
}
