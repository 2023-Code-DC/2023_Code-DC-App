import 'package:code_dc/model/color.dart';
import 'package:code_dc/model/data.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AskedPage extends StatefulWidget {
  const AskedPage({super.key});

  @override
  State<AskedPage> createState() => _AskedPageState();
}

class _AskedPageState extends State<AskedPage> {
  List<String> que = Quse().question();

  List<String> ans = Quse().answer();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text(
            "자주 묻는 질문",
            style: DCColor().boldFontBlack(18, FontWeight.w800),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: AnimationLimiter(
          child: ListView.builder(
            itemCount: que.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: ExpansionTile(
                          title: Text(
                            que[index],
                            style: DCColor().boldFontBlack(18, FontWeight.w700),
                          ),
                          children: [
                            ListTile(
                                title: Text(
                              ans[index],
                              style:
                                  DCColor().boldFontBlack(16, FontWeight.w500),
                            ))
                          ]),
                    ),
                  ));
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: DCColor.dcyellow,
          elevation: 0.5,
          focusElevation: 1,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("질문하기",
                      textAlign: TextAlign.center,
                      style: DCColor()
                          .boldFontBlack(size.width * 0.05, FontWeight.w700)),
                  actionsAlignment: MainAxisAlignment.spaceAround,
                  actions: [
                    ElevatedButton(
                        onPressed: (() {}),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: DCColor.dcyellow,
                        ),
                        child: Text(
                          "질문하기",
                          style: DCColor().boldFontBlack(
                              size.width * 0.05, FontWeight.w700),
                        )),
                    ElevatedButton(
                        onPressed: (() {}),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: DCColor.dcyellow,
                        ),
                        child: Text(
                          "문의 내역",
                          style: DCColor().boldFontBlack(
                              size.width * 0.05, FontWeight.w700),
                        ))
                  ],
                );
              },
            );
          },
          label: Text(
            "질문하기",
            style: DCColor().boldFontBlack(16, FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
