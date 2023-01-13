import 'package:code_dc/model/dcfirestore.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final storage = new FlutterSecureStorage();
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
          title: "Title!",
          body: "This is body!\n" "first page!!",
          image: Image.asset('assets/images/pepe.png'),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "Title!",
          body: "This is body!\n" "second page!!",
          image: Image.asset('assets/images/pepe.png'),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "Title!",
          body: "This is body!\n" "third page!!",
          image: Image.asset('assets/images/pepe.png'),
          decoration: getPageDecoration(),
        ),
      ],
      done: const Text("done"),
      onDone: () {
        Navigator.of(context).pushReplacementNamed("/mainpage");
      }, //done을 누르면 실행되는거(마지막 페이지에서 나옴)
      next: const Icon(Icons.arrow_forward), //Next 버튼 아이콘으로 됨
      showSkipButton: true, //스킵버튼 True로 활성화
      skip: const Text("Skip"), //스킵버튼 문구 지정
      dotsDecorator: DotsDecorator(
        color: Colors.cyan,
        size: const Size(10, 10), //점 사이즈
        activeSize: const Size(22, 10), //현재 활성화된 점 사이즈
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        activeColor: Colors.red, //밑에 활성화된 점 색상
      ),
      curve: Curves.bounceOut, //페이지 넘김 효과
    );
  }

  PageDecoration getPageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      bodyTextStyle: TextStyle(fontSize: 18, color: Colors.blue),
      imagePadding: EdgeInsets.only(top: 40),
      pageColor: Colors.orange,
    );
  }
}
