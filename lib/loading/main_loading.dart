import 'package:code_dc/model/color.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MainLoadingPage extends StatefulWidget {
  const MainLoadingPage({super.key});

  @override
  State<MainLoadingPage> createState() => _MainLoadingPageState();
}

class _MainLoadingPageState extends State<MainLoadingPage> {
  final storage = new FlutterSecureStorage();
  dynamic userInfo;
  _asyncMethod() async {
    userInfo = await storage.read(key: 'login');
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 400), () {
      setState(() {
        _a = true;
        _asyncMethod();
      });
    });
    Timer(Duration(milliseconds: 400), () {
      setState(() {
        _b = true;
      });
    });
    Timer(Duration(milliseconds: 1300), () {
      setState(() {
        _c = true;
      });
    });
    Timer(Duration(milliseconds: 1700), () {
      setState(() {
        _e = true;
      });
    });
    Timer(Duration(milliseconds: 3400), () {
      setState(() {
        _d = true;
      });
    });
    Timer(Duration(milliseconds: 3850), () {
      setState(() {
        Navigator.popAndPushNamed(
            context, userInfo != null ? "/mainpage" : "/loginpage");
      });
    });
  }

  bool _a = false;
  bool _b = false;
  bool _c = false;
  bool _d = false;
  bool _e = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: (() {
        return Future(() => false);
      }),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: _d ? 900 : 2500),
                curve: _d ? Curves.fastLinearToSlowEaseIn : Curves.elasticOut,
                height: _d
                    ? 0
                    : _a
                        ? _h / 2
                        : 20,
                width: 20,
                // color: Colors.deepPurpleAccent,
              ),
              AnimatedContainer(
                duration: Duration(
                    seconds: _d
                        ? 1
                        : _c
                            ? 2
                            : 0),
                curve: Curves.fastLinearToSlowEaseIn,
                height: _d
                    ? _h
                    : _c
                        ? 80
                        : 20,
                width: _d
                    ? _w
                    : _c
                        ? 200
                        : 20,
                decoration: BoxDecoration(
                    color: _b ? Colors.white : Colors.transparent,
                    borderRadius:
                        _d ? BorderRadius.only() : BorderRadius.circular(30)),
                child: Center(
                  child: _e
                      ? AnimatedTextKit(
                          totalRepeatCount: 1,
                          animatedTexts: [
                            FadeAnimatedText('동무 어서오라우!',
                                duration: Duration(milliseconds: 1700),
                                textStyle: DCColor()
                                    .boldFontBlack(24, FontWeight.w600)),
                          ],
                        )
                      : SizedBox(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
