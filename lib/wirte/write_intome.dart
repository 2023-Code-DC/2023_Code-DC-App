import 'package:code_dc/model/color.dart';
import 'package:code_dc/model/dcfirestore.dart';
import 'package:code_dc/wirte/write_motive.dart';
import 'package:flutter/material.dart';

class WriteMe extends StatefulWidget {
  WriteMe({super.key, required this.name});
  String name;
  @override
  State<WriteMe> createState() => _WriteMeState();
}

class _WriteMeState extends State<WriteMe> {
  String isme = "";
  TextEditingController meController = TextEditingController();
  late ScrollController _scrollController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode myFocusNode;
  @override
  void dispose() {
    meController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    _scrollController = ScrollController();
  }

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      UserData().introduceForm(isme);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WriteMotivePage(name: widget.name)));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        myFocusNode.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          controller: _scrollController,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      width: 10,
                      height: 20,
                    ),
                    Text(
                      widget.name + "님에 대해 알 수 있도록\n자기소개를 작성해주세요!",
                      textAlign: TextAlign.center,
                      style: DCColor()
                          .boldFontBlack(size.width * 0.066, FontWeight.w700),
                    ),
                    const SizedBox(
                      width: 10,
                      height: 30,
                    ),
                    TextFormField(
                        onTap: () {
                          _scrollController.animateTo(125.0,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "자기소개를 작성해주세요";
                          } else if (value.length < 10) {
                            return "그래도 10글자는 써야지 읽을 맛이 나지..";
                          }
                        },
                        key: const ValueKey(1),
                        onChanged: ((value) {
                          setState(() {
                            isme = value;
                          });
                        }),
                        maxLength: 500,
                        cursorColor: DCColor.gitcolor,
                        controller: meController,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            filled: true,
                            fillColor: Color.fromRGBO(247, 248, 249, 1),
                            hintText: "자기소개를 작성해주세요!",
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
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).unfocus();
                        },
                        focusNode: myFocusNode,
                        maxLines: 22),
                    const SizedBox(
                      width: 10,
                      height: 20,
                    ),
                    SizedBox(
                      width: size.width * 0.75,
                      child: ElevatedButton(
                        onPressed: (() {
                          FocusScope.of(context).unfocus();
                          _tryValidation();
                        }),
                        style: ElevatedButton.styleFrom(
                            shadowColor: const Color(0x00000000),
                            elevation: 0,
                            backgroundColor: isme.isNotEmpty
                                ? DCColor.dcyellow
                                : const Color.fromRGBO(217, 217, 217, 1),
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
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}
