import 'dart:convert';
import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/pages/individual/uploadDocument/social_upload_document.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';

class SocialEditPage extends StatefulWidget {
  @override
  _SocialEditPageState createState() => _SocialEditPageState();
}

class _SocialEditPageState extends State<SocialEditPage> {
  String name = "";
  bool changeButton = false;
  final maxLines = 3;
  final aboutController = TextEditingController();

  bool _isLoading = false;
  DateTime _selectedFromDate;
  TextEditingController _helpPartner = TextEditingController();
  TextEditingController _helpType = TextEditingController();
  TextEditingController _fromDatecontroller = TextEditingController();
  TextEditingController _details = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


  addHelp() async {
    SharedPreferences session = await SharedPreferences.getInstance();
   int userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });

    var dio = Dio();
    Map data = {
      "userId": userId,
      "partnerName": _helpPartner.text,
      "helpType": _helpType.text,
      "date": _fromDatecontroller.text,
      "details": _details.text,
    };
    print(data);

    print("${Api.addHelp}");
    print(jsonEncode(data));
    var response = await dio.post("${Api.addHelp}",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
          "versionnumber": "v1"
        }),
        data: data);
    print(response.data);
    if (response.statusCode == 200) {
      if (response.data['code'] == 100) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  BottomBarIndivitual(  index: 4,)));
        success(response.data['message']);
        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      success(response.data['message']);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
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

  // void initState() {
  //   super.initState();
  //   addHelp();
  // }
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
                          SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topRight,
                        child:IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             BottomBarIndivitual(  index: 4,)));
                            },
                          ),),
                          SizedBox(height: 20),
                          Text(
                            'Update Social Stats',
                            style: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'PoppinsBold',
                                height: 1.3,
                                fontWeight: FontWeight.w600,
                                fontSize: 32),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Help Partner',
                            style: kForteenText,
                          ),
                          TextFormField(
                            controller: _helpPartner,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Add your help partner",
                              hintStyle: k18F87Black400HT,
                            ),
                            style: k22InputText,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Help partner cannot be empty";
                              } else if (value.length > 22) {
                                return "Help partner length not more then 22";
                              }
                              return null;
                            },
                            onSaved: (String name) {},
                            onChanged: (value) {
                              name = value;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 25),
                          Text(
                            'Help Type',
                            style: kForteenText,
                          ),
                          TextFormField(
                            controller: _helpType,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Add your help type",
                              hintStyle: k18F87Black400HT,
                            ),
                            style: k22InputText,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Help type cannot be empty";
                              } else if (value.length > 22) {
                                return "Help type length not more then 22";
                              }
                              return null;
                            },
                            onSaved: (String name) {},
                            onChanged: (value) {
                              name = value;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 25),
                          Text(
                            'Help Date',
                            style: kForteenText,
                          ),
                          GestureDetector(
                            onTap: () => _selectFromdate(),
                            child: AbsorbPointer(
                              child: TextField(
                                controller: _fromDatecontroller,
                                style: k22InputText,
                                decoration: InputDecoration(
                                    isDense: true,
                                    hintText: "Date",
                                    hintStyle: k18F87Black400HT ),
                              ),
                            ),
                          ),
                          SizedBox(height: 25),
                          Text(
                            'Details',
                            style: kForteenText,
                          ),
                          SizedBox(height: 12),
                          Container(
                            height: maxLines * 18.0,
                            child: TextField(
                              maxLines: maxLines,
                              style: k22InputText,
                              decoration: InputDecoration(
                                hintText: "Details",
                                hintStyle: k18F87Black400HT,
                                fillColor: Colors.grey[100],
                                filled: true,
                              ),

                              controller: _details,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // ignore: deprecated_member_use
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                textColor: Colors.white,
                                color: Color(0xff3E66FB),
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Text(
                                    'Save & Next',
                                    style: k13Fwhite400BT,
                                  ),
                                ),
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             UploadSocialDocument()));
                                  if (_formkey.currentState.validate()) {
                                    addHelp();
                                  }
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


  _selectFromdate() async {
    DateTime pickedDate = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (context) {
        DateTime tempPickedDate = _selectedFromDate ?? DateTime.now();
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text('Done'),
                      onPressed: () {
                        Navigator.of(context).pop(tempPickedDate);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                    },
                    minimumDate: DateTime.utc(1979, 11, 9),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedFromDate) {
      setState(() {
        _selectedFromDate = pickedDate;
        _fromDatecontroller.text = pickedDate.toString();
      });

      _fromDatecontroller
        ..text = DateFormat('dd-MM-yyyy').format(_selectedFromDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _fromDatecontroller.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}
