import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/pages/individual/registration/indivitual_registration/started.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';

class IndividualSignUp extends StatefulWidget {
  final Map basic;
  IndividualSignUp({this.basic});
  @override
  _IndivitualSignUpState createState() => _IndivitualSignUpState();
}

class _IndivitualSignUpState extends State<IndividualSignUp> {
  String name = "";
  bool changeButton = false;

  int id = 1;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  BestTutorSite _site = BestTutorSite.private;

  bool _isLoading = false;
  TextEditingController _name = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController _email = TextEditingController();
  String employementStatus = '1';
  String radioButtonItem = 'one';
  TextEditingController _otp = TextEditingController();

  bool submitbutton = false;
  bool putOtp = false;
  var checkOtp;

  @override
  void dispose() {
    _name?.dispose();
    lastName?.dispose();
    _email?.dispose();
    _otp?.dispose();
    super.dispose();
  }

  sendOtp() async {
    try{
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
      "ph_no": "${widget.basic["phone"]}",
    };
    print(jsonEncode(data));//phone h string  or    _phoneNumber.toInt
    var response = await dio.post(
      Api.sendOtp,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
      data: data,
    );
  //  print(response.data);
    if (response.statusCode == 200) {
  //    print(response.data['code']);
      if (response.data['code'] == 100) {
        print("trueeeettttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttee");
        String verificationId = response.data['verificationId'];
        // int userId = response.data['etId'];
        session.setString("verificationId", verificationId);
        print(response.data['verificationId']);
        setState(() {
          checkOtp = response.data['checkOtp'];
          putOtp = true;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      //  success(response.data['message']);
      }
    }
    setState(() {
      _isLoading = false;
    });
  }
    catch(e){
      print(e);
    }
  }

  verifyOtp() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });
    Map data = {
      "ph_no": "${widget.basic["phone"]}",
      "otp": _otp.text,
      "verificationId": session.getString("verificationId"),
    };
    var response = await dio.post(
      Api.verifyOtp,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
      data: data,
    );
   // print(response.data);
    if (response.statusCode == 200) {
    //  print(response.data['code']);
      if (response.data['code'] == 106) {
        // int userId = response.data['response']['userId'];
        // session.setInt("userId", userId);
        setState(() {
          checkOtp = response.data['checkOtp'];
          putOtp = false;
          submitbutton = true;
        });
        print("vinayyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
       // success(response.data['message']);
        //extra code likh kr rakhaa h for future use
        // int etId = response.data['etId'];
        // // int userId = response.data['etId'];
        // session.setInt("etId", etId);
        // session.setInt("userId", userId);
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => BottomBarIndivitual()));
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(
        //       builder: (context) => BottomBarIndivitual(),
        //     ),
        //         (Route<dynamic> route) => false);
        // alertbox(response.data['message']);
      } else {
        setState(() {
          _isLoading = false;
        });
        //success(response.data['message']);
      }
      // int etid=session.getInt("etId");
      setState(() {
        _isLoading = false;
      });
    }
  }


  signup() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });
    Map data = {
      "mobile_no": "${widget.basic["phone"]}",
      "firstName": _name.text,
      "lastName": lastName.text,
      "email": _email.text,
      "employmentStatus": employementStatus,
    };
   // print(jsonEncode(data));
    var response = await dio.post(
      Api.register,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
      data: data,
    );
   // print(response.data);
    if (response.statusCode == 200) {
      // print(response.data);
      // print(response.data['code']);
      if (response.data['code'] == 100) {
        // session.setInt("userId", userId);
       // print(response.data);
        print("bnbnbnbnbnbnbnbnbnbnbnbnbnbnbnnnnbnbnnnbnbnnbnb");
        setState(() {
          success(response.data['message']);
          _isLoading = false;
        });
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
    loginVerify();
  }
    //await Future.delayed(Duration(seconds:2),

    //);
  // hello() async {
  //   try {
  //     signup();
  //     await Future.delayed(Duration(seconds:2), loginVerify());
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  loginVerify() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });
    Map data = {
      "ph_no": "${widget.basic["phone"]}",
      "otp": _otp.text,
      "verificationId": session.getString("verificationId"),
    };
   // print(jsonEncode(data));
    var response = await dio.post(
      Api.verifyLogin,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
      data: data,
    );
    if (response.statusCode == 200) {
     //print(response.data['code']);
      if (response.data['code'] == 100) {
        setState(() {
          int userId = response.data['response']['userId'];
          session.setInt("userId", userId);
          String email = response.data['response']['email'];
          session.setString("email", email);
          String firstName = response.data['response']['firstName'];
          session.setString("firstName", firstName);
          String lastName = response.data['response']['lastName'];
          session.setString("lastName", lastName);
          String mobileNo = response.data['response']['mobile_no'];
          session.setString("mobile_no", mobileNo);
          String token = response.data['token'];
          session.setString("token", token);
          _isLoading = false;
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) => Started()));
        });
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
                    Center(
                      child: Container(
                        height: 50,
                        width: 100,
                        child: Image.asset('assets/images/logofin.png'),
                      ),
                    ),
                    Text(
                      'Create your \naccount',
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'PoppinsBold',
                          height: 1.3,
                          fontWeight: FontWeight.w600,
                          fontSize: 32),
                    ),
                    SizedBox(height: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone Number',
                          style: kForteenText,
                        ),
                        (putOtp == false && submitbutton == false)
                            ? Text(
                         "${widget.basic["phone"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                            fontFamily: 'PoppinsLight',
                            fontSize: 22,
                            decoration: TextDecoration.underline,
                          ),
                        )
                            : (putOtp == true && submitbutton == false)
                            ? Stack(children: <Widget>[
                          Text(
                            "${widget.basic["phone"]}"
                            ,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
                              fontFamily: 'PoppinsLight',
                              fontSize: 22,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.end,
                            children: [
                              TextButton(
                                child: Text(
                                  "Resend OTP",
                                  style: TextStyle(
                                    color: Color(0xff3E66FB),
                                    fontSize: 16,
                                    fontFamily: 'PoppinsLight',
                                  ),
                                ),
                                onPressed: () {
                                  sendOtp();
                                },
                              ),
                            ],
                          ),
                        ])
                            : Text(
                          "${widget.basic["phone"]}"
                          ,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                            fontFamily: 'PoppinsLight',
                            fontSize: 22,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    (putOtp == false && submitbutton == false)
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(7)),
                          textColor: Colors.white,
                          color: Color(0xff3E66FB),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10),
                            child: Text("Send OTP",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'PoppinsLight',
                                )),
                          ),
                          onPressed: () {
                            sendOtp();
                          },
                        ),
                      ],
                    )
                        : SizedBox(),

                    // Center(
                    //         child: RaisedButton(
                    //           shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(7)),
                    //           textColor: Colors.white,
                    //           color: Color(0xff3E66FB),
                    //           child: Padding(
                    //             padding: const EdgeInsets.only(
                    //                 left: 65,
                    //                 right: 65,
                    //                 top: 10,
                    //                 bottom: 10),
                    //             child: Text(
                    //               "Edit Mobile",
                    //               style: k13Fwhite400BT,
                    //             ),
                    //           ),
                    //           onPressed: () {
                    //             // if (_phoneVerifyform.currentState
                    //             //     .validate()) {
                    //             //   checkPhone();
                    //             // }
                    //             Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                     builder: (context) =>
                    //                         IndividualSignUp()));
                    //           },
                    //         ),
                    //       ),
                    Visibility(
                      visible: putOtp,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Verify OTP',
                            style: kForteenText,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: putOtp,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0,left: 10,right: 10),
                            child: PinFieldAutoFill(
                              codeLength: 6,
                              decoration: UnderlineDecoration(
                                textStyle: k22InputText,
                                colorBuilder: FixedColorBuilder(
                                    Colors.grey),
                              ),
                              cursor: Cursor(
                                width: 1.5,
                                height: 20,
                                color: Colors.grey,
                                radius: Radius.circular(1),
                                enabled: false,
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
                        ],
                      ),
                    ),
                    Visibility(
                      visible: putOtp,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: Text(
                              "Verify OTP",
                              style: TextStyle(
                                color: Color(0xff3E66FB),
                                fontSize: 16,
                                fontFamily: 'PoppinsLight',
                              ),
                            ),
                            onPressed: () {

                              verifyOtp();

                              // if (_phoneVerifyform.currentState
                              //     .validate()) {
                              //   checkPhone();
                              // }
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             IndividualSignUp()));
                            },
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                        visible: putOtp,
                        child: SizedBox(
                          height: 15,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: submitbutton,
                      child: Text(
                        'First Name',
                        style: kForteenText,
                      ),
                    ),
              Visibility(
                visible: submitbutton,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.always, controller: _name,
                      style: k22InputText,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "John",
                        hintStyle: k18F87Black400HT,
                      ),


                  validator: (value) {
                    if (value.isEmpty) {
                      return "First Name cannot be empty";
                    } else if (value.length > 15) {
                      return "First Name length not more than 15 words";
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
                    SizedBox(height: 20),
                    Visibility(
                      visible: submitbutton,
                      child:Text(
                      'Last Name',
                      style: kForteenText,
                    ),),
                    Visibility(
                      visible: submitbutton,
                      child:TextFormField(
                      controller: lastName,
                      style: k22InputText,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "Smith",
                        hintStyle: k18F87Black400HT,
                      ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Last Name cannot be empty";
                          } else if (value.length > 15) {
                            return "Last Name length not more than 15 words";
                          }
                          return null;
                        },
                      onSaved: (String name) {},
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
                    ),),
                    SizedBox(height: 20),
                    Visibility(
                      visible: submitbutton,
                      child: Text(
                      'E-mail',
                      style: kForteenText,
                    ),),
                    Visibility(
                      visible: submitbutton,
                      child: TextFormField(
                      controller: _email,
                      style: k22InputText,
                      decoration: InputDecoration(
                        isDense: true,
                        hintStyle: k18F87Black400HT,
                        hintText: "example@gmail.com",
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter  email";
                        }
                        if (!RegExp(
                            "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return "Please enter valid email";
                        }
                        return null;
                      },
                      onSaved: (String email) {},
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
                    ),),
                    SizedBox(height: 20),
                    Visibility(
                      visible: submitbutton,
                      child:  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 1,
                          groupValue: id,
                          onChanged: (val) {
                            setState(() {
                              radioButtonItem = 'One';
                              id = 1;
                              employementStatus = '1';
                              print(employementStatus);
                            });
                          },
                        ),
                        Text(
                          'Student',
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
                              radioButtonItem = 'TWO';
                              id = 2;
                              employementStatus = '2';
                              print(employementStatus);
                            });
                          },
                        ),
                        Text(
                          'Employed',
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'PoppinsLight',
                              fontSize: 12),
                        ),
                        Radio(
                          value: 3,
                          groupValue: id,
                          onChanged: (val) {
                            setState(() {
                              radioButtonItem = 'THREE';
                              id = 3;
                              employementStatus = '3';
                              print(employementStatus);
                            });
                          },
                        ),
                        Text(
                          'Self Employed',
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'PoppinsLight',
                              fontSize: 12),
                        ),
                      ],
                    ),),
                    SizedBox(height: 15),
                    Visibility(
                      visible: submitbutton,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            textColor: Colors.white,
                            color: Color(0xff3E66FB),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10),
                              child: Text(
                                'Submit',
                                style: k13Fwhite400BT,
                              ),
                            ),
                            onPressed: () {
                              if (_formkey.currentState.validate()) {
                                signup();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     // ignore: deprecated_member_use
                    //     RaisedButton(
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(5)),
                    //       textColor: Colors.white,
                    //       color: Color(0xff3E66FB),
                    //       child: Padding(
                    //         padding: const EdgeInsets.only(
                    //             left: 10, top: 18, right: 10, bottom: 18),
                    //         child: Text(
                    //           'Submit',
                    //           style: k13Fwhite400BT,
                    //         ),
                    //       ),
                    //       onPressed: () {
                    //         if (_formkey.currentState.validate()) {
                    //           // signup();
                    //           // Navigator.push(
                    //           //     context,
                    //           //     MaterialPageRoute(
                    //           //         builder: (context) => StartedPage()));
                    //         }
                    //       },
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Future registrationUser() async {
  //   // url to registration php script
  //   var aPIURL = "https://www.emptra.com/api/registration.php";
  //   //json maping user entered details
  //   Map mapeddate = {
  //     'full_name': _name.text,
  //     'email': _email.text.trim(),
  //     'phone_no': _phone.text.trim(),
  //     'password': _password.text.trim(),
  //   }; //send  data using http post to our php code
  //   print("JSON DATA: ${mapeddate}");
  //   var response = await http.post(aPIURL,
  //       body: json.encode(mapeddate)); //getting response from php code, here
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //   } else {
  //     print('Request failed with status: ${response.statusCode}.');
  //   }
  // }
  radioButton() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            children: <Widget>[
              ListTile(
                title: const Text('Employed'),
                leading: Radio(
                  value: BestTutorSite.private,
                  groupValue: _site,
                  onChanged: (BestTutorSite value) {
                    setState(() {
                      print(_site);
                      _site = value;
                      employementStatus = '1';
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Self Employed'),
                leading: Radio(
                  value: BestTutorSite.goverment,
                  groupValue: _site,
                  onChanged: (BestTutorSite value) {
                    setState(() {
                      _site = value;
                      print(_site);
                      employementStatus = '2';
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Student'),
                leading: Radio(
                  value: BestTutorSite.both,
                  groupValue: _site,
                  onChanged: (BestTutorSite value) {
                    setState(() {
                      _site = value;
                      print(_site);
                      employementStatus = '3';
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
