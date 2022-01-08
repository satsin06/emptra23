import 'package:flutter/material.dart';
import 'package:flutter_emptra/models/getListModel/getEmailVerifyModel.dart';
import 'package:flutter_emptra/models/getListModel/getProfileinfoModel.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/adhar_webUrl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_emptra/models/getListModel/getAdhaarDetail.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:shared_preferences/shared_preferences.dart';



class EmailVerification extends StatefulWidget {
  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {

  String name = "";

  bool _isLoading = false;
  TextEditingController _name = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final aboutController = TextEditingController();

  GetPersonalInfoHistoryModel _personalInfoHistoryData;
  GetEmailVerify _getEmailVerifyData;

  getProfile() async {
    try{
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.get(
      "${Api.profileInfo}/$userId",
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
          _isLoading = false;
          print("!!!!!");
          _personalInfoHistoryData =
              GetPersonalInfoHistoryModel.fromJson(response.data);
          print(_personalInfoHistoryData);
        });
      } else {
        setState(() {
          _isLoading = false;
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(
          //       builder: (context) => Login(),
          //     ),
          //         (Route<dynamic> route) => false);
        });
      }
    } else {
      setState(() {
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(
        //       builder: (context) => Login(),
        //     ),
        //         (Route<dynamic> route) => false);
        _isLoading = false;
      });
    }
  }catch(e){
      print(e);
    }
  }

  getEmail() async {
    try{
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.get(
      "${Api.getEmailDetails}/$userId",
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
          _isLoading = false;
          _getEmailVerifyData =
              GetEmailVerify.fromJson(response.data);
          print(_getEmailVerifyData);
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
  }catch(e){
      print(e);
    }
  }

  verifyEmail() async {
    try{
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    var firstName = session.getString("firstName");
    var email = session.getString("email");
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });
    Map data = {
    "userId": userId,
    "firstName" : firstName,
    "email": email,
    };
    var response = await dio.post(
      Api.verifyEmail,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
      data: data,
    );
    if (response.statusCode == 200) {
      if (response.data['code'] == 100) {
        setState(() {
          _isLoading = false;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) =>   BottomBarIndivitual(index: 1,)));
        });
        success(response.data['message']);
      } else {
        setState(() {
          _isLoading = false;
          success(response.data['message']);
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    hello();
  }

  hello() async {
    await getEmail() ;
    await getProfile() ;
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
                                  CrossAxisAlignment.center,
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
                                    CircleAvatar(
                                      backgroundColor: Colors.indigo,
                                      radius: 50,
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/email.PNG"),
                                        radius: 50,
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                    Text(
                                      'Email Verification',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsBold',
                                          fontSize: 24),
                                    ),
                                    _getEmailVerifyData == null
                                        ? Container(
                                      width: 80,
                                      //color: Colors.amber[600],
                                      decoration: BoxDecoration(
                                          color: Color(0xffFBE4BB),
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(8))),
                                      // color: Colors.blue[600],
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(6.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons
                                                  .hourglass_top_outlined,
                                              size: 15,
                                              color: Color(0xffC47F00),
                                            ),
                                            Text(
                                              'PENDING',
                                              style: TextStyle(
                                                  color:
                                                  Color(0xffC47F00),
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontFamily:
                                                  'PoppinsLight',
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                        : _getEmailVerifyData.result.status
                                        .toString() ==
                                        "Approved"
                                        ? Container(
                                      width: 90,
                                      //color: Colors.amber[600],
                                      decoration: BoxDecoration(
                                          color: Color(0xffA7F3D0),
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(
                                                  8))),
                                      // color: Colors.blue[600],
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(
                                            6.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              size: 14,
                                              color: Colors.green,
                                            ),
                                            Text(
                                              'Approved',
                                              style: TextStyle(
                                                  color: Color(
                                                      0xff059669),
                                                  fontWeight:
                                                  FontWeight
                                                      .bold,
                                                  fontFamily:
                                                  'PoppinsLight',
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                        : _getEmailVerifyData.result.status
                                        .toString() ==
                                        "Rejected"
                                        ? Container(
                                      //color: Colors.amber[600],
                                      decoration: BoxDecoration(
                                          color:
                                          Color(0xffFECACA),
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius
                                                  .circular(
                                                  8))),
                                      // color: Colors.blue[600],
                                      alignment:
                                      Alignment.center,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets
                                            .all(6.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.cancel,
                                              size: 15,
                                              color: Colors.red,
                                            ),
                                            Text(
                                              'Rejected',
                                              style: TextStyle(
                                                  color: Colors
                                                      .red,
                                                  fontWeight:
                                                  FontWeight
                                                      .bold,
                                                  fontFamily:
                                                  'PoppinsLight',
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                        : Container(
                                      width: 80,
                                      //color: Colors.amber[600],
                                      decoration: BoxDecoration(
                                          color: Color(0xffFBE4BB),
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(8))),
                                      // color: Colors.blue[600],
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(6.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons
                                                  .hourglass_top_outlined,
                                              size: 15,
                                              color: Color(0xffC47F00),
                                            ),
                                            Text(
                                              'PENDING',
                                              style: TextStyle(
                                                  color:
                                                  Color(0xffC47F00),
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontFamily:
                                                  'PoppinsLight',
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15,top: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              'Click send button to verify your registered email id '+(_personalInfoHistoryData
                                                  .result
                                                  .personalInfo
                                                  .personal
                                                  .email
                                                  .toString())+'.'+'\n' 'We will send an email on your id with a link verify your email.',
                                              style: k20Text
                                          ),
                                           SizedBox(height: 10,),
                                           RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    5)),
                                            textColor:
                                            Colors.white,
                                            color: Color(
                                                0xff3E66FB),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets
                                                  .only(
                                                  top: 10,
                                                  bottom:
                                                  10),
                                              child: Row(
                                                mainAxisSize:
                                                MainAxisSize
                                                    .min,
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .send,
                                                    size: 20,
                                                    color: Colors
                                                        .white,
                                                  ),
                                                  Text(
                                                    'Send',
                                                    style:
                                                    k13Fwhite400BT,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onPressed:(){
                                              verifyEmail();
                                            }
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )))
                      ],
                    ),
                  ),
                ))));
  }

}

