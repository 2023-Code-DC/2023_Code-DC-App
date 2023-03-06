import 'package:code_dc/loading/main_loading.dart';
import 'package:code_dc/login_register/login.dart';
import 'package:code_dc/login_register/register.dart';
import 'package:code_dc/model/data.dart';
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
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

GoogleSignInAccount? _currentUser;
User? user = FirebaseAuth.instance.currentUser;
dynamic firstStrat;

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);
Future<void> _handleGetContact(GoogleSignInAccount user) async {
  final http.Response response = await http.get(
    Uri.parse('https://people.googleapis.com/v1/people/me/connections'
        '?requestMask.includeField=person.names'),
    headers: await user.authHeaders,
  );
  if (response.statusCode != 200) {
    print('People API gave a ${response.statusCode} '
        'response. Check logs for details.');
    //오류 메시지
  }

  print('People API ${response.statusCode} response: ${response.body}');
  return;
}

Future<void> SignOutWithGoogle() => _googleSignIn.disconnect();
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
  print("앱이 시작됨");
  runApp(
    MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      routes: {
        '/homescreen': (BuildContext context) => HomeScreen(),
        '/mainloadingpage': ((context) => MainLoadingPage()),
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
                child: LoginPage(),
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 500),
                reverseDuration: const Duration(milliseconds: 500),
                settings: settings);
          case '/mainpage':
            return PageTransition(
                child: MainPage(
                  user: _currentUser,
                ),
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
