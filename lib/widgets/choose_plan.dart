import 'dart:convert';
import 'dart:io';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/models/getListModel/getAmountModel.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/add_amount.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'drawer.dart';
import 'package:flutter_emptra/widgets/app_bar.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:flutter_emptra/models/getListModel/getProfileinfoModel.dart';

// ignore: must_be_immutable
class ChoosePlan extends StatefulWidget {
  @override
  _ChoosePlan createState() => _ChoosePlan();
}

class _ChoosePlan extends State<ChoosePlan>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  String radioButtonItem = 'one';
  bool _isLoading = false;
  GetPersonalInfoHistoryModel _personalInfoHistoryData;

  GetCredit _getCredit;
  String _profileUrl;
  int id = 1;
  String _gender;
  String name = "";
  var list;
  var employeeId;
  var employeeName;
  bool employementStatus = false;
  BestTutorSite _site = BestTutorSite.private;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  List<String> industryAutosuggest = [];
  final companyAutoSuggestionname = TextEditingController();

  GlobalKey<AutoCompleteTextFieldState<String>> addIndustryForm = GlobalKey();
  bool isWork = false;
  bool isMarry = false;
  bool isBuss = false;
  bool isGhostMode = false;
  bool isPrivateMode = false;
  bool isHidePh = false;
  bool isHidePro = false;
  bool isHideVehical = false;
  bool isDownload = false;
  bool isRation = false;
  bool isPan = false;
  bool isAadhar = false;
  bool isCreditCheck = false;
  bool isCreditHistory = false;
  final aboutController = TextEditingController();

  getCredit() async {
    try{
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
    } catch(e){
      print(e);
    }
  }
  standardPlan() async {
    try{
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      var dio = Dio();
      setState(() {
        _isLoading = true;
      });
      Map data = {
        "userId": userId,
        "creditPoints": 500,
        "bgcPlan": "standard"
      };
      print(jsonEncode(data));//phone h string  or    _phoneNumber.toInt
      var response = await dio.post(
        Api.standardPlan,
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
            getCredit();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ChoosePlan()));
            success(response.data['message']);
            _isLoading = false;
          });
        } else {
          setState(() {
            success(response.data['message']);
            _isLoading = false;
          });
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
  premiumPlan() async {
    try{
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      var dio = Dio();
      setState(() {
        _isLoading = true;
      });
      Map data = {
        "userId": userId,
        "creditPoints": 2000,
        "bgcPlan": "premium"
      };
      print(jsonEncode(data));//phone h string  or    _phoneNumber.toInt
      var response = await dio.post(
        Api.standardPlan,
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ChoosePlan()));
            getCredit();
            success(response.data['message']);
            _isLoading = false;
          });
        } else {
          setState(() {
            success(response.data['message']);
            _isLoading = false;
          });
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

  @override
  void initState() {
    super.initState();
    hello();
  }

  hello() async {
    _tabController = new TabController(length: 3, vsync: this);
    getCredit();
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
          color: Colors.white,
          child: _isLoading == true
              ? Center(child: CircularProgressIndicator())
              : WillPopScope(
            onWillPop: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BottomBarIndivitual())),
            child: Scaffold(
              backgroundColor: Colors.white,
              drawer: MyDrawer(),
              body: Container(
                width: double.infinity,
                height: 1300,
                color: Colors.white,
                child: TabBarView(
                  children: [
                    Column(
                        children: [
                          Stack(children: <Widget>[
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
                              padding: const EdgeInsets.only(top: 80.0),
                              child: TabBar(
                                unselectedLabelColor: Colors.black,
                                labelColor: Colors.red,
                                tabs: [
                                  Tab(
                                    child: Text("Standard",
                                        style: k18Fwhite600BT),
                                  ),
                                  Tab(
                                    child: Text(
                                      'Premium',
                                      style: k18Fwhite600BT,
                                    ),
                                  ),
                                  Tab(
                                    child: Text("Custom",
                                        style: k18Fwhite600BT),
                                  ),
                                ],
                                controller: _tabController,
                                indicatorSize: TabBarIndicatorSize.tab,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 15, top: 140),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Standart Plan',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'PoppinsBold',
                                            height: 1.3,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 32),
                                      ),
                                      Text(
                                        '(500 Credits)',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: 'PoppinsBold',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  // Text(
                                  //   'Physical Verification',
                                  //   style: TextStyle(
                                  //       color: Colors.black87,
                                  //       fontFamily: 'PoppinsBold',
                                  //       height: 1.3,
                                  //       fontWeight: FontWeight.w500,
                                  //       fontSize: 28),
                                  // ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Physical Verification',
                                          style: k18InputText),
                                      Icon(
                                        Icons.check_circle_outline,
                                        size: 25,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('*Health Check',
                                          style: k18InputText),
                                      Icon(
                                        Icons.check_circle_outline,
                                        size: 25,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Loans/Credit Analysis',
                                          style: k18InputText),
                                      Icon(
                                        Icons.check_circle_outline,
                                        size: 25,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Criminal Record Check',
                                          style: k18InputText),
                                      Icon(
                                        Icons.check_circle_outline,
                                        size: 25,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('AI Based- Face Match',
                                          style: k18InputText),
                                      Icon(
                                        Icons.check_circle_outline,
                                        size: 25,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Video based verification',
                                          style: k18InputText),
                                      Icon(
                                        Icons.check_circle_outline,
                                        size: 25,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 15,
                                  ),

                                  // Text(
                                  //   'Delete Your Profile',
                                  //   style: TextStyle(
                                  //       color: Colors.black87,
                                  //       fontFamily: 'PoppinsBold',
                                  //       height: 1.3,
                                  //       fontWeight: FontWeight.w500,
                                  //       fontSize: 28),
                                  // ),
                                  // Text(
                                  //     'This will permanently delete your profile and you will lose all your data.',
                                  //     style: k18InputText
                                  // ),
                                  // SizedBox(height: 10,),
                                  Center(
                                    child: DataTable(
                                      columns: [
                                        DataColumn(
                                            label: Text('Current Plan',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight
                                                        .bold))),
                                        DataColumn(
                                            label:
                                            Text(_getCredit==null?'Free Plan':_getCredit.result.bgcPlan==null?'Free Plan':_getCredit.result.bgcPlan.toString(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight
                                                        .bold)
                                            )
                                        ),
                                      ],
                                      rows: [
                                        DataRow(cells: [
                                          DataCell(Text('Total Credits',
                                              style: kForteenText)),
                                          DataCell(Text(_getCredit==null?'0':_getCredit.result.creditPoints.toString(),
                                              style: k16F87Black600HT)),
                                        ]),
                                        DataRow(cells: [
                                          DataCell(Text('Plan Cost',
                                              style: kForteenText)),
                                          DataCell(Text('500',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontFamily: 'PoppinsBold',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16),)),
                                        ]),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(builder: (BuildContext context) => AddAmount()));
                                        },
                                      ),
                                      _getCredit == null
                                          ? SizedBox() :_getCredit.result.creditPoints <= 500
                                          ? SizedBox()
                                          : RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(5)),
                                        textColor: Colors.white,
                                        color: Color(0xff3E66FB),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 12.0, bottom: 12.0),
                                          child: Text(
                                            'Book Service',
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
                                                            'Are you Sure you want to take Standard Plan.\n Doing this will charge 500 points from your wallet.',
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
                                                                standardPlan();
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
                                      ) ,
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],)]
                    ),
                    Column(
                      children: [
                        Stack(children: <Widget>[
                          Container(
                            child: Image.asset(
                              'assets/images/rectangle.png', // and width here
                            ),
                          ),
                          myAppBar(),
                          Padding(
                            padding: const EdgeInsets.only(top: 80.0),
                            child: TabBar(
                              unselectedLabelColor: Colors.black,
                              labelColor: Colors.red,
                              tabs: [
                                Tab(
                                  child: Text("Standard",
                                      style: k18Fwhite600BT),
                                ),
                                Tab(
                                  child: Text(
                                    'Premium',
                                    style: k18Fwhite600BT,
                                  ),
                                ),
                                Tab(
                                  child: Text("Custom",
                                      style: k18Fwhite600BT),
                                ),
                              ],
                              controller: _tabController,
                              indicatorSize: TabBarIndicatorSize.tab,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 15, top: 140),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Premium Plan',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsBold',
                                          height: 1.3,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 32),
                                    ),
                                    Text(
                                      '(2000 Credits)',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsBold',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                // Text(
                                //   'Physical Verification',
                                //   style: TextStyle(
                                //       color: Colors.black87,
                                //       fontFamily: 'PoppinsBold',
                                //       height: 1.3,
                                //       fontWeight: FontWeight.w500,
                                //       fontSize: 28),
                                // ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Govt Document Verification',
                                        style: k18InputText),
                                    Icon(
                                      Icons.check_circle_outline,
                                      size: 25,
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Priority Verification',
                                        style: k18InputText),
                                    Icon(
                                      Icons.check_circle_outline,
                                      size: 25,
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Linking with Digilocker',
                                        style: k18InputText),
                                    Icon(
                                      Icons.check_circle_outline,
                                      size: 25,
                                      color: Colors.green,
                                    ),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Address Verification',
                                        style: k18InputText),
                                    Icon(
                                      Icons.check_circle_outline,
                                      size: 25,
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Credit Check',
                                        style: k18InputText),
                                    Icon(
                                      Icons.check_circle_outline,
                                      size: 25,
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Education Verification',
                                        style: k18InputText),
                                    Icon(
                                      Icons.check_circle_outline,
                                      size: 25,
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('HR/Reference Verification',
                                        style: k18InputText),
                                    Icon(
                                      Icons.check_circle_outline,
                                      size: 25,
                                      color: Colors.green,
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: 15,
                                ),

                                // Text(
                                //   'Delete Your Profile',
                                //   style: TextStyle(
                                //       color: Colors.black87,
                                //       fontFamily: 'PoppinsBold',
                                //       height: 1.3,
                                //       fontWeight: FontWeight.w500,
                                //       fontSize: 28),
                                // ),
                                // Text(
                                //     'This will permanently delete your profile and you will lose all your data.',
                                //     style: k18InputText
                                // ),
                                // SizedBox(height: 10,),
                                Center(
                                  child: DataTable(
                                    columns: [
                                      DataColumn(
                                          label: Text('Current Plan',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight
                                                      .bold))),
                                      DataColumn(
                                          label:
                                          Text(_getCredit==null?'Free Plan':_getCredit.result.bgcPlan==null?'Free Plan':_getCredit.result.bgcPlan.toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight
                                                      .bold)
                                          )
                                      ),
                                    ],
                                    rows: [
                                      DataRow(cells: [
                                        DataCell(Text('Total Credits',
                                            style: kForteenText)),
                                        DataCell(Text(_getCredit==null?'0':_getCredit.result.creditPoints.toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black87,
                                                fontWeight:
                                                FontWeight.bold))),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text('Plan Cost',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black87,
                                                fontWeight:
                                                FontWeight.bold))),
                                        DataCell(Text('2000',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.red,
                                                fontWeight:
                                                FontWeight.bold)
                                        )),
                                      ]),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(builder: (BuildContext context) => AddAmount()));
                                      },
                                    ),

                                    // _getCredit == null
                                    //     ? SizedBox() :_getCredit.result.creditPoints >= 500
                                    //     ? SizedBox()
                                    //     : RaisedButton(
                                    //   shape: RoundedRectangleBorder(
                                    //       borderRadius:
                                    //       BorderRadius.circular(5)),
                                    //   textColor: Colors.white,
                                    //   color: Color(0xff3E66FB),
                                    //   child: Padding(
                                    //     padding: EdgeInsets.only(
                                    //         top: 12.0, bottom: 12.0),
                                    //     child: Text(
                                    //       'Book Service',
                                    //       style: k13Fwhite400BT,
                                    //     ),
                                    //   ),
                                    //   onPressed: () {
                                    //     showDialog(
                                    //       context: context,
                                    //       builder: (context) {
                                    //         return Dialog(
                                    //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    //           elevation: 16,
                                    //           child: Container(
                                    //             height: 220,
                                    //             child: Padding(
                                    //               padding: const EdgeInsets.all(20.0),
                                    //               child: Column(
                                    //                 children: [
                                    //                   Text(
                                    //                       'Are you Sure you want to take Standard Plan.\n Doing this will charge 500 points from your wallet.',
                                    //                       style: k16F87Black600HT
                                    //                   ),
                                    //                   SizedBox(height: 10,),
                                    //                   Row(
                                    //                     mainAxisAlignment:
                                    //                     MainAxisAlignment
                                    //                         .spaceBetween,
                                    //                     children: [
                                    //                       RaisedButton(
                                    //                         shape:
                                    //                         RoundedRectangleBorder(
                                    //                             borderRadius:
                                    //                             BorderRadius
                                    //                                 .circular(
                                    //                                 5)),
                                    //                         textColor: Colors.white,
                                    //                         color: Color(0xffDC2626),
                                    //                         child: Padding(
                                    //                           padding: EdgeInsets.only(
                                    //                               top: 14.0,
                                    //                               bottom: 14.0),
                                    //                           child: Text(
                                    //                             'Cancel',
                                    //                             style: k13Fwhite400BT,
                                    //                           ),
                                    //                         ),
                                    //                         onPressed: () => Navigator.pop(context, false),
                                    //                       ),
                                    //                       RaisedButton(
                                    //                         shape:
                                    //                         RoundedRectangleBorder(
                                    //                             borderRadius:
                                    //                             BorderRadius
                                    //                                 .circular(
                                    //                                 5)),
                                    //                         textColor: Colors.white,
                                    //                         color: Colors.green,
                                    //                         child: Padding(
                                    //                           padding: EdgeInsets.only(
                                    //                               top: 14.0,
                                    //                               bottom: 14.0),
                                    //                           child: Text(
                                    //                             'Confirm',
                                    //                             style: k13Fwhite400BT,
                                    //                           ),
                                    //                         ),
                                    //                         onPressed: () {
                                    //                           standardPlan();
                                    //                         },
                                    //                       ),
                                    //                     ],
                                    //                   ),
                                    //                 ],
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         );
                                    //       },
                                    //     );
                                    //
                                    //
                                    //
                                    //
                                    //   },
                                    // ),

                                    _getCredit == null?SizedBox(): _getCredit.result.creditPoints <= 1999
                                        ? SizedBox()
                                        : RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(5)),
                                      textColor: Colors.white,
                                      color: Color(0xff3E66FB),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 12.0, bottom: 12.0),
                                        child: Text(
                                          'Book Service',
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
                                                          'Are you Sure you want to take Standard Plan.\n Doing this will charge 2000 points from your wallet.',
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
                                                              premiumPlan();
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
                                    ) ,
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(children: <Widget>[
                          Container(
                            child: Image.asset(
                              'assets/images/rectangle.png', // and width here
                            ),
                          ),
                          myAppBar(),
                          Padding(
                            padding: const EdgeInsets.only(top: 80.0),
                            child: TabBar(
                              unselectedLabelColor: Colors.black,
                              labelColor: Colors.red,
                              tabs: [
                                Tab(
                                  child: Text("Standard",
                                      style: k18Fwhite600BT),
                                ),
                                Tab(
                                  child: Text(
                                    'Premium',
                                    style: k18Fwhite600BT,
                                  ),
                                ),
                                Tab(
                                  child: Text("Custom",
                                      style: k18Fwhite600BT),
                                ),
                              ],
                              controller: _tabController,
                              indicatorSize: TabBarIndicatorSize.tab,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15,right:15),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 150),
                                Row(
                                  children: [
                                    Text(
                                      'Custom Plan',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsBold',
                                          height: 1.3,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 32),
                                    ),
                                    Text(
                                      ' (0 Credits)',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsBold',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '(Contact Supported Team)',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontFamily: 'PoppinsBold',
                                      height: 1.3,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ]),
                        // Padding(
                        //   padding: const EdgeInsets.all(15.0),
                        //   child: Column(
                        //     children: [
                        //       Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text('Employment Verification',
                        //               style: k16F87Black600HT),
                        //           Switch(
                        //             onChanged: (bool value) {
                        //               if (isWork == false) {
                        //                 setState(() {
                        //                   isWork = true;
                        //                   // textValue = 'Switch Button is ON';
                        //                 });
                        //                 print('Switch Button is ON');
                        //               } else {
                        //                 setState(() {
                        //                   isWork = false;
                        //                   //textValue = 'Switch Button is OFF';
                        //                 });
                        //                 print('Switch Button is OFF');
                        //               }
                        //             },
                        //             value: isWork,
                        //             // activeColor: Colors.blue,
                        //             // activeTrackColor: Colors.yellow,
                        //             // inactiveThumbColor: Colors.redAccent,
                        //             // inactiveTrackColor: Colors.orange,
                        //           )
                        //         ],
                        //       ),
                        //       Row(
                        //         mainAxisAlignment:
                        //         MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text('HR Verification',
                        //               style: k16F87Black600HT),
                        //           Switch(
                        //             onChanged: (bool value) {
                        //               if (isMarry == false) {
                        //                 setState(() {
                        //                   isMarry = true;
                        //                   //   textValue = 'Switch Button is ON';
                        //                 });
                        //                 print('Switch Button is ON');
                        //               } else {
                        //                 setState(() {
                        //                   isMarry = false;
                        //                   // textValue = 'Switch Button is OFF';
                        //                 });
                        //                 print('Switch Button is OFF');
                        //               }
                        //             },
                        //             value: isMarry,
                        //             // activeColor: Colors.blue,
                        //             // activeTrackColor: Colors.yellow,
                        //             // inactiveThumbColor: Colors.redAccent,
                        //             // inactiveTrackColor: Colors.orange,
                        //           )
                        //         ],
                        //       ),
                        //       Row(
                        //         mainAxisAlignment:
                        //         MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text('Reference Check',
                        //               style: k16F87Black600HT),
                        //           Switch(
                        //             onChanged: (bool value) {
                        //               if (isBuss == false) {
                        //                 setState(() {
                        //                   isBuss = true;
                        //                   //textValue = 'Switch Button is ON';
                        //                 });
                        //                 print('Switch Button is ON');
                        //               } else {
                        //                 setState(() {
                        //                   isBuss = false;
                        //                   // textValue = 'Switch Button is OFF';
                        //                 });
                        //                 print('Switch Button is OFF');
                        //               }
                        //             },
                        //             value: isBuss,
                        //             // activeColor: Colors.blue,
                        //             // activeTrackColor: Colors.yellow,
                        //             // inactiveThumbColor: Colors.redAccent,
                        //             // inactiveTrackColor: Colors.orange,
                        //           )
                        //         ],
                        //       ),
                        //       Row(
                        //         mainAxisAlignment:
                        //         MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text('Face Verification',
                        //               style: k16F87Black600HT),
                        //           Switch(
                        //             onChanged: (bool value) {
                        //               if (isGhostMode == false) {
                        //                 setState(() {
                        //                   isGhostMode = true;
                        //                   //textValue = 'Switch Button is ON';
                        //                 });
                        //                 print('Switch Button is ON');
                        //               } else {
                        //                 setState(() {
                        //                   isGhostMode = false;
                        //                   // textValue = 'Switch Button is OFF';
                        //                 });
                        //                 print('Switch Button is OFF');
                        //               }
                        //             },
                        //             value: isGhostMode,
                        //             // activeColor: Colors.blue,
                        //             // activeTrackColor: Colors.yellow,
                        //             // inactiveThumbColor: Colors.redAccent,
                        //             // inactiveTrackColor: Colors.orange,
                        //           )
                        //         ],
                        //       ),
                        //       Row(
                        //         mainAxisAlignment:
                        //         MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text('Address Verification',
                        //               style: k16F87Black600HT),
                        //           Switch(
                        //             onChanged: (bool value) {
                        //               if (isPrivateMode == false) {
                        //                 setState(() {
                        //                   isPrivateMode = true;
                        //                   //textValue = 'Switch Button is ON';
                        //                 });
                        //                 print('Switch Button is ON');
                        //               } else {
                        //                 setState(() {
                        //                   isPrivateMode = false;
                        //                   //textValue = 'Switch Button is OFF';
                        //                 });
                        //                 print('Switch Button is OFF');
                        //               }
                        //             },
                        //             value: isPrivateMode,
                        //             // activeColor: Colors.blue,
                        //             // activeTrackColor: Colors.yellow,
                        //             // inactiveThumbColor: Colors.redAccent,
                        //             // inactiveTrackColor: Colors.orange,
                        //           )
                        //         ],
                        //       ),
                        //       Row(
                        //         mainAxisAlignment:
                        //         MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text('Education Verification',
                        //               style: k16F87Black600HT),
                        //           Switch(
                        //             onChanged: (bool value) {
                        //               if (isHidePh == false) {
                        //                 setState(() {
                        //                   isHidePh = true;
                        //                   //textValue = 'Switch Button is ON';
                        //                 });
                        //                 print('Switch Button is ON');
                        //               } else {
                        //                 setState(() {
                        //                   isHidePh = false;
                        //                   //textValue = 'Switch Button is OFF';
                        //                 });
                        //                 print('Switch Button is OFF');
                        //               }
                        //             },
                        //             value: isHidePh,
                        //             // activeColor: Colors.blue,
                        //             // activeTrackColor: Colors.yellow,
                        //             // inactiveThumbColor: Colors.redAccent,
                        //             // inactiveTrackColor: Colors.orange,
                        //           )
                        //         ],
                        //       ),
                        //       Row(
                        //         mainAxisAlignment:
                        //         MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text('Aadhaar',
                        //               style: k16F87Black600HT),
                        //           Switch(
                        //             onChanged: (bool value) {
                        //               if (isAadhar == false) {
                        //                 setState(() {
                        //                   isAadhar = true;
                        //                   //textValue = 'Switch Button is ON';
                        //                 });
                        //                 print('Switch Button is ON');
                        //               } else {
                        //                 setState(() {
                        //                   isAadhar = false;
                        //                   //textValue = 'Switch Button is OFF';
                        //                 });
                        //                 print('Switch Button is OFF');
                        //               }
                        //             },
                        //             value: isAadhar,
                        //             // activeColor: Colors.blue,
                        //             // activeTrackColor: Colors.yellow,
                        //             // inactiveThumbColor: Colors.redAccent,
                        //             // inactiveTrackColor: Colors.orange,
                        //           )
                        //         ],
                        //       ),
                        //       Row(
                        //         mainAxisAlignment:
                        //         MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text('Driver License',
                        //               style: k16F87Black600HT),
                        //           Switch(
                        //             onChanged: (bool value) {
                        //               if (isHidePro == false) {
                        //                 setState(() {
                        //                   isHidePro = true;
                        //                   //textValue = 'Switch Button is ON';
                        //                 });
                        //                 print('Switch Button is ON');
                        //               } else {
                        //                 setState(() {
                        //                   isHidePro = false;
                        //                   //textValue = 'Switch Button is OFF';
                        //                 });
                        //                 print('Switch Button is OFF');
                        //               }
                        //             },
                        //             value: isHidePro,
                        //             // activeColor: Colors.blue,
                        //             // activeTrackColor: Colors.yellow,
                        //             // inactiveThumbColor: Colors.redAccent,
                        //             // inactiveTrackColor: Colors.orange,
                        //           )
                        //         ],
                        //       ),
                        //       Row(
                        //         mainAxisAlignment:
                        //         MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text('Voter ID', style: k16F87Black600HT),
                        //           Switch(
                        //             onChanged: (bool value) {
                        //               if (isHideVehical == false) {
                        //                 setState(() {
                        //                   isHideVehical = true;
                        //                   // textValue = 'Switch Button is ON';
                        //                 });
                        //                 print('Switch Button is ON');
                        //               } else {
                        //                 setState(() {
                        //                   isHideVehical = false;
                        //                   //textValue = 'Switch Button is OFF';
                        //                 });
                        //                 print('Switch Button is OFF');
                        //               }
                        //             },
                        //             value: isHideVehical,
                        //             // activeColor: Colors.blue,
                        //             // activeTrackColor: Colors.yellow,
                        //             // inactiveThumbColor: Colors.redAccent,
                        //             // inactiveTrackColor: Colors.orange,
                        //           )
                        //         ],
                        //       ),
                        //       Row(
                        //         mainAxisAlignment:
                        //         MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text('Passport', style: k16F87Black600HT),
                        //           Switch(
                        //             onChanged: (bool value) {
                        //               if (isDownload == false) {
                        //                 setState(() {
                        //                   isDownload = true;
                        //                   //textValue = 'Switch Button is ON';
                        //                 });
                        //                 print('Switch Button is ON');
                        //               } else {
                        //                 setState(() {
                        //                   isDownload = false;
                        //                   // textValue = 'Switch Button is OFF';
                        //                 });
                        //                 print('Switch Button is OFF');
                        //               }
                        //             },
                        //             value: isDownload,
                        //             // activeColor: Colors.blue,
                        //             // activeTrackColor: Colors.yellow,
                        //             // inactiveThumbColor: Colors.redAccent,
                        //             // inactiveTrackColor: Colors.orange,
                        //           )
                        //         ],
                        //       ),
                        //       Row(
                        //         mainAxisAlignment:
                        //         MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text('Ration card',
                        //               style: k16F87Black600HT),
                        //           Switch(
                        //             onChanged: (bool value) {
                        //               if (isRation == false) {
                        //                 setState(() {
                        //                   isRation = true;
                        //                   // textValue = 'Switch Button is ON';
                        //                 });
                        //                 print('Switch Button is ON');
                        //               } else {
                        //                 setState(() {
                        //                   isRation = false;
                        //                   //textValue = 'Switch Button is OFF';
                        //                 });
                        //                 print('Switch Button is OFF');
                        //               }
                        //             },
                        //             value: isRation,
                        //             // activeColor: Colors.blue,
                        //             // activeTrackColor: Colors.yellow,
                        //             // inactiveThumbColor: Colors.redAccent,
                        //             // inactiveTrackColor: Colors.orange,
                        //           )
                        //         ],
                        //       ),
                        //       Row(
                        //         mainAxisAlignment:
                        //         MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text('Pan card', style: k16F87Black600HT),
                        //           Switch(
                        //             onChanged: (bool value) {
                        //               if (isPan == false) {
                        //                 setState(() {
                        //                   isPan = true;
                        //                   //   textValue = 'Switch Button is ON';
                        //                 });
                        //                 print('Switch Button is ON');
                        //               } else {
                        //                 setState(() {
                        //                   isPan = false;
                        //                   // textValue = 'Switch Button is OFF';
                        //                 });
                        //                 print('Switch Button is OFF');
                        //               }
                        //             },
                        //             value: isPan,
                        //             // activeColor: Colors.blue,
                        //             // activeTrackColor: Colors.yellow,
                        //             // inactiveThumbColor: Colors.redAccent,
                        //             // inactiveTrackColor: Colors.orange,
                        //           )
                        //         ],
                        //       ),
                        //       Text(
                        //         'Credit Check',
                        //         style: TextStyle(
                        //             color: Colors.black87,
                        //             fontFamily: 'PoppinsBold',
                        //             height: 1.3,
                        //             fontWeight: FontWeight.w500,
                        //             fontSize: 28),
                        //       ),
                        //       Row(
                        //         mainAxisAlignment:
                        //         MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text('Credit Check',
                        //               style: k16F87Black600HT),
                        //           Switch(
                        //             onChanged: (bool value) {
                        //               if (isCreditCheck == false) {
                        //                 setState(() {
                        //                   isCreditCheck = true;
                        //                   // textValue = 'Switch Button is ON';
                        //                 });
                        //                 print('Switch Button is ON');
                        //               } else {
                        //                 setState(() {
                        //                   isCreditCheck = false;
                        //                   //textValue = 'Switch Button is OFF';
                        //                 });
                        //                 print('Switch Button is OFF');
                        //               }
                        //             },
                        //             value: isCreditCheck,
                        //             // activeColor: Colors.blue,
                        //             // activeTrackColor: Colors.yellow,
                        //             // inactiveThumbColor: Colors.redAccent,
                        //             // inactiveTrackColor: Colors.orange,
                        //           )
                        //         ],
                        //       ),
                        //       Row(
                        //         mainAxisAlignment:
                        //         MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text('Credit History Assessment',
                        //               style: k16F87Black600HT),
                        //           Switch(
                        //             onChanged: (bool value) {
                        //               if (isCreditHistory == false) {
                        //                 setState(() {
                        //                   isCreditHistory = true;
                        //                   //   textValue = 'Switch Button is ON';
                        //                 });
                        //                 print('Switch Button is ON');
                        //               } else {
                        //                 setState(() {
                        //                   isCreditHistory = false;
                        //                   // textValue = 'Switch Button is OFF';
                        //                 });
                        //                 print('Switch Button is OFF');
                        //               }
                        //             },
                        //             value: isCreditHistory,
                        //             // activeColor: Colors.blue,
                        //             // activeTrackColor: Colors.yellow,
                        //             // inactiveThumbColor: Colors.redAccent,
                        //             // inactiveTrackColor: Colors.orange,
                        //           )
                        //         ],
                        //       ),
                        //       // Column(
                        //       //   children: [
                        //       //     Text(
                        //       //       'Criminal Check',
                        //       //       style: TextStyle(
                        //       //           color: Colors.black87,
                        //       //           fontFamily: 'PoppinsBold',
                        //       //           height: 1.3,
                        //       //           fontWeight: FontWeight.w500,
                        //       //           fontSize: 28),
                        //       //     ),
                        //       //     Row(
                        //       //       mainAxisAlignment:
                        //       //       MainAxisAlignment.spaceBetween,
                        //       //       children: [
                        //       //         Text('Aadhaar', style: k16F87Black600HT),
                        //       //         Switch(
                        //       //           onChanged: (bool value) {
                        //       //             if (isWork == false) {
                        //       //               setState(() {
                        //       //                 isWork = true;
                        //       //                 // textValue = 'Switch Button is ON';
                        //       //               });
                        //       //               print('Switch Button is ON');
                        //       //             } else {
                        //       //               setState(() {
                        //       //                 isWork = false;
                        //       //                 //textValue = 'Switch Button is OFF';
                        //       //               });
                        //       //               print('Switch Button is OFF');
                        //       //             }
                        //       //           },
                        //       //           value: isWork,
                        //       //           // activeColor: Colors.blue,
                        //       //           // activeTrackColor: Colors.yellow,
                        //       //           // inactiveThumbColor: Colors.redAccent,
                        //       //           // inactiveTrackColor: Colors.orange,
                        //       //         )
                        //       //       ],
                        //       //     ),
                        //       //     Row(
                        //       //       mainAxisAlignment:
                        //       //       MainAxisAlignment.spaceBetween,
                        //       //       children: [
                        //       //         Text('Driver License',
                        //       //             style: k16F87Black600HT),
                        //       //         Switch(
                        //       //           onChanged: (bool value) {
                        //       //             if (isMarry == false) {
                        //       //               setState(() {
                        //       //                 isMarry = true;
                        //       //                 //   textValue = 'Switch Button is ON';
                        //       //               });
                        //       //               print('Switch Button is ON');
                        //       //             } else {
                        //       //               setState(() {
                        //       //                 isMarry = false;
                        //       //                 // textValue = 'Switch Button is OFF';
                        //       //               });
                        //       //               print('Switch Button is OFF');
                        //       //             }
                        //       //           },
                        //       //           value: isMarry,
                        //       //           // activeColor: Colors.blue,
                        //       //           // activeTrackColor: Colors.yellow,
                        //       //           // inactiveThumbColor: Colors.redAccent,
                        //       //           // inactiveTrackColor: Colors.orange,
                        //       //         )
                        //       //       ],
                        //       //     ),
                        //       //     Row(
                        //       //       mainAxisAlignment:
                        //       //       MainAxisAlignment.spaceBetween,
                        //       //       children: [
                        //       //         Text('Voter ID', style: k16F87Black600HT),
                        //       //         Switch(
                        //       //           onChanged: (bool value) {
                        //       //             if (isWork == false) {
                        //       //               setState(() {
                        //       //                 isWork = true;
                        //       //                 // textValue = 'Switch Button is ON';
                        //       //               });
                        //       //               print('Switch Button is ON');
                        //       //             } else {
                        //       //               setState(() {
                        //       //                 isWork = false;
                        //       //                 //textValue = 'Switch Button is OFF';
                        //       //               });
                        //       //               print('Switch Button is OFF');
                        //       //             }
                        //       //           },
                        //       //           value: isWork,
                        //       //           // activeColor: Colors.blue,
                        //       //           // activeTrackColor: Colors.yellow,
                        //       //           // inactiveThumbColor: Colors.redAccent,
                        //       //           // inactiveTrackColor: Colors.orange,
                        //       //         )
                        //       //       ],
                        //       //     ),
                        //       //     Row(
                        //       //       mainAxisAlignment:
                        //       //       MainAxisAlignment.spaceBetween,
                        //       //       children: [
                        //       //         Text('Passport', style: k16F87Black600HT),
                        //       //         Switch(
                        //       //           onChanged: (bool value) {
                        //       //             if (isMarry == false) {
                        //       //               setState(() {
                        //       //                 isMarry = true;
                        //       //                 //   textValue = 'Switch Button is ON';
                        //       //               });
                        //       //               print('Switch Button is ON');
                        //       //             } else {
                        //       //               setState(() {
                        //       //                 isMarry = false;
                        //       //                 // textValue = 'Switch Button is OFF';
                        //       //               });
                        //       //               print('Switch Button is OFF');
                        //       //             }
                        //       //           },
                        //       //           value: isMarry,
                        //       //           // activeColor: Colors.blue,
                        //       //           // activeTrackColor: Colors.yellow,
                        //       //           // inactiveThumbColor: Colors.redAccent,
                        //       //           // inactiveTrackColor: Colors.orange,
                        //       //         )
                        //       //       ],
                        //       //     ),
                        //       //     Row(
                        //       //       mainAxisAlignment:
                        //       //       MainAxisAlignment.spaceBetween,
                        //       //       children: [
                        //       //         Text('Ration card',
                        //       //             style: k16F87Black600HT),
                        //       //         Switch(
                        //       //           onChanged: (bool value) {
                        //       //             if (isRation == false) {
                        //       //               setState(() {
                        //       //                 isRation = true;
                        //       //                 // textValue = 'Switch Button is ON';
                        //       //               });
                        //       //               print('Switch Button is ON');
                        //       //             } else {
                        //       //               setState(() {
                        //       //                 isRation = false;
                        //       //                 //textValue = 'Switch Button is OFF';
                        //       //               });
                        //       //               print('Switch Button is OFF');
                        //       //             }
                        //       //           },
                        //       //           value: isRation,
                        //       //           // activeColor: Colors.blue,
                        //       //           // activeTrackColor: Colors.yellow,
                        //       //           // inactiveThumbColor: Colors.redAccent,
                        //       //           // inactiveTrackColor: Colors.orange,
                        //       //         )
                        //       //       ],
                        //       //     ),
                        //       //     Row(
                        //       //       mainAxisAlignment:
                        //       //       MainAxisAlignment.spaceBetween,
                        //       //       children: [
                        //       //         Text('Pan card', style: k16F87Black600HT),
                        //       //         Switch(
                        //       //           onChanged: (bool value) {
                        //       //             if (isPan == false) {
                        //       //               setState(() {
                        //       //                 isPan = true;
                        //       //                 //   textValue = 'Switch Button is ON';
                        //       //               });
                        //       //               print('Switch Button is ON');
                        //       //             } else {
                        //       //               setState(() {
                        //       //                 isPan = false;
                        //       //                 // textValue = 'Switch Button is OFF';
                        //       //               });
                        //       //               print('Switch Button is OFF');
                        //       //             }
                        //       //           },
                        //       //           value: isPan,
                        //       //           // activeColor: Colors.blue,
                        //       //           // activeTrackColor: Colors.yellow,
                        //       //           // inactiveThumbColor: Colors.redAccent,
                        //       //           // inactiveTrackColor: Colors.orange,
                        //       //         )
                        //       //       ],
                        //       //     ),
                        //       //     Divider(
                        //       //       color: Colors.black,
                        //       //     ),
                        //       //   ],
                        //       // ),
                        //
                        //       // Column(
                        //       //   children: [
                        //       //     Text(
                        //       //       'Drug Test',
                        //       //       style: TextStyle(
                        //       //           color: Colors.black87,
                        //       //           fontFamily: 'PoppinsBold',
                        //       //           height: 1.3,
                        //       //           fontWeight: FontWeight.w500,
                        //       //           fontSize: 28),
                        //       //     ),
                        //       //     Divider(
                        //       //       color: Colors.black,
                        //       //     ),
                        //       //   ],
                        //       // ),
                        //
                        //       // Column(
                        //       //   children: [
                        //       //     Text(
                        //       //       'Health Check',
                        //       //       style: TextStyle(
                        //       //           color: Colors.black87,
                        //       //           fontFamily: 'PoppinsBold',
                        //       //           height: 1.3,
                        //       //           fontWeight: FontWeight.w500,
                        //       //           fontSize: 28),
                        //       //     ),
                        //       //   ],
                        //       // ),
                        //   Divider(
                        //           color: Colors.black,
                        //         ),
                        //       // SizedBox(
                        //       //   height: 15,
                        //       // ),
                        //       Center(
                        //         child: DataTable(
                        //           columns: [
                        //             DataColumn(
                        //                 label: Text('Current Plan',
                        //                     style: TextStyle(
                        //                         fontSize: 18,
                        //                         fontWeight:
                        //                         FontWeight.bold))),
                        //             DataColumn(
                        //                 label: Text('Free Plan',
                        //                     style: TextStyle(
                        //                         fontSize: 18,
                        //                         fontWeight:
                        //                         FontWeight.bold))),
                        //           ],
                        //           rows: [
                        //             DataRow(cells: [
                        //               DataCell(Text('Total Credits',
                        //                   style: kForteenText)),
                        //               DataCell(Text('0',
                        //                   style: k16F87Black600HT)),
                        //             ]),
                        //             DataRow(cells: [
                        //               DataCell(Text('Plan Cost',
                        //                   style: kForteenText)),
                        //               DataCell(Text('0',
                        //                   style: k16F87Black600HT)),
                        //             ]),
                        //             DataRow(cells: [
                        //               DataCell(Text('More Credits needed',
                        //                   style: kForteenText)),
                        //               DataCell(Text('0',
                        //                   style: k16F87Black600HT)),
                        //             ]),
                        //           ],
                        //         ),
                        //       ),
                        //       Center(
                        //         child: Text('Not enough credit',
                        //             style: k16F87Black600HT),
                        //       ),
                        //       SizedBox(
                        //         height: 10,
                        //       ),
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           RaisedButton(
                        //             shape: RoundedRectangleBorder(
                        //                 borderRadius:
                        //                 BorderRadius.circular(5)),
                        //             textColor: Colors.white,
                        //             color: Color(0xff3E66FB),
                        //             child: Padding(
                        //               padding: EdgeInsets.only(
                        //                   top: 12.0, bottom: 12.0),
                        //               child: Text(
                        //                 'Buy Credit',
                        //                 style: k13Fwhite400BT,
                        //               ),
                        //             ),
                        //             onPressed: () {},
                        //           ),
                        //           RaisedButton(
                        //             shape: RoundedRectangleBorder(
                        //                 borderRadius:
                        //                 BorderRadius.circular(5)),
                        //             textColor: Colors.white,
                        //             color: Color(0xff3E66FB),
                        //             child: Padding(
                        //               padding: EdgeInsets.only(
                        //                   top: 12.0, bottom: 12.0),
                        //               child: Text(
                        //                 'Book Service',
                        //                 style: k13Fwhite400BT,
                        //               ),
                        //             ),
                        //             onPressed: () {},
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                  controller: _tabController,
                ),
              ),
            ),
          )),
    );
  }

  cancelDoneButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          textColor: Colors.white,
          color: Color(0xff3E66FB),
          child: Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: Text(
              'Done',
              style: k13Fwhite400BT,
            ),
          ),
          onPressed: () {
            if (_formkey.currentState.validate()) {
              // updateProfile();
            }
          },
        ),
      ],
    );
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
                      employementStatus = true;
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
                      employementStatus = false;
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
