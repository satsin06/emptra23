import 'dart:convert';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/pages/individual/uploadDocument/certificate_uplaod_document.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';


class CertificateAdd extends StatefulWidget {
  @override
  _CertificateAddState createState() => _CertificateAddState();
}

class _CertificateAddState extends State<CertificateAdd> {
  String name = "";
  bool changeButton = false;
//  String etID = '285885';
  DateTime  initialDate= DateTime.utc(1970, 1, 1);
  String employementStatus;
  bool _isLoading = false;
  DateTime _selectedTodate;
  DateTime _selectedFromDate;
  TextEditingController _toDatecontroller = TextEditingController();
  TextEditingController _fromDatecontroller = TextEditingController();
  TextEditingController _organizeName = TextEditingController();
  TextEditingController _certificate = TextEditingController();
  TextEditingController _percentage = TextEditingController();
  TextEditingController _otherDetail = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  addCertificate() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });

    var dio = Dio();
    Map data = {
      "userId": userId,
      "organizationName": _organizeName.text,
      "certificateName": _certificate.text,
      "dateFrom": _fromDatecontroller.text,
      "dateTo":  _toDatecontroller.text,
      "description": _otherDetail.text,
    };

    print(data);
    print("${Api.addCertificate}");
    print(jsonEncode(data));
    var response = await dio.post("${Api.addCertificate}",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
          "versionnumber": "v1"
        }),
        data: data);
    print(response.data);
    if (response.statusCode == 200) {
      //employmentHistory();

      if (response.data['code'] == 100) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BottomBarIndivitual(  index: 2,)));
        success(response.data['message']);

        setState(() {
          _isLoading = false;
          //    employmentHistory();
        });
      }
      else {
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


  // @override
  // void initState() {
  //   super.initState();
  //   addCertificate();
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
                  child:  IconButton(
                      icon: Icon(Icons.close,size: 30,),
                      onPressed: () {
                        Navigator.pop(context);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             BottomBarIndivitual(  index: 2,)));
                      },
                    ),),
                    SizedBox(height: 20),
                    Text(
                      'Update Learning Stats',
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'PoppinsBold',
                          height: 1.3,
                          fontWeight: FontWeight.w600,
                          fontSize: 32),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Organization Name',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _organizeName,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "Organization Name",
                        hintStyle: k18F87Black400HT,
                      ),
                      style: k22InputText,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Organization Name cannot be empty";
                        } else if (value.length > 22) {
                          return "Organization Name length not more than 22";
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
                      'Certificate',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _certificate,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'certificate',
                        hintStyle: k18F87Black400HT,
                      ),
                      style: k22InputText,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "certificate cannot be empty";
                        } else if (value.length > 22) {
                          return "certificate length not more than 22";
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
                              hintStyle: k18F87Black400HT ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    Text(
                      'To',
                      style: kForteenText,
                    ),
                    GestureDetector(
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
                    SizedBox(height: 25),
                    Text(
                      'Course Completed in Percentage',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _percentage,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "%100",
                        hintStyle: k18F87Black400HT,
                      ),
                      style: k22InputText,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Course cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (String name) {},
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height:20),
                    Text(
                      'Other Detail',
                      style: kForteenText,
                    ),
                    SizedBox(height: 12),

                    TextField(
                      style: k22InputText,
                      //maxLines: maxLines,
                      decoration: InputDecoration(
                        hintText: "other Details",
                        hintStyle: k18F87Black400HT,
                        fillColor: Colors.grey[100],
                        filled: true,
                      ),
                      controller: _otherDetail,

                    ),
                    SizedBox(height:20),
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
                            if (_formkey.currentState.validate()) {
                              addCertificate();
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
}



// class Holder {
//   static getEducationHistory();
//
//   static double number = 12345 ;
//
//
//   static void message(){
//
//     print('You are Calling Static Method');
//   }
//
// }