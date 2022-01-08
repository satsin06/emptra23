import 'dart:convert';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BasicSoftSkillEdit extends StatefulWidget {
  @override
  _BasicSoftSkillEditState createState() => _BasicSoftSkillEditState();
}

class _BasicSoftSkillEditState extends State<BasicSoftSkillEdit> {
  String name = "";
  bool changeButton = false;
  String radioButtonItem = 'ONE';
  final maxLines = 4;
  final aboutController = TextEditingController();

  bool _isLoading = false;
  int _value = 10;
  int compValue = 5;
  int msValue = 5;
  int designValue = 5;
  int accountingValue = 5;
  int commmuniHindiValue = 5;
  int commmuniEnglishValue = 5;
  int writingHindiValue = 5;
  int writingEngValue = 5;

  final _formKey = GlobalKey<FormState>();

  basicsoftskill() async {
    try{
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });
    Map data = {
      "section": "skills",
      "action": "update",
      "basicSkills": {
        "computerSkills": compValue,
        "msOffice": msValue,
        "basicDesigning": designValue,
        "basicAccounting": accountingValue,
      },
      "softSkills": {
        "hindiCommunication": commmuniHindiValue,
        "englishCommunication": commmuniEnglishValue,
        "writingEnglish": writingEngValue,
        "writingHindi": writingHindiValue,
      }
    };

    print(jsonEncode(data));
    var response = await dio.put("${Api.addemployment}/$userId",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
          "versionnumber": "v1"
        }),
        data: data);
    print(response.data);

    if (response.statusCode == 200) {
      print(response.data);
      print(response.data['code']);
      if (response.data['code'] == 100) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>BottomBarIndivitual(index: 1,)));

        // alertbox(response.data['message']);
      } else {
        success(response.data['message']);
      }
      setState(() {
        _isLoading = false;
      });
    }
  }
    catch(e){
      print(e);
    }
  }
  success(String value) {
    // ignore: deprecated_member_use
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "$value",
          style: k13Fwhite400BT,
        ),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            // Code to execute.
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Color(0xffF8F7F3),
        child: _isLoading == true
            ? Center(child: CircularProgressIndicator())
            : Scaffold(
          body: SingleChildScrollView(
            child: Form(
              child: Padding(
                padding: const EdgeInsets.only(left: 18,right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 12),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 30.0,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             BottomBarIndivitual(index: 1,)));
                        },
                      ),
                    ),
                    Text(
                      'Self Assessment',
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'PoppinsBold',
                          fontWeight: FontWeight.w600,
                          fontSize: 32),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Please rate your skills from 1 to 10.',
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'PoppinsLight',
                          fontSize: 18),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Update your Skills',
                      style: kForteenText,
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Basic Skills',
                      style: kForteenText,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.transparent,
                              child: CircleAvatar(
                                backgroundImage:
                                AssetImage("assets/images/computerskills.png"),
                                radius: 25,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Computer Skills',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 17),
                                    ),
                                    SizedBox(
                                      width: 110,
                                    ),
                                    Text(
                                      '$compValue',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 300,
                                  height: 40,
                                  child: Slider(
                                    value: compValue.toDouble(),
                                    min: 1.0,
                                    max: 10.0,
                                    divisions: 9,
                                    activeColor: Color(0xff3E66FB),
                                    inactiveColor: Colors.grey,
                                    onChanged: (double newValue) {
                                      setState(() {
                                        compValue = newValue.round();
                                        print(_value);
                                      });
                                    },
                                    semanticFormatterCallback:
                                        (double newValue) {
                                      return '${newValue.round()} dollars';
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.transparent,
                              child: CircleAvatar(
                                backgroundImage:
                                AssetImage("assets/images/msoffice.png"),
                                radius: 25,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'MS Office',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 17),
                                    ),
                                    SizedBox(
                                      width: 150,
                                    ),
                                    Text(
                                      '$msValue',
                                      style: TextStyle(

                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 300,
                                  height: 40,
                                  child: Slider(
                                      value: msValue.toDouble(),
                                      min: 1.0,
                                      max: 10.0,
                                      divisions: 9,
                                      activeColor: Color(0xff3E66FB),
                                      inactiveColor: Colors.grey,
                                      onChanged: (double newValue) {
                                        setState(() {
                                          msValue = newValue.round();
                                        });
                                      },
                                      semanticFormatterCallback:
                                          (double newValue) {
                                        return '${newValue.round()} dollars';
                                      }),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.transparent,
                              child: CircleAvatar(
                                backgroundImage:
                                AssetImage("assets/images/basicdesigning.png"),
                                radius: 25,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Basic Designing',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 17),
                                    ),
                                    SizedBox(
                                      width: 90,
                                    ),
                                    Text(
                                      '$designValue',
                                      style: TextStyle(

                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 300,
                                  height: 40,
                                  child: Slider(
                                      value: designValue.toDouble(),
                                      min: 1.0,
                                      max: 10.0,
                                      divisions: 9,
                                      activeColor: Color(0xff3E66FB),
                                      inactiveColor: Colors.grey,
                                      onChanged: (double newValue) {
                                        setState(() {
                                          designValue =
                                              newValue.round();
                                        });
                                      },
                                      semanticFormatterCallback:
                                          (double newValue) {
                                        return '${newValue.round()} dollars';
                                      }),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.transparent,
                              child: CircleAvatar(
                                backgroundImage:
                                AssetImage("assets/images/basicaccounting.png"),
                                radius: 25,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Basic Accounting',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 17),
                                    ),
                                    SizedBox(
                                      width: 80,
                                    ),
                                    Text(
                                      '$accountingValue',
                                      style: TextStyle(

                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 40,
                                  width: 300,
                                  child: Slider(
                                    value: accountingValue.toDouble(),
                                    min: 1.0,
                                    max: 10.0,
                                    divisions: 9,
                                    activeColor: Color(0xff3E66FB),
                                    inactiveColor: Colors.grey,
                                    onChanged: (double newValue) {
                                      setState(() {
                                        accountingValue =
                                            newValue.round();
                                      });
                                    },
                                    semanticFormatterCallback:
                                        (double newValue) {
                                      return '${newValue.round()} dollars';
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      'Soft Skills',
                      style: kForteenText,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.transparent,
                              child: CircleAvatar(
                                backgroundImage:
                                AssetImage("assets/images/englishcommunication.png"),
                                radius: 25,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'English Communication',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 17),
                                    ),
                                    SizedBox(
                                      width: 35,
                                    ),
                                    Text(
                                      '$commmuniEnglishValue',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 300,
                                  height: 40,
                                  child: Slider(
                                    value: commmuniEnglishValue.toDouble(),
                                    min: 1.0,
                                    max: 10.0,
                                    divisions: 9,
                                    activeColor: Color(0xff3E66FB),
                                    inactiveColor: Colors.grey,
                                    onChanged: (double newValue) {
                                      setState(() {
                                        commmuniEnglishValue = newValue.round();
                                      });
                                    },
                                    semanticFormatterCallback:
                                        (double newValue) {
                                      return '${newValue.round()} dollars';
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.transparent,
                              child: CircleAvatar(
                                backgroundImage:
                                AssetImage("assets/images/hindicommunication.png"),
                                radius: 25,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hindi Communication   ',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 17),
                                    ),
                                    SizedBox(
                                      width: 35,
                                    ),
                                    Text(
                                      '$commmuniHindiValue',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 300,
                                  height: 40,
                                  child: Slider(
                                      value: commmuniHindiValue.toDouble(),
                                      min: 1.0,
                                      max: 10.0,
                                      divisions: 9,
                                      activeColor: Color(0xff3E66FB),
                                      inactiveColor: Colors.grey,
                                      onChanged: (double newValue) {
                                        setState(() {
                                          commmuniHindiValue = newValue.round();
                                        });
                                      },
                                      semanticFormatterCallback:
                                          (double newValue) {
                                        return '${newValue.round()} dollars';
                                      }),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.transparent,
                              child: CircleAvatar(
                                backgroundImage:
                                AssetImage("assets/images/writingengliash.png"),
                                radius: 25,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Writing English',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 17),
                                    ),
                                    SizedBox(
                                      width: 110,
                                    ),
                                    Text(
                                      '$writingEngValue',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 300,
                                  height: 40,
                                  child: Slider(
                                      value: writingEngValue.toDouble(),
                                      min: 1.0,
                                      max: 10.0,
                                      divisions: 9,
                                      activeColor: Color(0xff3E66FB),
                                      inactiveColor: Colors.grey,
                                      onChanged: (double newValue) {
                                        setState(() {
                                          writingEngValue = newValue.round();
                                        });
                                      },
                                      semanticFormatterCallback:
                                          (double newValue) {
                                        return '${newValue.round()} dollars';
                                      }),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.transparent,
                              child: CircleAvatar(
                                backgroundImage:
                                AssetImage( "assets/images/writinghindi.png"),
                                radius: 25,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Writing Hindi   ',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 17),
                                    ),
                                    SizedBox(
                                      width: 110,
                                    ),
                                    Text(
                                      '$writingHindiValue',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 40,
                                  width: 300,
                                  child: Slider(
                                    value: writingHindiValue.toDouble(),
                                    min: 1.0,
                                    max: 10.0,
                                    divisions: 9,
                                    activeColor: Color(0xff3E66FB),
                                    inactiveColor: Colors.grey,
                                    onChanged: (double newValue) {
                                      setState(() {
                                        writingHindiValue = newValue.round();
                                      });
                                    },
                                    semanticFormatterCallback:
                                        (double newValue) {
                                      return '${newValue.round()} dollars';
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          textColor: Colors.white,
                          color: Color(0xff3E66FB),
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text(
                              'Update',
                              style: k13Fwhite400BT,
                            ),
                          ),
                          onPressed: () {
                            basicsoftskill();
                            // if (_formkey.currentState.validate()) {
                            //   signup();


                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}

