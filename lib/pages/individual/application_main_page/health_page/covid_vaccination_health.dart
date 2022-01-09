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

class CovidVaccinationHealth extends StatefulWidget {
  const CovidVaccinationHealth({Key key}) : super(key: key);

  @override
  _CovidVaccinationHealthState createState() => _CovidVaccinationHealthState();
}

class _CovidVaccinationHealthState extends State<CovidVaccinationHealth> {
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
          padding: const EdgeInsets.only(
            left: 20, right: 15,
            //    top: 430
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Covid Vaccination',
                style: TextStyle(
                    color: Colors.black87,
                    fontFamily: 'PoppinsBold',
                    fontSize: 24),
              ),
            ],
          ),
        ),
        _covidData == null
            ? SizedBox()
            : _covidData.result.length == 2
                ? SizedBox()
                : _covidData.result.length == 1
                    ? _covidData.result[0].vaccineDose == 1
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(
                              left: 15, right: 15,
                              //    top: 350
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Vaccine2Add()));
                              },
                              child: Card(
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.indigo,
                                        radius: 20,
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/dose1.png"),
                                          radius: 22,
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Vaccine name 1",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black87,
                                                fontFamily: 'PoppinsLight',
                                                fontSize: 16),
                                          ),
                                          Text(
                                            "Dose: 1",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                                fontFamily: 'PoppinsLight',
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                    : SizedBox(),
        _covidData == null
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15, right: 15,
                      //    top: 350
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Vaccine1Add()));
                      },
                      child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.indigo,
                                radius: 20,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/images/dose1.png"),
                                  radius: 22,
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Vaccine name 1",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "Dose: 1",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15, right: 15,
                      //    top: 350
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Vaccine2Add()));
                      },
                      child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.indigo,
                                radius: 20,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/images/dose2.png"),
                                  radius: 22,
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Vaccine name 2",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "Dose: 2",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: ListView.builder(
                          itemCount: _covidData.result.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CovidVacinCard(
                                            data: _covidData, index: index)));
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
                                        radius: 20,
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(_covidData
                                                      .result[index]
                                                      .vaccineDose ==
                                                  1
                                              ? "assets/images/dose1.png"
                                              : "assets/images/dose2.png"),
                                          radius: 22,
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _covidData.result[index].vaccineName
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
                                              _covidData
                                                  .result[index].vaccineDose
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontFamily: 'PoppinsLight',
                                                  fontSize: 14),
                                            ),
                                          ),
                                          Text(
                                            '${_covidData.result[index].vaccineDate.toString()} ',
                                            style: kForteenText,
                                          ),
                                        ],
                                      ),
                                      _covidData.result[index].status ==
                                              "Pending"
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xffFBE4BB),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8))),
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
                                          : _covidData.result[index].status ==
                                                  "Approved"
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xffA7F3D0),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8))),
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
                                              : _covidData.result[index]
                                                          .status ==
                                                      "Rejected"
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xffFECACA),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          8))),
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
                                                  : SizedBox(),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
        // ignore: unrelated_type_equality_checks
        _covidData == null
            ? SizedBox()
            : _covidData.result.length == 2
                ? SizedBox()
                : _covidData.result.length == 1
                    ? _covidData.result[0].vaccineDose == 2
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(
                              left: 15, right: 15,
                              //    top: 350
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Vaccine2Add()));
                              },
                              child: Card(
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.indigo,
                                        radius: 20,
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/dose2.png"),
                                          radius: 22,
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Vaccine name 2",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black87,
                                                fontFamily: 'PoppinsLight',
                                                fontSize: 16),
                                          ),
                                          Text(
                                            "Dose: 2",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                                fontFamily: 'PoppinsLight',
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                    : SizedBox(),
        SizedBox(height: 20),
      ],
    );
  }
}
