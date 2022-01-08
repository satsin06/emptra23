import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/login.dart';
import 'package:flutter_emptra/models/getListModel/getEducationModel.dart';
import 'package:flutter_emptra/models/getListModel/getEmployeementModel.dart';
import 'package:flutter_emptra/models/getListModel/getIndustrySkillModel.dart';
import 'package:flutter_emptra/models/getListModel/getInterestModel.dart';
import 'package:flutter_emptra/models/getListModel/getOfficeAddress.dart';
import 'package:flutter_emptra/models/getListModel/getPermanentAddress.dart';
import 'package:flutter_emptra/models/getListModel/getPhotos.dart';
import 'package:flutter_emptra/models/getListModel/getProfileinfoModel.dart';
import 'package:flutter_emptra/models/getListModel/getTemparoryAddress.dart';
import 'package:flutter_emptra/models/getListModel/getVideoModel.dart';
import 'package:flutter_emptra/pages/individual/add/about/education_add.dart';
import 'package:flutter_emptra/pages/individual/add/about/interest_add.dart';
import 'package:flutter_emptra/pages/individual/add/about/photo_add.dart';
import 'package:flutter_emptra/pages/individual/add/about/skill_add.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/about_page/education_about.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/about_page/experience_aboutd.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/about_page/intrest_about.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/about_page/photos_about.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/about_page/skills_about.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/about_page/videos_about.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/education_card.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/experience_card.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/profile_card.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/social_card.dart';
import 'package:flutter_emptra/widgets/app_bar.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:flutter_emptra/widgets/qrCode.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../widgets/drawer.dart';
import '../../add/about/experience_add.dart';
import '../../add/about/video_add.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  bool _isLoading = false;
  GetEmployeementHistoryModel _employmentHistoryData;
  GetEducationHistoryModel _educationHistoryData;
  GetPersonalInfoHistoryModel _personalInfoHistoryData;
  GetIndustrySkillsHistoryModel _industrySkillsData;
  GetInterestHistoryModel _interestHistoryData;
  GetOfficeAddress _officeAddress;
  GetPermanentAddress _permanentAddress;
  GetTemporaryAddress _temporaryAddress;
  GetPhotos _getPhotoData;
  GetVideoModel _videoData;
  var _profilePic;

  truLink() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      var etKey = session.getString("etKey");
      var dio = Dio();
      setState(() {
        _isLoading = true;
      });
      Map data = {"userId": userId, "etKey": etKey};
      print(jsonEncode(data));
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
    } catch (e) {
      print(e);
    }
  }

  getProfile() async {
    try {
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
          String industryName = response.data['result']['personalInfo']
              ['personal']['industryName'];
          session.setString("industryName", industryName);
          int employeeId =
              response.data['result']['personalInfo']['personal']['industryId'];
          session.setInt("industryId", employeeId);
          String gender =
              response.data['result']['personalInfo']['personal']['gender'];
          session.setString("gender", gender);
          setState(() {
            _isLoading = false;
            print("!!!!!");
            _personalInfoHistoryData =
                GetPersonalInfoHistoryModel.fromJson(response.data);
            print(_personalInfoHistoryData);
            _profilePic = _personalInfoHistoryData
                            .result.personalInfo.personal.profilePicture ==
                        null ||
                    _personalInfoHistoryData
                            .result.personalInfo.personal.profilePicture ==
                        ""
                ? 'https://emptradocs.s3.ap-south-1.amazonaws.com/529893-user.jpg'
                : _personalInfoHistoryData
                    .result.personalInfo.personal.profilePicture
                    .toString();
            //   getEducationHistory();
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
          //     getEducationHistory();
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
        //   getEducationHistory();
      }
    } catch (e) {
      print(e);
    }
  }

  getPermanentAddress() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      //   print("${Api.educationHistoryList}/$userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();
      var response = await dio.get(
        "${Api.addressList}/$userId/Permanent",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
          "versionnumber": "v1"
        }),
      );
      print(response.data);
      if (response.statusCode == 200) {
        if (response.data['code'] == 100) {
          setState(() {
            _permanentAddress = GetPermanentAddress.fromJson(response.data);
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
    } catch (e) {
      print(e);
    }
  }

  getTemporaryAddress() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      //   print("${Api.educationHistoryList}/$userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();
      var response = await dio.get(
        "${Api.addressList}/$userId/Temporary",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
          "versionnumber": "v1"
        }),
      );
      print(response.data);
      if (response.statusCode == 200) {
        if (response.data['code'] == 100) {
          setState(() {
            _temporaryAddress = GetTemporaryAddress.fromJson(response.data);
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
    } catch (e) {
      print(e);
    }
  }

  getOfficeAddress() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      //   print("${Api.educationHistoryList}/$userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();
      var response = await dio.get(
        "${Api.addressList}/$userId/Office",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
          "versionnumber": "v1"
        }),
      );
      print(response.data);
      if (response.statusCode == 200) {
        if (response.data['code'] == 100) {
          setState(() {
            _officeAddress = GetOfficeAddress.fromJson(response.data);
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
    } catch (e) {
      print(e);
    }
  }

  getEmploymentHistory() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();
      var response = await dio.get(
        "${Api.employmentHistoryList}/$userId",
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
            _employmentHistoryData =
                GetEmployeementHistoryModel.fromJson(response.data);
            print(_employmentHistoryData);
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
    } catch (e) {
      print(e);
    }
  }

  getEducationHistory() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();
      var response = await dio.get(
        "${Api.educationHistoryList}/$userId",
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
            print("!!!!!");
            _educationHistoryData =
                GetEducationHistoryModel.fromJson(response.data);
            print(_educationHistoryData);
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
    } catch (e) {
      print(e);
    }
  }

  getIndustrySkills() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();
      var response = await dio.get(
        "${Api.skillsList}/$userId",
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
            _industrySkillsData =
                GetIndustrySkillsHistoryModel.fromJson(response.data);
            print(_industrySkillsData);
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

  getPhotos() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();
      var response = await dio.get(
        "${Api.photosList}/$userId",
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
            _isLoading = false;
            print(response.data['result']);
            _getPhotoData = GetPhotos.fromJson(response.data);
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
        //   getEducationHistory();
      }
    } catch (e) {
      print(e);
    }
  }

  getInterest() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();
      var response = await dio.get(
        "${Api.interestsList}/$userId",
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
            _isLoading = false;
            print(response.data['result']);
            print("!nterrrrrrrrrrrrrrrrrrrrrrrrrrrrrest!");
            _interestHistoryData =
                GetInterestHistoryModel.fromJson(response.data);
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
    } catch (e) {
      print(e);
    }
  }

  String _ytUrl1;
  String _ytUrl2;
  String _ytUrl3;
  String _ytUrl4;
  String _ytUrl5;
  String _ytUrl6;

  getVideo() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();
      var response = await dio.get(
        "${Api.videoList}/$userId",
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
            _isLoading = false;
            print(response.data['result']);
            print("!nterrrrrrrrrrrrrrrrrrrrrrrrrrrrrest!");
            _videoData = GetVideoModel.fromJson(response.data);

            _ytUrl1 = _videoData.result.videos.video1;
            _ytUrl2 = _videoData.result.videos.video2;
            _ytUrl3 = _videoData.result.videos.video3;
            _ytUrl4 = _videoData.result.videos.video4;
            _ytUrl5 = _videoData.result.videos.video5;
            _ytUrl6 = _videoData.result.videos.video6;
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
    } catch (err) {
      print('Caught error: $err');
    }
  }

  _ytController(url) {
    return YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url),
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: false,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    hello();
  }

  hello() async {
    try {
      await getProfile();
      await getEmploymentHistory();
      await getEducationHistory();
      await getIndustrySkills();
      await getInterest();
      await getPhotos();
      await getVideo();
      await getPermanentAddress();
      await getTemporaryAddress();
      await getOfficeAddress();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Color(0xffF8F7F3),
        child: _isLoading == true
            ? Center(child: CircularProgressIndicator())
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
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 65, left: 12, right: 12),
                              child: InkWell(
                                onTap: () {},
                                child: Stack(children: <Widget>[
                                  Card(
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundImage: _personalInfoHistoryData ==
                                                            null
                                                        ? AssetImage(
                                                            'assets/images/user.jpg', // and width here
                                                          )
                                                        : _personalInfoHistoryData
                                                                    .result
                                                                    .personalInfo
                                                                    .personal
                                                                    .profilePicture ==
                                                                ''
                                                            ? AssetImage(
                                                                'assets/images/user.jpg', // and width here
                                                              )
                                                            : _personalInfoHistoryData
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
                                                    backgroundColor:
                                                        Colors.transparent,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 10),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              _personalInfoHistoryData ==
                                                                      null
                                                                  ? ''
                                                                  : _personalInfoHistoryData
                                                                      .result
                                                                      .personalInfo
                                                                      .personal
                                                                      .firstName
                                                                      .toString(),
                                                              overflow:
                                                                  TextOverflow
                                                                      .fade,
                                                              maxLines: 1,
                                                              softWrap: false,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black87,
                                                                  fontFamily:
                                                                      'PoppinsLight',
                                                                  fontSize: 18),
                                                            ),
                                                            SizedBox(
                                                              width: 6,
                                                            ),
                                                            SizedBox(
                                                              //height: MediaQuery.of(context).size.height * 0.5,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .3,
                                                              child: Text(
                                                                _personalInfoHistoryData ==
                                                                        null
                                                                    ? ''
                                                                    : _personalInfoHistoryData
                                                                        .result
                                                                        .personalInfo
                                                                        .personal
                                                                        .lastName
                                                                        .toString(),
                                                                overflow:
                                                                    TextOverflow
                                                                        .fade,
                                                                maxLines: 1,
                                                                softWrap: false,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .black87,
                                                                    fontFamily:
                                                                        'PoppinsLight',
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Text(
                                                        _personalInfoHistoryData ==
                                                                null
                                                            ? ''
                                                            : _personalInfoHistoryData
                                                                        .result
                                                                        .personalInfo
                                                                        .professional
                                                                        .occupation ==
                                                                    ""
                                                                ? ''
                                                                : _personalInfoHistoryData
                                                                    .result
                                                                    .personalInfo
                                                                    .professional
                                                                    .occupation
                                                                    .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontFamily:
                                                                'PoppinsLight',
                                                            fontSize: 16),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 270,
                                                    child: Text(
                                                      _personalInfoHistoryData ==
                                                              null
                                                          ? ''
                                                          : _personalInfoHistoryData
                                                                      .result
                                                                      .personalInfo
                                                                      .personal
                                                                      .about ==
                                                                  ""
                                                              ? ''
                                                              : _personalInfoHistoryData
                                                                  .result
                                                                  .personalInfo
                                                                  .personal
                                                                  .about
                                                                  .toString(),
                                                      maxLines: 5,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: false,
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontFamily:
                                                              'PoppinsLight',
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // SizedBox(width: 20),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'TruKey',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Colors.black54,
                                                            fontFamily:
                                                                'PoppinsLight',
                                                            fontSize: 12),
                                                      ),
                                                      Container(
                                                        //color: Colors.amber[600],
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xffE8EDFB),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                        // color: Colors.blue[600],
                                                        alignment:
                                                            Alignment.center,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(14.0),
                                                          child: Text(
                                                            _personalInfoHistoryData ==
                                                                    null
                                                                ? ''
                                                                : _personalInfoHistoryData
                                                                    .result
                                                                    .etKey
                                                                    .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black87,
                                                                fontFamily:
                                                                    'PoppinsLight',
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '  TruId',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            color:
                                                                Colors.black54,
                                                            fontFamily:
                                                                'PoppinsLight',
                                                            fontSize: 12),
                                                      ),
                                                      Container(
                                                        //color: Colors.amber[600],
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xffE8EDFB),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                        // color: Colors.blue[600],
                                                        // alignment: Alignment
                                                        //     .center,
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(
                                                              _personalInfoHistoryData ==
                                                                      null
                                                                  ? ''
                                                                  : _personalInfoHistoryData
                                                                      .result
                                                                      .userId
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontFamily:
                                                                      'PoppinsLight',
                                                                  fontSize: 15),
                                                            ),
                                                            IconButton(
                                                                icon: Icon(
                                                                  Icons.share,
                                                                  size: 20,
                                                                ),
                                                                onPressed: () {
                                                                  Share.share(
                                                                    'This is my TruId ' +
                                                                        _personalInfoHistoryData
                                                                            .result
                                                                            .userId
                                                                            .toString(),
                                                                  );
                                                                }),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'TruLink',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.black54,
                                                    fontFamily: 'PoppinsLight',
                                                    fontSize: 12),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              _personalInfoHistoryData == null
                                                  ? SizedBox()
                                                  : _personalInfoHistoryData
                                                              .result.truLink !=
                                                          ""
                                                      ? Container(
                                                          width: 300,
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
                                                                  width: 250,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top: 13,
                                                                        left:
                                                                            10),
                                                                    child: Text(
                                                                      _personalInfoHistoryData
                                                                          .result
                                                                          .truLink
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
                                                                Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width:
                                                                          244,
                                                                    ),
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .share,
                                                                          size:
                                                                              20,
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Share
                                                                              .share(
                                                                            'This is My TruLink ' +
                                                                                _personalInfoHistoryData.result.truLink.toString(),
                                                                          );
                                                                        }),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
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
                                                        ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'Contact',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.black54,
                                                    fontFamily: 'PoppinsLight',
                                                    fontSize: 14),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.email,
                                                        size: 20,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                          _personalInfoHistoryData ==
                                                                  null
                                                              ? ''
                                                              : _personalInfoHistoryData
                                                                  .result
                                                                  .personalInfo
                                                                  .personal
                                                                  .email
                                                                  .toString(),
                                                          style:
                                                              k16F87Black600HT),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.phone,
                                                        size: 20,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                          _personalInfoHistoryData ==
                                                                  null
                                                              ? ''
                                                              : _personalInfoHistoryData
                                                                  .result
                                                                  .personalInfo
                                                                  .personal
                                                                  .mobileNo
                                                                  .toString(),
                                                          style:
                                                              k16F87Black600HT),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.analytics,
                                                        size: 20,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      SizedBox(
                                                        width: 290,
                                                        child: Text(
                                                          _personalInfoHistoryData ==
                                                                  null
                                                              ? ''
                                                              : _personalInfoHistoryData
                                                                  .result
                                                                  .personalInfo
                                                                  .personal
                                                                  .industryName
                                                                  .toString(),
                                                          style:
                                                              k16F87Black600HT,
                                                          overflow:
                                                              TextOverflow.fade,
                                                          maxLines: 1,
                                                          softWrap: false,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.edit_outlined,
                                        ),
                                        iconSize: 28,
                                        color: Colors.black,
                                        // splashColor: Colors.purple,
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfileEditCard(
                                                          // data: _personalInfoHistoryData,
                                                          )));
                                        },
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              myAppBar(),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
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
                                            builder: (context) => Scanner(
                                                // data: _personalInfoHistoryData,
                                                )));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: InkWell(
                          onTap: () {},
                          child: Stack(children: <Widget>[
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _permanentAddress == null
                                      ? SizedBox()
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20,
                                              top: 10,
                                              right: 10,
                                              bottom: 10),
                                          child: ListView.builder(
                                              itemCount: _permanentAddress
                                                  .result.length,
                                              scrollDirection: Axis.vertical,
                                              physics: ScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) => OfficeAdd()
                                                    //       // VehicleEditCard(
                                                    //       //     data:
                                                    //       //     _vehicleModelData,
                                                    //       //     index:
                                                    //       //     index)
                                                    //     ));
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Permanent Address',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                color: Colors
                                                                    .black54,
                                                                fontFamily:
                                                                    'PoppinsLight',
                                                                fontSize: 16),
                                                          ),
                                                          _permanentAddress
                                                                      .result[0]
                                                                      .status
                                                                      .toString() ==
                                                                  "Pending"
                                                              ? Container(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            6.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .hourglass_top_outlined,
                                                                          size:
                                                                              15,
                                                                          color:
                                                                              Color(0xffC47F00),
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
                                                              : _permanentAddress
                                                                          .result[
                                                                              0]
                                                                          .status
                                                                          .toString() ==
                                                                      "Approved"
                                                                  ? Container(
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
                                                                              'Approved',
                                                                              style: TextStyle(color: Color(0xff059669), fontWeight: FontWeight.bold, fontFamily: 'PoppinsLight', fontSize: 12),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : _permanentAddress
                                                                              .result[0]
                                                                              .status
                                                                              .toString() ==
                                                                          "Rejected"
                                                                      ? Container(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(6.0),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.cancel,
                                                                                  size: 15,
                                                                                  color: Colors.red,
                                                                                ),
                                                                                Text(
                                                                                  'Rejected',
                                                                                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontFamily: 'PoppinsLight', fontSize: 12),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : Container(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(6.0),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.hourglass_top_outlined,
                                                                                  size: 15,
                                                                                  color: Color(0xffC47F00),
                                                                                ),
                                                                                Text(
                                                                                  'PENDING',
                                                                                  style: TextStyle(color: Color(0xffC47F00), fontWeight: FontWeight.bold, fontFamily: 'PoppinsLight', fontSize: 12),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 350,
                                                        child: Text(
                                                          _permanentAddress
                                                                  .result[0]
                                                                  .house
                                                                  .toString() +
                                                              ', ' +
                                                              _permanentAddress
                                                                  .result[0]
                                                                  .area
                                                                  .toString() +
                                                              ', ' +
                                                              _permanentAddress
                                                                  .result[0]
                                                                  .landmark
                                                                  .toString() +
                                                              ', ' +
                                                              _permanentAddress
                                                                  .result[0]
                                                                  .city
                                                                  .toString() +
                                                              ', ' +
                                                              _permanentAddress
                                                                  .result[0]
                                                                  .state
                                                                  .toString() +
                                                              ', ' +
                                                              _permanentAddress
                                                                  .result[0]
                                                                  .country
                                                                  .toString() +
                                                              ', ',
                                                          maxLines: 5,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          // softWrap:
                                                          //     false,
                                                          style:
                                                              k16F87Black400HT,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                  _temporaryAddress == null
                                      ? SizedBox()
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 10, bottom: 10),
                                          child: ListView.builder(
                                              itemCount: _temporaryAddress
                                                  .result.length,
                                              scrollDirection: Axis.vertical,
                                              physics: ScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) => OfficeAdd()
                                                    //       // VehicleEditCard(
                                                    //       //     data:
                                                    //       //     _vehicleModelData,
                                                    //       //     index:
                                                    //       //     index)
                                                    //     ));
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Temparory Address',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                color: Colors
                                                                    .black54,
                                                                fontFamily:
                                                                    'PoppinsLight',
                                                                fontSize: 16),
                                                          ),
                                                          _temporaryAddress
                                                                      .result[0]
                                                                      .status
                                                                      .toString() ==
                                                                  "Pending"
                                                              ? Container(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            6.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .hourglass_top_outlined,
                                                                          size:
                                                                              15,
                                                                          color:
                                                                              Color(0xffC47F00),
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
                                                              : _temporaryAddress
                                                                          .result[
                                                                              0]
                                                                          .status
                                                                          .toString() ==
                                                                      "Approved"
                                                                  ? Container(
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
                                                                              'Approved',
                                                                              style: TextStyle(color: Color(0xff059669), fontWeight: FontWeight.bold, fontFamily: 'PoppinsLight', fontSize: 12),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : _temporaryAddress
                                                                              .result[0]
                                                                              .status
                                                                              .toString() ==
                                                                          "Rejected"
                                                                      ? Container(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(6.0),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.cancel,
                                                                                  size: 15,
                                                                                  color: Colors.red,
                                                                                ),
                                                                                Text(
                                                                                  'Rejected',
                                                                                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontFamily: 'PoppinsLight', fontSize: 12),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : Container(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(6.0),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.hourglass_top_outlined,
                                                                                  size: 15,
                                                                                  color: Color(0xffC47F00),
                                                                                ),
                                                                                Text(
                                                                                  'PENDING',
                                                                                  style: TextStyle(color: Color(0xffC47F00), fontWeight: FontWeight.bold, fontFamily: 'PoppinsLight', fontSize: 12),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 350,
                                                        child: Text(
                                                          _temporaryAddress
                                                                  .result[0]
                                                                  .house
                                                                  .toString() +
                                                              ', ' +
                                                              _temporaryAddress
                                                                  .result[0]
                                                                  .area
                                                                  .toString() +
                                                              ', ' +
                                                              _temporaryAddress
                                                                  .result[0]
                                                                  .landmark
                                                                  .toString() +
                                                              ', ' +
                                                              _temporaryAddress
                                                                  .result[0]
                                                                  .city
                                                                  .toString() +
                                                              ', ' +
                                                              _temporaryAddress
                                                                  .result[0]
                                                                  .state
                                                                  .toString() +
                                                              ', ' +
                                                              _temporaryAddress
                                                                  .result[0]
                                                                  .country
                                                                  .toString() +
                                                              ', ',
                                                          maxLines: 5,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          // softWrap:
                                                          //     false,
                                                          style:
                                                              k16F87Black400HT,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                  _officeAddress == null
                                      ? SizedBox()
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 10, bottom: 10),
                                          child: ListView.builder(
                                              itemCount:
                                                  _officeAddress.result.length,
                                              scrollDirection: Axis.vertical,
                                              physics: ScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) => OfficeAdd()
                                                    //       // VehicleEditCard(
                                                    //       //     data:
                                                    //       //     _vehicleModelData,
                                                    //       //     index:
                                                    //       //     index)
                                                    //     ));
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Office Address',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                color: Colors
                                                                    .black54,
                                                                fontFamily:
                                                                    'PoppinsLight',
                                                                fontSize: 16),
                                                          ),
                                                          _officeAddress
                                                                      .result[0]
                                                                      .status
                                                                      .toString() ==
                                                                  "Pending"
                                                              ? Container(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            6.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .hourglass_top_outlined,
                                                                          size:
                                                                              15,
                                                                          color:
                                                                              Color(0xffC47F00),
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
                                                              : _officeAddress
                                                                          .result[
                                                                              0]
                                                                          .status
                                                                          .toString() ==
                                                                      "Approved"
                                                                  ? Container(
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
                                                                              'Approved',
                                                                              style: TextStyle(color: Color(0xff059669), fontWeight: FontWeight.bold, fontFamily: 'PoppinsLight', fontSize: 12),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : _officeAddress
                                                                              .result[0]
                                                                              .status
                                                                              .toString() ==
                                                                          "Rejected"
                                                                      ? Container(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(6.0),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.cancel,
                                                                                  size: 15,
                                                                                  color: Colors.red,
                                                                                ),
                                                                                Text(
                                                                                  'Rejected',
                                                                                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontFamily: 'PoppinsLight', fontSize: 12),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : Container(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(6.0),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.hourglass_top_outlined,
                                                                                  size: 15,
                                                                                  color: Color(0xffC47F00),
                                                                                ),
                                                                                Text(
                                                                                  'PENDING',
                                                                                  style: TextStyle(color: Color(0xffC47F00), fontWeight: FontWeight.bold, fontFamily: 'PoppinsLight', fontSize: 12),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 350,
                                                        child: Text(
                                                          _officeAddress
                                                                  .result[0]
                                                                  .house
                                                                  .toString() +
                                                              ', ' +
                                                              _officeAddress
                                                                  .result[0]
                                                                  .area
                                                                  .toString() +
                                                              ', ' +
                                                              _officeAddress
                                                                  .result[0]
                                                                  .landmark
                                                                  .toString() +
                                                              ', ' +
                                                              _officeAddress
                                                                  .result[0]
                                                                  .city
                                                                  .toString() +
                                                              ', ' +
                                                              _officeAddress
                                                                  .result[0]
                                                                  .state
                                                                  .toString() +
                                                              ', ' +
                                                              _officeAddress
                                                                  .result[0]
                                                                  .country
                                                                  .toString() +
                                                              ', ',
                                                          maxLines: 5,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          // softWrap:
                                                          //     false,
                                                          style:
                                                              k16F87Black400HT,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ),

                      ///Experience About
                      ExperienceAbout(),
                      SizedBox(height: 30),

                      /// EducationAbout
                      EducationAbout(),
                      SizedBox(
                        height: 30,
                      ),

                      /// Skills About
                      SkillsAbout(),
                      SizedBox(
                        height: 30,
                      ),

                      /// Intrests About
                      IntrestAbout(),
                      SizedBox(
                        height: 30,
                      ),

                      /// Photos About
                      PhotosAbout(),
                      SizedBox(
                        height: 20,
                      ),

                      /// Videos About
                      VideosAbout()
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class YtCardWidget extends StatelessWidget {
  final YoutubePlayerController controller;

  const YtCardWidget({
    Key key,
    this.controller,
  }) : super(key: key);

  @override
  void dispose() {
    controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      height: 400,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 5,
            ),
            child: Text("",
                style: GoogleFonts.quicksand(fontStyle: FontStyle.normal)),
          ),
          YoutubePlayer(
            controller: controller,
            liveUIColor: Colors.amber,
          ),
        ],
      ),
    );
  }
}
