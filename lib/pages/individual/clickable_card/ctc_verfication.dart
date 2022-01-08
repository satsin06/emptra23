import 'dart:convert';
import 'dart:io';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/models/getListModel/getEmployeementModel.dart';
import 'package:flutter_emptra/pages/individual/registration/indivitual_registration/educationhistory.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CtcAdd extends StatefulWidget {
  @override
  _CtcAddState createState() => _CtcAddState();
}

class _CtcAddState extends State<CtcAdd> {
  String name = "";
  bool changeButton = false;
  bool _checkbox = true;
  final maxLines = 4;
  String _dropDownValue;
  DateTime initialDate = DateTime.utc(1970, 1, 1);
  final aboutController = TextEditingController();
  int id = 1;

  // String userId = '406451';
// String userId = '406451';
  TextEditingController _designation = TextEditingController();
  TextEditingController _website = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _about = TextEditingController();
  String employementStatus;
  bool _isLoading = false;
  DateTime _selectedDate;
  DateTime _selectedTodate;
  TextEditingController _toDatecontroller = TextEditingController();
  TextEditingController _fromDatecontroller = TextEditingController();
  final TextEditingController _typeAheadController = TextEditingController();
  var list;
  var employeeId;
  var isworking;
  List customerList = [];
  GlobalKey<AutoCompleteTextFieldState> key = new GlobalKey();
  bool loader = false;
  var textValue;
  GetEmployeementHistoryModel _employmentHistoryData;

  Future getCompanyName(String name) async {
    var dio = Dio();
    setState(() {
      loader = true;
    });

    var response = await dio.get(
      "${Api.companyName}$name",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        'x-api-key': 'RThhwOQ73l',
        'x-api-secret-key': 'p9ipBtWPKio4t1NathrAa7Z2F6TjgJdWr3adMV6v',
        'Cache-Control': 'no-cache',
        'postman-token': 'b1c505ef-b3ce-4d96-a953-53a66c7c9935'
      }),
    );
    setState(() {
      customerList = [];
      list = (response.data['data']);
    });
    print(list);
    for (int i = 0; i < list.length; i++) {
      setState(() {
        customerList.add(list[i]['name']);
      });

      setState(() {
        loader = false;
      });
    }
  }

  setcustcode(value) {
    for (int i = 0; i <= list.length; i++) {
      // print(list[i]['name']);
      if (list[i]['name'] == value) {
        setState(() {
          employeeId = list[i]['dataid'];
          textValue = value;
        });
      } else {
        print("no");
      }
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

  addEmployment() async {
    try{
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      var currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
      setState(() {
        _isLoading = true;
      });

      var dio = Dio();
      Map data = {
        "userId": userId,
        "employerId": employeeId.toString(),
        "designation": _designation.text,
        "website": _website.text,
        "employerName": textValue,
        "from": _fromDatecontroller.text,
        "isWorking": _checkbox,
        "about": _about.text,
        "to": _toDatecontroller.text == null || _toDatecontroller.text == ''
            ? currentDate
            : _toDatecontroller.text
      };
      print(data);

      print("${Api.addEmployment}");
      print(jsonEncode(data));
      var response = await dio.post("${Api.addEmployment}",
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
            "versionnumber": "v1"
          }),
          data: data);
      print(response.data);
      if (response.statusCode == 200) {
        getEmploymentHistory();
        if (response.data['code'] == 100) {
          setState(() {
            _isLoading = false;
            getEmploymentHistory();
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
    } catch(e){
      print(e);
    }
  }

  getEmploymentHistory() async {
    try{
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();
      var response = await dio.get(
        "${Api.employmentHistoryList}/$userId",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
          "versionnumber": "v1"
        }),
      );
      if (response.statusCode == 200) {
        print(response.data);
        if (response.data['code'] == 100) {
          setState(() {
            print("!!!!!");
            _employmentHistoryData =
                GetEmployeementHistoryModel.fromJson(response.data);
            print(_employmentHistoryData);
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch(e){
      print(e);
    }
  }

  _cancelEmpl({String userId}) async {
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.delete(
      "${Api.deleteEmployement}/$userId",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
    );
    print(response.data);
    if (response.statusCode == 200) {
      getEmploymentHistory();
      success(response.data['message']);
      setState(() {
        _employmentHistoryData = null;
        _isLoading = false;
      });
    } else {
      getEmploymentHistory();
      success(response.data['message']);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getEmploymentHistory();
    isworking = 'true';
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
              child: Column(
                children: <Widget>[
                SizedBox(
                height: 100,
              ),
              Card(
                elevation: 1,
                child: Container(
                  height: 700,
                  padding: new EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
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
                            //             BottomBarIndivitual(
                            //               index: 1,
                            //             )));
                          },
                        ),
                      ),
                      Text(
                        'CTC Verification',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'PoppinsBold',
                            height: 1.3,
                            fontWeight: FontWeight.w600,
                            fontSize: 32),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Organisation',
                        style: kForteenText,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                  child: Stack(
                                    children: [
                                      TypeAheadFormField(
                                        textFieldConfiguration:
                                        TextFieldConfiguration(
                                          onChanged: (controller) {
                                            print(controller);
                                            print(controller.length);
                                            if (controller.length > 0) {
                                              getCompanyName(
                                                controller,
                                              );
                                            }
                                          },
                                          controller: this._typeAheadController,
                                          style: k22InputText,
                                          decoration: InputDecoration(
                                              isDense: true,
                                              hintText: "Google Inc",
                                              hintStyle: k18F87Black400HT),
                                        ),
                                        suggestionsCallback: (pattern) {
                                          return customerList;
                                        },
                                        itemBuilder: (context, customerList) {
                                          return ListTile(
                                            title: Text(customerList),
                                          );
                                        },
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please Enter Customer Name';
                                          }
                                          return null;
                                        },
                                        transitionBuilder: (context,
                                            suggestionsBox, controller) {
                                          return suggestionsBox;
                                        },
                                        onSuggestionSelected: (customerList) {
                                          this._typeAheadController.text =
                                              customerList;
                                          setcustcode(customerList);
                                        },
                                      ),
                                      loader
                                          ? Positioned(
                                        top: 10,
                                        right: 10,
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          child:
                                          CircularProgressIndicator(
                                            valueColor:
                                            AlwaysStoppedAnimation<
                                                Color>(
                                                Colors.blueAccent),
                                          ),
                                        ),
                                      )
                                          : Container(),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Select Salary',
                        style: kForteenText,
                      ),
                      DropdownButton(
                        hint: _dropDownValue == null
                            ? Text(
                          'Select Any',
                          style: k18F87Black400HT,
                        )
                            : Text(
                            _dropDownValue,
                            style: k22InputText
                        ),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: k18F87Black400HT,
                        items: [
                          'Below 3 Lakhs',
                          '3 lakhs - 5 lakhs',
                          '5 lakhs - 10 lakhs',
                          '10 lakhs - 50 lakhs',
                          'Above 50 lakhs',
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

                      SizedBox(height: 15),
                      Text(
                        'Till Date',
                        style: kForteenText,
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(),
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: _fromDatecontroller,
                            style: k22InputText,
                            decoration: InputDecoration(
                                isDense: true,
                                hintText: "dd-mm-yyyy",
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
                                'Next',
                                style: k13Fwhite400BT,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EducationHistory()));
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
            ],),
          ),
        ),
        ) ),
    );
  }

  _selectTodate() async {
    DateTime pickedDate = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (context) {
        DateTime tempPickedDate = _selectedTodate ?? DateTime.now();
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
                    minimumDate: initialDate,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedTodate) {
      setState(() {
        _selectedTodate = pickedDate;
        _toDatecontroller.text = pickedDate.toString();
      });
      _toDatecontroller
        ..text = DateFormat('dd-MM-yyyy').format(_selectedTodate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _toDatecontroller.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  _selectDate() async {
    DateTime pickedDate = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (context) {
        DateTime tempPickedDate = _selectedDate ?? DateTime.now();
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

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        initialDate = pickedDate;
        _selectedDate = pickedDate;
        _fromDatecontroller.text = pickedDate.toString();
      });
      _fromDatecontroller
        ..text = DateFormat('dd-MM-yyyy').format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _fromDatecontroller.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}

//  '  Content-Type: application/json' \
//  ' x-api-key: QTuppgM7sd' \
//  'x-api-secret-key: SeKtSRvNiReVsWCOAAtwLsglmSSkai3E7bEvq3EO'
