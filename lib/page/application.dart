import 'package:code_dc/model/color.dart';
import 'package:flutter/material.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: DCColor.background,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "신청서 페이지",
                    style: DCColor()
                        .boldFontBlack(size.width * 0.07, FontWeight.w800),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: size.height * 0.4,
                        width: size.width * 0.43,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(217, 217, 217, 1),
                                width: 2),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      Container(
                        height: size.height * 0.4,
                        width: size.width * 0.43,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromRGBO(217, 217, 217, 1),
                                width: 2),
                            borderRadius: BorderRadius.circular(12)),
                      )
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromRGBO(217, 217, 217, 1), width: 2),
                        borderRadius: BorderRadius.circular(12)),
                    width: double.infinity,
                    height: size.height * 0.25,
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
