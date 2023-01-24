import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AnnouncementPage extends StatefulWidget {
  AnnouncementPage({super.key, required this.list});
  List<String> list;
  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  User? user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;
  Future onRefresh() async {
    List<String> docs = [];
    QuerySnapshot<Map<String, dynamic>> doc =
        await firestore.collection('notice').get();
    for (var index in doc.docs) {
      docs.add(index.id);
    }
    List<String> notice = [];
    for (var i = 0; i < docs.length; i++) {
      DocumentSnapshot<Map<String, dynamic>> result =
          await firestore.collection('notice').doc(docs[i]).get();
      notice.add(result["내용"]);
      setState(() {
        widget.list = notice;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
        child: ListView.builder(
          itemCount: widget.list.length,
          itemBuilder: (context, index) {
            final item = widget.list[index];
            return ListTile(
              title: Text(item),
            );
          },
        ),
        onRefresh: onRefresh);
  }
}
