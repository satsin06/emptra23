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

class CoursesLearning extends StatefulWidget {
  const CoursesLearning({Key key}) : super(key: key);

  @override
  _CoursesLearningState createState() => _CoursesLearningState();
}

class _CoursesLearningState extends State<CoursesLearning> {
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Courses',
              style: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'PoppinsBold',
                  fontSize: 24),
            ),
            Container(
              height: 35,
              width: 80,
              decoration: BoxDecoration(
                  color: Color(0xff3E66FB),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: FlatButton(
                child: Text(
                  '+ Add',
                  style: TextStyle(fontFamily: 'PoppinsLight', fontSize: 12),
                ),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CoursesAdd()));
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        _courseData == null
            ? Column(
                children: [
                  Container(
                    height: 300,
                    width: 300,
                    child: Image.asset(
                      'assets/images/courseadd.png', // and width here
                    ),
                  ),
                  Text(
                    'Add Courses',
                    style: TextStyle(
                        color: Colors.black26,
                        fontFamily: 'PoppinsNormal',
                        fontSize: 24),
                  ),
                ],
              )
            : _courseData.result == null
                ? Column(
                    children: [
                      Container(
                        height: 300,
                        width: 300,
                        child: Image.asset(
                          'assets/images/courseadd.png', // and width here
                        ),
                      ),
                      Text(
                        'Add Courses',
                        style: TextStyle(
                            color: Colors.black26,
                            fontFamily: 'PoppinsNormal',
                            fontSize: 24),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: ListView.builder(
                            itemCount: _courseData.result.length,
                            shrinkWrap: true,
                            // scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CoursesEditCard(
                                                    data: _courseData,
                                                    index: index)));
                                    // LearnEditCard(
                                    //     data:
                                    //     socialData[i])));
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
                                            radius: 22,
                                            child: CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  "assets/images/courseadd.png"),
                                              radius: 22,
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _courseData.result[index].name
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    color: Colors.black87,
                                                    fontFamily: 'PoppinsLight',
                                                    fontSize: 16),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                child: Text(
                                                  _courseData
                                                      .result[index].institution
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontFamily:
                                                          'PoppinsLight',
                                                      fontSize: 14),
                                                ),
                                              ),
                                              Text(
                                                '${_courseData.result[index].from.toString()} - ${_courseData.result[index].to.toString()}',
                                                style: kForteenText,
                                              ),
                                            ],
                                          ),
                                          _courseData.result[index].status
                                                      .toString() ==
                                                  "Pending"
                                              ? Container(
                                                  //color: Colors.amber[600],
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffFBE4BB),
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
                                                          Icons
                                                              .hourglass_top_outlined,
                                                          size: 15,
                                                          color:
                                                              Color(0xffC47F00),
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
                                                )
                                              : _courseData.result[index].status
                                                          .toString() ==
                                                      "Approved"
                                                  ? Container(
                                                      //color: Colors.amber[600],
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xffA7F3D0),
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
                                                                  .check_circle,
                                                              size: 14,
                                                              color:
                                                                  Colors.green,
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
                                                  : _courseData.result[index]
                                                              .status
                                                              .toString() ==
                                                          "Rejected"
                                                      ? Container(
                                                          //color: Colors.amber[600],
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xffFECACA),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
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
                                                                      .cancel_outlined,
                                                                  size: 15,
                                                                  color: Colors
                                                                      .red,
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
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      : SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ));
                            }),
                      ),
                    ],
                  ),
      ],
    );
  }
}
