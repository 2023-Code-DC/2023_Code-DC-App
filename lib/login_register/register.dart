import 'package:code_dc/model/color.dart';
import 'package:code_dc/model/dcfirestore.dart';
import 'package:code_dc/model/login_model.dart';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final welcometext = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "동무!",
        style: DCColor().boldFontBlack(30),
      ),
      Text(
        "처음온걸 환영합네다.",
        style: DCColor().boldFontBlack(30),
      ),
    ],
  );
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String emailtext = "";
  String passwordtext = "";
  String nametext = "";
  String chpasswordtext = "";
  late FocusNode emailFocusNode;
  late FocusNode pwFocusNode;
  late FocusNode chpwFocusNode;
  @override
  void initState() {
    emailFocusNode = FocusNode();
    pwFocusNode = FocusNode();
    chpwFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    pwFocusNode.dispose();
    chpwFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _tryValidation() {
      //동무되기 버튼 클릭
      final isValid = _formKey.currentState!.validate();
      if (isValid) {
        _formKey.currentState!.save(); //텍스트 폼필드가 다 정상이면 작동
        UserAuthentication()
            .CreateWithDevice(context, nametext, emailtext, passwordtext);
      }
    }

    Widget namefield = TextFormField(
      validator: (value) {
        if (value!.trim().isEmpty || value.length > 10) {
          return "10글자 아래로 똑바로 적으라우 ";
        }
      },
      key: const ValueKey(1),
      onChanged: ((value) {
        setState(() {
          nametext = value;
        });
      }),
      decoration: const InputDecoration(
          filled: true,
          fillColor: Color.fromRGBO(247, 248, 249, 1),
          hintText: "니 명을 적어라 (이름)",
          hintStyle: TextStyle(
              fontSize: 15,
              fontFamily: "urbanist",
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(131, 145, 161, 1)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(8))),
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
              borderRadius: BorderRadius.all(Radius.circular(8)))),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(emailFocusNode);
      },
    );

    Widget Emailfield = TextFormField(
      validator: (value) =>
          EmailValidator.validate(value!) ? null : "올바른 전자우편을 적으라우",
      key: const ValueKey(2),
      onChanged: ((value) {
        setState(() {
          emailtext = value;
        });
      }),
      decoration: const InputDecoration(
          filled: true,
          fillColor: Color.fromRGBO(247, 248, 249, 1),
          hintText: "전자우편을 적어라 (이메일)",
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Color.fromRGBO(218, 218, 218, 1),
            ),
          ),
          hintStyle: TextStyle(
              fontSize: 15,
              fontFamily: "urbanist",
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(131, 145, 161, 1)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Color.fromRGBO(218, 218, 218, 1),
              ),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.red,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)))),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next, //다음버튼
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(pwFocusNode);
      },
      focusNode: emailFocusNode,
    );

    Widget Passwordfield = TextFormField(
      validator: (value) {
        if (value!.trim().isEmpty || value.length < 8) {
          return "8글자 이상으로 적으라우 동무";
        }
      },
      key: const ValueKey(3),
      onChanged: ((value) {
        setState(() {
          passwordtext = value;
        });
      }),
      obscureText: true,
      decoration: const InputDecoration(
          filled: true,
          fillColor: Color.fromRGBO(247, 248, 249, 1),
          hintText: "통과 암호 (비밀번호)",
          hintStyle: TextStyle(
              fontSize: 15,
              fontFamily: "urbanist",
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(131, 145, 161, 1)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(8))),
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
              borderRadius: BorderRadius.all(Radius.circular(8)))),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(chpwFocusNode);
      },
      focusNode: pwFocusNode,
    );

    Widget checkPasswordfield = TextFormField(
      validator: (value) {
        if (passwordtext == value) {
          return null;
        } else {
          return "일치하는지 확인하라우";
        }
      },
      key: const ValueKey(4),
      onChanged: ((value) {}),
      obscureText: true,
      decoration: const InputDecoration(
          filled: true,
          fillColor: Color.fromRGBO(247, 248, 249, 1),
          hintText: "통과 암호 확인 (비밀번호 확인)",
          hintStyle: TextStyle(
              fontSize: 15,
              fontFamily: "urbanist",
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(131, 145, 161, 1)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(8))),
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
              borderRadius: BorderRadius.all(Radius.circular(8)))),
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (value) {
        FocusScope.of(context).unfocus();
      },
      focusNode: chpwFocusNode,
    );

    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: InkWell(
                          onTap: (() {
                            Navigator.pop(context);
                          }),
                          child: Icon(
                            Icons.arrow_back,
                            size: 36,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 14,
                        width: 1,
                      ),
                      welcometext
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      namefield,
                      SizedBox(
                        height: 15,
                      ),
                      Emailfield,
                      SizedBox(
                        height: 15,
                      ),
                      Passwordfield,
                      SizedBox(
                        height: 15,
                      ),
                      checkPasswordfield,
                    ],
                  ),
                  SizedBox(
                    height: 180,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: (() {
                                FocusScope.of(context).unfocus();
                                _tryValidation();
                              }),
                              child: Text(
                                "동무 되기",
                                style: DCColor().boldFontWhite(15),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: DCColor.backgroundcolor,
                                  minimumSize: Size(330, 56),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)))),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
