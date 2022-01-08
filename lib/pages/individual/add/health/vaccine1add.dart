import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Vaccine1Add extends StatefulWidget {
  @override
  _Vaccine1AddState createState() => _Vaccine1AddState();
}

class _Vaccine1AddState extends State<Vaccine1Add> {
//  String userId = '285885';
  bool _isLoading = false;
  DateTime _selectedFromDate;
  TextEditingController _fromDatecontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _dropDownValue;
  String _dose;

  addVaccine() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });

    var dio = Dio();
    Map data = {
      "userId": userId,
      "vaccineName": _dropDownValue,
      "vaccineDate": _fromDatecontroller.text,
      "vaccineDose": 1,
      "type": "Covid"
    };
    print(data);
    print("${Api.addVaccine}");
    print(jsonEncode(data));
    var response = await dio.post("${Api.addVaccine}",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
          "versionnumber": "v1"
        }),
        data: data);
    print(response.data);
    if (response.statusCode == 200) {
      if (response.data['code'] == 100) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BottomBarIndivitual(
                      index: 3,
                    )));
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
                            child: IconButton(
                              icon: Icon(
                                Icons.close,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => BottomBarIndivitual(
                                //           index: 3,
                                //         )));
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Add Vaccination',
                            style: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'PoppinsBold',
                                height: 1.3,
                                fontWeight: FontWeight.w600,
                                fontSize: 32),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Vaccine Name',
                            style: kForteenText,
                          ),
                          DropdownButton(
                            hint: _dropDownValue == null
                                ? Text(
                                    'Covid Vaccine Name',
                                    style: k18F87Black400HT,
                                  )
                                : Text(_dropDownValue, style: k22InputText),
                            isExpanded: true,
                            iconSize: 30.0,
                            style: k18F87Black400HT,
                            items: [
                              'Covaxin',
                              'Sputnik v',
                              'Moderna',
                              'Pfizer',
                              'Covishield',
                            ].map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  _dropDownValue = val;
                                },
                              );
                            },
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Vaccine Date',
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
                                    hintStyle: k18F87Black400HT),
                              ),
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
                                  addVaccine();
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             UploadSocialDocument()));
                                  // if (_formkey.currentState.validate()) {
                                  //   signup();
                                  // }
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
                    minimumDate: DateTime.utc(1979, 12, 31),
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
