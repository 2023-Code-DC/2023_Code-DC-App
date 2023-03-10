// ignore_for_file: avoid_print

import 'package:code_dc/model/color.dart';
import 'package:code_dc/model/dcfirestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();
GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);
final already = SnackBar(
  backgroundColor: DCColor.gitcolor,
  content: Text("이미 존재하는 전자우편이라우 동무",
      style: DCColor().boldFontWhite(20, FontWeight.w600)),
  duration: const Duration(seconds: 2),
);
final userNotFound = SnackBar(
  backgroundColor: DCColor.gitcolor,
  content: Text("동무는 당원신청서를 작성하라우",
      style: DCColor().boldFontWhite(20, FontWeight.w600)),
  duration: const Duration(seconds: 2),
);
final wrongPassword = SnackBar(
  backgroundColor: DCColor.gitcolor,
  content: Text("동무 통과암호가 틀리다우",
      style: DCColor().boldFontWhite(20, FontWeight.w600)),
  duration: const Duration(seconds: 2),
);
final invalidEmail = SnackBar(
  backgroundColor: DCColor.gitcolor,
  content:
      Text("동무 이메일이 틀리다우", style: DCColor().boldFontWhite(20, FontWeight.w600)),
  duration: const Duration(seconds: 2),
);

class UserAuthentication {
  signInWithGoogle(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    await storage.write(key: "login", value: "google");

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    print(user);
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) async {
      Navigator.popAndPushNamed(context, "/mainpage");
    });
  }

  signOutWithGoogle(BuildContext context) async {
    final authentication = FirebaseAuth.instance;
    String? logindata = await storage.read(key: 'login');
    if (logindata == "device") {
      authentication.signOut();
    } else {
      _googleSignIn.disconnect();
    }
    try {
      Navigator.popAndPushNamed(context, "/homescreen");
    } catch (e) {
      print(e);
    }

    await storage.delete(key: "login");
  }

  createWithDevice(BuildContext context, String username, String userEmail,
      String userPassword) async {
    final authentication = FirebaseAuth.instance;
    try {
      UserData().deviceAddData(username, username, userEmail, "none");

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        ScaffoldMessenger.of(context).showSnackBar(already);
      } else {
        print(e);
      }
    }
  }

  siginInWithDevice(BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => Navigator.popAndPushNamed(context, "/mainpage"));

      await storage.write(key: "login", value: "device");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(userNotFound);
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(wrongPassword);
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(invalidEmail);
      }
    }
  }
}
