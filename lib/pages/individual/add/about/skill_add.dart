import 'dart:convert';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/models/getListModel/getIndustrySkillModel.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SkillAdd extends StatefulWidget {
  @override
  _SkillAddState createState() => _SkillAddState();
}

class _SkillAddState extends State<SkillAdd> {
  String name = "";
  int _rating = 5;
  TextEditingController _skill = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  GetIndustrySkillsHistoryModel _industrySkillsData;

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

  addIndustrySkills() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    Map data = {
      "userId": userId,
      "industryName": _skill.text,
      "rating": _rating
    };
    print(data);
    print("${Api.addSkills}");
    print(jsonEncode(data));
    var response = await dio.post("${Api.addSkills}",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
          "versionnumber": "v1"
        }),
        data: data);
    print(response.data);
    if (response.statusCode == 200) {
      if (response.data['code'] == 100) {
        setState(() {
          _isLoading = false;
        getIndustryHistory();
          success("Please tell us more \n about your Industry skill");
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
  }

  getIndustryHistory() async {
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
          print("!!!!!");
          _industrySkillsData =
              GetIndustrySkillsHistoryModel.fromJson(response.data);
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

  _deleteSkills({String userId}) async {
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.delete(
    //  'http://65.2.81.228/removeIndustrySkills/$userId',
      "${Api.deleteSkills}/$userId",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
    );
    print(response.data);
    if (response.statusCode == 200) {
      getIndustryHistory();
      setState(() {
        _industrySkillsData = null;
        _isLoading = false;
      });
    } else {
      getIndustryHistory();
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getIndustryHistory();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Color(0xffF8F7F3),
        child: _isLoading == true
            ? Center(child: CircularProgressIndicator())
            : Scaffold(
                body: SingleChildScrollView(
                  child: Form(
                    key: _formkey,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                      Align(
                          alignment: Alignment.topRight,
                          child:IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             BottomBarIndivitual()));
                            },
                          ),),
                          SizedBox(height: 20),
                          Text(
                            'Add Skills',
                            style: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'PoppinsBold',
                                height: 1.3,
                                fontWeight: FontWeight.w600,
                                fontSize: 32),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Please tell us more about your skill',
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'PoppinsLight',
                                fontSize: 18),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 20.0, right: 20,top: 10),
                            child: Text(
                              'Add More Skills',
                              style: kForteenText,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: TextFormField(
                              controller: _skill,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: "TOP Skill",
                                hintStyle: k18F87Black400HT,
                              ),
                              style: k22InputText,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Skill cannot be empty";
                                }
                                return null;
                              },
                              onSaved: (String name) {},
                              onChanged: (value) {
                                name = value;
                                setState(() {});
                              },
                            ),
                          ),
                          SizedBox(height: 15),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Rate Your Skill ',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 17),
                                    ),
                                    Text(
                                      '$_rating',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 40,
                                width: double.infinity,
                                child: Slider(
                                  value: _rating.toDouble(),
                                  min: 0.0,
                                  max: 10.0,
                                  divisions: 10,
                                  activeColor: Color(0xff3E66FB),
                                  inactiveColor: Colors.grey,
                                  onChanged: (double newValue) {
                                    setState(() {
                                      _rating = newValue.round();
                                    });
                                  },
                                  semanticFormatterCallback: (double newValue) {
                                    return '${newValue.round()} dollars';
                                  },
                                ),
                              ),
                            ],
                          ),
                        //   SizedBox(height: 15),
                        //   // ignore: deprecated_member_use
                        //   _industrySkillsData
                        //       .result.length>=6
                        // ? Container()
                        //   :
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                textColor: Colors.white,
                                color: Color(0xff3E66FB),
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Text(
                                    'Save',
                                    style: k13Fwhite400BT,
                                  ),
                                ),
                                onPressed: () {
                                  addIndustrySkills();
                                  // if (_formkey.currentState.validate()) {
                                  //   signup();
                                  // }
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 25),


                          _industrySkillsData == null
                              ? Container()
                              : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 20.0, right: 20,bottom: 10),
                                child: Text(
                                  'Your Top Skills',
                                  style: kForteenText,
                                ),
                              ),
                              Container(
                                child: ListView.builder(
                                    itemCount: _industrySkillsData
                                        .result.length,
                                    shrinkWrap: true,
                                    // scrollDirection: Axis.horizontal,
                                    physics:
                                    NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Card(
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(15.0),
                                        ),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(6.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(width: 10,),
                                                  Text(
                                                    _industrySkillsData.result[index].rating.toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight
                                                            .w900,
                                                        color: Colors
                                                            .black87,
                                                        fontFamily:
                                                        'PoppinsLight',
                                                        fontSize:18),
                                                  ),
                                                  SizedBox(width: 10,),
                                                  Text(
                                                    _industrySkillsData.result[index].industryName.toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight
                                                            .w400,
                                                        color: Colors
                                                            .black87,
                                                        fontFamily:
                                                        'PoppinsLight',
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.close),
                                                onPressed: () {
                                                  _deleteSkills(
                                                      userId:
                                                      _industrySkillsData
                                                          .result[
                                                      index]
                                                          .id);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                          // GridView.builder(
                          //   itemCount:_industrySkillsData
                          //       .result.length,
                          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          //     crossAxisCount: MediaQuery.of(context).orientation ==
                          //         Orientation.landscape ? 3: 2,
                          //     crossAxisSpacing: 8,
                          //     mainAxisSpacing: 8,
                          //     childAspectRatio: (2 / 1),
                          //   ),
                          //   itemBuilder: (context,index,) {
                          //     return GestureDetector(
                          //       onTap:(){
                          //         //Navigator.of(context).pushNamed(RouteName.GridViewCustom);
                          //       },
                          //       child:Container(
                          //         child: Column(
                          //           mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                          //           children: [
                          //             Text(
                          //               _industrySkillsData.result[index].rating.toString(),
                          //               style: TextStyle(
                          //                   fontWeight:
                          //                   FontWeight
                          //                       .w900,
                          //                   color: Colors
                          //                       .black87,
                          //                   fontFamily:
                          //                   'PoppinsLight',
                          //                   fontSize:18),
                          //             ),
                          //             Text(
                          //               _industrySkillsData.result[index].industryName,
                          //               style: TextStyle(
                          //                   fontWeight:
                          //                   FontWeight
                          //                       .w900,
                          //                   color: Colors
                          //                       .black87,
                          //                   fontFamily:
                          //                   'PoppinsLight',
                          //                   fontSize: 16),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // )
                          // GridView.builder(
                          //   itemCount:  _industrySkillsData
                          //       .result.length,
                          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          //       crossAxisCount: 2,
                          //       crossAxisSpacing: 4.0,
                          //       mainAxisSpacing: 4.0
                          //   ),
                          //   itemBuilder: (BuildContext context, int index){
                          //     return Container(
                          //       child: Column(
                          //         children: [
                          //           Text(
                          //             _industrySkillsData.result[index].rating.toString(),
                          //             style: TextStyle(
                          //                 fontWeight:
                          //                 FontWeight
                          //                     .w900,
                          //                 color: Colors
                          //                     .black87,
                          //                 fontFamily:
                          //                 'PoppinsLight',
                          //                 fontSize:18),
                          //           ),
                          //           Text(
                          //             _industrySkillsData.result[index].industryName,
                          //             style: TextStyle(
                          //                 fontWeight:
                          //                 FontWeight
                          //                     .w900,
                          //                 color: Colors
                          //                     .black87,
                          //                 fontFamily:
                          //                 'PoppinsLight',
                          //                 fontSize: 16),
                          //           ),
                          //           IconButton(
                          //             icon: Icon(Icons.close),
                          //             onPressed: () {
                          //               _deleteSkills(
                          //                   userId:
                          //                   _industrySkillsData
                          //                       .result[
                          //                   index]
                          //                       .id);
                          //             },
                          //           ),
                          //         ],
                          //       ),
                          //     );
                          //   },
                          // )
                   ]
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
