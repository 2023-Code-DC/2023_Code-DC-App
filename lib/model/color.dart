import 'package:flutter/material.dart';

class DCColor {
  static const Color gitcolor = Color.fromRGBO(30, 35, 44, 1);
  static const Color dcyellow = Color.fromRGBO(255, 208, 41, 1);
  static const Color background = Color.fromRGBO(228, 229, 229, 1);
  static const Color strokecolor2 = Color.fromRGBO(242, 242, 243, 1);
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

  blodFontgrey(double fontsize, FontWeight w) {
    return TextStyle(
        fontSize: fontsize,
        fontFamily: "inter",
        fontWeight: w,
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
            color: DCColor.strokecolor2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: DCColor.strokecolor2,
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
          color: Color.fromRGBO(217, 217, 217, 1),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
    );
  }

  modifyMainMenuContainer(String str, Size size) {
    return Container(
      height: size.height * 0.08,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: const Color.fromRGBO(217, 217, 217, 1), width: 2),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Text(
            str,
            style: DCColor().boldFontBlack(size.width * 0.05, FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
