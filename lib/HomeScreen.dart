import 'package:code_dc/model/color.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        height: double.infinity,
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "동무!",
                  style: DCColor().boldFontBlack(30, FontWeight.w600),
                ),
                Text(
                  "동무를 찾고있었습네다.",
                  style: DCColor().boldFontBlack(30, FontWeight.w600),
                ),
                const SizedBox(
                  width: 1,
                  height: 6,
                ),
                Text("발신 -코드디씨-",
                    style: DCColor().boldFontBlack(16, FontWeight.w600))
              ]),
              Center(
                child: Image.asset(
                  "assets/images/logo.png",
                  scale: size.width * 0.001,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        minimumSize: const Size(330, 56),
                        backgroundColor: DCColor.gitcolor),
                    onPressed: (() {
                      Navigator.popAndPushNamed(context, "/mainloadingpage");
                    }),
                    child: Text(
                      "단추 눌러 동무 되기",
                      style: DCColor().boldFontWhite(15, FontWeight.w600),
                    )),
              )
            ]),
      ),
    );
  }
}
