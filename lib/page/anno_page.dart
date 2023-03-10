import 'package:code_dc/model/color.dart';
import 'package:flutter/material.dart';

class AnnouncementDetailPage extends StatefulWidget {
  const AnnouncementDetailPage(
      {super.key, required this.title, required this.text, required this.day});
  final String title;
  final String text;
  final String day;

  @override
  State<AnnouncementDetailPage> createState() => _AnnouncementDetailPageState();
}

class _AnnouncementDetailPageState extends State<AnnouncementDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "공지사항",
          style: DCColor().boldFontBlack(18, FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: DCColor().boldFontBlack(22, FontWeight.w600),
                ),
                const SizedBox(
                  height: 8,
                  width: 6,
                ),
                Text(
                  widget.day,
                  style: DCColor().blodFontgrey(12, FontWeight.w500),
                ),
                const SizedBox(
                  width: 10,
                  height: 30,
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 10,
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: Text(
              widget.text,
            ),
          )
        ]),
      ),
    );
  }
}
