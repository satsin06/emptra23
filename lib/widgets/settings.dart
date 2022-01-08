import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/login.dart';
import 'package:flutter_emptra/models/getListModel/getProfileinfoModel.dart';
import 'package:flutter_emptra/models/getListModel/getSocialModel.dart';
import 'package:flutter_emptra/models/getListModel/getSocialScore.dart';
import 'package:flutter_emptra/widgets/app_bar.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'drawer.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  GetSocialHistoryModel _socialData;
  GetSocialScore _socialSco;
  bool _isLoading = false;

 // bool isSwitched = false;
  bool isWork = false;
  bool isMarry = false;
  bool isBuss = false;
  bool isGhostMode = false;
  bool isPrivateMode = false;
  bool isHidePh = false;
  bool isHidePro = false;
  bool isHideVehical = false;
  bool isDownload = false;
  GetPersonalInfoHistoryModel _personalInfoHistoryData;

  //var textValue = 'Switch is OFF';

  getProfile() async {
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
          _personalInfoHistoryData = GetPersonalInfoHistoryModel.fromJson(response.data);
          print(_personalInfoHistoryData);
          //   getEducationHistory();
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        //     getEducationHistory();
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      //   getEducationHistory();
    }
  }
  getSocialHistory() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    int userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.get(
      "${Api.helpHistoryList}/$userId",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
    );
    if (response.statusCode == 200) {
      if (response.data['code'] == 100) {
        setState(() {
          _socialData = GetSocialHistoryModel.fromJson(response.data);
          _isLoading = false;
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
  }

  getSocialScore() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();

    var response = await dio.get(
      "${Api.socialScore}/$userId",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
    );
    if (response.statusCode == 200) {
      print("!!!!!");
      setState(() {
        //  _socialSco=response.data["socialScore"];
        _socialSco = GetSocialScore.fromJson(response.data);
        // print(0.1 * double.tryParse(_socialSco.socialScore.toString()));
        //_socialSco = getSocialScoreFromJson(response.data);
        // fromJson(response.data);

        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }
  truLink() async {
    try{
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      var etKey = session.getString("etKey");
      var dio = Dio();
      setState(() {
        _isLoading = true;
      });
      Map data = {"userId": userId, "etKey": etKey};
      var response = await dio.post(
        Api.sendTruLink,
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
          setState(() {
            getProfile();
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      }
      setState(() {
        _isLoading = false;
      });
    }  catch(e){
      print(e);
    }
  }

  deleteProfile() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.delete(
      "${Api.deleteProfile}/$userId",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
    );

    if (response.statusCode == 200) {
      if (response.data['code'] == 100) {
        setState(() {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
                  (Route<dynamic> route) => false);
          _isLoading = false;
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
  }

  @override
  void initState() {
    super.initState();
    hello();
  }

  hello() async {
    await getProfile();
    await getSocialScore();
    await getSocialHistory();
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
            : WillPopScope(
    onWillPop: () =>

    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) =>BottomBarIndivitual())),

    child:
        Scaffold(
          drawer: MyDrawer(),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        'assets/images/rectangle.png', // and width here
                      ),
                    ),
                    Stack(
                      children: [
                        myAppBar(),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 25,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BottomBarIndivitual()));
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 15, top: 60),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Settings',
                            style: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'PoppinsBold',
                                height: 1.3,
                                fontWeight: FontWeight.w400,
                                fontSize: 36),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Only available for profiles with TruScore above 600',
                            style: k16F87Black600HT
                          ),
                          SizedBox(height: 10),
                          Text(
                            'General',
                            style: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'PoppinsBold',
                                height: 1.3,
                                fontWeight: FontWeight.w500,
                                fontSize: 28),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Open to work',
                                  style: k16F87Black600HT
                              ),
                              Switch(
                                onChanged:(bool value) {
                                  if(isWork == false)
                                  {
                                    setState(() {
                                      isWork = true;
                                     // textValue = 'Switch Button is ON';
                                    });
                                    print('Switch Button is ON');
                                  }
                                  else
                                  {
                                    setState(() {
                                      isWork = false;
                                      //textValue = 'Switch Button is OFF';
                                    });
                                    print('Switch Button is OFF');
                                  }
                                },
                                value: isWork,
                                // activeColor: Colors.blue,
                                // activeTrackColor: Colors.yellow,
                                // inactiveThumbColor: Colors.redAccent,
                                // inactiveTrackColor: Colors.orange,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Open to Marriage',
                                  style:k16F87Black600HT
                              ),
                              Switch(
                                onChanged:(bool value) {
                                  if(isMarry == false)
                                  {
                                    setState(() {
                                      isMarry = true;
                                   //   textValue = 'Switch Button is ON';
                                    });
                                    print('Switch Button is ON');
                                  }
                                  else
                                  {
                                    setState(() {
                                      isMarry = false;
                                     // textValue = 'Switch Button is OFF';
                                    });
                                    print('Switch Button is OFF');
                                  }
                                },
                                value: isMarry,
                                // activeColor: Colors.blue,
                                // activeTrackColor: Colors.yellow,
                                // inactiveThumbColor: Colors.redAccent,
                                // inactiveTrackColor: Colors.orange,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Open to Business',
                                  style: k16F87Black600HT
                              ),
                              Switch(
                                onChanged:(bool value) {
                                  if(isBuss == false)
                                  {
                                    setState(() {
                                      isBuss = true;
                                      //textValue = 'Switch Button is ON';
                                    });
                                    print('Switch Button is ON');
                                  }
                                  else
                                  {
                                    setState(() {
                                      isBuss = false;
                                     // textValue = 'Switch Button is OFF';
                                    });
                                    print('Switch Button is OFF');
                                  }
                                },
                                value: isBuss,
                                // activeColor: Colors.blue,
                                // activeTrackColor: Colors.yellow,
                                // inactiveThumbColor: Colors.redAccent,
                                // inactiveTrackColor: Colors.orange,
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          // Text(
                          //   'Privacy',
                          //   style: TextStyle(
                          //       color: Colors.black87,
                          //       fontFamily: 'PoppinsBold',
                          //       height: 1.3,
                          //       fontWeight: FontWeight.w500,
                          //       fontSize: 28),
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //         'Ghost Mode',
                          //         style: k16F87Black600HT
                          //     ),
                          //     Switch(
                          //       onChanged:(bool value) {
                          //         if(isGhostMode == false)
                          //         {
                          //           setState(() {
                          //             isGhostMode = true;
                          //             //textValue = 'Switch Button is ON';
                          //           });
                          //           print('Switch Button is ON');
                          //         }
                          //         else
                          //         {
                          //           setState(() {
                          //             isGhostMode = false;
                          //            // textValue = 'Switch Button is OFF';
                          //           });
                          //           print('Switch Button is OFF');
                          //         }
                          //       },
                          //       value: isGhostMode,
                          //       activeColor: Colors.blue,
                          //       activeTrackColor: Colors.yellow,
                          //       inactiveThumbColor: Colors.redAccent,
                          //       inactiveTrackColor: Colors.orange,
                          //     )
                          //   ],
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //         'Private Mode',
                          //         style: k16F87Black600HT
                          //     ),
                          //     Switch(
                          //       onChanged:(bool value) {
                          //         if(isPrivateMode == false)
                          //         {
                          //           setState(() {
                          //             isPrivateMode = true;
                          //             //textValue = 'Switch Button is ON';
                          //           });
                          //           print('Switch Button is ON');
                          //         }
                          //         else
                          //         {
                          //           setState(() {
                          //             isPrivateMode = false;
                          //             //textValue = 'Switch Button is OFF';
                          //           });
                          //           print('Switch Button is OFF');
                          //         }
                          //       },
                          //       value: isPrivateMode,
                          //       activeColor: Colors.blue,
                          //       activeTrackColor: Colors.yellow,
                          //       inactiveThumbColor: Colors.redAccent,
                          //       inactiveTrackColor: Colors.orange,
                          //     )
                          //   ],
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //         'Hide Phone Number',
                          //         style: k16F87Black600HT
                          //     ),
                          //     Switch(
                          //       onChanged:(bool value) {
                          //         if(isHidePh == false)
                          //         {
                          //           setState(() {
                          //             isHidePh = true;
                          //             //textValue = 'Switch Button is ON';
                          //           });
                          //           print('Switch Button is ON');
                          //         }
                          //         else
                          //         {
                          //           setState(() {
                          //             isHidePh = false;
                          //             //textValue = 'Switch Button is OFF';
                          //           });
                          //           print('Switch Button is OFF');
                          //         }
                          //       },
                          //       value: isHidePh,
                          //       activeColor: Colors.blue,
                          //       activeTrackColor: Colors.yellow,
                          //       inactiveThumbColor: Colors.redAccent,
                          //       inactiveTrackColor: Colors.orange,
                          //     )
                          //   ],
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //         'Hide Property Detail',
                          //         style: k16F87Black600HT
                          //     ),
                          //     Switch(
                          //       onChanged:(bool value) {
                          //         if(isHidePro == false)
                          //         {
                          //           setState(() {
                          //             isHidePro = true;
                          //             //textValue = 'Switch Button is ON';
                          //           });
                          //           print('Switch Button is ON');
                          //         }
                          //         else
                          //         {
                          //           setState(() {
                          //             isHidePro = false;
                          //             //textValue = 'Switch Button is OFF';
                          //           });
                          //           print('Switch Button is OFF');
                          //         }
                          //       },
                          //       value: isHidePro,
                          //       activeColor: Colors.blue,
                          //       activeTrackColor: Colors.yellow,
                          //       inactiveThumbColor: Colors.redAccent,
                          //       inactiveTrackColor: Colors.orange,
                          //     )
                          //   ],
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //         'Hide vehical | drive',
                          //         style: k16F87Black600HT
                          //     ),
                          //     Switch(
                          //       onChanged:(bool value) {
                          //         if(isHideVehical == false)
                          //         {
                          //           setState(() {
                          //             isHideVehical = true;
                          //            // textValue = 'Switch Button is ON';
                          //           });
                          //           print('Switch Button is ON');
                          //         }
                          //         else
                          //         {
                          //           setState(() {
                          //             isHideVehical = false;
                          //             //textValue = 'Switch Button is OFF';
                          //           });
                          //           print('Switch Button is OFF');
                          //         }
                          //       },
                          //       value: isHideVehical,
                          //       activeColor: Colors.blue,
                          //       activeTrackColor: Colors.yellow,
                          //       inactiveThumbColor: Colors.redAccent,
                          //       inactiveTrackColor: Colors.orange,
                          //     )
                          //   ],
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //         'Hide Download Property',
                          //         style: k16F87Black600HT
                          //     ),
                          //     Switch(
                          //       onChanged:(bool value) {
                          //         if(isDownload == false)
                          //         {
                          //           setState(() {
                          //             isDownload = true;
                          //             //textValue = 'Switch Button is ON';
                          //           });
                          //           print('Switch Button is ON');
                          //         }
                          //         else
                          //         {
                          //           setState(() {
                          //             isDownload = false;
                          //            // textValue = 'Switch Button is OFF';
                          //           });
                          //           print('Switch Button is OFF');
                          //         }
                          //       },
                          //       value: isDownload,
                          //       activeColor: Colors.blue,
                          //       activeTrackColor: Colors.yellow,
                          //       inactiveThumbColor: Colors.redAccent,
                          //       inactiveTrackColor: Colors.orange,
                          //     )
                          //   ],
                          // ),
                          Center(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              textColor: Colors.white,
                              color: Color(0xff3E66FB),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child:  Text(
                                  "Save",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'PoppinsLight',
                                  ),
                                ),
                              ),
                              onPressed: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             IndividualSignUp()));
                              },
                            ),
                          ),
                          SizedBox(
                            height:15,
                          ),
                          Text(
                            '  TruKey',
                            style: k16F87Black600HT,
                          ),
                           Container(
                            width: 320,
                            child: Card(
                              elevation: 1,
                              color: Color(
                                  0xffE8EDFB),
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    15.0),
                              ),
                              child: Stack(
                                children: <
                                    Widget>[
                                  Container(
                                    width: 280,
                                    child:
                                    Padding(
                                      padding: const EdgeInsets
                                          .only(
                                          top: 12,bottom: 12,
                                          left:
                                          10),
                                      child: Text(
                                        _personalInfoHistoryData
                                            .result
                                            .etKey
                                            .toString(),
                                        overflow:
                                        TextOverflow
                                            .fade,
                                        maxLines:
                                        1,
                                        softWrap:
                                        false,
                                        style: TextStyle(
                                            color: Colors
                                                .black87,
                                            fontFamily:
                                            'PoppinsLight',
                                            fontSize:
                                            15),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '  TruLink',
                            style: k16F87Black600HT,
                          ),
                          _personalInfoHistoryData==null?'': _personalInfoHistoryData
                              .result
                              .truLink ==
                              ""
                              ? Container(
                            //color: Colors.amber[600],
                            decoration: BoxDecoration(
                                color: Color(
                                    0xffE8EDFB),
                                borderRadius: BorderRadius
                                    .all(Radius
                                    .circular(
                                    10))),
                            // color: Colors.blue[600],
                            alignment: Alignment
                                .topLeft,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    'Generate Truelink',
                                    style:
                                    k14F87Black400HT),
                                IconButton(
                                    icon: Icon(
                                      Icons
                                          .model_training,
                                      size: 20,
                                    ),
                                    onPressed:
                                        () {
                                      truLink();
                                      //  Share.share('check out my website https://example.com');
                                    }),
                              ],
                            ),
                          )
                              : Container(
                            width: 330,
                            child: Card(
                              elevation: 1,
                              color: Color(
                                  0xffE8EDFB),
                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    15.0),
                              ),
                              child: Stack(
                                children: <
                                    Widget>[
                                  Container(
                                    width: 230,
                                    child:
                                    Padding(
                                      padding: const EdgeInsets
                                          .only(
                                          top:
                                          13,
                                          left:
                                          10),
                                      child:
                                      Text(
                                        _personalInfoHistoryData
                                            .result
                                            .truLink
                                            .toString(),
                                        overflow:
                                        TextOverflow.fade,
                                        maxLines:
                                        1,
                                        softWrap:
                                        false,
                                        style: TextStyle(
                                            color: Colors
                                                .black87,
                                            fontFamily:
                                            'PoppinsLight',
                                            fontSize:
                                            15),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:
                                        230,
                                      ),
                                      IconButton(
                                          icon:
                                          Icon(
                                            Icons.share,
                                            size:
                                            30,
                                          ),
                                          onPressed:
                                              () {
                                            Share.share(
                                              'This is My TruLink ' + _personalInfoHistoryData.result.truLink.toString(),
                                            );
                                          }),
                                    ],
                                  ),
                                  SizedBox(width: 5,),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width:
                                        270,
                                      ),
                                      IconButton(
                                          icon:
                                          Icon(
                                            Icons
                                                .update,
                                            size:
                                            30,
                                          ),
                                          onPressed:
                                              () {
                                                truLink();

                                            // Share
                                            //     .share(
                                            //   'This is My TruLink ' +
                                            //       _personalInfoHistoryData.result.truLink.toString(),
                                            // );
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '  EmployerLink',
                            style: k16F87Black600HT,
                          ),
                          // _personalInfoHistoryData
                          //     .result.truLink ==
                          //     null
                          //     ?

                          Container(
                            //color: Colors.amber[600],
                            decoration: BoxDecoration(
                                color: Color(
                                    0xffE8EDFB),
                                borderRadius: BorderRadius
                                    .all(Radius
                                    .circular(
                                    10))),
                            // color: Colors.blue[600],
                            alignment:
                            Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    'Generate EmployerLink',
                                    style:
                                    k14F87Black400HT),
                                IconButton(
                                    icon: Icon(
                                      Icons
                                          .model_training,
                                      size: 20,
                                    ),
                                    onPressed:
                                        () {
                                      //truLink();
                                      //  Share.share('check out my website https://example.com');
                                    }),
                              ],
                            ),
                          )
                          //     : Container(
                          //   width: 330,
                          //   child: Card(
                          //     elevation: 1,
                          //     color: Color(
                          //         0xffE8EDFB),
                          //     shape:
                          //     RoundedRectangleBorder(
                          //       borderRadius:
                          //       BorderRadius
                          //           .circular(
                          //           15.0),
                          //     ),
                          //     child: Stack(
                          //       children: <
                          //           Widget>[
                          //         Container(
                          //           width: 230,
                          //           child:
                          //           Padding(
                          //             padding: const EdgeInsets
                          //                 .only(
                          //                 top: 13,
                          //                 left:
                          //                 10),
                          //             child: Text(
                          //               _personalInfoHistoryData
                          //                   .result
                          //                   .truLink
                          //                   .toString(),
                          //               overflow:
                          //               TextOverflow
                          //                   .fade,
                          //               maxLines:
                          //               1,
                          //               softWrap:
                          //               false,
                          //               style: TextStyle(
                          //                   color: Colors
                          //                       .black87,
                          //                   fontFamily:
                          //                   'PoppinsLight',
                          //                   fontSize:
                          //                   15),
                          //             ),
                          //           ),
                          //         ),
                          //         Row(
                          //           children: [
                          //             SizedBox(
                          //               width:
                          //               230,
                          //             ),
                          //             IconButton(
                          //                 icon:
                          //                 Icon(
                          //                   Icons
                          //                       .share,
                          //                   size:
                          //                   30,
                          //                 ),
                          //                 onPressed:
                          //                     () {
                          //                   // Share
                          //                   //     .share(
                          //                   //   'This is My TruLink ' +
                          //                   //       _personalInfoHistoryData.result.truLink.toString(),
                          //                   // );
                          //                 }),
                          //           ],
                          //         ),
                          //         Row(
                          //           children: [
                          //             SizedBox(
                          //               width:
                          //               270,
                          //             ),
                          //             IconButton(
                          //                 icon:
                          //                 Icon(
                          //                   Icons
                          //                       .update,
                          //                   size:
                          //                   30,
                          //                 ),
                          //                 onPressed:
                          //                     () {
                          //                   // Share
                          //                   //     .share(
                          //                   //   'This is My TruLink ' +
                          //                   //       _personalInfoHistoryData.result.truLink.toString(),
                          //                   // );
                          //                 }),
                          //           ],
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          ,SizedBox(
                            height:15,
                          ),
                          Text(
                            '  ArtistLink',
                            style: k16F87Black600HT,
                          ),

                          // _personalInfoHistoryData
                          //     .result.truLink ==
                          //     null
                          //     ?
                          Container(
                            //color: Colors.amber[600],
                            decoration: BoxDecoration(
                                color: Color(
                                    0xffE8EDFB),
                                borderRadius: BorderRadius
                                    .all(Radius
                                    .circular(
                                    10))),
                            // color: Colors.blue[600],
                            alignment:
                            Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    'Generate ArtistLink',
                                    style:
                                    k14F87Black400HT),
                                IconButton(
                                    icon: Icon(
                                      Icons
                                          .model_training,
                                      size: 20,
                                    ),
                                    onPressed:
                                        () {
                                      //truLink();
                                      //  Share.share('check out my website https://example.com');
                                    }),
                              ],
                            ),
                          ),
                          //     : Container(
                          //   width: 330,
                          //   child: Card(
                          //     elevation: 1,
                          //     color: Color(
                          //         0xffE8EDFB),
                          //     shape:
                          //     RoundedRectangleBorder(
                          //       borderRadius:
                          //       BorderRadius
                          //           .circular(
                          //           15.0),
                          //     ),
                          //     child: Stack(
                          //       children: <
                          //           Widget>[
                          //         Container(
                          //           width: 230,
                          //           child:
                          //           Padding(
                          //             padding: const EdgeInsets
                          //                 .only(
                          //                 top: 13,
                          //                 left:
                          //                 10),
                          //             child: Text(
                          //               _personalInfoHistoryData
                          //                   .result
                          //                   .truLink
                          //                   .toString(),
                          //               overflow:
                          //               TextOverflow
                          //                   .fade,
                          //               maxLines:
                          //               1,
                          //               softWrap:
                          //               false,
                          //               style: TextStyle(
                          //                   color: Colors
                          //                       .black87,
                          //                   fontFamily:
                          //                   'PoppinsLight',
                          //                   fontSize:
                          //                   15),
                          //             ),
                          //           ),
                          //         ),
                          //         Row(
                          //           children: [
                          //             SizedBox(
                          //               width:
                          //               230,
                          //             ),
                          //             IconButton(
                          //                 icon:
                          //                 Icon(
                          //                   Icons
                          //                       .share,
                          //                   size:
                          //                   30,
                          //                 ),
                          //                 onPressed:
                          //                     () {
                          //                   // Share
                          //                   //     .share(
                          //                   //   'This is My TruLink ' +
                          //                   //       _personalInfoHistoryData.result.truLink.toString(),
                          //                   // );
                          //                 }),
                          //           ],
                          //         ),
                          //         Row(
                          //           children: [
                          //             SizedBox(
                          //               width:
                          //               270,
                          //             ),
                          //             IconButton(
                          //                 icon:
                          //                 Icon(
                          //                   Icons
                          //                       .update,
                          //                   size:
                          //                   30,
                          //                 ),
                          //                 onPressed:
                          //                     () {
                          //                   // Share
                          //                   //     .share(
                          //                   //   'This is My TruLink ' +
                          //                   //       _personalInfoHistoryData.result.truLink.toString(),
                          //                   // );
                          //                 }),
                          //           ],
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '  ArtistLink (Limited)',
                            style: k16F87Black600HT,
                          ),
                          // _personalInfoHistoryData
                          //     .result.truLink ==
                          //     null
                          //     ?
                          Container(
                            //color: Colors.amber[600],
                            decoration: BoxDecoration(
                                color: Color(
                                    0xffE8EDFB),
                                borderRadius: BorderRadius
                                    .all(Radius
                                    .circular(
                                    10))),
                            // color: Colors.blue[600],
                            alignment:
                            Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    'Generate ArtistLink (Limited)',
                                    style:
                                    k14F87Black400HT),
                                IconButton(
                                    icon: Icon(
                                      Icons
                                          .model_training,
                                      size: 20,
                                    ),
                                    onPressed:
                                        () {
                                      //truLink();
                                      //  Share.share('check out my website https://example.com');
                                    }),
                              ],
                            ),
                          ),
                          //     : Container(
                          //   width: 330,
                          //   child: Card(
                          //     elevation: 1,
                          //     color: Color(
                          //         0xffE8EDFB),
                          //     shape:
                          //     RoundedRectangleBorder(
                          //       borderRadius:
                          //       BorderRadius
                          //           .circular(
                          //           15.0),
                          //     ),
                          //     child: Stack(
                          //       children: <
                          //           Widget>[
                          //         Container(
                          //           width: 230,
                          //           child:
                          //           Padding(
                          //             padding: const EdgeInsets
                          //                 .only(
                          //                 top: 13,
                          //                 left:
                          //                 10),
                          //             child: Text(
                          //               _personalInfoHistoryData
                          //                   .result
                          //                   .truLink
                          //                   .toString(),
                          //               overflow:
                          //               TextOverflow
                          //                   .fade,
                          //               maxLines:
                          //               1,
                          //               softWrap:
                          //               false,
                          //               style: TextStyle(
                          //                   color: Colors
                          //                       .black87,
                          //                   fontFamily:
                          //                   'PoppinsLight',
                          //                   fontSize:
                          //                   15),
                          //             ),
                          //           ),
                          //         ),
                          //         Row(
                          //           children: [
                          //             SizedBox(
                          //               width:
                          //               230,
                          //             ),
                          //             IconButton(
                          //                 icon:
                          //                 Icon(
                          //                   Icons
                          //                       .share,
                          //                   size:
                          //                   30,
                          //                 ),
                          //                 onPressed:
                          //                     () {
                          //                   // Share
                          //                   //     .share(
                          //                   //   'This is My TruLink ' +
                          //                   //       _personalInfoHistoryData.result.truLink.toString(),
                          //                   // );
                          //                 }),
                          //           ],
                          //         ),
                          //         Row(
                          //           children: [
                          //             SizedBox(
                          //               width:
                          //               270,
                          //             ),
                          //             IconButton(
                          //                 icon:
                          //                 Icon(
                          //                   Icons
                          //                       .update,
                          //                   size:
                          //                   30,
                          //                 ),
                          //                 onPressed:
                          //                     () {
                          //                   // Share
                          //                   //     .share(
                          //                   //   'This is My TruLink ' +
                          //                   //       _personalInfoHistoryData.result.truLink.toString(),
                          //                   // );
                          //                 }),
                          //           ],
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '  MatrimonialLink (Full)',
                            style: k16F87Black600HT,
                          ),
                          // _personalInfoHistoryData
                          //     .result.truLink ==
                          //     null
                          //     ?
                          Container(
                            //color: Colors.amber[600],
                            decoration: BoxDecoration(
                                color: Color(
                                    0xffE8EDFB),
                                borderRadius: BorderRadius
                                    .all(Radius
                                    .circular(
                                    10))),
                            // color: Colors.blue[600],
                            alignment:
                            Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    'Generate MatrimonialLink (Full)',
                                    style:
                                    k14F87Black400HT),
                                IconButton(
                                    icon: Icon(
                                      Icons
                                          .model_training,
                                      size: 20,
                                    ),
                                    onPressed:
                                        () {
                                      //truLink();
                                      //  Share.share('check out my website https://example.com');
                                    }),
                              ],
                            ),
                          ),
                          //     : Container(
                          //   width: 330,
                          //   child: Card(
                          //     elevation: 1,
                          //     color: Color(
                          //         0xffE8EDFB),
                          //     shape:
                          //     RoundedRectangleBorder(
                          //       borderRadius:
                          //       BorderRadius
                          //           .circular(
                          //           15.0),
                          //     ),
                          //     child: Stack(
                          //       children: <
                          //           Widget>[
                          //         Container(
                          //           width: 230,
                          //           child:
                          //           Padding(
                          //             padding: const EdgeInsets
                          //                 .only(
                          //                 top: 13,
                          //                 left:
                          //                 10),
                          //             child: Text(
                          //               _personalInfoHistoryData
                          //                   .result
                          //                   .truLink
                          //                   .toString(),
                          //               overflow:
                          //               TextOverflow
                          //                   .fade,
                          //               maxLines:
                          //               1,
                          //               softWrap:
                          //               false,
                          //               style: TextStyle(
                          //                   color: Colors
                          //                       .black87,
                          //                   fontFamily:
                          //                   'PoppinsLight',
                          //                   fontSize:
                          //                   15),
                          //             ),
                          //           ),
                          //         ),
                          //         Row(
                          //           children: [
                          //             SizedBox(
                          //               width:
                          //               230,
                          //             ),
                          //             IconButton(
                          //                 icon:
                          //                 Icon(
                          //                   Icons
                          //                       .share,
                          //                   size:
                          //                   30,
                          //                 ),
                          //                 onPressed:
                          //                     () {
                          //                   // Share
                          //                   //     .share(
                          //                   //   'This is My TruLink ' +
                          //                   //       _personalInfoHistoryData.result.truLink.toString(),
                          //                   // );
                          //                 }),
                          //           ],
                          //         ),
                          //         Row(
                          //           children: [
                          //             SizedBox(
                          //               width:
                          //               270,
                          //             ),
                          //             IconButton(
                          //                 icon:
                          //                 Icon(
                          //                   Icons
                          //                       .update,
                          //                   size:
                          //                   30,
                          //                 ),
                          //                 onPressed:
                          //                     () {
                          //                   // Share
                          //                   //     .share(
                          //                   //   'This is My TruLink ' +
                          //                   //       _personalInfoHistoryData.result.truLink.toString(),
                          //                   // );
                          //                 }),
                          //           ],
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height:15,
                          ),
                          Text(
                            '  MatrimonialLink (Limited)',
                            style: k16F87Black600HT,
                          ),
                          // _personalInfoHistoryData
                          //     .result.truLink ==
                          //     null
                          //     ?
                          Container(
                            //color: Colors.amber[600],
                            decoration: BoxDecoration(
                                color: Color(
                                    0xffE8EDFB),
                                borderRadius: BorderRadius
                                    .all(Radius
                                    .circular(
                                    10))),
                            // color: Colors.blue[600],
                            alignment:
                            Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    'Generate MatrimonialLink (Limited)',
                                    style:
                                    k14F87Black400HT),
                                IconButton(
                                    icon: Icon(
                                      Icons
                                          .model_training,
                                      size: 20,
                                    ),
                                    onPressed:
                                        () {
                                      //truLink();
                                      //  Share.share('check out my website https://example.com');
                                    }),
                              ],
                            ),
                          ),
                          //     : Container(
                          //   width: 330,
                          //   child: Card(
                          //     elevation: 1,
                          //     color: Color(
                          //         0xffE8EDFB),
                          //     shape:
                          //     RoundedRectangleBorder(
                          //       borderRadius:
                          //       BorderRadius
                          //           .circular(
                          //           15.0),
                          //     ),
                          //     child: Stack(
                          //       children: <
                          //           Widget>[
                          //         Container(
                          //           width: 230,
                          //           child:
                          //           Padding(
                          //             padding: const EdgeInsets
                          //                 .only(
                          //                 top: 13,
                          //                 left:
                          //                 10),
                          //             child: Text(
                          //               _personalInfoHistoryData
                          //                   .result
                          //                   .truLink
                          //                   .toString(),
                          //               overflow:
                          //               TextOverflow
                          //                   .fade,
                          //               maxLines:
                          //               1,
                          //               softWrap:
                          //               false,
                          //               style: TextStyle(
                          //                   color: Colors
                          //                       .black87,
                          //                   fontFamily:
                          //                   'PoppinsLight',
                          //                   fontSize:
                          //                   15),
                          //             ),
                          //           ),
                          //         ),
                          //         Row(
                          //           children: [
                          //             SizedBox(
                          //               width:
                          //               230,
                          //             ),
                          //             IconButton(
                          //                 icon:
                          //                 Icon(
                          //                   Icons
                          //                       .share,
                          //                   size:
                          //                   30,
                          //                 ),
                          //                 onPressed:
                          //                     () {
                          //                   // Share
                          //                   //     .share(
                          //                   //   'This is My TruLink ' +
                          //                   //       _personalInfoHistoryData.result.truLink.toString(),
                          //                   // );
                          //                 }),
                          //           ],
                          //         ),
                          //         Row(
                          //           children: [
                          //             SizedBox(
                          //               width:
                          //               270,
                          //             ),
                          //             IconButton(
                          //                 icon:
                          //                 Icon(
                          //                   Icons
                          //                       .update,
                          //                   size:
                          //                   30,
                          //                 ),
                          //                 onPressed:
                          //                     () {
                          //                   // Share
                          //                   //     .share(
                          //                   //   'This is My TruLink ' +
                          //                   //       _personalInfoHistoryData.result.truLink.toString(),
                          //                   // );
                          //                 }),
                          //           ],
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: 10),
                          Text(
                            'Delete Your Profile',
                            style: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'PoppinsBold',
                                height: 1.3,
                                fontWeight: FontWeight.w500,
                                fontSize: 28),
                          ),
                          Text(
                              'This will permanently delete your profile and you will lose all your data.',
                              style: k18InputText
                          ),
                          SizedBox(height: 10,),
                          Center(
                            child: RaisedButton(
                              shape:
                              RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                      5)),
                              textColor: Colors.white,
                              color: Color(0xffDC2626),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 14.0,
                                    bottom: 14.0),
                                child: Text(
                                  'Delete Profie',
                                  style: k13Fwhite400BT,
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      elevation: 16,
                                      child: Container(
                                        height: 220,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                  'Are you Sure you want to delete your profile.\nThis will permanently delete your profile and you will lose all your data.',
                                                  style: k16F87Black600HT
                                              ),
                                              SizedBox(height: 10,),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  RaisedButton(
                                                    shape:
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            5)),
                                                    textColor: Colors.white,
                                                    color: Color(0xffDC2626),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 14.0,
                                                          bottom: 14.0),
                                                      child: Text(
                                                        'Cancel',
                                                        style: k13Fwhite400BT,
                                                      ),
                                                    ),
                                                    onPressed: () => Navigator.pop(context, false),
                                                  ),
                                                  RaisedButton(
                                                    shape:
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            5)),
                                                    textColor: Colors.white,
                                                    color: Colors.green,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 14.0,
                                                          bottom: 14.0),
                                                      child: Text(
                                                        'Confirm',
                                                        style: k13Fwhite400BT,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      deleteProfile();
                                                    },
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 20,),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     RaisedButton(
                          //       shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(5)),
                          //       textColor: Colors.white,
                          //       color: Color(0xff3E66FB),
                          //       child: Padding(
                          //         padding: const EdgeInsets.only(
                          //             top: 10, bottom: 10),
                          //         child: Text(
                          //           'Save',
                          //           style: k13Fwhite400BT,
                          //         ),
                          //       ),
                          //       onPressed: () {
                          //         // if (_formkey.currentState.validate()) {
                          //         //   signup();
                          //         // }
                          //       },
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ],
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
