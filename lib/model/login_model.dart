import 'package:code_dc/model/color.dart';
import 'package:code_dc/model/dcfirestore.dart';
import 'package:code_dc/page/home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();
GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);
final Already = SnackBar(
  backgroundColor: DCColor.backgroundcolor,
  content: Text("이미 존재하는 전자우편이라우 동무", style: DCColor().boldFontWhite(20)),
  duration: Duration(seconds: 2),
);
final UserNotFound = SnackBar(
  backgroundColor: DCColor.backgroundcolor,
  content: Text("동무는 당원신청서를 작성하라우", style: DCColor().boldFontWhite(20)),
  duration: Duration(seconds: 2),
);
final WrongPassword = SnackBar(
  backgroundColor: DCColor.backgroundcolor,
  content: Text("동무 통과암호가 틀리다우", style: DCColor().boldFontWhite(20)),
  duration: Duration(seconds: 2),
);
final InvalidEmail = SnackBar(
  backgroundColor: DCColor.backgroundcolor,
  content: Text("동무 이메일이 틀리다우", style: DCColor().boldFontWhite(20)),
  duration: Duration(seconds: 2),
);

class UserAuthentication {
  signInWithGoogle(BuildContext context) async {
    await storage.write(key: "login", value: "google");
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    Navigator.pushNamed(context, "/mainpage");
    print(googleUser);
    return googleUser;
  }

  Future<void> SignOutWithGoogle() async {
    final _authentication = FirebaseAuth.instance;
    String? logindata = await storage.read(key: 'login');
    _authentication.signOut();
    print(logindata);
    await storage.delete(key: "login");
  }

  CreateWithDevice(BuildContext context, String username, String userEmail,
      String userPassword) async {
    final _authentication = FirebaseAuth.instance;
    try {
      final newUser = await _authentication.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);
      UserData().DeviceAddData(username, username, userEmail, "none");
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        ScaffoldMessenger.of(context).showSnackBar(Already);
      } else {
        print(e);
      }
    }
  }

  SiginInWithDevice(BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushNamed(context, "/mainpage");
      await storage.write(key: "login", value: "device");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(UserNotFound);
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(WrongPassword);
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(InvalidEmail);
      }
    }
  }
}
