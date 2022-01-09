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
import 'package:flutter_emptra/pages/individual/clickable_card/basicsoftskill_editable.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelfAssessmentAccoutn extends StatefulWidget {
  const SelfAssessmentAccoutn({Key key}) : super(key: key);

  @override
  _SelfAssessmentAccoutnState createState() => _SelfAssessmentAccoutnState();
}

class _SelfAssessmentAccoutnState extends State<SelfAssessmentAccoutn> {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Self Assessment',
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
                  'Update',
                  style: TextStyle(fontFamily: 'PoppinsLight', fontSize: 12),
                ),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BasicSoftSkillEdit(
                              //  data:_personalInfoHistoryData
                              )));
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        _personalInfoHistoryData == null
            ? Container(
                height: 300,
                width: 300,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BasicSoftSkillEdit()));
                  },
                  child: Image.asset(
                    'assets/images/skill.png', // and width here
                  ),
                ),
              )
            : InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BasicSoftSkillEdit()));
                },
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Basic Skills',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black87,
                                  fontFamily: 'PoppinsLight',
                                  fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/computerskills.png"),
                                      radius: 25,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    'Computer Skills',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 100, right: 20, bottom: 10),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: LinearProgressIndicator(
                                  value: 0.1 *
                                      double.tryParse(_personalInfoHistoryData
                                          .result.basicSkills.computerSkills
                                          .toString()),
                                  minHeight: 6,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color(0xff3E66FB),
                                  ),
                                  backgroundColor: Color(0xffCBD5E1),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/msoffice.png"),
                                      radius: 25,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '  Ms Office',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 100, right: 20, bottom: 10),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: LinearProgressIndicator(
                                  value: 0.1 *
                                      double.tryParse(_personalInfoHistoryData
                                          .result.basicSkills.msOffice
                                          .toString()),
                                  minHeight: 6,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color(0xff3E66FB),
                                  ),
                                  backgroundColor: Color(0xffCBD5E1),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/basicdesigning.png"),
                                      radius: 25,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '  Basic Designing',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 100, right: 20, bottom: 10),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: LinearProgressIndicator(
                                  value: 0.1 *
                                      double.tryParse(_personalInfoHistoryData
                                          .result.basicSkills.basicAccounting
                                          .toString()),
                                  minHeight: 6,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color(0xff3E66FB),
                                  ),
                                  backgroundColor: Color(0xffCBD5E1),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/basicaccounting.png"),
                                      radius: 25,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '  Basic Accounting',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 100, right: 20, bottom: 10),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: LinearProgressIndicator(
                                  value: 0.1 *
                                      double.tryParse(_personalInfoHistoryData
                                          .result.basicSkills.basicAccounting
                                          .toString()),
                                  minHeight: 6,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color(0xff3E66FB),
                                  ),
                                  backgroundColor: Color(0xffCBD5E1),
                                ),
                              ),
                            ),
                            Text(
                              'Soft Skills',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black87,
                                  fontFamily: 'PoppinsLight',
                                  fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/englishcommunication.png"),
                                      radius: 25,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '  English Communication',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 100, right: 20, bottom: 10),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: LinearProgressIndicator(
                                  value: 0.1 *
                                      double.tryParse(_personalInfoHistoryData
                                          .result
                                          .softSkills
                                          .englishCommunication
                                          .toString()),
                                  minHeight: 6,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color(0xff3E66FB),
                                  ),
                                  backgroundColor: Color(0xffCBD5E1),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/hindicommunication.png"),
                                      radius: 25,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    'Hindi Communication',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 100, right: 20, bottom: 10),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: LinearProgressIndicator(
                                  value: 0.1 *
                                      double.tryParse(_personalInfoHistoryData
                                          .result.softSkills.hindiCommunication
                                          .toString()),
                                  minHeight: 6,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color(0xff3E66FB),
                                  ),
                                  backgroundColor: Color(0xffCBD5E1),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/writingengliash.png"),
                                      radius: 25,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '  Writing English',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 100, right: 20, bottom: 10),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: LinearProgressIndicator(
                                  value: 0.1 *
                                      double.tryParse(_personalInfoHistoryData
                                          .result.softSkills.writingEnglish
                                          .toString()),
                                  minHeight: 6,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color(0xff3E66FB),
                                  ),
                                  backgroundColor: Color(0xffCBD5E1),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 25,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "assets/images/writinghindi.png"),
                                      radius: 25,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '  Writing Hindi',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: 'PoppinsLight',
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 100, right: 20, bottom: 10),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: LinearProgressIndicator(
                                  value: 0.1 *
                                      double.tryParse(_personalInfoHistoryData
                                          .result.softSkills.writingHindi
                                          .toString()),
                                  minHeight: 6,
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color(0xff3E66FB),
                                  ),
                                  backgroundColor: Color(0xffCBD5E1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
