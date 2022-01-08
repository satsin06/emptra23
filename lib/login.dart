import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/pages/individual/registration/indivitual_registration/new_registration.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:flutter_emptra/widgets/dialog_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String name = "";
  bool changeButton = false;
  Map basic;
  bool _isLoading = false;
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _otp = TextEditingController();
  bool putOtp = false;
  var chechOtp;
  final GlobalKey<FormState> _phoneVerifyform = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneNumber?.dispose();
    _otp?.dispose();
    super.dispose();
  }

  checkPhone(BuildContext context) async {
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });
    Map data = {
      "phone": _phoneNumber.text,
    };
    print(jsonEncode(data));
    var response = await dio.post(
      Api.checkPhone,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
      data: data,
    );
    print(response.data);
    if (response.statusCode == 200) {
      if (response.data['code'] == 100) {
        setState(() {
          _isLoading = false;
          sendOtp();
        });
      } else {
        setState(() {
          basic = {
            "phone": _phoneNumber.text.trim(),
          };
          _isLoading = false;
        });
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => IndividualSignUp(basic: basic
            )));
        DialogUtils.successDialog(context, response.data['message']);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  sendOtp() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });
    // int etId = session.getInt("etId");
    Map data = {
      //  "userId": session.getInt("etId"),
      //"userId": session.getInt("userId"),
      // id h int  or  ("etId").toString
      "ph_no": _phoneNumber.text.trim()
    }; //phone h string  or    _phoneNumber.toInt
    print(jsonEncode(data));
    var response = await dio.post(
      Api.sendOtp,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
      data: data,
    );
    print(response.data);
    if (response.statusCode == 200) {
      print(response.data['code']);
      if (response.data['code'] == 100) {
        print("trueeeeee");
        String verificationId = response.data['verificationId'];
        // int userId = response.data['etId'];
        session.setString("verificationId", verificationId);
        print(response.data['verificationId']);
        setState(() {
          chechOtp = response.data['chechOtp'];
          putOtp = true;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        DialogUtils.successDialog(context, response.data['message']);
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  verifyOtp() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });
    Map data = {
      "ph_no": _phoneNumber.text.trim(),
      "otp": _otp.text,
      "verificationId": session.getString("verificationId"),
    };
    //print(jsonEncode(data));
    var response = await dio.post(
      Api.verifyOtp,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
      data: data,
    );
    if (response.statusCode == 200) {
      print(response.data['code']);
      if (response.data['code'] == 100) {
        int userId = response.data['response']['userId'];
        session.setInt("userId", userId);
        String email = response.data['response']['email'];
        session.setString("email", email);
        String token = response.data['token'];
        session.setString("token", token);
        String mobileNo = response.data['response']['mobile_no'];
        session.setString("mobile_no", mobileNo);

        // print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
        // print(response.data['response']['email']);
        // print(response.data['response']['userId']);
        // print(response.data['token']);
        // print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
        // int etId = response.data['etId'];
        // // int userId = response.data['etId'];
        // session.setInt("etId", etId);
        // session.setInt("userId", userId);
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => BottomBarIndivitual()));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => BottomBarIndivitual(),
            ),
            (Route<dynamic> route) => false);
        // alertbox(response.data['message']);
      } else {
        DialogUtils.successDialog(context, response.data['message']);
      }
      // int etid=session.getInt("etId");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _listenOtp() async{
    await SmsAutoFill().listenForCode;
  }
  void initState(){
    super.initState();
    _listenOtp();
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
                    key: _phoneVerifyform,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   children: [
                        //     Container(
                        //       height: 220,
                        //       width: 200,
                        //       child: Image.asset(
                        //         'assets/images/autherization.png', // and width here
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Container(
                          height: 80,
                          width: 120,
                          child: Image.asset(
                            'assets/images/logofin.png', // and width here
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.black87,
                              height: 1.2,
                              fontFamily: 'PoppinsBold',
                              fontWeight: FontWeight.w500,
                              fontSize: 32),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Get access to Verified Information of',
                          style: k16F87Black400HT,
                        ),
                        Text(
                          'an Individual',
                          style: k16F87Black400HT,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Phone Number',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45,
                                    fontFamily: 'PoppinsBold',
                                    fontSize: 14),
                              ),
                              putOtp == false
                                  ? TextFormField(
                                      controller: _phoneNumber,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintStyle: TextStyle(
                                          height: 1.5,
                                          fontSize: 18.0,
                                          fontFamily: 'PoppinsLight',
                                          color: Colors.black87,
                                        ),
                                        hintText: "Enter Your phone Number",
                                      ),
                                      style: k22InputText,
                                   keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Phone Number cannot be empty";
                                        } else if (value.length < 10) {
                                          return "Phone Number length should be atleast 10";
                                        }
                                        return null;
                                      },
                                      onSaved: (String name) {},
                                      onChanged: (value) {
                                        name = value;
                                        setState(() {});
                                      },
                                    )
                                  :  Stack(
                                children: <Widget>[
                                  TextFormField(
                                        enabled: false,
                                        controller: _phoneNumber,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintStyle: TextStyle(
                                            height: 1.5,
                                            fontSize: 18.0,
                                            fontFamily: 'PoppinsLight',
                                            color: Colors.black87,
                                          ),
                                          hintText: "Enter Your phone Number",
                                        ),
                                        style: k22InputText,
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Phone Number cannot be empty";
                                          } else if (value.length < 10) {
                                            return "Phone Number length should be atleast 10";
                                          }
                                          return null;
                                        },
                                        onSaved: (String name) {},
                                        onChanged: (value) {
                                          name = value;
                                          setState(() {});
                                        },
                                      ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        child: Text(
                                          "Edit Mobile",
                                          style: TextStyle(
                                            color: Color(0xff3E66FB),
                                                        fontSize: 16,
                                                        fontFamily: 'PoppinsLight',
                                                      ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>Login()));
                                        },
                                      ),
                                    ],
                                  ),

                                ]  ),
                            ],
                          ),
                        ),
                        putOtp == false
                            ?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7)),
                                    textColor: Colors.white,
                                    color: Color(0xff3E66FB),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                      child: Text(
                                        "Send OTP",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'PoppinsLight',
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      final signcode =await SmsAutoFill().getAppSignature;
                                      if (_phoneVerifyform.currentState
                                          .validate()) {
                                        checkPhone(context);
                                      }
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             BottomBarIndivitual()));
                                    },
                                  ),
                                SizedBox(width: 20,)
                              ],
                            )
                            :SizedBox(),

                        Visibility(
                            child: SizedBox(
                          height: 10,
                        )),
                        Visibility(
                          visible: putOtp,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  'Verify OTP',
                                  style: kForteenText,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: putOtp,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0,left: 20,right: 20),
                            child: PinFieldAutoFill(
                              codeLength: 6,
                              decoration: UnderlineDecoration(
                                textStyle: k22InputText,
                                colorBuilder: FixedColorBuilder(
                                    Colors.black12),
                              ),
                              cursor: Cursor(
                                width: 1.5,
                                height: 20,
                                color: Colors.grey,
                                radius: Radius.circular(1),
                                enabled: true,
                              ),
                              controller: _otp,
                              onCodeChanged: (val){
                                print(val);
                              },
                            ),
                            // TextFormField(
                            //   controller: _otp,
                            //   style: k22InputText,
                            //   decoration: InputDecoration(
                            //     isDense: true,
                            //     hintText: "@OTP",
                            //     hintStyle: k18F87Black400HT,
                            //   ),
                            //  keyboardType: TextInputType.number,
                            //   validator: (value) {
                            //     if (value.isEmpty) {
                            //       return "otpcannot be empty";
                            //     }
                            //     return null;
                            //   },
                            //   onSaved: (String name) {},
                            //   onChanged: (value) {
                            //     name = value;
                            //     setState(() {});
                            //   },
                            // ),
                          ),
                        ),
                        Visibility(
                          visible: putOtp,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0,left: 20),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7)),
                                  textColor: Colors.white,
                                  color: Color(0xff3E66FB),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Text(
                                      "Verify OTP",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'PoppinsLight',
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_phoneVerifyform.currentState.validate()) {
                                      verifyOtp();
                                    }
                                  },
                                ),
                                SizedBox(width: 20,)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Column(
                          children: [
                            Container(
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "By logging in, you agree to our",
                                    style: k13Fblack400BT,
                                  ),
                                  TextButton(
                                    child: Text(
                                      "Terms and Conditions",
                                      style: TextStyle(
                                          color: Colors.indigo,
                                          fontFamily: 'Inter',
                                          fontSize: 13),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>Login()));
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    child: Text(
                                      "Privacy Policy",
                                      style: TextStyle(
                                          color: Colors.indigo,
                                          fontFamily: 'Inter',
                                          fontSize: 13),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>Login()));
                                    },
                                  ),
                                  Text(
                                    "&",
                                    style: k13Fblack400BT,
                                  ),
                                  TextButton(
                                    child: Text(
                                      "Get In Touch",
                                      style: TextStyle(
                                          color: Colors.indigo,
                                          fontFamily: 'Inter',
                                          fontSize: 13),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>Login()));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: 250,
                          width: 250,
                          child: Image.asset(
                            'assets/images/loginUpper.png', // and width here
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
