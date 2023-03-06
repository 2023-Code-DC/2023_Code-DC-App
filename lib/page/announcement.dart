import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_dc/model/color.dart';
import 'package:code_dc/page/anno_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnnouncementPage extends StatefulWidget {
  AnnouncementPage({
    super.key,
    required this.text,
    required this.title,
    required this.day,
  });
  List<String> text;
  List<String> title;
  List<String> day;
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
    List<String> notice_text = [];
    List<String> notice_day = [];
    List<String> notice_title = [];
    for (var i = 0; i < docs.length; i++) {
      DocumentSnapshot<Map<String, dynamic>> result =
          await firestore.collection('notice').doc(docs[i]).get();
      notice_text.add(result["내용"]);
      notice_day.add(result["날짜"]);
      notice_title.add(result["제목"]);
      widget.text = notice_text;
      widget.day = notice_day;
      widget.title = notice_title;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          "공지사항",
          style: DCColor().boldFontBlack(18, FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: AnimationLimiter(
          child: ListView.builder(
            itemCount: widget.text.length,
            itemBuilder: (context, index) {
              List<String> retext = List.from(widget.text.reversed);
              List<String> retitle = List.from(widget.title.reversed);
              List<String> reday = List.from(widget.day.reversed);

              String text = retext[index];
              String title = retitle[index];
              String day = reday[index];
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return AnnouncementDetailPage(
                                text: text,
                                day: day,
                                title: title,
                              );
                            },
                          ));
                        },
                        title: Text(
                          title,
                          style: DCColor().boldFontBlack(18, FontWeight.w700),
                        ),
                        subtitle: Text(
                          day,
                          style: DCColor().blodFontgrey(12, FontWeight.w500),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
