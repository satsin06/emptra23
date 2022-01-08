import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/models/getListModel/getAmountModel.dart';
import 'package:flutter_emptra/models/getListModel/getRtpcrModel.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/add_amount.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RtpcrAdd extends StatefulWidget {
  @override
  _RtpcrAddState createState() => _RtpcrAddState();
}

class _RtpcrAddState extends State<RtpcrAdd> {
//  String userId = '285885';
  bool _isLoading = false;
  DateTime _selectedFromDate;
  TextEditingController _fromDatecontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _dropDownValue;
  DateTime _selectedTodate;
  TextEditingController _toDatecontroller = TextEditingController();
  TextEditingController _address = TextEditingController();
  GetCredit _getCredit;
  GetRtpcrModel _rtpcrData;

  @override
  void initState() {
    super.initState();
    hello();
  }

  hello() async {
    await getCredit();
    await getRtpcrDetail();
  }

  getCredit() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();
      var response = await dio.get(
        "${Api.getCredit}/$userId",
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
            _getCredit = GetCredit.fromJson(response.data);
            print(_getCredit);
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

  getRtpcrDetail() async {
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
        if (response.data['code'] == 100) {
          setState(() {
            _rtpcrData = GetRtpcrModel.fromJson(response.data);
            _fromDatecontroller.text = _rtpcrData.result.date == null
                ? null
                : _rtpcrData.result.date.toString();
            _toDatecontroller.text = _rtpcrData.result.time == null
                ? null
                : _rtpcrData.result.time.toString();
            _address.text = _rtpcrData.result.address == null
                ? null
                : _rtpcrData.result.address.toString();
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
    } catch (e) {
      print(e);
    }
  }

  addRtpcr() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    var firstName = session.getString("firstName");
    setState(() {
      _isLoading = true;
    });

    var dio = Dio();
    Map data = {
      "userId": userId,
      "name": firstName,
      "date": _fromDatecontroller.text.isEmpty == true
          ? null
          : _fromDatecontroller.text,
      "time": _toDatecontroller.text.isEmpty == true
          ? null
          : _toDatecontroller.text,
      "address": _address.text.isEmpty == true ? null : _address.text
    };
    print(data);
    print("${Api.addRtPcr}");
    print(jsonEncode(data));
    var response = await dio.post("${Api.addRtPcr}",
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
        success(response.data['message']);
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
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'RTPCR Booking',
                            style: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'PoppinsBold',
                                height: 1.3,
                                fontWeight: FontWeight.w600,
                                fontSize: 32),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Date',
                            style: kForteenText,
                          ),
                          GestureDetector(
                            onTap: () => _selectFromdate(),
                            child: AbsorbPointer(
                              child: TextField(
                                controller: _fromDatecontroller,
                                style: k22InputText,
                                decoration: InputDecoration(
                                    isDense: true,
                                    hintText: "Date",
                                    hintStyle: k18F87Black400HT),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Time',
                            style: kForteenText,
                          ),
                          GestureDetector(
                            onTap: () => _selectTodate(),
                            child: AbsorbPointer(
                              child: TextField(
                                controller: _toDatecontroller,
                                style: k22InputText,
                                decoration: InputDecoration(
                                    isDense: true,
                                    hintText: "time",
                                    hintStyle: k18F87Black400HT),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Address',
                            style: kForteenText,
                          ),
                          TextFormField(
                            controller: _address,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "sample collection address",
                              hintStyle: k18F87Black400HT,
                            ),
                            style: k22InputText,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Address";
                              }
                              return null;
                            },
                            // onSaved: (String name) {},
                            // onChanged: (value) {
                            //   name = value;
                            //   setState(() {});
                            // },
                          ),
                          SizedBox(height: 20),
                          _getCredit == null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      textColor: Colors.white,
                                      color: Color(0xff3E66FB),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 12.0, bottom: 12.0),
                                        child: Text(
                                          'Buy Credit',
                                          style: k13Fwhite400BT,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        AddAmount()));
                                      },
                                    ),
                                  ],
                                )
                              : _getCredit.result.creditPoints <= 499
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          textColor: Colors.white,
                                          color: Color(0xff3E66FB),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 12.0, bottom: 12.0),
                                            child: Text(
                                              'Buy Credit',
                                              style: k13Fwhite400BT,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        AddAmount()));
                                          },
                                        ),
                                      ],
                                    )
                                  : _rtpcrData == null
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              textColor: Colors.white,
                                              color: Color(0xff3E66FB),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                child: Text(
                                                  'Submit',
                                                  style: k13Fwhite400BT,
                                                ),
                                              ),
                                              onPressed: () {
                                                if (_formkey.currentState
                                                    .validate()) {
                                                  addRtpcr();
                                                }
                                              },
                                            ),
                                          ],
                                        )
                                      : SizedBox(),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  _selectTodate() async {
    DateTime pickedDate = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (context) {
        DateTime tempPickedDate = _selectedTodate ?? DateTime.now();
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text('Done'),
                      onPressed: () {
                        Navigator.of(context).pop(tempPickedDate);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (value) {},
                    initialDateTime: DateTime.now(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedTodate) {
      setState(() {
        _selectedTodate = pickedDate;
        _toDatecontroller.text = pickedDate.toString();
      });
      _toDatecontroller
        ..text = DateFormat("kk:mm").format(_selectedTodate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _toDatecontroller.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  _selectFromdate() async {
    DateTime pickedDate = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (context) {
        DateTime tempPickedDate = _selectedFromDate ?? DateTime.now();
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text('Done'),
                      onPressed: () {
                        Navigator.of(context).pop(tempPickedDate);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                    },
                    minimumDate: DateTime.utc(1979, 12, 31),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedFromDate) {
      setState(() {
        _selectedFromDate = pickedDate;
        _fromDatecontroller.text = pickedDate.toString();
      });

      _fromDatecontroller
        ..text = DateFormat('dd-MM-yyyy').format(_selectedFromDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _fromDatecontroller.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}
