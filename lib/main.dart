import 'package:code_dc/loading/main_loading.dart';
import 'package:code_dc/login_register/login.dart';
import 'package:code_dc/login_register/register.dart';
import 'package:code_dc/modify/modify_main.dart';
import 'package:code_dc/page/application.dart';
import 'package:code_dc/page/main_page.dart';
import 'package:code_dc/wirte/write_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import 'firebase_options.dart';
import 'homescreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/services.dart';

User? user = FirebaseAuth.instance.currentUser;
dynamic firstStrat;

void main() async {
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  kakao.KakaoSdk.init(
    nativeAppKey: '245a8022cd30a514b0843483c584d9f6',
    javaScriptAppKey: '08cd1575234813e9fc1337bb9385a490',
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );
  runApp(
    MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      routes: {
        '/homescreen': (BuildContext context) => const HomeScreen(),
        '/mainloadingpage': ((context) => const MainLoadingPage()),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/registerpage':
            return PageTransition(
                child: const RegisterPage(),
                type: PageTransitionType.leftToRightWithFade,
                duration: const Duration(milliseconds: 500),
                reverseDuration: const Duration(milliseconds: 500),
                settings: settings);
          case '/loginpage':
            return PageTransition(
                child: const LoginPage(),
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 500),
                reverseDuration: const Duration(milliseconds: 500),
                settings: settings);
          case '/mainpage':
            return PageTransition(
                child: const MainPage(),
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 500),
                reverseDuration: const Duration(milliseconds: 500),
                settings: settings);
          case '/applicationpage':
            return PageTransition(
                child: const ApplicationPage(),
                type: PageTransitionType.rightToLeft,
                duration: const Duration(milliseconds: 200),
                reverseDuration: const Duration(milliseconds: 200),
                settings: settings);
          case '/writeformpage':
            return PageTransition(
                child: const FormWritePage(),
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 200),
                reverseDuration: const Duration(milliseconds: 200),
                settings: settings);
          case '/modifyformpage':
            return PageTransition(
                child: const ModifyFormPage(),
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 200),
                reverseDuration: const Duration(milliseconds: 200),
                settings: settings);
          default:
            return null;
        }
      },
    ),
  );
}
