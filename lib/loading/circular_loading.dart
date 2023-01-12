import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class CircularLoadingPage extends StatelessWidget {
  const CircularLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularLoadingPage()]),
    );
  }
}
