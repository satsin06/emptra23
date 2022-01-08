import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/models/getListModel/getAmountModel.dart';
import 'package:flutter_emptra/models/getListModel/getBankDetail.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/add_amount.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BankCardEdit extends StatefulWidget {
  @override
  _BankCardEditState createState() => _BankCardEditState();
}

class _BankCardEditState extends State<BankCardEdit> {
  String name = "";
  bool changeButton = false;
  TextEditingController _name = TextEditingController();
  TextEditingController _accnum = TextEditingController();
  TextEditingController _ifsc = TextEditingController();
  TextEditingController _phone = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  GetBankDetail _bankData;
  GetCredit _getCredit;

  getBankDetail() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();
      var response = await dio.get(
        "${Api.getBankDetails}/$userId",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
          "versionnumber": "v1"
        }),
      );
      if (response.statusCode == 200) {
        if (response.data['code'] == 100) {
          setState(() {
            _bankData = GetBankDetail.fromJson(response.data);
            _isLoading = false;
            print("!!!!!");
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
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    hello();
  }

  hello() async {
    await getBankDetail();
    await getCredit();
  }

  getCredit() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();
      var response = await dio.get(
        "${Api.getCredit}/$userId",
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
            _getCredit = GetCredit.fromJson(response.data);
            print(_getCredit);
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
    } catch (e) {
      print(e);
    }
  }

  bankDetail() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      var token = session.getString("token");
      var dio = Dio();
      setState(() {
        _isLoading = true;
      });
      Map data = {
        "bulkValidationId": "verifyaccount",
        "entries": [
          {
            "name": _name.text,
            "bankAccount": _accnum.text,
            "ifsc": _ifsc.text,
            "phone": _phone.text.trim()
          }
        ]
      };

      var response = await dio.post("${Api.addBank}",
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "token": token,
            "versionnumber": "v1"
          }),
          data: data);
      print(response.data);
      if (response.statusCode == 200) {
        if (response.data['code'] == 100) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomBarIndivitual(
                    index: 1,
                  )));
          setState(() {
            _isLoading = false;
          });
          success(response.data['message']);
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
    } catch (e) {
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
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                  //             BottomBarIndivitual(index: 1,)));
                                },
                              ),
                            ),
                            Center(
                              child: CircleAvatar(
                                backgroundColor: Colors.indigo,
                                radius: 50,
                                child: CircleAvatar(
                                  backgroundImage:
                                  AssetImage("assets/images/bank.png"),
                                  radius: 50,
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                            ),
                            Text(
                              'Bankcard',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'PoppinsBold',
                                  fontSize: 24),
                            ),

                            _bankData == null
                                ? Container(
                              width: 80,
                              //color: Colors.amber[600],
                              decoration: BoxDecoration(
                                  color: Color(0xffFBE4BB),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(8))),
                              // color: Colors.blue[600],
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.hourglass_top_outlined,
                                      size: 15,
                                      color: Color(0xffC47F00),
                                    ),
                                    Text(
                                      'PENDING',
                                      style: TextStyle(
                                          color: Color(0xffC47F00),
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            )
                                : _bankData != null
                                ? Container(
                              width: 90,
                              //color: Colors.amber[600],
                              decoration: BoxDecoration(
                                  color: Color(0xffA7F3D0),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(8))),
                              // color: Colors.blue[600],
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
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
                                          color: Color(0xff059669),
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
                                : SizedBox(),
                            // _bankData.result.status.toString() == "Rejected"
                            //     ?  Container(
                            //   //color: Colors.amber[600],
                            //   decoration: BoxDecoration(
                            //       color: Color(
                            //           0xffFECACA),
                            //       borderRadius: BorderRadius
                            //           .all(Radius
                            //           .circular(
                            //           8))),
                            //   // color: Colors.blue[600],
                            //   alignment:
                            //   Alignment.center,
                            //   child: Padding(
                            //     padding:
                            //     const EdgeInsets
                            //         .all(6.0),
                            //     child: Row(
                            //       children: [
                            //         Icon(
                            //           Icons
                            //               .cancel,
                            //           size: 15,
                            //           color: Colors
                            //               .red,
                            //         ),
                            //         Text(
                            //           'Rejected',
                            //           style: TextStyle(
                            //               color: Colors
                            //                   .red,
                            //               fontWeight:
                            //               FontWeight
                            //                   .bold,
                            //               fontFamily:
                            //               'PoppinsLight',
                            //               fontSize:
                            //               12),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ):SizedBox(),
                            Stack(
                              children: <Widget>[
                                _bankData == null
                                    ? Padding(
                                  padding:
                                  const EdgeInsets.only(top: 25.0),
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/bank_card.png'),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                  ),
                                )
                                    : Padding(
                                  padding:
                                  const EdgeInsets.only(top: 20.0),
                                  child: Image(
                                    image: AssetImage(
                                        'assets/images/bank_cardd.png'),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        'Name',
                                        style: k13Fwhite400BT,
                                      ),
                                      _bankData == null
                                          ? TextFormField(
                                        controller: _name,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintText: "Your name in bank",
                                          hintStyle: k18F87White400HT,
                                        ),
                                        style: k18Fwhite400BT,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return;
                                          }
                                          return null;
                                        },
                                        onSaved: (String name) {},
                                        onChanged: (value) {
                                          name = value;
                                          setState(() {});
                                        },
                                      )
                                          : Text(
                                        _bankData.result[0].userName,
                                        style: k20F87White600T,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Account Number',
                                        style: k13Fwhite400BT,
                                      ),
                                      _bankData == null
                                          ? TextFormField(
                                        controller: _accnum,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintText: "eg:01100XXXXXXXX",
                                          hintStyle: k18F87White400HT,
                                        ),
                                        style: k18Fwhite400BT,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return;
                                          }
                                          return null;
                                        },
                                        onSaved: (String name) {},
                                        onChanged: (value) {
                                          name = value;
                                          setState(() {});
                                        },
                                      )
                                          : Text(
                                        _bankData.result[0].bankAccount,
                                        style: k20F87White600T,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'IFSC',
                                        style: k13Fwhite400BT,
                                      ),
                                      _bankData == null
                                          ? TextFormField(
                                        controller: _ifsc,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintText: "eg:BANK001234",
                                          hintStyle: k18F87White400HT,
                                        ),
                                        style: k18Fwhite400BT,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Please fill all the details";
                                          }
                                          return null;
                                        },
                                        onSaved: (String name) {},
                                        onChanged: (value) {
                                          name = value;
                                          setState(() {});
                                        },
                                      )
                                          : Text(
                                        _bankData.result[0].ifsc,
                                        style: k20F87White600T,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      _bankData == null
                                          ? Text(
                                        'Phone Number',
                                        style: k13Fwhite400BT,
                                      )
                                          : Text(
                                        'Bank Name',
                                        style: k13Fwhite400BT,
                                      ),
                                      _bankData == null
                                          ? TextFormField(
                                        controller: _phone,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintText: "eg:987654321",
                                          hintStyle: k18F87White400HT,
                                        ),
                                        style: k18Fwhite400BT,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return;
                                          }
                                          return null;
                                        },
                                        onSaved: (String name) {},
                                        onChanged: (value) {
                                          name = value;
                                          setState(() {});
                                        },
                                      )
                                          : Text(
                                        _bankData.result[0].bankName,
                                        style: k20F87White600T,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            _getCredit == null
                                ? Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  ' You need atleast 5 credits to verify account',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'PoppinsBold',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ))
                                : _getCredit.result.creditPoints <= 4
                                ? Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  ' You need atleast 5 credits to verify account',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'PoppinsBold',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ))
                                : _bankData == null
                                ? Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  ' You need atleast 5 credits to verify account',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'PoppinsBold',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ))
                                : SizedBox(),

                            _getCredit == null
                                ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(5)),
                                  textColor: Colors.white,
                                  color: Color(0xff3E66FB),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 12.0, bottom: 12.0),
                                    child: Text(
                                      'Buy Credit',
                                      style: k13Fwhite400BT,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext
                                            context) =>
                                                AddAmount()));
                                  },
                                ),
                              ],
                            )
                                : _getCredit.result.creditPoints <= 4
                                ? Row(
                              mainAxisAlignment:
                              MainAxisAlignment.end,
                              children: [
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(5)),
                                  textColor: Colors.white,
                                  color: Color(0xff3E66FB),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 12.0, bottom: 12.0),
                                    child: Text(
                                      'Buy Credit',
                                      style: k13Fwhite400BT,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext
                                            context) =>
                                                AddAmount()));
                                  },
                                ),
                              ],
                            )
                                : _bankData == null
                                ? Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          5)),
                                  textColor: Colors.white,
                                  color: Color(0xff3E66FB),
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(
                                        top: 10,
                                        bottom: 10),
                                    child: Text(
                                      'Submit',
                                      style: k13Fwhite400BT,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formkey.currentState
                                        .validate()) {
                                      bankDetail();
                                    }
                                  },
                                ),
                                // RaisedButton(
                                //   shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(5)),
                                //   textColor: Colors.white,
                                //   color: Color(0xff6840FD),
                                //   child: Padding(
                                //     padding: const EdgeInsets.only(
                                //         top: 10, bottom: 10),
                                //     child: Text(
                                //       'Connect digilocker',
                                //       style: k13Fwhite400BT,
                                //     ),
                                //   ),
                                //   onPressed: () {},
                                // ),
                              ],
                            )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
