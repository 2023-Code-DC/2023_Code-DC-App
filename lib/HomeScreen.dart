import 'package:code_dc/model/color.dart';
import 'package:code_dc/page/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DCColor.backgroundcolor,
      body: UserPage(),
    );
  }
}

class UserPage extends StatelessWidget {
  UserPage({super.key});
  final _authentication = FirebaseAuth.instance;
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await _authentication.signInWithCredential(credential);
  }

  void SignOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    if (_authentication == null) {
      return Center(
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
                SignOut();
              }),
              child: Text("로그아웃")),
          ElevatedButton(
              onPressed: (() {
                print(_authentication.currentUser?.displayName);
              }),
              child: Text("확인"))
        ],
      ));
    } else {
      return MainPage();
    }
  }
}
