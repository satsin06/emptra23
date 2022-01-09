import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
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
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewAccount extends StatefulWidget {
  const ReviewAccount({Key key}) : super(key: key);

  @override
  _ReviewAccountState createState() => _ReviewAccountState();
}

class _ReviewAccountState extends State<ReviewAccount> {
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Review',
              style: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'PoppinsBold',
                  fontSize: 24),
            ),
          ],
        ),
        SizedBox(height: 10),
        _getAllHrDetails == null
            ? GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             CountryAdd()));
                },
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, bottom: 10, top: 20),
                        child: Text(
                          'Please fill your hr details',
                          style: kForteenText,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             ReviewSkillEdit()));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: ListView.builder(
                          itemCount: _getAllHrDetails.result.length,
                          shrinkWrap: true,
                          // scrollDirection: Axis.horizontal,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _getAllHrDetails
                                          .result[index].organizationName
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 16),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Hr Name: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 14),
                                        ),
                                        Text(
                                          _getAllHrDetails.result[index].hrName
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Review: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 14),
                                        ),
                                        Text(
                                          _getAllHrDetails.result[index].review
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Dedication and Hardwork',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 16),
                                        ),
                                        Text(
                                          _getAllHrDetails
                                              .result[index].dedicationHandwork
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      child: LinearProgressIndicator(
                                        value: 0.1 *
                                            double.tryParse(_getAllHrDetails
                                                .result[index]
                                                .dedicationHandwork
                                                .toString()),
                                        minHeight: 6,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                          Color(0xff1EB75D),
                                        ),
                                        backgroundColor: Color(0xffCBD5E1),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Punctuality',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 16),
                                        ),
                                        Text(
                                          _getAllHrDetails
                                              .result[index].punctuality
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      child: LinearProgressIndicator(
                                        value: 0.1 *
                                            double.tryParse(_getAllHrDetails
                                                .result[index].punctuality
                                                .toString()),
                                        minHeight: 6,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                          Color(0xff1EB75D),
                                        ),
                                        backgroundColor: Color(0xffCBD5E1),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Team Work',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 16),
                                        ),
                                        Text(
                                          _getAllHrDetails
                                              .result[index].teamWork
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      child: LinearProgressIndicator(
                                        value: 0.1 *
                                            double.tryParse(_getAllHrDetails
                                                .result[index].teamWork
                                                .toString()),
                                        minHeight: 6,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                          Color(0xff1EB75D),
                                        ),
                                        backgroundColor: Color(0xffCBD5E1),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Client Satisfaction',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 16),
                                        ),
                                        Text(
                                          _getAllHrDetails
                                              .result[index].clientSatisfaction
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      child: LinearProgressIndicator(
                                        value: 0.1 *
                                            double.tryParse(_getAllHrDetails
                                                .result[index]
                                                .clientSatisfaction
                                                .toString()),
                                        minHeight: 6,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                          Color(0xff1EB75D),
                                        ),
                                        backgroundColor: Color(0xffCBD5E1),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Learning and Growth',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 16),
                                        ),
                                        Text(
                                          _getAllHrDetails
                                              .result[index].learningGrowth
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      child: LinearProgressIndicator(
                                        value: 0.1 *
                                            double.tryParse(_getAllHrDetails
                                                .result[index].learningGrowth
                                                .toString()),
                                        minHeight: 6,
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                          Color(0xff1EB75D),
                                        ),
                                        backgroundColor: Color(0xffCBD5E1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
