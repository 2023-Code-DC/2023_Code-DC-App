import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:device_info_plus/device_info_plus.dart';

final firestore = FirebaseFirestore.instance;

class UserData {
  getData(User? user, String data) async {
    var result = await firestore.collection('userdata').doc(user!.uid).get();
    print(result["email"]);
    print(result["image"]);
    print(result["image"].runtimeType);
    return result["image"];
  }

  addData(User? user) async {
    final userdata = {
      "displayName": user!.displayName.toString(),
      "name": user.displayName.toString(),
      "email": user.email,
      "image": user.photoURL != null ? user.photoURL.toString() : "none"
    };
    firestore.collection("userdata").doc(user.uid).set(userdata);
  }

  DeviceAddData(
    String displayName,
    String name,
    String email,
    String image,
  ) async {
    User? user = FirebaseAuth.instance.currentUser;
    final userdata = {
      "displayName": displayName,
      "name": displayName,
      "email": email,
      "image": image
    };
    firestore.collection("userdata").doc(user?.uid).set(userdata);
  }
}
