import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_dc/model/color.dart';
import 'package:code_dc/model/dcfirestore.dart';
import 'package:flutter/material.dart';

class ModifyMotivePage extends StatefulWidget {
  const ModifyMotivePage({super.key, required this.result});
  final DocumentSnapshot<Map<String, dynamic>> result;
  @override
  State<ModifyMotivePage> createState() => _ModifyMotivePageState();
}

class _ModifyMotivePageState extends State<ModifyMotivePage> {
  String motive = "";
  TextEditingController motiveController = TextEditingController();
  late ScrollController _scrollController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode myFocusNode;
  @override
  void dispose() {
    motiveController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    _scrollController = ScrollController();
    motiveController.text = widget.result["동기"];
    motive = widget.result["동기"];
  }

  void _tryValidation(c) {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      UserData().motiveForm(motive);
      Navigator.pop(context);
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
                    Row(
                      children: [
                        IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back)),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                      height: 20,
                    ),
                    Text(
                      "CODE D.C. 동아리에\n지원하게된 동기를 작성해주세요!",
                      textAlign: TextAlign.center,
                      style: DCColor()
                          .boldFontBlack(size.width * 0.064, FontWeight.w700),
                    ),
                    const SizedBox(
                      width: 10,
                      height: 30,
                    ),
                    TextFormField(
                        onTap: () {
                          _scrollController.animateTo(125.0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "지원동기를 작성해주세요";
                          } else if (value.length < 10) {
                            return "그래도 10글자는 써야지 읽을 맛이 나지..";
                          }
                          return null;
                        },
                        key: const ValueKey(1),
                        onChanged: ((value) {
                          setState(() {
                            motive = value;
                          });
                        }),
                        maxLength: 500,
                        cursorColor: DCColor.gitcolor,
                        controller: motiveController,
                        decoration: DCColor()
                            .textFieldDecoration("동아리에 지원하게된 동기를 작성해주세요!"),
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).unfocus();
                        },
                        focusNode: myFocusNode,
                        minLines: 5,
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
                          _tryValidation(context);
                        }),
                        style: ElevatedButton.styleFrom(
                            shadowColor: const Color(0x00000000),
                            elevation: 0,
                            backgroundColor: motive.isNotEmpty
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
