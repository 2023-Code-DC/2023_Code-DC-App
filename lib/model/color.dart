import 'package:flutter/material.dart';

class DCColor {
  static const Color gitcolor = Color.fromRGBO(30, 35, 44, 1);
  static const Color dcyellow = Color.fromRGBO(255, 208, 41, 1);
  static const Color background = Color.fromRGBO(244, 248, 249, 1);
  boldFontBlack(double fontsize, FontWeight w) {
    return TextStyle(
        fontSize: fontsize,
        fontFamily: "inter",
        fontWeight: w,
        height: 1,
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

  boldFontYellow(double fontsize, FontWeight w) {
    return TextStyle(
        fontSize: fontsize,
        fontFamily: "inter",
        fontWeight: w,
        color: const Color.fromRGBO(255, 208, 41, 1));
  }

  textFieldDecoration(String text) {
    return InputDecoration(
        contentPadding: const EdgeInsets.all(8),
        filled: true,
        fillColor: const Color.fromRGBO(247, 248, 249, 1),
        hintText: text,
        hintStyle: const TextStyle(
            fontSize: 15,
            fontFamily: "inter",
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(131, 145, 161, 1)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Color.fromRGBO(218, 218, 218, 1),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Color.fromRGBO(218, 218, 218, 1),
          ),
        ),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Colors.red,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8))));
  }

  dropdownButtonFormField() {
    return const InputDecoration(
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: Color.fromRGBO(218, 218, 218, 1),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
    );
  }
}
