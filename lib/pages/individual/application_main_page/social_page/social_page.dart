import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/login.dart';
import 'package:flutter_emptra/models/getListModel/getProfileinfoModel.dart';
import 'package:flutter_emptra/models/getListModel/getSocialModel.dart';
import 'package:flutter_emptra/models/getListModel/getSocialScore.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/about_page/shimmer_about.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/social_page/volunteer_social.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/social_card.dart';
import 'package:flutter_emptra/widgets/app_bar.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:flutter_emptra/widgets/qrCode.dart';
import '../../../../widgets/drawer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../add/social/social_add.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  GetSocialHistoryModel _socialData;
  GetSocialScore _socialSco;
  bool _isLoading = false;
  GetPersonalInfoHistoryModel _personalInfoHistoryData;

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
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
                  (Route<dynamic> route) => false);
        });
      }
    } else {
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => Login(),
            ),
                (Route<dynamic> route) => false);
        _isLoading = false;
      });
    }
  }catch(e){
      print(e);
    }
  }
  getSocialHistory() async {
    try{
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
    catch(e){
      print(e);
    }
  }

  getSocialScore() async {
    try{
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
    try{
    await getSocialScore();
    await getProfile();
    await getSocialHistory();
  }catch(e){
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
                          _socialSco == null
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 90),
                                  child: Center(
                                    child: CircularPercentIndicator(
                                      radius: 200.0,
                                      lineWidth: 13.0,
                                      animation: true,
                                      percent: 0.0,
                                      center: Stack(
                                        children: <Widget>[
                                          Center(
                                            child: Container(
                                              width: 150,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xffF59E0B)),
                                            ),
                                          ),
                                          Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Social Score",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                          'PoppinsLight',
                                                      fontSize: 14),
                                                ),
                                                Text(
                                                  "0",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'PoppinsBold',
                                                      fontSize: 34),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: Color(0xffF59E0B),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 90),
                                  child: Center(
                                    child: CircularPercentIndicator(
                                      radius: 200.0,
                                      lineWidth: 13.0,
                                      animation: true,
                                      percent: 0.01 *
                                          double.tryParse(_socialSco.socialScore
                                              .toString()),
                                      center: Stack(
                                        children: <Widget>[
                                          Center(
                                            child: Container(
                                              width: 150,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xffF59E0B)),
                                            ),
                                          ),
                                          Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Social Score",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                          'PoppinsLight',
                                                      fontSize: 14),
                                                ),
                                                Text(
                                                  _socialSco.socialScore
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'PoppinsBold',
                                                      fontSize: 34),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: Color(0xffF59E0B),
                                    ),
                                  ),
                                ),
                          /// Volunteer
                          
                          VolunteerSocial()
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
