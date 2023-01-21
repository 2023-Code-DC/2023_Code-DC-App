import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_dc/model/color.dart';
import 'package:code_dc/modify/modify_intome.dart';
import 'package:code_dc/modify/modify_motive.dart';
import 'package:code_dc/modify/modify_name.dart';
import 'package:code_dc/modify/modify_plan.dart';
import 'package:code_dc/modify/modify_student.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ModifyFormPage extends StatefulWidget {
  const ModifyFormPage({super.key});

  @override
  State<ModifyFormPage> createState() => _ModifyFormPageState();
}

class _ModifyFormPageState extends State<ModifyFormPage> {
  late DocumentSnapshot<Map<String, dynamic>> result;
  User? user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;
  Future getdata() async {
    result = await firestore.collection('Form').doc(user!.uid).get();
    return result == null ? null : "true";
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
        future: getdata(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Column(children: [
                  Row(
                    children: [
                      IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back)),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                    height: 30,
                  ),
                  Text(
                    "신청서 수정 페이지",
                    style: DCColor()
                        .boldFontBlack(size.width * 0.072, FontWeight.w700),
                  ),
                  const SizedBox(
                    width: 10,
                    height: 40,
                  ),
                  InkWell(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  ModifyNamePage(result: result))));
                    }),
                    child: Container(
                      height: size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color.fromRGBO(217, 217, 217, 1),
                              width: 2),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "개인정보 수정하기",
                          style: DCColor().boldFontBlack(
                              size.width * 0.05, FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                    height: 45,
                  ),
                  InkWell(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  ModifyStudentPage(result: result))));
                    }),
                    child: Container(
                      height: size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color.fromRGBO(217, 217, 217, 1),
                              width: 2),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "학번 수정하기",
                          style: DCColor().boldFontBlack(
                              size.width * 0.05, FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                    height: 45,
                  ),
                  InkWell(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  ModifyMePage(result: result))));
                    }),
                    child: Container(
                      height: size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color.fromRGBO(217, 217, 217, 1),
                              width: 2),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "자기소개 수정하기",
                          style: DCColor().boldFontBlack(
                              size.width * 0.05, FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                    height: 45,
                  ),
                  InkWell(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  ModifyMotivePage(result: result))));
                    }),
                    child: Container(
                      height: size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color.fromRGBO(217, 217, 217, 1),
                              width: 2),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "지원동기 수정하기",
                          style: DCColor().boldFontBlack(
                              size.width * 0.05, FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                    height: 45,
                  ),
                  InkWell(
                    onTap: (() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  ModifyPlanPage(result: result))));
                    }),
                    child: Container(
                      height: size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color.fromRGBO(217, 217, 217, 1),
                              width: 2),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "포부 수정하기",
                          style: DCColor().boldFontBlack(
                              size.width * 0.05, FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                    height: 45,
                  ),
                ]),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
