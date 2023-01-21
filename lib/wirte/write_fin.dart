import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:code_dc/model/color.dart';
import 'package:flutter/material.dart';

class WriteFinPage extends StatefulWidget {
  WriteFinPage({super.key, required this.name});
  String name;
  @override
  State<WriteFinPage> createState() => _WriteFinPageState();
}

class _WriteFinPageState extends State<WriteFinPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _aa = true;
      });
    });
    Timer(const Duration(seconds: 6), () {
      setState(() {
        _a = true;
      });
    });
  }

  bool _aa = false;
  bool _b = false;
  bool _a = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return Future(
          () => false,
        );
      },
      child: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            !_b && _aa == true
                ? DefaultTextStyle(
                    style: DCColor()
                        .boldFontBlack(size.width * 0.05, FontWeight.w700),
                    child: AnimatedTextKit(
                        isRepeatingAnimation: false,
                        animatedTexts: [
                          TyperAnimatedText("안녕하세요 ${widget.name}님",
                              speed: const Duration(milliseconds: 120)),
                          TyperAnimatedText('지원서 작성이 모두 완료되었나요?',
                              textAlign: TextAlign.center,
                              speed: const Duration(milliseconds: 120)),
                        ]))
                : SizedBox(),
            _b
                ? DefaultTextStyle(
                    style: DCColor()
                        .boldFontBlack(size.width * 0.05, FontWeight.w700),
                    child: AnimatedTextKit(
                        isRepeatingAnimation: false,
                        animatedTexts: [
                          TyperAnimatedText("신청서 작성이 정상적으로 완료되었습니다",
                              speed: const Duration(milliseconds: 120)),
                          TyperAnimatedText(
                              "신청서를 수정하고 싶으시면\n수정페이지에서 수정하실 수 있습니다",
                              textAlign: TextAlign.center,
                              speed: const Duration(milliseconds: 120)),
                          TyperAnimatedText('CODE D.C. 동아리에 지원해주셔서\n감사합니다!',
                              textAlign: TextAlign.center,
                              speed: const Duration(milliseconds: 120)),
                        ]))
                : SizedBox(),
            const SizedBox(
              width: 10,
              height: 30,
            ),
            _a && _b == false
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * 0.45,
                        child: ElevatedButton(
                          onPressed: (() {
                            Timer(const Duration(seconds: 1), () {
                              setState(() {
                                _b = true;
                              });
                            });
                            Timer(const Duration(seconds: 14), () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, "/mainpage", (route) => false);
                            });
                          }),
                          style: ElevatedButton.styleFrom(
                              shadowColor: const Color(0x00000000),
                              elevation: 0,
                              backgroundColor: DCColor.dcyellow,
                              minimumSize: const Size(330, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          child: Text(
                            "네",
                            style: DCColor().boldFontBlack(
                                size.width * 0.055, FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox()
          ],
        )),
      ),
    );
  }
}
