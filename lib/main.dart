import 'package:code_dc/loading/main_loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'HomeScreen.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData(
          textTheme: TextTheme(
              bodyText1: TextStyle(color: Colors.white),
              bodyText2: TextStyle(color: Colors.white))),
      routes: {
        '/test': (BuildContext context) => TestPage(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/mainloadingpage':
            return PageTransition(
              child: MainLoadingPage(),
              type: PageTransitionType.fade,
              settings: settings,
            );
          default:
            return null;
        }
      },
    ),
  );
}
