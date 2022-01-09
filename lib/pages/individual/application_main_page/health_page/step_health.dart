import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/login.dart';
import 'package:flutter_emptra/models/getListModel/getBmiModel.dart';
import 'package:flutter_emptra/models/getListModel/getCovideVaccineModel.dart';
import 'package:flutter_emptra/models/getListModel/getHealthScore.dart';
import 'package:flutter_emptra/models/getListModel/getPhysicalBody.dart';
import 'package:flutter_emptra/models/getListModel/getProfileinfoModel.dart';
import 'package:flutter_emptra/models/getListModel/getRtpcrModel.dart';
import 'package:flutter_emptra/models/getListModel/getVaccineModel.dart';
import 'package:flutter_emptra/pages/individual/add/health/physicalBody.dart';
import 'package:flutter_emptra/pages/individual/add/health/rtpcr.dart';
import 'package:flutter_emptra/pages/individual/add/health/vaccine1add.dart';
import 'package:flutter_emptra/pages/individual/add/health/vaccine2add.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/about_page/shimmer_about.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/health_page/bmi_health.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/health_page/covid_vaccination_health.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/health_page/physical_details_health.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/health_page/rtpcr_health.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/health_page/step_health.dart';
import 'package:flutter_emptra/pages/individual/application_main_page/health_page/vaccination_health.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/bmi_calculator_card.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/covidVaccine.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/health_card.dart';
import 'package:flutter_emptra/widgets/app_bar.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:flutter_emptra/widgets/qrCode.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../widgets/drawer.dart';
import '../../add/health/health_add.dart';

class StepCounterHealth extends StatefulWidget {
  const StepCounterHealth({Key key}) : super(key: key);

  @override
  _StepCounterHealthState createState() => _StepCounterHealthState();
}

class _StepCounterHealthState extends State<StepCounterHealth> {
  String name = "";
  TextEditingController _height = TextEditingController();
  TextEditingController _weight = TextEditingController();
  List<bool> isSelected;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String employementStatus;
  bool _isLoading = false;
  GetHealthScore _healthScore;
  GetOtherVaccineModel _vaccineData;
  GetCovidVaccineModel _covidData;
  GetBmiModel _bmiData;
  GetPersonalInfoHistoryModel _personalInfoHistoryData;
  GetPhysicalBodyModel _physicalBodyData;
  GetRtpcrModel _rtpcrData;

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
    } catch (e) {
      print(e);
    }
  }

  getPhysicalBody() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();
      var response = await dio.get(
        "${Api.physicalBody}/$userId",
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
            // print(response.data['result']);
            // print("!nterrrrrrrrrrrrrrrrrrrrrrrrrrrrrest!");
            _physicalBodyData = GetPhysicalBodyModel.fromJson(response.data);
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

  addBmi() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      setState(() {
        _isLoading = true;
      });

      var dio = Dio();
      Map data = {
        "userId": userId,
        "weight": _weight.text,
        "height": int.parse(_height.text) / 100,
      };
      print(data);

      print("${Api.addBmi}");
      print(jsonEncode(data));
      var response = await dio.post("${Api.addBmi}",
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
            "versionnumber": "v1"
          }),
          data: data);
      print(response.data);
      if (response.statusCode == 200) {
        if (response.data['code'] == 100) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomBarIndivitual(
                        index: 3,
                      )));
          setState(() {
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
          success(response.data['message']);
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

  getHealthScore() async {
    try {
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
    } catch (e) {
      print(e);
    }
  }

  getRtpcr() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();
      var response = await dio.get(
        "${Api.getRtpcr}/$userId",
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
            _rtpcrData = GetRtpcrModel.fromJson(response.data);
            print(_rtpcrData);
            _isLoading = false;
          });
          print(response.data);
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

  getOtherVaccine() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();
      var response = await dio.get(
        "${Api.vaccineHistoryList}/$userId/Others",
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
            _vaccineData = GetOtherVaccineModel.fromJson(response.data);
            print(_vaccineData);
            _isLoading = false;
          });
          print(response.data);
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

  getCovidVaccine() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();
      var response = await dio.get(
        "${Api.vaccineHistoryList}/$userId/Covid",
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
            _covidData = GetCovidVaccineModel.fromJson(response.data);
            print(_covidData);
            _isLoading = false;
          });
          print(response.data);
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

  getBmiHistory() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();
      var response = await dio.get(
        "${Api.bmi}/$userId",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
          "versionnumber": "v1"
        }),
      );
      if (response.statusCode == 200) {
        if (response.data['code'] == 100) {
          setState(() {
            _bmiData = GetBmiModel.fromJson(response.data);
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

  @override
  void initState() {
    super.initState();
    isSelected = [true, false];
    hello();
  }

  hello() async {
    try {
      await getProfile();
      await getBmiHistory();
      await getHealthScore();
      await getOtherVaccine();
      await getCovidVaccine();
      await getPhysicalBody();
      await getRtpcr();
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 15),
          child: Text(
            'Step Counter',
            style: TextStyle(
                color: Colors.black87, fontFamily: 'PoppinsBold', fontSize: 24),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {},
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 20, bottom: 20),
                        child: Center(
                          child: CircularPercentIndicator(
                            radius: 200.0,
                            lineWidth: 13.0,
                            animation: true,
                            percent: 0.7,
                            center: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Total Steps",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 14),
                                  ),
                                  Text(
                                    "6000",
                                    style: TextStyle(
                                        color: Color(0xff3E66FB),
                                        fontFamily: 'PoppinsBold',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 34),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "/9000",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Color(0xff0FE8ED),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  'assets/images/step1.png', // and width here
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    '16 min',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsBold',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    'walking',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'PoppinsBold',
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  'assets/images/burn.png', // and width here
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    '6700 cal',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsBold',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    'Burned',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'PoppinsBold',
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  'assets/images/step2.png', // and width here
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    '24 min',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsBold',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    'Running',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'PoppinsBold',
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  'assets/images/path.png', // and width here
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    '2.4 km',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsBold',
                                        fontSize: 16),
                                  ),
                                  Text(
                                    'Distance',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'PoppinsBold',
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
