import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_dc/model/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

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
    return Scaffold(
      body: RefreshIndicator(
          child: AnimationLimiter(
            child: ListView.builder(
              itemCount: widget.list.length,
              itemBuilder: (context, index) {
                final item = widget.list[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Text(
                        item,
                        style: DCColor().boldFontBlack(20, FontWeight.w700),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          onRefresh: onRefresh),
    );
  }
}
