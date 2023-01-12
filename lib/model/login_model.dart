import 'package:code_dc/model/color.dart';
import 'package:code_dc/model/dcfirestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _authentication = FirebaseAuth.instance;
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

class UserAuthentication {
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

  siginInWithDevice(BuildContext context, String username, String userEmail,
      String userPassword) async {
    try {
      final newUser = await _authentication.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);
      UserData().DeviceAddData(username, username, userEmail, "none");
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        ScaffoldMessenger.of(context).showSnackBar(Already);
      } else {
        print(e);
      }
    }
  }
}
