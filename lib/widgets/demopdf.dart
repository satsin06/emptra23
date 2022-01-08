import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_emptra/models/getListModel/getEtScore.dart';
import 'package:flutter_emptra/models/getListModel/getHealthScore.dart';
import 'package:flutter_emptra/models/getListModel/getLearningScore.dart';
import 'package:flutter_emptra/models/getListModel/getProfileinfoModel.dart';
import 'package:flutter_emptra/models/getListModel/getSocialScore.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:printing/printing.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyAppp extends StatefulWidget {
  @override
  State<MyAppp> createState() => _MyApppState();
}

class _MyApppState extends State<MyAppp> {
  final GlobalKey<State<StatefulWidget>> _printKey = GlobalKey();

  final GlobalKey<State<StatefulWidget>> _printKey1 = GlobalKey();

  bool _isLoading = true;
 String firstName ;
  String lastName;
  String dob ;
  String webSite ;
  String about;

  String profilePic;
  String profile;
  String ctc ;
  String facebook ;
  String twitter ;
  String linkedIn ;
  String instagram ;
  String employeeName ;
  String employeeId ;
  String gender ;

  GetPersonalInfoHistoryModel _personalInfoHistoryData;

  GetEtScore _etScore;

  GetHealthScore _healthScore;

  GetLearningScore _learningScore;

  GetSocialScore _socialSco;

  String _profileUrl;

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
    } catch(e){
      print(e);
    }
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
    } catch(e){
      print(e);
    }
  }

  getHealthScore() async {
    try{
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();
      var response = await dio.get(
        "${Api.healthScore}/$userId",
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
          _healthScore = GetHealthScore.fromJson(response.data);
          print(response.data['result']);
          print(_healthScore);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch(e){
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
    } catch(e){
      print(e);
    }
  }

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
        String firstName =
        response.data['result']['personalInfo']['personal']['firstName'];
        session.setString("firstName", firstName);
        String lastName =
        response.data['result']['personalInfo']['personal']['lastName'];
        session.setString("lastName", lastName);
        String etKey = response.data['result']['etKey'];
        session.setString("etKey", etKey);
        setState(() {
          _isLoading = false;
          print("!!!!!");
          _personalInfoHistoryData =
              GetPersonalInfoHistoryModel.fromJson(response.data);
          print(_personalInfoHistoryData);
          // profilePic = _personalInfoHistoryData
          //     .result.personalInfo.personal.profilePicture ==
          //     null ||
          //     _personalInfoHistoryData
          //         .result.personalInfo.personal.profilePicture ==
          //         ""
          //     ? 'https://emptradocs.s3.ap-south-1.amazonaws.com/529893-user.jpg'
          //     : _personalInfoHistoryData
          //     .result.personalInfo.personal.profilePicture
          //     .toString();
          // firstName = _personalInfoHistoryData
          //     .result.personalInfo.personal.firstName ==
          //     null
          //     ? ''
          //     : _personalInfoHistoryData.result.personalInfo.personal.firstName
          //     .toString();
          // lastName = _personalInfoHistoryData
          //     .result.personalInfo.personal.lastName ==
          //     null
          //     ? ''
          //     : _personalInfoHistoryData.result.personalInfo.personal.lastName
          //     .toString();
          // dob =
          // _personalInfoHistoryData.result.personalInfo.personal.dob == null
          //     ? ''
          //     : _personalInfoHistoryData.result.personalInfo.personal.dob
          //     .toString();
          // webSite = _personalInfoHistoryData
          //     .result.personalInfo.personal.website ==
          //     null
          //     ? ''
          //     : _personalInfoHistoryData.result.personalInfo.personal.website
          //     .toString();
          //
          // employeeName = _personalInfoHistoryData
          //     .result.personalInfo.personal.industryName ==
          //     null
          //     ? ''
          //     : _personalInfoHistoryData
          //     .result.personalInfo.personal.industryName
          //     .toString();
          //
          // employeeId = _personalInfoHistoryData
          //     .result.personalInfo.personal.industryId ==
          //     null
          //     ? ''
          //     : _personalInfoHistoryData.result.personalInfo.personal.industryId
          //     .toString();
          // gender =
          // _personalInfoHistoryData.result.personalInfo.personal.gender ==
          //     null
          //     ? ''
          //     : _personalInfoHistoryData.result.personalInfo.personal.gender
          //     .toString();
          // about =
          // _personalInfoHistoryData.result.personalInfo.personal.about ==
          //     null
          //     ? ''
          //     : _personalInfoHistoryData.result.personalInfo.personal.about
          //     .toString();
          // profile = _personalInfoHistoryData
          //     .result.personalInfo.professional.occupation ==
          //     null
          //     ? ''
          //     : _personalInfoHistoryData
          //     .result.personalInfo.professional.occupation
          //     .toString();
          // ctc = _personalInfoHistoryData
          //     .result.personalInfo.professional.ctc ==
          //     null
          //     ? ''
          //     : _personalInfoHistoryData.result.personalInfo.professional.ctc
          //     .toString();
          // facebook =
          // _personalInfoHistoryData.result.personalInfo.social.facebook ==
          //     null
          //     ? ''
          //     : _personalInfoHistoryData.result.personalInfo.social.facebook
          //     .toString();
          // twitter =
          // _personalInfoHistoryData.result.personalInfo.social.twitter ==
          //     null
          //     ? ''
          //     : _personalInfoHistoryData.result.personalInfo.social.twitter
          //     .toString();
          // linkedIn =
          // _personalInfoHistoryData.result.personalInfo.social.linkedin ==
          //     null
          //     ? ''
          //     : _personalInfoHistoryData.result.personalInfo.social.linkedin
          //     .toString();
          // instagram = _personalInfoHistoryData
          //     .result.personalInfo.social.instagram ==
          //     null
          //     ? ''
          //     : _personalInfoHistoryData.result.personalInfo.social.instagram
          //     .toString();
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

  hello() async {
    try{
      await getProfile();
      await getEtScore();
      await getHealthScore();
      await getLearningScore();
      await getSocialScore();
    }catch (err) {
      print('Caught error: $err');
    }
  }

  @override
  void initState() {
    super.initState();
    hello();
  }

  void _printScreen() {
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      final doc = pw.Document();

      final image = await WidgetWraper.fromKey(
        key: _printKey,
        pixelRatio: 5.0,
      );

      // doc.addPage(pw.Page(
      //     pageFormat: format,
      //     build: (pw.Context context) {
      //       return pw.Center(
      //         child: pw.Expanded(
      //           child: pw.Image(image),
      //         ),
      //       );
      //     }
      //     )
      // );

      doc.addPage(pw.Page(
          pageFormat: format,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Expanded(
                child: pw.Image(image),
              ),
            );
          }
      )
      );
      return doc.save();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Scaffold(
        body: RepaintBoundary(
          key: _printKey,
          child:
          // This is the widget that will be printed.
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/images/rectanglebackground.png', // and width here
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .start,
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    child: Container(
                                      height: 120,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 8,
                                        ),
                                      ),
                                      child: _personalInfoHistoryData ==
                                            null?Container(
                                        height: 120,
                                              width: 100,
                                              child: Image.asset(
                                          'assets/images/user.jpg', // and width here
                                        ),
                                            ):
                                        _personalInfoHistoryData
                                            .result
                                            .personalInfo
                                            .personal
                                            .profilePicture ==
                                            ''? Container(
                                          height: 120,
                                              width: 100,
                                              child: Image.asset(
                                          'assets/images/user.jpg', // and width here
                                        ),
                                            ) : _personalInfoHistoryData
                                            .result
                                            .personalInfo
                                            .personal
                                            .profilePicture ==
                                            null
                                            ? Container(
                                          height: 120,
                                              width: 100,
                                              child: Image.asset(
                                          'assets/images/user.jpg', // and width here
                                        ),
                                            )
                                            : Container(
                                          height: 120,
                                              width: 100,
                                              child: Image.network(
                                              _personalInfoHistoryData
                                                  .result
                                                  .personalInfo
                                                  .personal
                                                  .profilePicture),
                                            ),
                                      ),
                                    ),
                                  SizedBox(height: 20,),
                                ],
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        _personalInfoHistoryData==null?'':
                                        _personalInfoHistoryData
                                            .result
                                            .personalInfo
                                            .personal
                                            .firstName.toString(),
                                        overflow:
                                        TextOverflow
                                            .fade,
                                        maxLines: 1,
                                        softWrap:
                                        false,
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight
                                                .w900,
                                            color: Colors
                                                .black87,
                                            fontFamily:
                                            'PoppinsLight',
                                            fontSize:
                                            24),
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      SizedBox(
                                        //height: MediaQuery.of(context).size.height * 0.5,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width *
                                            .3,
                                        child: Text(
                                          _personalInfoHistoryData==null?'':
                                          _personalInfoHistoryData
                                              .result
                                              .personalInfo
                                              .personal
                                              .lastName
                                              .toString(),
                                          overflow:
                                          TextOverflow
                                              .fade,
                                          maxLines:
                                          1,
                                          softWrap:
                                          false,
                                          style: TextStyle(
                                              fontWeight: FontWeight
                                                  .w900,
                                              color: Colors
                                                  .black87,
                                              fontFamily:
                                              'PoppinsLight',
                                              fontSize:
                                              24),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    _personalInfoHistoryData==null?'':
                                    _personalInfoHistoryData
                                        .result
                                        .personalInfo
                                        .professional
                                        .occupation==""?'':
                                    _personalInfoHistoryData
                                        .result
                                        .personalInfo
                                        .professional
                                        .occupation
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors
                                            .black54,
                                        fontFamily:
                                        'PoppinsLight',
                                        fontSize:
                                        16),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    //color: Colors.amber[600],
                                    decoration: BoxDecoration(
                                        color: Color(
                                            0xffA7F3D0),
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                    // color: Colors.blue[600],
                                    alignment:
                                    Alignment
                                        .center,
                                    child:
                                    Padding(
                                      padding:
                                      const EdgeInsets.all(6.0),
                                      child:
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            size: 14,
                                            color: Colors.green,
                                          ),
                                          Text(
                                            'Verified',
                                            style: TextStyle(color: Color(0xff059669), fontWeight: FontWeight.bold, fontFamily: 'PoppinsLight', fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    'Verified: Aadhar',
                                    style: TextStyle(
                                        fontWeight:
                                        FontWeight
                                            .w500,
                                        color: Colors
                                            .black87,
                                        fontFamily:
                                        'PoppinsLight',
                                        fontSize:
                                        12,
                                  ),),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'About: ',
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight.w900,
                                    color: Colors.black87,
                                    fontFamily:
                                    'PoppinsLight',
                                    fontSize: 16),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 270,
                                    child: Text(
                                      _personalInfoHistoryData==null?'':
                                      _personalInfoHistoryData
                                          .result
                                          .personalInfo
                                          .personal
                                          .about==""?'':
                                      _personalInfoHistoryData
                                          .result
                                          .personalInfo
                                          .personal
                                          .about
                                          .toString(),
                                      maxLines: 5,
                                      overflow: TextOverflow
                                          .ellipsis,
                                      softWrap:
                                      false,
                                      style: TextStyle(
                                          color: Colors
                                              .black54,
                                          fontFamily:
                                          'PoppinsLight',
                                          fontSize:
                                          14),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _etScore==null?SizedBox():
          Padding(
            padding: const EdgeInsets.only(top:40.0,right: 10,),
            child: Align(
              alignment: Alignment.topRight,
              child: CircularPercentIndicator(
                        radius: 120.0,
                        lineWidth: 5,
                        animation: true,
                        percent: 0.001*
                            double.tryParse(
                                _etScore.etScore.toString()),
                        animationDuration: 2000,
                        arcBackgroundColor: Colors.white,
                        arcType: ArcType.HALF,
                        center: Stack(
                          children: <Widget>[
                            Center(
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "TruScore",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 12),
                                  ),
                                  Text(
                                    _etScore.etScore.toString()+ ' %',
                                    style: TextStyle(
                                        color: Color(0xffFF5C5C),
                                        fontFamily: 'PoppinsBold',
                                        fontSize: 15),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                        circularStrokeCap: CircularStrokeCap.butt,
                        backgroundColor: Colors.transparent,
                        progressColor: Color(0xffFF5C5C),
                      ),),
          ),
                  ],
                ),
                 Column(
                   crossAxisAlignment:
                   CrossAxisAlignment.start,
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left:20),
                       child: Text(
                         'Basic Skills',
                         style: TextStyle(
                             fontWeight:
                             FontWeight.w900,
                             color: Colors.black87,
                             fontFamily:
                             'PoppinsLight',
                             fontSize: 16),
                       ),
                     ),
                     SizedBox(height: 10),
                     Padding(
                       padding:
                       const EdgeInsets.only(
                           left: 20, right: 20),
                       child: Row(
                         mainAxisAlignment:
                         MainAxisAlignment.start,
                         children: [
                           CircleAvatar(
                             backgroundColor:
                             Colors.indigo,
                             radius: 25,
                             child: CircleAvatar(
                               backgroundImage:
                               AssetImage(
                                   "assets/images/computerskills.png"),
                               radius: 25,
                               backgroundColor:
                               Colors
                                   .transparent,
                             ),
                           ),
                           SizedBox(
                             width: 30,
                           ),
                           Text(
                             'Computer Skills',
                             style: TextStyle(
                                 color:
                                 Colors.black87,
                                 fontFamily:
                                 'PoppinsLight',
                                 fontSize: 16),
                           ),
                         ],
                       ),
                     ),
                     _personalInfoHistoryData==null ?SizedBox():
                     Padding(
                       padding:
                       const EdgeInsets.only(
                           left: 100,
                           right: 20,
                           bottom: 10),
                       child: ClipRRect(
                         borderRadius:
                         BorderRadius.all(
                             Radius.circular(5)),
                         child:
                         LinearProgressIndicator(
                           value: 0.1 *
                               double.tryParse(
                                   _personalInfoHistoryData
                                       .result
                                       .basicSkills
                                       .computerSkills
                                       .toString()
                               ),
                           minHeight: 6,
                           valueColor:
                           new AlwaysStoppedAnimation<
                               Color>(
                             Color(0xff3E66FB),
                           ),
                           backgroundColor:
                           Color(0xffCBD5E1),
                         ),
                       ),
                     ),
                     Padding(
                       padding:
                       const EdgeInsets.only(
                         left: 20.0,
                         right: 20,
                       ),
                       child: Row(
                         mainAxisAlignment:
                         MainAxisAlignment.start,
                         children: [
                           CircleAvatar(
                             backgroundColor:
                             Colors.indigo,
                             radius: 25,
                             child: CircleAvatar(
                               backgroundImage:
                               AssetImage(
                                   "assets/images/msoffice.png"),
                               radius: 25,
                               backgroundColor:
                               Colors
                                   .transparent,
                             ),
                           ),
                           SizedBox(
                             width: 20,
                           ),
                           Text(
                             '  Ms Office',
                             style: TextStyle(
                                 color:
                                 Colors.black87,
                                 fontFamily:
                                 'PoppinsLight',
                                 fontSize: 16),
                           ),
                         ],
                       ),
                     ),
                     _personalInfoHistoryData==null ?SizedBox():
                     Padding(
                       padding:
                       const EdgeInsets.only(
                           left: 100,
                           right: 20,
                           bottom: 10),
                       child: ClipRRect(
                         borderRadius:
                         BorderRadius.all(
                             Radius.circular(5)),
                         child:
                         LinearProgressIndicator(
                           value: 0.1 *
                               double.tryParse(
                                   _personalInfoHistoryData
                                       .result
                                       .basicSkills
                                       .msOffice.toString()),
                           minHeight: 6,
                           valueColor:
                           new AlwaysStoppedAnimation<
                               Color>(
                             Color(0xff3E66FB),
                           ),
                           backgroundColor:
                           Color(0xffCBD5E1),
                         ),
                       ),
                     ),
                     Padding(
                       padding:
                       const EdgeInsets.only(
                           left: 20, right: 20),
                       child: Row(
                         mainAxisAlignment:
                         MainAxisAlignment.start,
                         children: [
                           CircleAvatar(
                             backgroundColor:
                             Colors.indigo,
                             radius: 25,
                             child: CircleAvatar(
                               backgroundImage:
                               AssetImage(
                                   "assets/images/basicdesigning.png"),
                               radius: 25,
                               backgroundColor:
                               Colors
                                   .transparent,
                             ),
                           ),
                           SizedBox(
                             width: 20,
                           ),
                           Text(
                             '  Basic Designing',
                             style: TextStyle(
                                 color:
                                 Colors.black87,
                                 fontFamily:
                                 'PoppinsLight',
                                 fontSize: 16),
                           ),
                         ],
                       ),
                     ),
                     _personalInfoHistoryData==null ?SizedBox():
                     Padding(
                       padding:
                       const EdgeInsets.only(
                           left: 100,
                           right: 20,
                           bottom: 10),
                       child: ClipRRect(
                         borderRadius:
                         BorderRadius.all(
                             Radius.circular(5)),
                         child:
                         LinearProgressIndicator(
                           value: 0.1 *
                               double.tryParse(
                                   _personalInfoHistoryData
                                       .result
                                       .basicSkills
                                       .basicAccounting
                                       .toString()),
                           minHeight: 6,
                           valueColor:
                           new AlwaysStoppedAnimation<
                               Color>(
                             Color(0xff3E66FB),
                           ),
                           backgroundColor:
                           Color(0xffCBD5E1),
                         ),
                       ),
                     ),
                     Padding(
                       padding:
                       const EdgeInsets.only(
                           left: 20, right: 20),
                       child: Row(
                         mainAxisAlignment:
                         MainAxisAlignment.start,
                         children: [
                           CircleAvatar(
                             backgroundColor:
                             Colors.indigo,
                             radius: 25,
                             child: CircleAvatar(
                               backgroundImage:
                               AssetImage(
                                   "assets/images/basicaccounting.png"),
                               radius: 25,
                               backgroundColor:
                               Colors
                                   .transparent,
                             ),
                           ),
                           SizedBox(
                             width: 20,
                           ),
                           Text(
                             '  Basic Accounting',
                             style: TextStyle(
                                 color:
                                 Colors.black87,
                                 fontFamily:
                                 'PoppinsLight',
                                 fontSize: 16),
                           ),
                         ],
                       ),
                     ),
                     _personalInfoHistoryData==null ?SizedBox():
                     Padding(
                       padding:
                       const EdgeInsets.only(
                           left: 100,
                           right: 20,
                           bottom: 10),
                       child: ClipRRect(
                         borderRadius:
                         BorderRadius.all(
                             Radius.circular(5)),
                         child:
                         LinearProgressIndicator(
                           value: 0.1 *
                               double.tryParse(
                                   _personalInfoHistoryData
                                       .result
                                       .basicSkills
                                       .basicAccounting
                                       .toString()),
                           minHeight: 6,
                           valueColor:
                           new AlwaysStoppedAnimation<
                               Color>(
                             Color(0xff3E66FB),
                           ),
                           backgroundColor:
                           Color(0xffCBD5E1),
                         ),
                       ),
                     ),
                   ],
                 ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Soft Skills',
                        style: TextStyle(
                            fontWeight:
                            FontWeight.w900,
                            color: Colors.black87,
                            fontFamily:
                            'PoppinsLight',
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding:
                      const EdgeInsets.only(
                          left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor:
                            Colors.indigo,
                            radius: 25,
                            child: CircleAvatar(
                              backgroundImage:
                              AssetImage(
                                  "assets/images/englishcommunication.png"),
                              radius: 25,
                              backgroundColor:
                              Colors
                                  .transparent,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            '  English Communication',
                            style: TextStyle(
                                color:
                                Colors.black87,
                                fontFamily:
                                'PoppinsLight',
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    _personalInfoHistoryData==null ?SizedBox():
                    Padding(
                      padding:
                      const EdgeInsets.only(
                          left: 100,
                          right: 20,
                          bottom: 10),
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.all(
                            Radius.circular(5)),
                        child:
                        LinearProgressIndicator(
                          value: 0.1 *
                              double.tryParse(
                                  _personalInfoHistoryData
                                      .result
                                      .softSkills
                                      .englishCommunication
                                      .toString()),
                          minHeight: 6,
                          valueColor:
                          new AlwaysStoppedAnimation<
                              Color>(
                            Color(0xff3E66FB),
                          ),
                          backgroundColor:
                          Color(0xffCBD5E1),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(
                          left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor:
                            Colors.indigo,
                            radius: 25,
                            child: CircleAvatar(
                              backgroundImage:
                              AssetImage(
                                  "assets/images/hindicommunication.png"),
                              radius: 25,
                              backgroundColor:
                              Colors
                                  .transparent,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'Hindi Communication',
                            style: TextStyle(
                                color:
                                Colors.black87,
                                fontFamily:
                                'PoppinsLight',
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    _personalInfoHistoryData==null ?SizedBox():
                    Padding(
                      padding:
                      const EdgeInsets.only(
                          left: 100,
                          right: 20,
                          bottom: 10),
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.all(
                            Radius.circular(5)),
                        child:
                        LinearProgressIndicator(
                          value: 0.1 *
                              double.tryParse(
                                  _personalInfoHistoryData
                                      .result
                                      .softSkills
                                      .hindiCommunication
                                      .toString()),
                          minHeight: 6,
                          valueColor:
                          new AlwaysStoppedAnimation<
                              Color>(
                            Color(0xff3E66FB),
                          ),
                          backgroundColor:
                          Color(0xffCBD5E1),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(
                          left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor:
                            Colors.indigo,
                            radius: 25,
                            child: CircleAvatar(
                              backgroundImage:
                              AssetImage(
                                  "assets/images/writingengliash.png"),
                              radius: 25,
                              backgroundColor:
                              Colors
                                  .transparent,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            '  Writing English',
                            style: TextStyle(
                                color:
                                Colors.black87,
                                fontFamily:
                                'PoppinsLight',
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    _personalInfoHistoryData==null ?SizedBox():
                    Padding(
                      padding:
                      const EdgeInsets.only(
                          left: 100,
                          right: 20,
                          bottom: 10),
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.all(
                            Radius.circular(5)),
                        child:
                        LinearProgressIndicator(
                          value: 0.1 *
                              double.tryParse(
                                  _personalInfoHistoryData
                                      .result
                                      .softSkills
                                      .writingEnglish
                                      .toString()),
                          minHeight: 6,
                          valueColor:
                          new AlwaysStoppedAnimation<
                              Color>(
                            Color(0xff3E66FB),
                          ),
                          backgroundColor:
                          Color(0xffCBD5E1),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(
                          left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor:
                            Colors.indigo,
                            radius: 25,
                            child: CircleAvatar(
                              backgroundImage:
                              AssetImage(
                                  "assets/images/writinghindi.png"),
                              radius: 25,
                              backgroundColor:
                              Colors
                                  .transparent,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            '  Writing Hindi',
                            style: TextStyle(
                                color:
                                Colors.black87,
                                fontFamily:
                                'PoppinsLight',
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    _personalInfoHistoryData==null ?SizedBox():
                    Padding(
                      padding:
                      const EdgeInsets.only(
                          left: 100,
                          right: 20,
                          bottom: 10),
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.all(
                            Radius.circular(5)),
                        child:
                        LinearProgressIndicator(
                          value: 0.1 *
                              double.tryParse(
                                  _personalInfoHistoryData
                                      .result
                                      .softSkills
                                      .writingHindi
                                      .toString()),
                          minHeight: 6,
                          valueColor:
                          new AlwaysStoppedAnimation<
                              Color>(
                            Color(0xff3E66FB),
                          ),
                          backgroundColor:
                          Color(0xffCBD5E1),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.print),
          onPressed: _printScreen,
        ),
      ),
    );
  }
}
