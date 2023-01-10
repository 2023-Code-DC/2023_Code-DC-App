import 'package:code_dc/model/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final welcometext = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "동무!",
        style: DCColor().boldFontBlack(30),
      ),
      Text(
        "돌아온걸 환영합네다.",
        style: DCColor().boldFontBlack(30),
      ),
    ],
  );
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _pwController = new TextEditingController();
  String emailtext = "";
  String passwordtext = "";
  late FocusNode myFocusNode;

  @override
  void initState() {
    myFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _tryValidation() {
      final isValid = _formKey.currentState!.validate();
      if (isValid) {
        _formKey.currentState!.save();
      }
    }

    Widget Emailfield = TextFormField(
      validator: (value) =>
          EmailValidator.validate(value!) ? null : "올바른 전자우편을 적으라우",
      key: const ValueKey(1),
      onChanged: ((value) {}),
      controller: _emailController,
      decoration: const InputDecoration(
          filled: true,
          fillColor: Color.fromRGBO(247, 248, 249, 1),
          hintText: "전자우편을 적으라우 (이메일)",
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
        FocusScope.of(context).requestFocus(myFocusNode);
      },
    );
    Widget Passwordfield = TextFormField(
      validator: (value) {
        if (value!.trim().isEmpty || value.length < 8) {
          return "8글자 이상으로 적으라우 동무";
        }
      },
      key: const ValueKey(2),
      onChanged: ((value) {}),
      controller: _pwController,
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
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (value) {
        FocusScope.of(context).unfocus();
      },
      focusNode: myFocusNode,
    );
    return GestureDetector(
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
                welcometext,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Emailfield,
                    SizedBox(
                      height: 15,
                    ),
                    Passwordfield,
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text(
                            "구성원 신청서",
                            style: DCColor().loginGOregFontBlack(10),
                          ),
                        ),
                        Container(
                          color: Colors.black,
                          height: 1,
                          width: 58,
                        )
                      ],
                    )
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
                              "복귀하기",
                              style: DCColor().boldFontWhite(15),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: DCColor.backgroundcolor,
                                minimumSize: Size(330, 56),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)))),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            color: Color.fromRGBO(198, 198, 198, 1),
                            height: 1,
                            width: 140,
                          ),
                          Text(
                            "또는",
                            style: DCColor().blodFontgrey(14),
                          ),
                          Container(
                            color: Color.fromRGBO(198, 198, 198, 1),
                            height: 1,
                            width: 140,
                          )
                        ],
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.white,
                              minimumSize: Size(105, 56),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Color.fromRGBO(218, 218, 218, 1)),
                                  borderRadius: BorderRadius.circular(8))),
                          onPressed: () {},
                          child: Image.asset(
                            "assets/images/google_logo.png",
                            scale: 26,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
