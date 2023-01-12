import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:device_info_plus/device_info_plus.dart';

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

  DeviceAddData(
    String displayName,
    String name,
    String email,
    String image,
  ) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}');
    print(androidInfo.id);
    final userdata = {
      "displayName": displayName,
      "name": displayName,
      "email": email,
      "image": image
    };
    firestore.collection("userdata").doc(androidInfo.id).set(userdata);
  }
}
