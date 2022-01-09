import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/login.dart';
import 'package:flutter_emptra/models/getListModel/getCertificateModel.dart';
import 'package:flutter_emptra/models/getListModel/getCourseModel.dart';
import 'package:flutter_emptra/models/getListModel/getLearningScore.dart';
import 'package:flutter_emptra/models/getListModel/getProfileinfoModel.dart';
import 'package:flutter_emptra/pages/individual/add/learning/certificate_add.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/about_page/shimmer_about.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/learning_page/courses_learning.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/certificate_card.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/courses_card.dart';
import 'package:flutter_emptra/widgets/app_bar.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:flutter_emptra/widgets/qrCode.dart';
import '../../../../widgets/drawer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../add/learning/courses_add.dart';

class LearningPage extends StatefulWidget {
  @override
  _LearningPageState createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  GetCourseHistoryModel _courseData;
  GetCertificateModel _certificateData;
  GetLearningScore _learningScore;
  GetPersonalInfoHistoryModel _personalInfoHistoryData;
  bool _isLoading = false;

  //String userId = "285885";
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

  success1(String value) {
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
  getLearningScore() async {
    try{
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.get(
      "${Api.learningScore}/$userId",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
    );
    if (response.statusCode == 200) {
      print(response.data);
      setState(() {
        print("!!!!!");
        _learningScore = GetLearningScore.fromJson(response.data);
        print(response.data['result']);
        print(_learningScore);
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

  getCourseHistory() async {
    try{
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.get(
      "${Api.courseHistoryList}/$userId",
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
          _courseData = GetCourseHistoryModel.fromJson(response.data);
          print(_courseData);
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
  getCertificateHistory() async {
    try{
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.get(
      "${Api.certificateHistoryList}/$userId",
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
          _certificateData = GetCertificateModel.fromJson(response.data);
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

  @override
  void initState() {
    super.initState();
    hello();
  }

  hello() async {
    try{
    await getProfile();
    await getLearningScore();
    await getCourseHistory();
    await getCertificateHistory();
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
                          _learningScore == null
                              ?
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 90),
                            child: Center(
                              child: CircularPercentIndicator(
                                radius: 200.0,
                                lineWidth: 13.0,
                                animation: true,
                                percent:0.0,
                                center: Stack(
                                  children: <Widget>[
                                    Center(
                                      child: Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xff10B981)),
                                      ),
                                    ),
                                    Center(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Learn Score",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'PoppinsLight',
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
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: Color(0xff10B981),
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
                                percent:
                                0.01*double.tryParse(_learningScore
                                    .learningScore
                                    .toString()),
                                center: Stack(
                                  children: <Widget>[
                                    Center(
                                      child: Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xff10B981)),
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
                                                fontFamily: 'PoppinsLight',
                                                fontSize: 14),
                                          ),
                                          Text(
                                            _learningScore
                                                .learningScore
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
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: Color(0xff10B981),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 320),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                
                                /// Courses Learning
                                CoursesLearning(),
                                SizedBox(height: 10),
                                
                                /// Certificate Learning
                                
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
    );
  }
}
