import 'package:flutter/material.dart';
import 'package:flutter_emptra/login.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/models/getListModel/getAmountModel.dart';
import 'package:flutter_emptra/models/getListModel/getEtScore.dart';
import 'package:flutter_emptra/models/getListModel/getHealthScore.dart';
import 'package:flutter_emptra/models/getListModel/getLearningScore.dart';
import 'package:flutter_emptra/models/getListModel/getProfileinfoModel.dart';
import 'package:flutter_emptra/models/getListModel/getSocialScore.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/add_amount.dart';
import 'choose_plan.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'demopdf.dart';
import 'settings.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  bool _isLoading = false;
  GetPersonalInfoHistoryModel _personalInfoHistoryData;
  GetEtScore _etScore;
  GetHealthScore _healthScore;
  GetLearningScore _learningScore;
  GetSocialScore _socialSco;
  GetCredit _getAmount;
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
    } catch(e){
      print(e);
    }
  }

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
            _getAmount = GetCredit.fromJson(response.data);
            print(_getAmount);
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

  hello() async {
    try{
    await getProfile();
    await getEtScore();
    await getHealthScore();
    await getLearningScore();
    await getSocialScore();
    await getCredit();
  }catch (err) {
  print('Caught error: $err');
  }
}
  @override
  void initState() {
    super.initState();
    hello();
  }


  Future logOut(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => Login()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/rectangle.png"))),
              child: Stack(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                  _personalInfoHistoryData ==
                    null?AssetImage(
                    'assets/images/user.jpg', // and width here
                  ):
                            _personalInfoHistoryData
                                .result
                                .personalInfo
                                .personal
                                .profilePicture ==
                                ''? AssetImage(
                              'assets/images/user.jpg', // and width here
                            ) : _personalInfoHistoryData
                                .result
                                .personalInfo
                                .personal
                                .profilePicture ==
                                null
                                ? AssetImage(
                              'assets/images/user.jpg', // and width here
                            )
                                : NetworkImage(
                                _personalInfoHistoryData
                                    .result
                                    .personalInfo
                                    .personal
                                    .profilePicture),
                            radius: 45,
                            backgroundColor: Colors.transparent,
                          ),
                          // CircleAvatar(
                          //   backgroundImage:
                          //   _personalInfoHistoryData
                          //       .result
                          //       .personalInfo
                          //       .personal
                          //       .profilePicture ==
                          //       "" ||_personalInfoHistoryData
                          //       .result
                          //       .personalInfo
                          //       .personal
                          //       .profilePicture ==
                          //       null
                          //       ? AssetImage(
                          //     'assets/images/user.jpg', // and width here
                          //   )
                          //       : NetworkImage(
                          //       _personalInfoHistoryData
                          //           .result
                          //           .personalInfo
                          //           .personal
                          //           .profilePicture),
                          //   radius: 45,
                          //   backgroundColor: Colors.transparent,
                          // ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _personalInfoHistoryData == null
                                  ? Text(
                                'name',
                                style: TextStyle(fontSize: 2),
                              )
                                  : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      _personalInfoHistoryData
                                          .result.personalInfo.personal.firstName
                                          .toString() ,
                                      overflow:
                                      TextOverflow
                                          .fade,
                                      maxLines:
                                      1,
                                      softWrap:
                                      false,
                                      style: k16F87Black600HT
                                  ),
                                  SizedBox(width: 4,),
                                  SizedBox(
                                    //height: MediaQuery.of(context).size.height * 0.5,
                                    width: MediaQuery.of(context).size.width * .2,
                                    child: Text(
                                        _personalInfoHistoryData
                                            .result.personalInfo.personal.lastName
                                            .toString() ,
                                        overflow:
                                        TextOverflow
                                            .fade,
                                        maxLines:
                                        1,
                                        softWrap:
                                        false,
                                        style: k16F87Black600HT
                                    ),),
                                ],
                              ),
                              Row(
                                children: [
                                  _personalInfoHistoryData
                                      ==null? Text(
                                      '',): Text(
                                      _personalInfoHistoryData
                                          .result.userId
                                          .toString(),
                                      style: k18F87Black400HT),
                                ],
                              ),
                           SizedBox(height: 10,),
                              Row(
                                children: [
                                  Text(
                                    'Credits: ',
                                    style:   k16F87Black600HT,
                                  ),
                                  Text(
                                    _getAmount==null?'':
                                    _getAmount
                                          .result.creditPoints
                                          .toString(),
                                      style: k18F87Black400HT,
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                  ),
                                ],
                              ),
                            ],
                          ),

                        ],
                      ),

                    ],
                  ),
                ),
              ])),
          Container(
            height: 40,
            child: InkWell(
                onTap: () {
          Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddAmount()));
          },
              child: ListTile(
                leading: Text(
                  " ₹",
                  style: k16F87Black600HT,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Buy Credits",
                      style: k16F87Black600HT,
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      textColor: Colors.white,
                      color: Color(0xff3E66FB),
                      child: Text(
                        // ignore: unrelated_type_equality_checks
                        '+Buy',
                        style: k13Fwhite400BT,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddAmount()));
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 40,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyAppp()));
              },
              //onTap: () {_createPDF();},
              child: ListTile(
                leading: Icon(
                  Icons.file_download,
                  color: Colors.black,
                  size: 20,
                ),
                title: Text(
                  "Download Profile",
                  style: k16F87Black600HT,
                ),
              ),
            ),
          ),

          Container(
            height: 40,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ChoosePlan()));
              },
              child: ListTile(
                leading: Icon(
                  Icons.analytics_outlined,
                  color: Colors.black,
                  size: 20,
                ),
                title: Text(
                  "Choose Plan",
                  style:  k16F87Black600HT,
                ),
              ),
            ),
          ),
          Container(
            height: 40,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SettingPage()));
              },
              child: ListTile(
                leading: Icon(
                  Icons.settings,
                  size: 20,
                  color: Colors.black,
                ),
                title: Text(
                  "Setting",
                  style: k16F87Black600HT,
                ),
              ),
            ),
          ),
          Container(
            height: 40,
            child: InkWell(
              onTap: () {
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (context) => SettingPage()));
              },
              child: ListTile(
                leading: Icon(
                  Icons.info_outline,
                  size: 20,
                  color: Colors.black,
                ),
                title: Text(
                  "About",
                  style: k16F87Black600HT,
                ),
              ),
            ),
          ),
          Container(
            height: 40,
            child: InkWell(
              onTap: () => logOut(context),
              // DocumentInformationPage
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  size: 20,
                  color: Colors.red,
                ),
                title: Text(
                  "LogOut",
                  style: k16F87Black600HT,
                ),
              ),
            ),
          ),

          _etScore == null
                  ? Column(
                    children: [
                      SizedBox(height: 30,),
                      Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Stack(children: <Widget>[
                            Center(
                              child: SizedBox(
                                height: 150,
                                width: 200,
                              ),
                            ),
                            Center(
                              child: CircularPercentIndicator(
                                radius: 140.0,
                                lineWidth: 7,
                                animation: true,
                                percent: 0.0,
                              animationDuration: 1000,
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
                                            height: 40,
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
                                                fontSize: 28),
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
                          ])),
                    ],
                  )
                  : Padding(
                      padding: const EdgeInsets.only(left: 12,top: 30),
                      child: Stack(children: <Widget>[
                        Center(
                          child: CircularPercentIndicator(
                            radius: 140.0,
                            lineWidth: 7.0,
                            animation: true,
                            percent: 0.001 *
                                double.tryParse(_etScore.etScore.toString()),
                            animationDuration: 1000,
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
                                        height: 30,
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
                                            fontSize: 28),
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
                        Padding(
                          padding: const EdgeInsets.only(top:110),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _learningScore == null
                                  ? Column(
                                children: [
                                  CircularPercentIndicator(
                                    radius: 60.0,
                                    lineWidth: 6.0,
                                    animation: true,
                                    percent: 0.0,
                                    center: Stack(
                                      children: <Widget>[
                                        Center(
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xff10B981)),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            "0",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'PoppinsBold',
                                                fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: Color(0xff10B981),
                                  ),
                                  Text(
                                    "Learning",
                                    style: k16F87Black600HT,
                                  ),
                                ],
                              )
                                  : Column(
                                children: [
                                  CircularPercentIndicator(
                                    radius: 60.0,
                                    lineWidth: 5.0,
                                    animation: true,
                                    percent: 0.01 *
                                        double.tryParse(
                                            _learningScore.learningScore.toString()),
                                    center: Stack(
                                      children: <Widget>[
                                        Center(
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xff10B981)),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            _learningScore.learningScore.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'PoppinsBold',
                                                fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: Color(0xff10B981),
                                  ),
                                  Text(
                                    "Learning",
                                    style: k16F87Black600HT,
                                  ),
                                ],
                              ),
                              SizedBox(width: 15,),
                              _healthScore == null
                                  ? Column(
                                children: [
                                  CircularPercentIndicator(
                                    radius: 60.0,
                                    lineWidth: 5.0,
                                    animation: true,
                                    percent: 0.0,
                                    // percent: double.tryParse(_healthScore
                                    //     .healthScore
                                    //     .toString()) / 100,
                                    // 0.01*double.tryParse(_healthScore
                                    //     .healthScore
                                    //     .toString()),
                                    center: Stack(
                                      children: <Widget>[
                                        Center(
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xff3E66FB)),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            "0",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'PoppinsBold',
                                                fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: Color(0xff3E66FB),
                                  ),
                                  Text(
                                    "Health",
                                    style: k16F87Black600HT,
                                  ),
                                ],
                              )
                                  : _healthScore.healthScore == null
                                  ? Column(
                                children: [
                                  CircularPercentIndicator(
                                    radius: 60.0,
                                    lineWidth: 5.0,
                                    animation: true,
                                    percent: 0.0,
                                    // percent: double.tryParse(_healthScore
                                    //     .healthScore
                                    //     .toString()) / 100,
                                    // 0.01*double.tryParse(_healthScore
                                    //     .healthScore
                                    //     .toString()),
                                    center: Stack(
                                      children: <Widget>[
                                        Center(
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xff3E66FB)),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            "0",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'PoppinsBold',
                                                fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: Color(0xff3E66FB),
                                  ),
                                  Text(
                                    "Health",
                                    style: k16F87Black600HT,
                                  ),
                                ],
                              )
                                  : Column(
                                children: [
                                  CircularPercentIndicator(
                                    radius: 60.0,
                                    lineWidth: 5.0,
                                    animation: true,
                                    percent: 0.01 *
                                        double.tryParse(
                                            _healthScore.healthScore.toString()),
                                    // percent: double.tryParse(_healthScore
                                    //     .healthScore
                                    //     .toString()) / 100,
                                    // 0.01*double.tryParse(_healthScore
                                    //     .healthScore
                                    //     .toString()),
                                    center: Stack(
                                      children: <Widget>[
                                        Center(
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xff3E66FB)),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            _healthScore.healthScore.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'PoppinsBold',
                                                fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: Color(0xff3E66FB),
                                  ),
                                  Text(
                                    "Health",
                                    style: k16F87Black600HT,
                                  ),
                                ],
                              ),
                              SizedBox(width: 15,),
                              _socialSco == null
                                  ? Column(
                                children: [
                                  CircularPercentIndicator(
                                    radius: 60.0,
                                    lineWidth: 5.0,
                                    animation: true,
                                    percent: 0.0,
                                    center: Stack(
                                      children: <Widget>[
                                        Center(
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xff10B981)),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            "0",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'PoppinsBold',
                                                fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: Color(0xffF59E0B),
                                  ),
                                  Text("Social", style: k16F87Black600HT),
                                ],
                              )
                                  : Column(
                                children: [
                                  CircularPercentIndicator(
                                    radius: 60.0,
                                    lineWidth: 5.0,
                                    animation: true,
                                    percent: 0.01 *
                                        double.tryParse(
                                            _socialSco.socialScore.toString()),
                                    center: Stack(
                                      children: <Widget>[
                                        Center(
                                          child: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xffF59E0B)),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            _socialSco.socialScore.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'PoppinsBold',
                                                fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: Color(0xffF59E0B),
                                  ),
                                  Text("Social", style: k16F87Black600HT),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ])),
        ],
      ),
    );
  }
  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();
    //final vpage = document.pages.add();
    page.graphics.drawImage(
        PdfBitmap(await _readImageData('logofin.png')),
        Rect.fromLTWH(0, 100, 300, 250));

    page.graphics.drawString('First Name '+_personalInfoHistoryData
        .result.personalInfo.personal.firstName
        .toString()+
        '\n''TrueID '+_personalInfoHistoryData
        .result.userId
        .toString()+
    '\n''TrueKey '+_personalInfoHistoryData
        .result.etKey
        .toString(),
        PdfStandardFont(PdfFontFamily.helvetica, 30),);
    //
    // vpage.graphics.drawString('Welcome to Truegy!',
    //     PdfStandardFont(PdfFontFamily.helvetica, 30));


    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 30),
        cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

    grid.columns.add(count: 3);
    grid.headers.add(1);

    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Learning Score';
    header.cells[1].value = 'Social Score';
    header.cells[2].value = 'Health Score';

    PdfGridRow row = grid.rows.add();
    row.cells[0].value = _learningScore.learningScore.toString();
    row.cells[1].value = _socialSco.socialScore.toString();
    row.cells[2].value = '0';
        //_healthScore.healthScore.toString();

    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));


    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, _personalInfoHistoryData
        .result.personalInfo.personal.firstName
        .toString()+'.truegy'+'.pdf');
  }
}
Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final path = (await getExternalStorageDirectory()).path;
  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open('$path/$fileName');
}
Future<Uint8List> _readImageData(String name) async {
  final data = await rootBundle.load('assets/images/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}


