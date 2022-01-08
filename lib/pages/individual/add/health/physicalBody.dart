import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/models/getListModel/getInterestModel.dart';
import 'package:flutter_emptra/models/getListModel/getPhysicalBody.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhysicalBodyAdd extends StatefulWidget {
  @override
  _PhysicalBodyAddState createState() => _PhysicalBodyAddState();
}

class _PhysicalBodyAddState extends State<PhysicalBodyAdd> {
  String name = "";
  TextEditingController _hairTexture = TextEditingController();
  TextEditingController _bustSize = TextEditingController();
  TextEditingController _hipsSize = TextEditingController();
  TextEditingController _eyeColor = TextEditingController();
  TextEditingController _skinTone = TextEditingController();
  TextEditingController _waist = TextEditingController();
  TextEditingController _identificationMark = TextEditingController();
  TextEditingController _hairColor = TextEditingController();
  TextEditingController _shoeSize = TextEditingController();

  final aboutController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String employementStatus;
  bool _isLoading = false;

  GetPhysicalBodyModel _physicalBodyData;

  @override
  void dispose() {
    _hairTexture?.dispose();
    _bustSize?.dispose();
    _hipsSize?.dispose();
    _eyeColor?.dispose();
    _skinTone?.dispose();
    _waist?.dispose();
    _identificationMark?.dispose();
    _hairColor?.dispose();
    _shoeSize?.dispose();
    super.dispose();
  }

  addPhysicalData() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });
    Map data = {
          "userId": userId,
          "bust": _bustSize.text.isEmpty==true?"":_bustSize.text,
          "waist":_waist.text.isEmpty==true?"":_waist.text,
          "hips": _hipsSize.text.isEmpty==true?"":_hipsSize.text,
          "skinTone":_skinTone.text.isEmpty==true?"":_skinTone.text,
          "eyeColor": _eyeColor.text.isEmpty==true?"":_eyeColor.text,
          "hairColor": _hairColor.text.isEmpty==true?"":_hairColor.text,
          "hairTexture":_hairTexture.text.isEmpty==true?"":_hairTexture.text,
          "identificationMark": _identificationMark.text.isEmpty==true?"":_identificationMark.text,
          "shoeSize": _shoeSize.text.isEmpty==true?"":_shoeSize.text,
    };

    print("${Api.addPhysicalbody}/$userId");
    print(jsonEncode(data));
    var response = await dio.post("${Api.addPhysicalbody}",
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
              context, MaterialPageRoute(builder: (context) => BottomBarIndivitual(index: 3,)));
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
  getPhysicalData() async {
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
          _physicalBodyData =
              GetPhysicalBodyModel.fromJson(response.data);
          _hairTexture.text =_physicalBodyData.result[0].hairTexture.toString();
          _bustSize.text =_physicalBodyData.result[0].bust.toString();
          _hipsSize.text =_physicalBodyData.result[0].hips.toString();
          _eyeColor.text =_physicalBodyData.result[0].eyeColor.toString();
          _skinTone.text =_physicalBodyData.result[0].skinTone.toString();
          _waist.text =_physicalBodyData.result[0].waist.toString();
          _identificationMark.text =_physicalBodyData.result[0].identificationMark.toString();
          _hairColor.text =_physicalBodyData.result[0].hairColor.toString();
          _shoeSize.text =_physicalBodyData.result[0].shoeSize.toString();
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
  @override
  void initState() {
    super.initState();
    getPhysicalData();
    //isworking = 'true';
    // getCustomerName();
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
                      child: IconButton(
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
                          //             BottomBarIndivitual(index: 3,)));
                        },
                      ),),
                    SizedBox(height: 10),
                    Text(
                      'Add Physical Details',
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'PoppinsBold',
                          height: 1.3,
                          fontWeight: FontWeight.w600,
                          fontSize: 32),
                    ),
                    SizedBox(height: 30),

                    Text(
                      'Hair Texture',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _hairTexture,
                      style: k22InputText,
                      decoration: InputDecoration(
                        isDense: true,
                      //  hintText: "Hair Texture",
                        hintStyle: k18F87Black400HT,
                      ),
                      validator: (value) {
                        if (value.length > 15) {
                          return "Hair Texture length not more than 15 words";
                        }return null;
                      },
                      onSaved: (String name) {},
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Bust',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _bustSize,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        isDense: true,
                     //   hintText: "@Beatles",
                        hintStyle: k18F87Black400HT,
                      ),
                      style: k22InputText,
                      validator: (value) {
                         if (value.length > 15) {
                          return "Bust length not more than 15 words";
                        }
                        return null;
                      },
                      onSaved: (String name) {},
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Hips',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _hipsSize,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        isDense: true,
                      //  hintText: "F.R.I.E.N.D",
                        hintStyle: k18F87Black400HT,
                      ),
                      style: k22InputText,
                      validator: (value) {
                         if (value.length > 15) {
                          return "Hips length words not more than 15 words";
                        }
                        return null;
                      },
                      onSaved: (String name) {},
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Eye Color',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _eyeColor,
                      decoration: InputDecoration(
                        isDense: true,
                      //  hintText: "Invincible",
                        hintStyle: k18F87Black400HT,
                      ),
                      style: k22InputText,
                      validator: (value) {
                        if (value.length > 15) {
                          return "Eye Color words length not more than 15 words";
                        }
                        return null;
                      },
                      onSaved: (String name) {},
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Skin Tone',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _skinTone,
                      decoration: InputDecoration(
                        isDense: true,
                       // hintText: "Hero",
                        hintStyle: k18F87Black400HT,
                      ),
                      style: k22InputText,
                      validator: (value) {
                         if (value.length > 15) {
                          return "Skin Tone words length not more than 15 words";
                        }
                        return null;
                      },
                      onSaved: (String name) {},
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Waist',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _waist,
                      style: k22InputText,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        isDense: true,
                      //  hintText: "@Chetan Bhagat",
                        hintStyle: k18F87Black400HT,
                      ),
                      validator: (value) {
                         if (value.length > 15) {
                          return "Waist words length not more than 15 words";
                        }
                        return null;
                      },
                      onSaved: (String name) {},
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Identification Mark',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _identificationMark,
                      decoration: InputDecoration(
                        isDense: true,
                      //  hintText: "game",
                        hintStyle: k18F87Black400HT,
                      ),
                      style: k22InputText,
                      validator: (value) {
                        if (value.length > 15) {
                          return "Identification words Mark length not more than 15 words";
                        }
                        return null;
                      },
                      onSaved: (String name) {},
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Hair Color',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _hairColor,
                      decoration: InputDecoration(
                        isDense: true,
                     //   hintText: "@Running",
                        hintStyle: k18F87Black400HT,
                      ),
                      style: k22InputText,
                      validator: (value) {
                        if (value.length > 15) {
                          return "Hair Color words length not more than 10 words";
                        }
                        return null;
                      },
                      onSaved: (String name) {},
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
                    ),

                    SizedBox(height: 25),
                    Text(
                      'Shoe Size',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _shoeSize,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        isDense: true,
                        //   hintText: "@Running",
                        hintStyle: k18F87Black400HT,

                      ),
                      style: k22InputText,
                      validator: (value) {
                       if (value.length > 15) {
                          return "Shoe Size words length not more than 10 words";
                        }
                        return null;
                      },
                      onSaved: (String name) {},
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
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
                            // addPhysicalData();
                            if (_formkey.currentState.validate()) {
                              addPhysicalData();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
