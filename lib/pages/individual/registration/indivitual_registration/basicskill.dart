import 'dart:convert';
import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'softskill.dart';

class BasicSkill extends StatefulWidget {
  @override
  _BasicSkillState createState() => _BasicSkillState();
}

class _BasicSkillState extends State<BasicSkill> {
  final aboutController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
 // String userId = "285885";

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
  final msOffice = GlobalKey<FormState>();
  Map basic;

  basicskill() async {
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
            context, MaterialPageRoute(builder: (context) => SoftSkill()));
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
          body:  SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 12),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              'Save & Exit',
                              style: kForteenText,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Container(
                                width: 210,
                                height: 8,
                                color: Color(0xff3E66FB),
                              ),
                              Container(
                                width: 120,
                                height: 8,
                                color: Color(0xffCBD5E1),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Tell us about your skills',
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
                            'Basic Skills',
                            style: kForteenText,
                          ),
                          SizedBox(height: 25),
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
                                            MainAxisAlignment.start,
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
                                            width: 93,
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
                                            width: 135,
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
                                            key: msOffice,
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
                                                designValue = newValue.round();
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
                                    'Next',
                                    style: k13Fwhite400BT,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    basic = {
                                      "computerSkills": compValue,
                                      "msOffice": msValue,
                                      "basicDesigning": designValue,
                                      "basicAccounting": accountingValue,
                                    };
                                  }
                                  );
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SoftSkill(basic: basic)));
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
