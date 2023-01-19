import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_dc/model/color.dart';
import 'package:code_dc/model/dcfirestore.dart';
import 'package:code_dc/wirte/wrtie_student.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FormWritePage extends StatefulWidget {
  const FormWritePage({super.key});

  @override
  State<FormWritePage> createState() => _FormWritePageState();
}

class _FormWritePageState extends State<FormWritePage> {
  User? user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;
  final TextEditingController nameController = TextEditingController();
  String name = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode myFocusNode;
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    void _tryValidation() {
      final isValid = _formKey.currentState!.validate();
      if (isValid) {
        _formKey.currentState!.save();
        nameController.text = "";
        UserData().firstForm(name);
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => WriteStudentPage())));
      }
    }

    return GestureDetector(
      onTap: () {
        myFocusNode.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(children: [
              const SizedBox(
                width: 10,
                height: 20,
              ),
              Text(
                "이름을 입력해주세요",
                style:
                    DCColor().boldFontBlack(size.width * 0.08, FontWeight.w700),
              ),
              Text(
                "실명을 입력해주세요",
                style:
                    DCColor().boldFontBlack(size.width * 0.04, FontWeight.w500),
              ),
              const SizedBox(
                width: 10,
                height: 50,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.trim().isEmpty || value.length < 2) {
                            return "이름을 적어주세요";
                          }
                        },
                        key: const ValueKey(1),
                        onChanged: ((value) {
                          setState(() {
                            name = value;
                          });
                        }),
                        cursorColor: DCColor.gitcolor,
                        controller: nameController,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(247, 248, 249, 1),
                            hintText: "이름을 입력해주세요",
                            hintStyle: TextStyle(
                                fontSize: 15,
                                fontFamily: "inter",
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(131, 145, 161, 1)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color.fromRGBO(218, 218, 218, 1),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color.fromRGBO(218, 218, 218, 1),
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.red,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)))),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.name,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).unfocus();
                        },
                        focusNode: myFocusNode,
                      ),
                      const SizedBox(
                        width: 10,
                        height: 40,
                      ),
                      SizedBox(
                        width: size.width * 0.6,
                        child: ElevatedButton(
                          onPressed: (() {
                            FocusScope.of(context).unfocus();
                            _tryValidation();
                          }),
                          style: ElevatedButton.styleFrom(
                              shadowColor: const Color(0x00000000),
                              elevation: 0,
                              backgroundColor: name.length > 2
                                  ? DCColor.dcyellow
                                  : Color.fromRGBO(217, 217, 217, 1),
                              minimumSize: const Size(330, 56),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          child: Text(
                            "확인",
                            style: DCColor().boldFontBlack(
                                size.width * 0.045, FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ))
            ]),
          ),
        )),
      ),
    );
  }
}
