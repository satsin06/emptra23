import 'dart:convert';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/models/getListModel/getIndustrySkillModel.dart';
import 'package:flutter_emptra/models/getListModel/getVideoModel.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideoAdd extends StatefulWidget {
  @override
  _VideoAddState createState() => _VideoAddState();
}

class _VideoAddState extends State<VideoAdd> {
  String name = "";
  TextEditingController _video1 = TextEditingController();
  TextEditingController _video2 = TextEditingController();
  TextEditingController _video3 = TextEditingController();
  TextEditingController _video4= TextEditingController();
  TextEditingController _video5 = TextEditingController();
  TextEditingController _video6 = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  GetIndustrySkillsHistoryModel _industrySkillsData;
  GetVideoModel _videoData;

  String _ytUrl1;
  String _ytUrl2;
  String _ytUrl3;
  String _ytUrl4;
  String _ytUrl5;
  String _ytUrl6;

  alertbox(String value) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      title: 'Oops...',
      text: value,
    );
  }

  success(String value) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      title: '',
      text: value,
    );
  }

  addVideo() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    Map data ={
      "userId": userId,
      "videos": {
        "video1": _video1.text.isEmpty==true?null:_video1.text,
        "video2": _video2.text.isEmpty==true?null:_video2.text,
        "video3": _video3.text.isEmpty==true?null:_video3.text,
        "video4": _video4.text.isEmpty==true?null:_video4.text,
        "video5": _video5.text.isEmpty==true?null:_video5.text,
        "video6": _video6.text.isEmpty==true?null:_video6.text,
      }
    };

    print(data);
    print("${Api.addVideos}");
    print(jsonEncode(data));
    var response = await dio.post("${Api.addVideos}",
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomBarIndivitual()));
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        alertbox(response.data['message']);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }
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
            _video1.text = _videoData.result.videos.video1==null?null:_videoData.result.videos.video1.toString();
            _video2.text = _videoData.result.videos.video2==null?null:_videoData.result.videos.video2.toString();
            _video3.text = _videoData.result.videos.video3==null?null:_videoData.result.videos.video3.toString();
            _video4.text = _videoData.result.videos.video4==null?null:_videoData.result.videos.video4.toString();
            _video5.text = _videoData.result.videos.video5==null?null:_videoData.result.videos.video5.toString();
            _video6.text = _videoData.result.videos.video6==null?null:_videoData.result.videos.video6.toString();
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

  @override
  void initState() {
    super.initState();
    getVideo();
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
                    child:   IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                         //  Navigator.push(
                         //      context,
                         //      MaterialPageRoute(
                         //          builder: (context) =>
                         //              BottomBarIndivitual()));
                        },
                      ),),
                      SizedBox(height: 20),
                      Text(
                        'Add Videos',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'PoppinsBold',
                            height: 1.3,
                            fontWeight: FontWeight.w600,
                            fontSize: 32),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 20.0, right: 20,top: 10),
                        child: Text(
                          'Add More Videos',
                          style: kForteenText,
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 20.0, right: 20,top: 10),
                        child: Text(
                          'Video1',
                          style: kForteenText,
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 20.0, right: 20),
                        child: TextFormField(
                          controller: _video1,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: "Video1",
                            hintStyle: k18F87Black400HT,
                          ),
                          style: k22InputText,
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return "Skill cannot be empty";
                          //   }
                          //   return null;
                          // },
                          // onSaved: (String name) {},
                          // onChanged: (value) {
                          //   name = value;
                          //   setState(() {});
                          // },
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 20.0, right: 20,top: 10),
                        child: Text(
                          'Video2',
                          style: kForteenText,
                        ),
                      ),

                      Padding(
                        padding:
                        const EdgeInsets.only(left: 20.0, right: 20),
                        child: TextFormField(
                          controller: _video2,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: "Video2",
                            hintStyle: k18F87Black400HT,
                          ),
                          style: k22InputText,
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return "Skill cannot be empty";
                          //   }
                          //   return null;
                          // },
                          // onSaved: (String name) {},
                          // onChanged: (value) {
                          //   name = value;
                          //   setState(() {});
                          // },
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 20.0, right: 20,top: 10),
                        child: Text(
                          'Video3',
                          style: kForteenText,
                        ),
                      ),

                      Padding(
                        padding:
                        const EdgeInsets.only(left: 20.0, right: 20),
                        child: TextFormField(
                          controller: _video3,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: "Video3",
                            hintStyle: k18F87Black400HT,
                          ),
                          style: k22InputText,
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return "Skill cannot be empty";
                          //   }
                          //   return null;
                          // },
                          // onSaved: (String name) {},
                          // onChanged: (value) {
                          //   name = value;
                          //   setState(() {});
                          // },
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 20.0, right: 20,top: 10),
                        child: Text(
                          'Video4',
                          style: kForteenText,
                        ),
                      ),

                      Padding(
                        padding:
                        const EdgeInsets.only(left: 20.0, right: 20),
                        child: TextFormField(
                          controller: _video4,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: "Video4",
                            hintStyle: k18F87Black400HT,
                          ),
                          style: k22InputText,
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return "Skill cannot be empty";
                          //   }
                          //   return null;
                          // },
                          // onSaved: (String name) {},
                          // onChanged: (value) {
                          //   name = value;
                          //   setState(() {});
                          // },
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 20.0, right: 20,top: 10),
                        child: Text(
                          'Video5',
                          style: kForteenText,
                        ),
                      ),

                      Padding(
                        padding:
                        const EdgeInsets.only(left: 20.0, right: 20),
                        child: TextFormField(
                          controller: _video5,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: "Video5",
                            hintStyle: k18F87Black400HT,
                          ),
                          style: k22InputText,
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return "Skill cannot be empty";
                          //   }
                          //   return null;
                          // },
                          // onSaved: (String name) {},
                          // onChanged: (value) {
                          //   name = value;
                          //   setState(() {});
                          // },
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 20.0, right: 20,top: 10),
                        child: Text(
                          'Video6',
                          style: kForteenText,
                        ),
                      ),

                      Padding(
                        padding:
                        const EdgeInsets.only(left: 20.0, right: 20),
                        child: TextFormField(
                          controller: _video6,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: "Video6",
                            hintStyle: k18F87Black400HT,
                          ),
                          style: k22InputText,
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return "Skill cannot be empty";
                          //   }
                          //   return null;
                          // },
                          // onSaved: (String name) {},
                          // onChanged: (value) {
                          //   name = value;
                          //   setState(() {});
                          // },
                        ),
                      ),
                      SizedBox(height: 25),
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
                              addVideo();
                              // if (_formkey.currentState.validate()) {
                              //   signup();
                              // }
                            },
                          ),
                          SizedBox(width: 20,),
                        ],
                      ),
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
