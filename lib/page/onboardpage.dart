import 'package:code_dc/model/color.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final storage = const FlutterSecureStorage();
  fisrt() async {
    await storage.write(key: "first", value: "false");
  }

  @override
  void initState() {
    super.initState();
    fisrt();
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        //PageViewModel로 해도 되고 Widget 만들어서 해도 될듯?
        PageViewModel(
          title: "개발자를 꿈꾸고 계신가요?",
          body: "코드디씨는 교내 개발동아리로 재학생이라면\n 누구나 지원할 수 있습니다.",
          image: Image.asset('assets/images/boarding1.png'),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "코드디씨의 운영방향",
          body:
              "기초향상 -> 개인 과제 -> 팀 프로젝트 순으로\n기초적인 프로그래밍 실력을 학습 한 이후\n실제 프로젝트를 진행합니다.",
          image: Image.asset('assets/images/boarding2.png'),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "류재희를 알고계신가요?",
          body: "진짜 굉장할껄요?",
          image: Image.asset('assets/images/boarding3.png'),
          decoration: getPageDecoration(),
        ),
      ],
      done: Text("완료", style: DCColor().boldFontWhite(18, FontWeight.w600)),
      onDone: () {
        Navigator.of(context).pushReplacementNamed("/mainpage");
      }, //done을 누르면 실행되는거(마지막 페이지에서 나옴)
      globalBackgroundColor: const Color.fromRGBO(30, 35, 44, 1),
      next: Text("다음",
          style:
              DCColor().boldFontWhite(18, FontWeight.w600)), //Next 버튼 아이콘으로 됨
      showSkipButton: false,
      showBackButton: true,
      baseBtnStyle: TextButton.styleFrom(
        foregroundColor: Colors.black,
      ),
      back: Text(
        "이전",
        style: DCColor().boldFontWhite(18, FontWeight.w600),
      ), //스킵버튼 문구 지정
      dotsContainerDecorator: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white, width: 0.8))),
      dotsDecorator: DotsDecorator(
        color: Colors.white,
        size: const Size(10, 10), //점 사이즈
        activeSize: const Size(22, 10), //현재 활성화된 점 사이즈
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),

        activeColor: DCColor.dcyellow, //밑에 활성화된 점 색상
      ),
      curve: Curves.ease, //페이지 넘김 효과
    );
  }

  PageDecoration getPageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
      bodyTextStyle: TextStyle(fontSize: 18, color: Colors.white),
      imagePadding: EdgeInsets.only(top: 40),
      pageColor: Color.fromRGBO(30, 35, 44, 1),
    );
  }
}
