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
import 'package:flutter_emptra/pages/individual/application_main_page/about_page/about_page.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/about_page/education_about.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/about_page/experience_aboutd.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/about_page/intrest_about.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/about_page/photos_about.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/about_page/shimmer_about.dart';
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

class ExperienceAbout extends StatefulWidget {
  const ExperienceAbout({Key key}) : super(key: key);

  @override
  _ExperienceAboutState createState() => _ExperienceAboutState();
}

class _ExperienceAboutState extends State<ExperienceAbout> {
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Experience',
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
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ExperienceAdd()),
                        (Route<dynamic> route) => route is AboutPage);
                    //  (Route<dynamic> route) => false);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             ExperienceAdd()));
                  },
                ),
              ),
            ],
          ),
        ),
        _employmentHistoryData == null
            ? Container(
                height: 300,
                width: 300,
                child: Image.asset(
                  'assets/images/experience.png', // and width here
                ),
              )
            : _employmentHistoryData.result == null
                ? Container(
                    height: 300,
                    width: 300,
                    child: Image.asset(
                      'assets/images/experience.png', // and width here
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Container(
                      height: 210.0,
                      child: ListView.builder(
                          itemCount: _employmentHistoryData.result.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ExperienceEditCard(
                                                data: _employmentHistoryData,
                                                index: index)));
                              },
                              child: Container(
                                width: 250,
                                child: Card(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(17.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: _employmentHistoryData
                                                          .result[index].website
                                                          .toString() ==
                                                      ""
                                                  ? AssetImage(
                                                      "assets/images/experience.png")
                                                  : NetworkImage(
                                                      'https://logo.clearbit.com/' +
                                                          _employmentHistoryData
                                                              .result[index]
                                                              .website
                                                              .toString()),
                                              radius: 25,
                                              backgroundColor:
                                                  Colors.transparent,
                                            ),
                                            //  SizedBox(width: 60),
                                            _employmentHistoryData
                                                        .result[index].status
                                                        .toString() ==
                                                    "Pending"
                                                ? Container(
                                                    //color: Colors.amber[600],
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffFBE4BB),
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
                                                  )
                                                : _employmentHistoryData
                                                            .result[index]
                                                            .status
                                                            .toString() ==
                                                        "Approved"
                                                    ? Container(
                                                        //color: Colors.amber[600],
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xffA7F3D0),
                                                            borderRadius:
                                                                BorderRadius
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
                                                                    .check_circle,
                                                                size: 14,
                                                                color: Colors
                                                                    .green,
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
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : _employmentHistoryData
                                                                .result[index]
                                                                .status ==
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
                                                            alignment: Alignment
                                                                .center,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(6.0),
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .cancel,
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
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _employmentHistoryData
                                                  .result[index].designation,
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              softWrap: false,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.black87,
                                                  fontFamily: 'PoppinsLight',
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              _employmentHistoryData
                                                  .result[index].employerName
                                                  .toString(),
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              softWrap: false,
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontFamily: 'PoppinsLight',
                                                  fontSize: 16),
                                            ),
                                            Text(
                                              // '${(Moment.parse(_employmentHistoryData.result[index].from.toString()).format('MMM y'))} - ${(Moment.parse(_employmentHistoryData.result[index].to.toString()).format('MMM y'))} ',
                                              '${_employmentHistoryData.result[index].from.toString()} - ${_employmentHistoryData.result[index].to.toString()}',
                                              style: kForteenText,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            _employmentHistoryData
                                                        .result[index].status ==
                                                    "Pending"
                                                ? Text(
                                                    'PENDING',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xffC47F00),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            'PoppinsLight',
                                                        fontSize: 12),
                                                  )
                                                : _employmentHistoryData
                                                            .result[index]
                                                            .status ==
                                                        "Approved"
                                                    ? Text(
                                                        'Approved',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff059669),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'PoppinsLight',
                                                            fontSize: 12),
                                                      )
                                                    : _employmentHistoryData
                                                                .result[index]
                                                                .status ==
                                                            "Rejected"
                                                        ? Text(
                                                            'Rejected',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'PoppinsLight',
                                                                fontSize: 12),
                                                          )
                                                        : SizedBox(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
      ],
    );
  }
}
