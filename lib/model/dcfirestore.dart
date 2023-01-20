import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firestore = FirebaseFirestore.instance;

class UserData {
  getData(User? user, String data) async {
    var result = await firestore.collection('userdata').doc(user!.uid).get();
    return result["image"];
  }

  firstData() {
    User? user = FirebaseAuth.instance.currentUser;
    final userdata = {
      "displayName": user!.displayName,
      "name": user.displayName,
      "email": user.email,
      "image": user.photoURL,
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
      "image": image,
    };
    firestore.collection("userdata").doc(user?.uid).set(userdata);
  }

  firstForm(String name, String number) {
    User? user = FirebaseAuth.instance.currentUser;
    final form = {
      "동기": "동기글",
      "이름": name,
      "자기소개": "자기소개",
      "전화번호": number,
      "포부": "포부",
      "학번": "학번",
    };
    firestore.collection("Form").doc(user!.uid).set(form);
  }

  schoolIDForm(String id) {
    User? user = FirebaseAuth.instance.currentUser;
    final form = {
      "학번": id,
    };
    firestore.collection("Form").doc(user!.uid).update(form);
  }

  introduceForm(String myself) {
    User? user = FirebaseAuth.instance.currentUser;
    final form = {
      "자기소개": myself,
    };
    firestore.collection("Form").doc(user!.uid).update(form);
  }

  motiveForm(String motive) {
    User? user = FirebaseAuth.instance.currentUser;
    final form = {
      "동기": motive,
    };
    firestore.collection("Form").doc(user!.uid).update(form);
  }

  planForm(String plan) {
    User? user = FirebaseAuth.instance.currentUser;
    final form = {
      "동기": plan,
    };
    firestore.collection("Form").doc(user!.uid).update(form);
  }
}
