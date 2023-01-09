import 'package:code_dc/model/color.dart';
import 'package:code_dc/model/dcfirestore.dart';
import 'package:code_dc/page/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleSignInAccount? _currentUser;
  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      //현재 사용자가 변경 될때 실행됨
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact(_currentUser!);
      }
    });
    _googleSignIn.signInSilently();
    //이전에 인증된 사용자로 로그인 시도
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        print('People API gave a ${response.statusCode} '
            'response. Check logs for details.');
        //오류 메시지
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> SignOutWithGoogle() => _googleSignIn.disconnect();
  //로그아웃

  @override
  Widget build(BuildContext context) {
    return _currentUser != null
        ? MainPage(
            SignOut: SignOutWithGoogle,
            user: _currentUser,
          )
        : Scaffold(
            backgroundColor: DCColor.backgroundcolor,
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text("가입"),
                  onPressed: (() {
                    signInWithGoogle();
                  }),
                ),
                ElevatedButton(
                    onPressed: (() {
                      SignOutWithGoogle();
                    }),
                    child: Text("로그아웃")),
                ElevatedButton(
                    onPressed: (() {
                      print('name = ${_currentUser?.displayName}');
                      print('email = ${_currentUser?.email}');
                      print('id = ${_currentUser?.id}');
                      print('id = ${_currentUser?.photoUrl}');
                    }),
                    child: Text("확인"))
              ],
            )),
          );
  }
}
