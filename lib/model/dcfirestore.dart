import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

final firestore = FirebaseFirestore.instance;

class UserData {
  getData(GoogleSignInAccount user, String data) async {
    var result = await firestore.collection('userdata').doc(user.id).get();
    print(result["email"]);
    print(result["image"]);
    print(result["image"].runtimeType);
    return result["image"];
  }

  addData(GoogleSignInAccount user) async {
    final userdata = {
      "displayName": user.displayName.toString(),
      "name": user.displayName.toString(),
      "email": user.email,
      "image": user.photoUrl != null ? user.photoUrl.toString() : "none"
    };
    firestore.collection("userdata").doc(user.id).set(userdata);
  }
}
