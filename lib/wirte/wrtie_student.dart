import 'package:code_dc/model/color.dart';
import 'package:code_dc/model/dcfirestore.dart';
import 'package:code_dc/wirte/write_intome.dart';
import 'package:flutter/material.dart';

class WriteStudentPage extends StatefulWidget {
  WriteStudentPage({super.key, required this.name});
  String name;
  @override
  State<WriteStudentPage> createState() => _WriteStudentPageState();
}

class _WriteStudentPageState extends State<WriteStudentPage> {
  final gradelist = ['1학년', '2학년', '3학년'];
  var selectgrade = "1학년";
  var selectclass = "메타버스게임과";
  var selectclassnumber = "1반";
  final firstclass = ["메타버스게임과", "클라우드보안과"];
  final secclass = ["메타버스게임과", "클라우드보안과", "네트워크보안과"];
  final thrClass = ["게임과", "네트워크보안과", "해킹보안과"];
  final oneClassNumber = ["1반"];
  final twoClassNumber = ["1반", "2반"];
  int number = 0;
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

    if (number < 10) {
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
      numberController.text = "";
      schoolID();
      UserData().schoolIDForm(schoolid);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => WriteMe(
                    name: widget.name,
                  ))));
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
                            height: 65,
                          ),
                          Text(
                            "학번을 입력해주세요",
                            style: DCColor().boldFontBlack(
                                size.width * 0.08, FontWeight.w700),
                          ),
                          Text(
                            "정확히 입력해주세요",
                            style: DCColor().boldFontBlack(
                                size.width * 0.04, FontWeight.w500),
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
                              borderRadius: BorderRadius.circular(8),
                              value: selectgrade,
                              items: gradelist
                                  .map((e) => DropdownMenuItem(
                                      value: e, child: Text(e)))
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
                              setState(() {
                                number = int.parse(value);
                              });
                            }),
                            cursorColor: DCColor.gitcolor,
                            controller: numberController,
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromRGBO(247, 248, 249, 1),
                                hintText: "번호를 입력해주세요",
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
                      ))),
            ),
          ),
        ),
      ),
    );
  }
}
