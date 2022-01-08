import 'dart:convert';
import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'educationhistory.dart';

class AddInstitute extends StatefulWidget {
  @override
  _AddInstitute createState() => _AddInstitute();
}

class _AddInstitute extends State<AddInstitute> {
  TextEditingController _addinstitute = TextEditingController();
  TextEditingController _website = TextEditingController();
  bool _isLoading = false;
  String name = "";
  final GlobalKey<FormState> addInstituteForm = GlobalKey<FormState>();

  addInstitute() async {
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });
    Map data =
      {
        "instituteName":_addinstitute.text,
        "instituteWebsite": _website.text.isEmpty==true?"":_website.text
    };
    print(jsonEncode(data));
    var response = await dio.post(
      Api.addInstitute,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
      data: data,
    );

    if (response.statusCode == 200) {
      print(response.data);
      print(response.data['code']);
      if (response.data['code'] == 100) {
        print("trueeeeee");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EducationHistory()));
        success(response.data['message']);

        // alertbox(response.data['message']);
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
                    key: addInstituteForm,
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
                            'Add Institute',
                            style: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'PoppinsBold',
                                height: 1.3,
                                fontWeight: FontWeight.w600,
                                fontSize: 32),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Institute Name',
                            style: kForteenText,
                          ),
                          TextFormField(
                            controller: _addinstitute,
                            style: k22InputText,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "institute name",
                              hintStyle: k18F87Black400HT,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "institute cannot be empty";
                              }
                              return null;
                            },
                            onSaved: (String name) {},
                            // onChanged: (value) {
                            //   name = value;
                            //   setState(() {});
                            // },
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
                              hintText: "Institute Website",
                              hintStyle: k18F87Black400HT,
                            ),
                            style: k22InputText,
                            // validator: (value) {
                            //   if (value.isEmpty) {
                            //     return "Website cannot be empty";
                            //   }
                            //   return null;
                            // },
                            // onSaved: (String name) {},
                            // onChanged: (value) {
                            //   name = value;
                            //   setState(() {});
                            // },
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                textColor: Colors.white,
                                color: Color(0xff3E66FB),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 18, right: 10, bottom: 18),
                                  child: Text(
                                    'Submit',
                                    style: k13Fwhite400BT,
                                  ),
                                ),
                                onPressed: () {
                                  if (addInstituteForm.currentState
                                      .validate()) {
                                    addInstitute();
                                    //   // Navigator.push(
                                    //   //     context,
                                    //   //     MaterialPageRoute(
                                    //   //         builder: (context) => StartedPage()));
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
}
