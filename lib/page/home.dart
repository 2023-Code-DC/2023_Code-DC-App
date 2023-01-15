import 'package:code_dc/model/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Timer? timer;
  PageController controller = PageController(
    initialPage: 0,
  );
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 4), (timer) {
      int currentPage = controller.page!.toInt();
      int nextPage = currentPage + 1;

      if (nextPage > 4) {
        nextPage = 0;
      }
      controller.animateToPage(nextPage,
          duration: Duration(milliseconds: 400), curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    emmmm() async {
      final storage = new FlutterSecureStorage();

      String? value = await storage.read(key: "login");
      print(value);
    }

    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
          child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              child: PageView(
                controller: controller,
                children: [1, 2, 3, 4, 5]
                    .map((e) => Container(
                        color: Colors.red,
                        child: Text(
                          e.toString(),
                          style: DCColor().boldFontWhite(30),
                        )))
                    .toList(),
              ),
            )
          ],
        ),
      )),
    );
  }
}
