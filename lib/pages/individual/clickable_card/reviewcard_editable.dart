import 'dart:convert';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import '../registration/indivitual_registration/allset.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewSkillEdit extends StatefulWidget {
  @override
  _ReviewSkillEditState createState() => _ReviewSkillEditState();
}

class _ReviewSkillEditState extends State<ReviewSkillEdit> {

  final aboutController = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String employementStatus;
  bool _isLoading = false;
  int _value = 10;
  int compValue = 5;
  int msValue = 5;

  final msOffice = GlobalKey<FormState>();



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
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 12),
                    Text(
                      'Update your review',
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'PoppinsBold',
                          fontWeight: FontWeight.w600,
                          fontSize: 32),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Please rate your skills from 1 to 5.',
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'PoppinsLight',
                          fontSize: 18),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Review',
                      style: kForteenText,
                    ),
                    SizedBox(height: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,

                                  children: [
                                    Text(
                                      'Punctuality',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 17),
                                    ),
                                    SizedBox(
                                      width: 130,
                                    ),
                                    Text(
                                      '$compValue%',
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
                                    min: 0.0,
                                    max: 10.0,
                                    divisions: 10,
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
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Dedication and Hardwork',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 17),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '$msValue%',
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
                                    min: 0.0,
                                    max: 10.0,
                                    divisions: 10,
                                    activeColor: Color(0xff3E66FB),
                                    inactiveColor: Colors.grey,
                                    onChanged: (double newValue) {
                                      setState(() {
                                        msValue = newValue.round();
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
                            // if (_formkey.currentState.validate()) {
                            //   signup();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomBarIndivitual()));
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

