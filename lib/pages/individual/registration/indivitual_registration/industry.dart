import 'dart:convert';
import 'dart:io';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/pages/individual/registration/indivitual_registration/digilocker.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Industry extends StatefulWidget {
  @override
  _IndustryState createState() => _IndustryState();
}

class _IndustryState extends State<Industry> {

  String radioButtonItem = 'one';
  int id = 1;
  String _gender;
  String name = "";
  var list;
  var employeeId;
  var employeeName;
  bool marriedStatus = false;
  BestTutorSite _site = BestTutorSite.private;
  bool _isLoading = false;
  DateTime initialDate = DateTime.utc(1970, 1, 1);
  TextEditingController _fromDatecontroller = TextEditingController();
  DateTime _selectedFromDate;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  List<String> industryAutosuggest = [];
  GlobalKey<AutoCompleteTextFieldState<String>> addIndustryForm =
      new GlobalKey();
  final companyAutoSuggestionname = TextEditingController();

  getCustomerName() async {
    print("2232");
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });

    var response = await dio.get(
      Api.industryList,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
    );
    print(response.data);
    list = (response.data['result'][0]['industries']);
    print(list);
    for (int i = 0; i < list.length; i++) {
      industryAutosuggest.add(list[i]['industryName']);
      industryAutosuggest.add(list[i]['industryId']);
      setState(() {
        _isLoading = false;
      });
      print(industryAutosuggest);
    }
  }

  setcustcode(value) {
    print(value);
    for (int i = 0; i < list.length; i++) {
      if (list[i]['industryName'] == value) {
        setState(() {
          employeeId = list[i]['industryId'];
          employeeName = value;
        });
        print(list[i]['industryId']);
      }
    }
  }

  updateProfile() async {
    try{
    SharedPreferences session = await SharedPreferences.getInstance();
    var email = session.getString("email");
    var userId = session.getInt("userId");
    var mobileno = session.getString("mobile_no");
    var firstName = session.getString("firstName");
    var lastName = session.getString("lastName");

    var dio = Dio();
    setState(() {
      _isLoading = true;
    });
    Map data = {
      "section": "personalInfo",
      "action": "update",
      "personalInfo": {
        "personal": {
          "firstName":  firstName,
          "lastName": lastName,
          "dob": _fromDatecontroller.text,
          "email": email,
          "mobile_no": mobileno,
          "gender": _gender==""?"": _gender,
          "industryId": employeeId==null?0:employeeId,
          "industryName": employeeName==null?"":employeeName,
          "isMarried": marriedStatus ,
          "about": "",
          "website":"",
          "profilePicture": "",
        },
        "professional": {
          "occupation": "",
          "ctc": "",
        },
        "social": {
          "facebook":"",
          "twitter": "",
          "linkedin": "",
          "instagram": "",
        }
      }
    };
    print(jsonEncode(data));
    var response = await dio.put(
      "${Api.updateProfile}/$userId",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
      data: data,
    );
    print(response.data);
    if (response.statusCode == 200) {
      // print(response.data);
      if (response.data['code'] == 100) {
        setState(() {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) => DigiLocker()));
          _isLoading = false;
        });
        // alertbox(response.data['message']);
      } else {
        setState(() {
          _isLoading = false;
        });
        success(response.data['message']);
      }
      // int etid=session.getInt("etId");
    } else {
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
  void initState() {
    super.initState();
    getCustomerName();
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
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              'Save & Exit',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: 'PoppinsLight',
                                  fontSize: 14),
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
                                width: 140,
                                height: 8,
                                color: Color(0xffCBD5E1),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Personal Information',
                            style: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'PoppinsBold',
                                height: 1.3,
                                fontWeight: FontWeight.w600,
                                fontSize: 32),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Please tell us about yourself',
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'PoppinsLight',
                                fontSize: 18),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Add Industry',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black45,
                                fontFamily: 'PoppinsBold',
                                fontSize: 14),
                          ),
                          SimpleAutoCompleteTextField(
                              key: addIndustryForm,
                              style: k22InputText,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: "Insdustry",
                                hintStyle: k18F87Black400HT,
                              ),
                              controller: companyAutoSuggestionname,
                              suggestions: industryAutosuggest,
                              textChanged: (text) =>
                                  this.companyAutoSuggestionname.text,
                              clearOnSubmit: false,
                              textSubmitted: (text) => setcustcode(
                                    this.companyAutoSuggestionname.text,
                                  )
                          ),
                          SizedBox(height: 20),
                          Text(
                            'DOB',
                            style: kForteenText,
                          ),
                          GestureDetector(
                            onTap: () => _selectFromdate(),
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: _fromDatecontroller,
                                style: k22InputText,
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: "DOB",
                                  hintStyle: k18F87Black400HT,
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "DOB can't be empty";
                                  }
                                  return null;
                                },
                                onSaved: (String name) {},
                                onChanged: (value) {
                                  name = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'gender',
                            style: kForteenText,
                          ),
                          DropdownButton(
                            hint: _gender == null
                                ? Text(
                              'Select Your Gender',
                              style: k18F87Black400HT,
                            )
                                : Text(
                              _gender,
                            ),
                            isExpanded: true,
                            iconSize: 30.0,
                            style: k22InputText,
                            items: [
                              'Male',
                              'Female',
                              'Other',
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
                                  _gender = val;
                                },
                              );
                            },
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Marital Status',
                            style: kForteenText,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: <Widget>[
                              Radio(
                                value: 1,
                                groupValue: id,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonItem = 'TWO';
                                    id = 1;
                                    marriedStatus = false;
                                    print(marriedStatus);
                                  });
                                },
                              ),
                              Text(
                                'No',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: 'PoppinsLight',
                                    fontSize: 12),
                              ),
                              Radio(
                                value: 2,
                                groupValue: id,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonItem = 'One';
                                    id = 2;
                                    marriedStatus = true;
                                    print(marriedStatus);
                                  });
                                },
                              ),
                              Text(
                                'Yes',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: 'PoppinsLight',
                                    fontSize: 12),
                              ),
                            ],
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
                                      'Submit & Next ',
                                      style: k13Fwhite400BT,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formkey.currentState.validate()) {
                                      updateProfile();
                                    }
                                  }
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
        initialDate=pickedDate;
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

  radioButton() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            children: <Widget>[
              ListTile(
                title: const Text('Yes'),
                leading: Radio(
                  value: BestTutorSite.private,
                  groupValue: _site,
                  onChanged: (BestTutorSite value) {
                    setState(() {
                      print(_site);
                      _site = value;
                      marriedStatus = true;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('No'),
                leading: Radio(
                  value: BestTutorSite.goverment,
                  groupValue: _site,
                  onChanged: (BestTutorSite value) {
                    setState(() {
                      _site = value;
                      print(_site);
                      marriedStatus = false;
                    });
                  },
                ),
              ),
            ],
          );
        });
  }
}
enum BestTutorSite { private, goverment, both }