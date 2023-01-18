import 'package:flutter/material.dart';

class DCColor {
  static const Color gitcolor = Color.fromRGBO(30, 35, 44, 1);
  static const Color dcyellow = Color.fromRGBO(255, 208, 41, 1);
  static const Color background = Color.fromARGB(255, 245, 246, 247);
  boldFontBlack(double fontsize, FontWeight w) {
    return TextStyle(
        fontSize: fontsize,
        fontFamily: "inter",
        fontWeight: w,
        color: Colors.black);
  }

  boldFontWhite(double fontsize, FontWeight w) {
    return TextStyle(
      fontSize: fontsize,
      fontFamily: "inter",
      fontWeight: w,
      color: Colors.white,
    );
  }

  loginGOregFontBlack(double fontsize) {
    return TextStyle(
        fontSize: fontsize,
        fontFamily: "inter",
        fontWeight: FontWeight.w700,
        color: Colors.black);
  }

  blodFontgrey(double fontsize) {
    return TextStyle(
        fontSize: fontsize,
        fontFamily: "inter",
        fontWeight: FontWeight.w700,
        color: const Color.fromRGBO(106, 112, 124, 1));
  }
}
