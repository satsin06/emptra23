import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/models/getListModel/getOfficeAddress.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/address_card.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OfficeAdd extends StatefulWidget {
  @override
  _OfficeAddState createState() => _OfficeAddState();
}

class _OfficeAddState extends State<OfficeAdd> {

  String name = "";



  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  GetOfficeAddress _officeAddress;
  TextEditingController _landMark = TextEditingController();
  TextEditingController _cityAdd = TextEditingController();
  TextEditingController _houseNo = TextEditingController();
  TextEditingController _areaAdd = TextEditingController();
  TextEditingController _stateAdd = TextEditingController();
  TextEditingController _countryAdd = TextEditingController();



  @override
  void initState() {
    super.initState();
    getOfficeAddress();
  }

  getOfficeAddress() async {
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
          _houseNo.text = _officeAddress.result[0].house.toString() == null
              ? ''
              : _houseNo.text = _officeAddress.result[0].house.toString();

          _areaAdd.text = _officeAddress.result[0].area.toString() == null
              ? ''
              : _areaAdd.text = _officeAddress.result[0].area.toString();

          _landMark.text = _officeAddress.result[0].landmark.toString() == null
              ? ''
              : _landMark.text = _officeAddress.result[0].landmark.toString();

          _cityAdd.text = _officeAddress.result[0].city.toString() == null
              ? ''
              : _cityAdd.text = _officeAddress.result[0].city.toString();

          _stateAdd.text = _officeAddress.result[0].state.toString() == null
              ? ''
              : _stateAdd.text = _officeAddress.result[0].state.toString();

          _countryAdd.text = _officeAddress.result[0].country.toString() == null
              ? ''
              : _countryAdd.text = _officeAddress.result[0].country.toString();

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

  officeAdd() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    var firstName = session.getString("firstName");
    var lastName = session.getString("lastName");
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });


    Map data =
    {
      "userId": userId,
      "firstName": firstName,
      "lastName": lastName,
      "organizationId": "Office",
      "house": _houseNo.text,
      "area": _areaAdd.text,
      "landmark": _landMark.text,
      "city": _cityAdd.text,
      "state":  _stateAdd.text,
      "country": _countryAdd.text
    };


    print(jsonEncode(data));
    var response = await dio.post("${Api.addAddress}",
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
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) =>  AddressCard()));
          _isLoading = false;
          success(response.data['message']);
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
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 30.0,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddressCard()
                              ));
                        },
                      ),
                    ),
                    Text(
                      'Office Address',
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'PoppinsBold',
                          height: 1.3,
                          fontWeight: FontWeight.w600,
                          fontSize: 32),
                    ),

                    SizedBox(height: 20),
                    Text(
                      'Building',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _houseNo,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "eg: H-102",
                        hintStyle: k18F87Black400HT,
                      ),
                      style: k22InputText,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Flat, House no., Building, Apartment cannot be empty";
                        }
                        return null;
                      },
                      onSaved: (String name) {},
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
                    ),

                    SizedBox(height: 20),
                    Text(
                      'Area, Colony, Street, Sector, Village',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _areaAdd,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "eg: South City2",
                        hintStyle: k18F87Black400HT,
                      ),
                      style: k22InputText,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Area, Colony, Street, Sector, Village";
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
                      'Landmark',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _landMark,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "eg: Near Subhash Chock",
                        hintStyle: k18F87Black400HT,
                      ),
                      style: k22InputText,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Landmark cannot be empty";
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
                      'City',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _cityAdd,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "eg: City",
                        hintStyle: k18F87Black400HT,
                      ),
                      style: k22InputText,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "City can't be empty";
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
                      'State',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _stateAdd,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "eg: Haryana",
                        hintStyle: k18F87Black400HT,
                      ),
                      style: k22InputText,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "State can't be empty";
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
                      'Country',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _countryAdd,
                      style: k22InputText,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "eg: India",
                        hintStyle: k18F87Black400HT,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Country can't be empty";
                        }
                        return null;
                      },
                      onSaved: (String name) {},
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
                    ),

                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'This will deduct 10 points from your wallet',
                          style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'PoppinsLight',
                              fontSize: 12),
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          textColor: Colors.white,
                          color: Color(0xff3E66FB),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Submit',
                              style: k13Fwhite400BT,
                            ),
                          ),
                          onPressed: () {
                            if (_formkey.currentState.validate()) {
                              officeAdd();
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
