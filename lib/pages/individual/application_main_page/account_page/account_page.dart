import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/login.dart';
import 'package:flutter_emptra/models/getListModel/getAdhaarDetail.dart';
import 'package:flutter_emptra/models/getListModel/getAllhrDetail.dart';
import 'package:flutter_emptra/models/getListModel/getBankDetail.dart';
import 'package:flutter_emptra/models/getListModel/getCountryModel.dart';
import 'package:flutter_emptra/models/getListModel/getCreditModel.dart';
import 'package:flutter_emptra/models/getListModel/getEmailVerifyModel.dart';
import 'package:flutter_emptra/models/getListModel/getEtScore.dart';
import 'package:flutter_emptra/models/getListModel/getPenDetail.dart';
import 'package:flutter_emptra/models/getListModel/getProfileinfoModel.dart';
import 'package:flutter_emptra/pages/individual/add/account/country_add.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/about_page/shimmer_about.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/account_page/review_account.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/account_page/self_assessment_account.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/address_card.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/ctc_verfication.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/email_verification.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/vehicle_card.dart';
import 'package:flutter_emptra/widgets/qrCode.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../clickable_card/pancard_editable.dart';
import 'package:flutter_emptra/widgets/app_bar.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import '../../../../widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../clickable_card/adhaarcard_editable.dart';
import '../../clickable_card/bankcard_editable.dart';
import '../../clickable_card/basicsoftskill_editable.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  GetPersonalInfoHistoryModel _personalInfoHistoryData;
  bool _isLoading = false;
  GetCountryListModel _countryData;
  GetBankDetail _bankData;
  GetAdhaarDetail _getAdhaarDetail;
  GetPenCardDetail _getPenCardDetail;
  GetAllHrDetail _getAllHrDetails;
  GetEtScore _etScore;
  GetCreditModel _getCreditModel;
  GetEmailVerify _getEmailVerify;

  getCredit() async {
    try{
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();

    var response = await dio.get(
      "${Api.creditScore}/$userId",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
    );

    if (response.statusCode == 200) {
      if (response.data['code'] == 100) {
        setState(() {
          _getCreditModel = GetCreditModel.fromJson(response.data);
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
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }catch(e){
      print(e);
    }
  }

  getEmailVerify() async {
    try{
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();

    var response = await dio.get(
      "${Api.getEmailVerify}/$userId",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
    );
    print('object,object vobjectvobjectobjectvobjectobjectobjectobjectobjectobjectobject');
    if (response.statusCode == 200) {
      if (response.data['code'] == 100) {
        setState(() {
          print('object,object vobjectvobjectobjectvobjectobjectobjectobjectobjectobjectobject');
          _getEmailVerify = GetEmailVerify.fromJson(response.data);
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
  }catch(e){
      print(e);
    }
  }

  getEtScore() async {
    try{
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();

    var response = await dio.get(
      "${Api.etScore}/$userId",
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
        _etScore = GetEtScore.fromJson(response.data);
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
    catch(e){
      print(e);
    }
  }

  getPanDetail() async {
    try{
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.get(
      "${Api.getPenDetails}/$userId/PANCR",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
    );
    if (response.statusCode == 200) {
      if (response.data['code'] == 100) {
        setState(() {
          _getPenCardDetail = GetPenCardDetail.fromJson(response.data);
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
  }catch(e){
      print(e);
    }
  }

  getCountry() async {
    try{
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.get(
      "${Api.employeeCountry}/$userId",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
    );
    if (response.statusCode == 200) {
      print(response.data);
      if (response.data['code'] == 200) {
        setState(() {
          print("!!!!!");
          _countryData = GetCountryListModel.fromJson(response.data);
          _isLoading = false;
          print(_countryData);
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
    catch(e){
      print(e);
    }
  }

  getBasicSoft() async {
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
        _isLoading = false;
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(
        //       builder: (context) => Login(),
        //     ),
        //         (Route<dynamic> route) => false);
      });
    }
  }catch(e){
      print(e);
    }
  }

  getBankDetail() async {
    try{
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
  }
    catch(e){
      print(e);
    }
  }

  getAdhaarDetail() async {
    try{
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.get(
      "${Api.getAdhaarDetails}/$userId/ADHAR",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
    );
    if (response.statusCode == 200) {
      if (response.data['code'] == 100) {
        setState(() {
          _getAdhaarDetail = GetAdhaarDetail.fromJson(response.data);
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
  }
    catch(e){
      print(e);
    }
  }

  getAllHrDetail() async {
    try{
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.get(
      "${Api.getAllHrDetails}/$userId",
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
          _getAllHrDetails = GetAllHrDetail.fromJson(response.data);
          print(_getAllHrDetails);
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
    try{
    await getBasicSoft();
    await getEmailVerify();
    await getEtScore();
    await getCountry();
    await getBankDetail();
    await getAdhaarDetail();
    await getAllHrDetail();
    await getPanDetail();
    await getCredit();
  }
  catch(e){
  print(e);
  }
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Color(0xffF8F7F3),
        child: _isLoading == true
            ? Center(child: ShimmerAbout())
            : Scaffold(
                drawer: MyDrawer(),
                body: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              'assets/images/rectanglebackground.png', // and width here
                            ),
                          ),
                          Stack(
                            children: [
                              myAppBar(),
                              Align(
                                alignment: Alignment.topRight,
                                child:
                                IconButton(
                                  icon: Icon(
                                    Icons.qr_code,
                                  ),
                                  //iconSize: 28,
                                  color: Colors.white,
                                  // splashColor: Colors.purple,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Scanner(
                                                  // data: _personalInfoHistoryData,
                                                )));
                                  },
                                ),),
                            ],
                          ),
                          Center(
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 70, left: 12, right: 12),
                                child: Stack(children: <Widget>[
                                  Center(
                                    child: Card(
                                      elevation: 1,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: SizedBox(
                                        height: 170,
                                        width: 300,
                                      )
                                    ),
                                  ),
                                  _etScore == null?
                                  Padding(
                                    padding: const EdgeInsets.only(top:20),
                                    child: Center(
                                      child: CircularPercentIndicator(
                                        radius: 190.0,
                                        lineWidth: 11.0,
                                        animation: true,
                                        percent: 0.0,
                                        animationDuration: 2000,
                                        arcBackgroundColor: Colors.grey,
                                        arcType: ArcType.HALF,
                                        center: Stack(
                                          children: <Widget>[
                                            Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 60,
                                                  ),
                                                  Text(
                                                    "TruScore",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontFamily: 'PoppinsLight',
                                                        fontSize: 20),
                                                  ),
                                                  Text(
                                                  "0",
                                                    style: TextStyle(
                                                        color: Color(0xffFF5C5C),
                                                        fontFamily: 'PoppinsBold',
                                                        fontSize: 34),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        circularStrokeCap: CircularStrokeCap.butt,
                                        backgroundColor: Colors.transparent,
                                        progressColor: Color(0xffFF5C5C),
                                      ),
                                    ),
                                  ):
                                  Padding(
                                    padding: const EdgeInsets.only(top:20),
                                    child: Center(
                                      child: CircularPercentIndicator(
                                        radius: 190.0,
                                        lineWidth: 11,
                                        animation: true,
                                        percent: 0.001*
                                            double.tryParse(
                                                _etScore.etScore.toString()),
                                        animationDuration: 2000,
                                        arcBackgroundColor: Colors.grey,
                                        arcType: ArcType.HALF,
                                        center: Stack(
                                          children: <Widget>[
                                            Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 60,
                                                  ),
                                                  Text(
                                                    "TruScore",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontFamily: 'PoppinsLight',
                                                        fontSize: 20),
                                                  ),
                                                  Text(
                                                    _etScore.etScore.toString(),
                                                    style: TextStyle(
                                                        color: Color(0xffFF5C5C),
                                                        fontFamily: 'PoppinsBold',
                                                        fontSize: 34),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        circularStrokeCap: CircularStrokeCap.butt,
                                        backgroundColor: Colors.transparent,
                                        progressColor: Color(0xffFF5C5C),
                                      ),
                                    ),
                                  ),
                                ])),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AdhaarCardEdit()));
                              },
                              child: Card(
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.indigo,
                                        radius: 25,
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/adhaar.png"),
                                          radius: 25,
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      Text(
                                        'Adhaar Card',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                            fontFamily: 'PoppinsLight',
                                            fontSize: 16),
                                      ),
                                      SizedBox(width: 20),
                                      _getAdhaarDetail == null
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
                                          : _getAdhaarDetail.result.status
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
                                              : _getAdhaarDetail.result.status
                                                          .toString() ==
                                                      "Rejected"
                                                  ? Container(
                                                      width: 80,
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
                                                          color:
                                                              Color(0xffFBE4BB),
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
                                                              Icons
                                                                  .hourglass_top_outlined,
                                                              size: 15,
                                                              color: Color(
                                                                  0xffC47F00),
                                                            ),
                                                            Text(
                                                              'PENDING',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xffC47F00),
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
                                                    ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PenCardEdit()));
                              },
                              child: Card(
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.white24,
                                        radius: 25,
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/pan.png"),
                                          radius: 25,
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      Text(
                                        'Pancard',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                            fontFamily: 'PoppinsLight',
                                            fontSize: 16),
                                      ),
                                      SizedBox(width: 20),
                                      _getPenCardDetail == null
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
                                          : _getPenCardDetail.result.status
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
                                              : _getPenCardDetail.result.status
                                                          .toString() ==
                                                      "Rejected"
                                                  ? Container(
                                                      width: 90,
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
                                                          color:
                                                              Color(0xffFBE4BB),
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
                                                              Icons
                                                                  .hourglass_top_outlined,
                                                              size: 15,
                                                              color: Color(
                                                                  0xffC47F00),
                                                            ),
                                                            Text(
                                                              'PENDING',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xffC47F00),
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
                                                    ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/car.PNG"),
                                        radius: 25,
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                    Text(
                                      'Driving Licence',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 16),
                                    ),
                                    Container(
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
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/covi.png"),
                                        radius: 25,
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                    Text(
                                      'Covid Vaccination',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 16),
                                    ),
                                    Container(
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
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              // onTap: () {
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => CreditCardEdit()));
                              // },
                              child: Card(
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/passport.png"),
                                          radius: 25,
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                      Text(
                                        'Passport',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                            fontFamily: 'PoppinsLight',
                                            fontSize: 16),
                                      ),
                                      Container(
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EmailVerification()));
                              },
                              child: Card(
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.indigo,
                                        radius: 25,
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/email.PNG"),
                                          radius: 25,
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                      Text(
                                        'Email Verification',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                            fontFamily: 'PoppinsLight',
                                            fontSize: 16),
                                      ),
                                      _getEmailVerify == null
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
                                          : _getEmailVerify.result.status
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
                                          : _getEmailVerify.result.status
                                          .toString() ==
                                          "Rejected"
                                          ? Container(
                                        width: 90,
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
                                            color:
                                            Color(0xffFBE4BB),
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
                                                Icons
                                                    .hourglass_top_outlined,
                                                size: 15,
                                                color: Color(
                                                    0xffC47F00),
                                              ),
                                              Text(
                                                'PENDING',
                                                style: TextStyle(
                                                    color: Color(
                                                        0xffC47F00),
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
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),

                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BankCardEdit()));
                              },
                              child: Card(
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.indigo,
                                        radius: 25,
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/bank.png"),
                                          radius: 25,
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                      SizedBox(width: 30),
                                      Text(
                                        'Bank Details',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                            fontFamily: 'PoppinsLight',
                                            fontSize: 16),
                                      ),
                                      SizedBox(width: 20),
                                      _bankData == null
                                          ? Container(
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
                                          : _bankData != null
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
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddressCard()));
                              },
                              child: Card(
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/clipboard.png"),
                                          radius: 25,
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                      Text(
                                        'Physical Address Verify',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                            fontFamily: 'PoppinsLight',
                                            fontSize: 16),
                                      ),
                                      Container(
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VehicleCard()));
                              },
                              child: Card(
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/car.PNG"),
                                          radius: 25,
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                      Text(
                                        'Vehicles Owned',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                            fontFamily: 'PoppinsLight',
                                            fontSize: 16),
                                      ),
                                      Container(
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CtcAdd()));
                              },
                              child: Card(
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/ctc.PNG"),
                                          radius: 25,
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                      Text(
                                        'CTC Verification',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                            fontFamily: 'PoppinsLight',
                                            fontSize: 16),
                                      ),
                                      Container(
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/credit_check.png"),
                                        radius: 25,
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                    Text(
                                      'Credit Check',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 16),
                                    ),
                                    Container(
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
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/criminalCheck.PNG"),
                                        radius: 25,
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                    Text(
                                      'Criminal Check',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 16),
                                    ),
                                    Container(
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
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/investigate.png"),
                                        radius: 25,
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                    Text(
                                      'Investigative Check',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 16),
                                    ),
                                    Container(
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
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/drug.PNG"),
                                        radius: 25,
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                    Text(
                                      'Drug Test',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 16),
                                    ),
                                    Container(
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
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/idendify.PNG"),
                                        radius: 25,
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                    Text(
                                      'Identifiaction Marks',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 16),
                                    ),
                                    Container(
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
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            
                            /// Self Assessment Account
                            SelfAssessmentAccoutn(),
                            SizedBox(height: 30),
                            
                            ///Review Account
                            ReviewAccount(),
                            SizedBox(height: 10),
                            
                            ///Country Account
                            
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
