import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/pages/individual/registration/indivitual_registration/employmenthistory.dart';
import 'package:flutter_emptra/widgets/constant.dart';


class AddCompany extends StatefulWidget {
  @override
  _AddCompany createState() => _AddCompany();
}

class _AddCompany extends State<AddCompany> {
  TextEditingController _companyName = TextEditingController();
  bool _isLoading = false;
  final GlobalKey<FormState> addCompanyForm = GlobalKey<FormState>();

  addCompany() async {
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });
    Map data = {
      "companyName": _companyName.text,
    };
    print(jsonEncode(data));
    var response = await dio.post(
      Api.addCompany,
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
            MaterialPageRoute(builder: (context) => EmploymentHistory()));
        success(response.data['message']);
      } else {
        setState(() {
          _isLoading = false;
        });
        success(response.data['message']);
      }
    }
    setState(() {
      _isLoading = false;
    });
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
              key: addCompanyForm,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Container(
                        height: 50,
                        width: 100,
                        child: Image.asset('assets/images/logo.png'),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Add Company',
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'PoppinsBold',
                          height: 1.3,
                          fontWeight: FontWeight.w600,
                          fontSize: 32),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Industry Name',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _companyName,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "Industry",
                        hintStyle: k18F87Black400HT,
                      ),
                      style: k22InputText,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "company cannot be empty";
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
                            if (addCompanyForm.currentState.validate()) {
                              addCompany();
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
