import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_dc/model/color.dart';
import 'package:code_dc/model/dcfirestore.dart';
import 'package:flutter/material.dart';

class ModifyStudentPage extends StatefulWidget {
  ModifyStudentPage({super.key, required this.result});
  DocumentSnapshot<Map<String, dynamic>> result;
  @override
  State<ModifyStudentPage> createState() => _ModifyStudentPageState();
}

class _ModifyStudentPageState extends State<ModifyStudentPage> {
  final gradelist = ['1학년', '2학년', '3학년'];
  var selectgrade = "1학년";
  var selectclass = "메타버스게임과";
  var selectclassnumber = "1반";
  final firstclass = ["메타버스게임과", "클라우드보안과"];
  final secclass = ["메타버스게임과", "클라우드보안과", "네트워크보안과"];
  final thrClass = ["게임과", "네트워크보안과", "해킹보안과"];
  final oneClassNumber = ["1반"];
  final twoClassNumber = ["1반", "2반"];
  String number = "";
  String schoolid = "";
  final TextEditingController numberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode myFocusNode;
  late ScrollController _scrollController;

  schoolID() {
    String id = "";
    if (selectclass == "메타버스게임과") {
      id += "G";
    } else if (selectclass == "클라우드보안과") {
      id += "C";
    } else if (selectclass == "네트워크보안과") {
      id += "N";
    } else if (selectclass == "게임과") {
      id += "G";
    } else {
      id += "H";
    }

    if (selectgrade == "1학년") {
      id += "1";
    } else if (selectgrade == "2학년") {
      id += "2";
    } else {
      id += "3";
    }

    if (selectclassnumber == "1반") {
      id += "1";
    } else {
      id += "2";
    }

    if (int.parse(number) < 10) {
      schoolid = id + "0" + number.toString();
    } else {
      schoolid = id + number.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    _scrollController = ScrollController();
    String id = widget.result["학번"];
    String myclass = widget.result["학번"].toString().substring(0, 1);
    String grade = widget.result["학번"].toString().substring(1, 2);
    String classnumber = widget.result["학번"].toString().substring(2, 3);
    String mynumber = widget.result["학번"].toString().substring(3, 5);
    if (myclass == "G") {
      selectclass = "메타버스게임과";
    } else if (myclass == "C") {
      selectclass = "클라우드보안과";
    } else if (myclass == "N") {
      selectclass = "네트워크보안과";
    } else if (myclass == "G") {
      selectclass = "게임과";
    } else {
      selectclass = "해킹보안과";
    }

    if (grade == "1") {
      selectgrade = "1학년";
    } else if (grade == "2") {
      selectgrade = "2학년";
    } else {
      selectgrade = "3학년";
    }

    if (classnumber == "1") {
      selectclassnumber = "1반";
    } else {
      selectclassnumber = "2반";
    }
    number = int.parse(mynumber).toString();
    numberController.text = number.toString();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    numberController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      schoolID();
      UserData().schoolIDForm(schoolid);
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
                              icon: Icon(Icons.arrow_back)),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                        height: 20,
                      ),
                      Text(
                        "학번을 입력해주세요",
                        style: DCColor()
                            .boldFontBlack(size.width * 0.08, FontWeight.w700),
                      ),
                      Text(
                        "정확히 입력해주세요",
                        style: DCColor()
                            .boldFontBlack(size.width * 0.04, FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 10,
                        height: 50,
                      ),
                      ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField(
                          key: const ValueKey(1),
                          style: DCColor().boldFontBlack(
                              size.width * 0.04, FontWeight.w500),
                          decoration: DCColor().dropdownButtonFormField(),
                          borderRadius: BorderRadius.circular(8),
                          value: selectgrade,
                          items: gradelist
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectclassnumber = "1반";
                              selectgrade = value.toString();
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                        height: 30,
                      ),
                      ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField(
                          key: const ValueKey(2),
                          decoration: DCColor().dropdownButtonFormField(),
                          borderRadius: BorderRadius.circular(8),
                          style: DCColor().boldFontBlack(
                              size.width * 0.04, FontWeight.w500),
                          value: selectgrade == "3학년"
                              ? firstclass.contains(selectclass) == true
                                  ? "게임과"
                                  : selectclass
                              : thrClass.contains(selectclass) == true
                                  ? "메타버스게임과"
                                  : selectclass,
                          items: selectgrade != "3학년"
                              ? selectgrade == "1학년"
                                  ? firstclass
                                      .map((e) => DropdownMenuItem(
                                          value: e, child: Text(e)))
                                      .toList()
                                  : secclass
                                      .map((e) => DropdownMenuItem(
                                          value: e, child: Text(e)))
                                      .toList()
                              : thrClass
                                  .map((e) => DropdownMenuItem(
                                      value: e, child: Text(e)))
                                  .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectclass = value.toString();
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                        height: 30,
                      ),
                      ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButtonFormField(
                          key: const ValueKey(3),
                          decoration: DCColor().dropdownButtonFormField(),
                          borderRadius: BorderRadius.circular(8),
                          style: DCColor().boldFontBlack(
                              size.width * 0.04, FontWeight.w500),
                          value: selectclassnumber,
                          items: selectgrade == "3학년"
                              ? selectclass == "해킹보안과"
                                  ? twoClassNumber
                                      .map((e) => DropdownMenuItem(
                                          value: e, child: Text(e)))
                                      .toList()
                                  : oneClassNumber
                                      .map((e) => DropdownMenuItem(
                                          value: e, child: Text(e)))
                                      .toList()
                              : selectgrade == "2학년"
                                  ? selectclass == "클라우드보안과"
                                      ? twoClassNumber
                                          .map((e) => DropdownMenuItem(
                                              value: e, child: Text(e)))
                                          .toList()
                                      : oneClassNumber
                                          .map((e) => DropdownMenuItem(
                                              value: e, child: Text(e)))
                                          .toList()
                                  : twoClassNumber
                                      .map((e) => DropdownMenuItem(
                                          value: e, child: Text(e)))
                                      .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectclassnumber = value.toString();
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                        height: 30,
                      ),
                      TextFormField(
                        onTap: () {
                          _scrollController.animateTo(120.0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "번호를 입력해주세요";
                          } else if (int.parse(value) == 0) {
                            return "솔직히 0번은 아니지";
                          } else if (int.parse(value) > 25) {
                            return "내가 몇번까지 있는지 모르겠지만 그정도는 안될껄?";
                          }
                          return null;
                        },
                        key: const ValueKey(4),
                        onChanged: ((value) {
                          if (!value.isEmpty) {
                            setState(() {
                              number = int.parse(value).toString();
                            });
                          }
                        }),
                        cursorColor: DCColor.gitcolor,
                        controller: numberController,
                        decoration: const InputDecoration(
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
                        ),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).unfocus();
                        },
                        focusNode: myFocusNode,
                      ),
                      const SizedBox(
                        width: 10,
                        height: 30,
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
                              backgroundColor: number != 0
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
            ),
          ),
        ),
      ),
    );
  }
}
