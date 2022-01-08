import 'dart:convert';
import 'dart:io';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/models/getListModel/getCountryModel.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountryAdd extends StatefulWidget {
  @override
  _CountryAddState createState() => _CountryAddState();
}

class _CountryAddState extends State<CountryAdd> {
  String name = "";
  int _rating = 5;
  TextEditingController _country = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  GetCountryListModel _countryData;
  var countryName;
  var list;
  var countryId;
  List<String> industryAutosuggest = [];
  final companyAutoSuggestionname = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<String>> addIndustryForm =
  new GlobalKey();

  getCustomerName() async {
    print("2232");
    SharedPreferences session = await SharedPreferences.getInstance();
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });
    var response = await dio.get(
      Api.countryList,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
    );
    print(response.data);
    list = (response.data['result'][0]['countries']);
    print(list);
    for (int i = 0; i < list.length; i++) {
      industryAutosuggest.add(list[i]['name']);
      setState(() {
        _isLoading = false;
      });
      print(industryAutosuggest);
    }
  }

  setcustcode(value) {
    for (int i = 0; i <= list.length; i++) {
      // print(list[i]['name']);
      if (list[i]['name'] == value) {
        setState(() {
          countryId= list[i]['id'];
          countryName = value;
        });
      } else {
        print(list[i]['id']);
      }
    }
  }



  @override
  void initState() {
    super.initState();
    hello();
  }


  hello() async {
    await getCustomerName();
    await getCountry();
  }

  addCountry() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    Map data =
    {
      "userId": userId,
      "id": countryId.toString(),
      "country": countryName
    };
    print("vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv");
  //  print("${Api.addCountries}");
    print(jsonEncode(data));
    var response = await dio.post("${Api.addCountries}",
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
         getCountry();
          success("Please tell us more \n about your Country");
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
  getCountry() async {
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
          print( _countryData);
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



  _deleteCountry({String userId}) async {
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.delete(
      "${Api.deleteCountry}/$userId",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
    );
    print(response.data);
    if (response.statusCode == 200) {
      getCountry();
      setState(() {
        _countryData = null;
        _isLoading = false;
      });
    } else {
      getCountry();
      setState(() {
        _isLoading = false;
      });
    }
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
                          //             BottomBarIndivitual(index: 1,)));
                        },
                      ),),
                      SizedBox(height: 20),
                      Text(
                        'Add Country',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'PoppinsBold',
                            height: 1.3,
                            fontWeight: FontWeight.w600,
                            fontSize: 32),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Please tell us more about your Country Visited',
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'PoppinsLight',
                            fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding:
                        const EdgeInsets.only( right: 20,top: 10),
                        child: Text(
                          'Add More Countries',
                          style: kForteenText,
                        ),
                      ),
                      SimpleAutoCompleteTextField(
                          key: addIndustryForm,
                          style: k22InputText,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: "Country",
                            hintStyle: k18F87Black400HT,
                          ),
                          controller: companyAutoSuggestionname,
                          suggestions: industryAutosuggest,
                          textChanged: (text) =>
                          this.companyAutoSuggestionname.text,
                          clearOnSubmit: false,
                          textSubmitted: (text) => setcustcode(
                            this.companyAutoSuggestionname.text,
                          )),
                      SizedBox(height: 15),

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
                              addCountry();
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      _countryData == null
                          ? Container()
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 5, right: 20,bottom: 10),
                            child: Text(
                              'Your Visited Country',
                              style: kForteenText,
                            ),
                          ),
                          Container(
                            child: ListView.builder(
                                itemCount: _countryData
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
                                      BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.only(left: 20.0, right: 6,bottom: 6,top:6),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text(
                                            _countryData.result[index].country.toString(),
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
                                          IconButton(
                                            icon: Icon(Icons.close),
                                            onPressed: () {
                                              _deleteCountry(
                                                  userId:
                                                  _countryData
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
