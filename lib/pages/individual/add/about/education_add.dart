
import 'package:flutter_emptra/pages/individual/add/about/institute_add.dart';
import 'package:flutter_emptra/pages/individual/uploadDocument/education_upload_document.dart';
import 'dart:convert';
import 'dart:io';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EducationAdd extends StatefulWidget {
  @override
  _EducationAddState createState() => _EducationAddState();
}

class _EducationAddState extends State<EducationAdd> {
//  int userId = 764502;
//  String userId = "764502";
  String name = "";
  DateTime initialDate = DateTime.utc(1970, 1, 1);
  bool changeButton = false;
  bool _checkbox = true;
  final maxLines = 4;
  int id = 1;
  final aboutController = TextEditingController();
  TextEditingController _name = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String employementStatus;
  bool _isLoading = false;
  DateTime _selectedFromDate;
  DateTime _selectedTodate;
  TextEditingController _toDatecontroller = TextEditingController();
  TextEditingController _fromDatecontroller = TextEditingController();
  TextEditingController _cgpaText = TextEditingController();
  TextEditingController _website = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<String>> institutename = new GlobalKey();
  final companyAutoSuggestionname = TextEditingController();
  List<String> customerAutosuggest = [];
  List educationList = [];
  var list;
  var employeeId;
  var currentluStudy;
  var instituteName;

  @override
  void initState() {
    super.initState();
    getInstituteName();
  }

  addEducation() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    var currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });
    Map data = {
      "userId": userId,
      "instituteId": employeeId,
      "instituteName": instituteName,
      "specialization": _name.text,
      "cgpa": _cgpaText.text,
      "website":_website.text,
      "isWorking": _checkbox,
      "from": _fromDatecontroller.text,
      "to": _toDatecontroller.text == null || _toDatecontroller.text == ''
          ? currentDate
          : _toDatecontroller.text
    };

    print("${Api.addeducationHistory}/$userId");
    print(jsonEncode(data));
    var response = await dio.post("${Api.addeducationHistory}",
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
            MaterialPageRoute(builder: (context) => BottomBarIndivitual()));
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
  getInstituteName() async {
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });

    var response = await dio.get(
      Api.instituteList,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
    );
    print(response.data);
    if (response.data['code'] == 100) {
      list = (response.data['result']);
      for (int i = 0; i < list.length; i++) {
        customerAutosuggest.add(list[i]['instituteName']);
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      print("Nott");
    }
    setState(() {
      currentluStudy = 'Yes';
    });
  }

  setcustcode(value) {
    print(value);
    for (int i = 0; i < list.length; i++) {
      if (list[i]['instituteName'] == value) {
        print(list[i]);
        setState(() {
          employeeId = list[i]['_id'];
          instituteName = value;
        });
        print(list[i]['_id']);
      }
    }
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
                              //               index: 0,
                              //             )));
                            },
                          ),),
                          SizedBox(height: 20),
                          Text(
                            'Add Education',
                            style: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'PoppinsBold',
                                height: 1.3,
                                fontWeight: FontWeight.w600,
                                fontSize: 32),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Please tell us where are you currently studying',
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'PoppinsLight',
                                fontSize: 18),
                          ),

                          SizedBox(height: 30),
                          Text(
                            'Study',
                            style: kForteenText,
                          ),
                          TextFormField(
                            controller: _name,
                            style: k22InputText,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "B.Tech Computer Science",
                              hintStyle: k18F87Black400HT,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Name cannot be empty";
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
                            'Institution',
                            style: kForteenText,
                          ),
                          SimpleAutoCompleteTextField(
                              key: institutename,
                              style: k22InputText,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: "Institute name",
                                hintStyle: k18F87Black400HT,
                              ),
                              controller: companyAutoSuggestionname,
                              suggestions: customerAutosuggest,
                              textChanged: (text) =>
                                  this.companyAutoSuggestionname.text,
                              clearOnSubmit: false,
                              textSubmitted: (text) => setcustcode(
                                    this.companyAutoSuggestionname.text,
                                  )),
                          SizedBox(height: 25),
                          Text(
                            'Website',
                            style: kForteenText,
                          ),
                          TextFormField(
                            controller: _website,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "www.google.com",
                              hintStyle: k18F87Black400HT,
                            ),
                            style: k22InputText,
                            // validator: (value) {
                            //   if (value.isEmpty) {
                            //     return "Website cannot be empty";
                            //   }
                            //   return null;
                            // },
                            onSaved: (String name) {},
                            onChanged: (value) {
                              name = value;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 32,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Can't find your institute?",
                                  style: k16F87Black400HT,
                                ),
                                TextButton(
                                  child: Text(
                                    "add here",
                                    style: TextStyle(
                                        color: Colors.indigo,
                                        fontFamily: 'Inter',
                                        fontSize: 16),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>InstituteAdd()));
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 25),
                          Text(
                            'CGPA',
                            style: kForteenText,
                          ),
                          TextFormField(
                            controller: _cgpaText,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "8.5",
                              hintStyle: k18F87Black400HT,
                            ),
                            keyboardType: TextInputType.number,
                            style: k22InputText,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "CGPA cannot be empty";
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
                            'From',
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
                                  hintText: "Start Date",
                                  hintStyle: k18F87Black400HT,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 25),
                          currentluStudy != null
                              ? SizedBox()
                              : Text(
                                  'To',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45,
                                      fontFamily: 'PoppinsBold',
                                      fontSize: 14),
                                ),
                          currentluStudy != null
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
                                        hintStyle: k18F87Black400HT,
                                      ),
                                    ),
                                  ),
                                ),
                          Row(
                            children: [
                              Checkbox(
                                value: _checkbox,
                                onChanged: (value) {
                                  setState(() {
                                    _checkbox = !_checkbox;
                                    if (_checkbox) {
                                      currentluStudy = 'Yes';
                                      print(currentluStudy);
                                    } else {
                                      currentluStudy = null;
                                      print(currentluStudy);
                                    }
                                  });
                                },
                              ),
                              Text(
                                'I am currently studing',
                                style: kForteenText,
                              ),
                            ],
                          ),
                          // ignore: deprecated_member_use
                          SizedBox(height: 20),
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
                                    'Save & Next',
                                    style: k13Fwhite400BT,
                                  ),
                                ),
                                onPressed: () {
                                  addEducation();
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
        initialDate = pickedDate;
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
