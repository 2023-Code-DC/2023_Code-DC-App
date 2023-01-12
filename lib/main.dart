import 'package:code_dc/loading/main_loading.dart';
import 'package:code_dc/login_register/login.dart';
import 'package:code_dc/login_register/register.dart';
import 'package:code_dc/model/login_model.dart';
import 'package:code_dc/page/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'HomeScreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

GoogleSignInAccount? _currentUser;
User? user = FirebaseAuth.instance.currentUser;
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
  ;
  print('People API ${response.statusCode} response: ${response.body}');
  return;
}

Future<void> SignOutWithGoogle() => _googleSignIn.disconnect();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("앱이 시작됨");
  print(user);
  _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
    //현재 사용자가 변경 될때 실행됨
    _currentUser = account;
    if (_currentUser != null) {
      _handleGetContact(_currentUser!);
    }
  });
  _googleSignIn.signInSilently();
  //이전에 인증된 사용자로 로그인 시도
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData(
          textTheme: TextTheme(
              bodyText1: TextStyle(color: Colors.white),
              bodyText2: TextStyle(color: Colors.white))),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/mainloadingpage':
            return PageTransition(
              child: MainLoadingPage(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          case '/registerpage':
            return PageTransition(
                child: RegisterPage(),
                type: PageTransitionType.leftToRightWithFade,
                duration: Duration(milliseconds: 500),
                reverseDuration: Duration(milliseconds: 500),
                settings: settings);
          case '/loginpage':
            return PageTransition(
                child: LoginPage(),
                type: PageTransitionType.fade,
                duration: Duration(milliseconds: 500),
                reverseDuration: Duration(milliseconds: 500),
                settings: settings);
          case '/mainpage':
            return PageTransition(
                child: MainPage(
                  user: _currentUser,
                ),
                type: PageTransitionType.bottomToTop,
                duration: Duration(milliseconds: 500),
                reverseDuration: Duration(milliseconds: 500),
                settings: settings);
          default:
            return null;
        }
      },
    ),
  );
}
