import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BmiEditCard extends StatefulWidget {
  @override
  _BmiEditCardState createState() => _BmiEditCardState();
}

class _BmiEditCardState extends State<BmiEditCard> {
  String name = "";
  TextEditingController _height = TextEditingController();
  TextEditingController _weight = TextEditingController();
  List<bool> isSelected;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String employementStatus;
  bool _isLoading = false;

  addBmi() async {
    try{
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });

    var dio = Dio();
    Map data =
    {
      "userId":  userId,
      "weight": _weight.text,
      "height": int.parse(_height.text)/100,
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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BottomBarIndivitual(index: 3,)));
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
  }
    catch(e){
      print(e);
    }
  }
  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
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
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xffF8F7F3),
      child: Scaffold(
        body: _isLoading == true
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                      ),
                      Card(
                        elevation: 1,
                        child: Container(
                          width: double.infinity,
                          height: 700,
                          padding: new EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(Icons.close,size: 30.0,),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             BottomBarIndivitual(index: 3,)));
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                ),
                                child: Card(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10),
                                        Text(
                                          'Gender',
                                          style: kForteenText,
                                        ),
                                        SizedBox(height: 20),
                                        Center(
                                          child: ToggleButtons(
                                           // borderColor: Colors.black,
                                            fillColor:Color(0xffCBD5E1),
                                           // borderWidth: 2,
                                          //  selectedBorderColor: Colors.black,
                                            selectedColor: Colors.white,
                                            borderRadius: BorderRadius.circular(15.0),
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    22.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .center,
                                                  children: [
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .mars,
                                                      color: Colors.grey,
                                                      size: 50.0,
                                                    ),
                                                    Text(
                                                      'Male',
                                                      style: kForteenText,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    22.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .center,
                                                  children: [
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .venus,
                                                      color: Colors.grey,
                                                      size: 50.0,
                                                    ),
                                                    Text(
                                                      'Female',
                                                      style: kForteenText,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                            onPressed: (int index) {
                                              setState(() {
                                                for (int i = 0; i < isSelected.length; i++) {
                                                  isSelected[i] = i == index;
                                                }
                                              });
                                            },
                                            isSelected: isSelected,
                                          ),
                                        ),
                                        SizedBox(height: 25),
                                        Text(
                                          'Height',
                                          style: kForteenText,
                                        ),
                                        TextFormField(
                                          controller:  _height,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            hintText: "enter height in cm",
                                            hintStyle: k18F87Black400HT,
                                          ),
                                          style: k22InputText,

                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "Height cannot be empty";
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
                                          'Weight',
                                          style: kForteenText,
                                        ),
                                        TextFormField(
                                          controller: _weight,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            hintText: "enter weight in KG",
                                            hintStyle: k18F87Black400HT,
                                          ),
                                          style: k22InputText,

                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "weight cannot be empty";
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5)),
                                              textColor: Colors.white,
                                              color: Color(0xff3E66FB),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(
                                                        14.0),
                                                child: Text(
                                                  'Calculate BMI',
                                                  style: k13Fwhite400BT,
                                                ),
                                              ),
                                              onPressed: () {
                                                addBmi();
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             BasicSkillPage()));
                                                // if (_formkey.currentState.validate()) {
                                                //   signup();
                                                // }
                                              },
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
