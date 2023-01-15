import 'package:flutter/material.dart';

class AskedPage extends StatelessWidget {
  const AskedPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
          child: Container(
        height: size.height,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "질문 페이지",
              style: TextStyle(color: Colors.white, fontSize: 30),
            )
          ],
        ),
      )),
    );
  }
}
