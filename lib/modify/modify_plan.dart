import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_dc/model/color.dart';
import 'package:code_dc/model/dcfirestore.dart';
import 'package:flutter/material.dart';

class ModifyPlanPage extends StatefulWidget {
  const ModifyPlanPage({super.key, required this.result});
  final DocumentSnapshot<Map<String, dynamic>> result;
  @override
  State<ModifyPlanPage> createState() => _ModifyPlanPageState();
}

class _ModifyPlanPageState extends State<ModifyPlanPage> {
  String plan = "";
  TextEditingController planController = TextEditingController();
  late ScrollController _scrollController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode myFocusNode;
  @override
  void dispose() {
    planController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    _scrollController = ScrollController();
    planController.text = widget.result["포부"];
    plan = widget.result["포부"];
  }

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      UserData().planForm(plan);
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
                      "${widget.result["이름"]}님의 포부를 작성해주세요!",
                      textAlign: TextAlign.center,
                      style: DCColor()
                          .boldFontBlack(size.width * 0.06, FontWeight.w700),
                    ),
                    const SizedBox(
                      width: 10,
                      height: 30,
                    ),
                    TextFormField(
                        minLines: 5,
                        onTap: () {
                          _scrollController.animateTo(125.0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "포부를 작성해주세요";
                          } else if (value.length < 10) {
                            return "그래도 10글자는 써야지 읽을 맛이 나지..";
                          }
                          return null;
                        },
                        key: const ValueKey(1),
                        onChanged: ((value) {
                          setState(() {
                            plan = value;
                          });
                        }),
                        maxLength: 500,
                        cursorColor: DCColor.gitcolor,
                        controller: planController,
                        decoration:
                            DCColor().textFieldDecoration("포부를 작성해주세요!"),
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
                            backgroundColor: plan.isNotEmpty
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
