import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/models/getListModel/getEmployeementModel.dart';
import 'package:flutter_emptra/pages/individual/add/about/hrdetail_add.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'dart:convert';
import 'dart:io';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExperienceAdd extends StatefulWidget {
  @override
  _ExperienceAddState createState() => _ExperienceAddState();
}

class _ExperienceAddState extends State<ExperienceAdd> {
  String name = "";
  bool changeButton = false;
  bool _checkbox = true;
  final maxLines = 4;
  final aboutController = TextEditingController();
  int id = 1;
  DateTime  initialDate= DateTime.utc(1970, 1, 1);
  // String userId = '406451';
// String userId = '406451';
  TextEditingController _designation = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String employementStatus;
  bool _isLoading = false;
  DateTime _selectedDate;
  DateTime _selectedTodate;
  TextEditingController _toDatecontroller = TextEditingController();
  TextEditingController _website = TextEditingController();
  TextEditingController _fromDatecontroller = TextEditingController();
  var list;
  var employeeId;
  GetEmployeementHistoryModel _employmentHistoryData;
  List<String> industryAutosuggest = [];
  GlobalKey<AutoCompleteTextFieldState<String>> companyname = new GlobalKey();
  final companyAutoSuggestionname = TextEditingController();
  // List employementList = [];
  var isworking;
  List customerList = [];
  final TextEditingController _typeAheadController = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState> key = new GlobalKey();
  bool loader = false;
  var textValue;

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
      "about":aboutController.text,
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
      if (response.data['code'] == 100) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    BottomBarIndivitual()
                    // HrDetailAdd(
                    //     data:
                    //     _employmentHistoryData,
                    //     index: index)
        ));

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



  @override
  void initState() {
    super.initState();
    getCompanyName(name);
 //   addEmployment();
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
              child: Padding(
                padding: const EdgeInsets.all(18.0),
              child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      icon: Icon(Icons.close,size: 30,),
                      onPressed: () {
                        Navigator.pop(context);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             BottomBarIndivitual()));
                      },
                    ),),
                    SizedBox(height: 20),
                    Text(
                      'Add Experience',
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'PoppinsBold',
                          height: 1.3,
                          fontWeight: FontWeight.w600,
                          fontSize: 32),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Please tell us where are you currently working',
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'PoppinsLight',
                          fontSize: 18),
                    ),
                    SizedBox(height: 30),
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
                                            hintStyle: k18F87Black400HT ),
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

                    SizedBox(height: 15),
                    Text(
                      'Job Title',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _designation,
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: "Software Engineer",
                          hintStyle: k18F87Black400HT ),
                      style: k22InputText,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Job title cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (String name) {},
                      onChanged: (value) {
                        name = value;
                        setState(() {
                          //putOtp = true;
                        });
                      },
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Website',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _website,
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: "truegy.in",
                          hintStyle: k18F87Black400HT ),
                      style: k22InputText,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "website cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (String name) {},
                      onChanged: (value) {
                        name = value;
                        setState(() {
                          //putOtp = true;
                        });
                      },
                    ),
                    SizedBox(height: 15),
                    Text(
                      'From',
                      style: kForteenText,
                    ),
                    GestureDetector(
                      onTap: () => _selectDate(),
                      child: AbsorbPointer(
                        child: TextField(
                          controller: _fromDatecontroller,
                          style: k22InputText,
                          decoration: InputDecoration(
                              isDense: true,
                              hintText: "Start Date",
                              hintStyle: k18F87Black400HT ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    isworking == 'true'
                        ? SizedBox()
                        : Text(
                      'To',
                      style: kForteenText,
                    ),
                    isworking == 'true'
                        ? SizedBox()
                        : GestureDetector(
                      onTap: () => _selectTodate(),
                      child: AbsorbPointer(
                        child: TextField(
                          controller: _toDatecontroller,
                          style: k22InputText,
                          decoration: InputDecoration(
                              isDense: true,
                              hintText: "End Date",
                              hintStyle: k18F87Black400HT ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          value: _checkbox,
                          onChanged: (value) {
                            setState(() {
                              _checkbox = !_checkbox;
                            });
                            if (_checkbox) {
                              setState(() {
                                isworking = 'true';
                              });
                            } else if (!_checkbox) {
                              setState(() {
                                isworking = 'false';
                              });
                            }
                          },
                        ),
                        Text(
                          'I am currently working',
                          style: kForteenText,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'About the job',
                      style: kForteenText,
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: maxLines * 24.0,
                      child: TextField(
                        maxLines: maxLines,
                        style: k22InputText,
                        decoration: InputDecoration(
                          hintText: "About Your Role",
                          hintStyle: k18F87Black400HT ,
                          fillColor: Colors.grey[100],
                          filled: true,
                        ),
                        controller: aboutController,
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
                            padding:EdgeInsets.all(15.0),
                            child: Text(
                              'Save & Next',
                              style: k13Fwhite400BT,
                            ),
                          ),
                          onPressed: () {
                            addEmployment();
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
                    //maximumDate:DateTime.now(),
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
        initialDate=pickedDate;
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
