import 'package:code_dc/loading/main_loading.dart';
import 'package:code_dc/model/color.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        height: double.infinity,
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "동무!",
                  style: DCColor().boldFontBlack(30),
                ),
                Text(
                  "동무를 찾고있었습네다.",
                  style: DCColor().boldFontBlack(30),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("발신 -코드디씨-", style: DCColor().boldFontBlack(16)),
                    ],
                  ),
                )
              ]),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        minimumSize: Size(330, 56),
                        backgroundColor: DCColor.backgroundcolor),
                    onPressed: (() {
                      Navigator.popAndPushNamed(context, "/mainloadingpage");
                    }),
                    child: Text(
                      "단추 눌러 동무 되기",
                      style: DCColor().boldFontWhite(15),
                    )),
              )
            ]),
      ),
    );
  }
}
