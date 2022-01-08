import 'dart:convert';
import 'dart:io';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/models/getListModel/getOfficeAddress.dart';
import 'package:flutter_emptra/models/getListModel/getPermanentAddress.dart';
import 'package:flutter_emptra/models/getListModel/getTemparoryAddress.dart';
import 'package:flutter_emptra/pages/individual/add/account/current_add.dart';
import 'package:flutter_emptra/pages/individual/add/account/office_add.dart';
import 'package:flutter_emptra/pages/individual/add/account/parmanent_add.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressCard extends StatefulWidget {
  @override
  _AddressCardState createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  String name = "";
  final maxLines = 4;
  int id = 1;
  GetOfficeAddress _officeAddress;
  GetPermanentAddress _permanentAddress;
  GetTemporaryAddress _temporaryAddress;

  final aboutController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _isLoading = false;
  GlobalKey<AutoCompleteTextFieldState<String>> institutename = new GlobalKey();
  final companyAutoSuggestionname = TextEditingController();

  @override
  void initState() {
    super.initState();
    getPermanentAddress();
    getTemporaryAddress();
    getOfficeAddress();
  }

  getPermanentAddress() async {
    try{
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    //   print("${Api.educationHistoryList}/$userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.get(
      "${Api.addressList}/$userId/Permanent",
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
          _permanentAddress = GetPermanentAddress.fromJson(response.data);
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
  getTemporaryAddress() async {
    try{
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    //   print("${Api.educationHistoryList}/$userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.get(
      "${Api.addressList}/$userId/Temporary",
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
          _temporaryAddress = GetTemporaryAddress.fromJson(response.data);
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
    catch(e){
      print(e);
    }
  }
  getOfficeAddress() async {
    try{
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
            : WillPopScope(
          onWillPop: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomBarIndivitual(index: 1))),
          child: Scaffold(
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
                            Navigator.pop(context);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             BottomBarIndivitual(index: 1,)
                            //     ));
                          },
                        ),
                      ),
                      Text(
                        'Physical Address Verification',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'PoppinsBold',
                            height: 1.3,
                            fontWeight: FontWeight.w600,
                            fontSize: 32),
                      ),
                      SizedBox(height: 10),
                      Column(
                        children: [
                          Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PermanentAdd()));
                              },
                              child: Container(
                                width: 300,
                                child: Card(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Permanent Address',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'PoppinsLight',
                                            fontSize: 18),
                                      ),
                                      Divider(
                                        color: Colors.black54,
                                      ),
                                      Container(
                                        child: Image
                                            .asset(
                                          'assets/images/home.png',
                                          height:
                                          100,
                                          width:
                                          100,
                                        ),
                                      ),
                                      _permanentAddress == null
                                          ? SizedBox()
                                          : Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12, right: 12),
                                          child: Container(
                                            child: ListView.builder(
                                                itemCount:
                                                _permanentAddress.result.length,
                                                scrollDirection: Axis.vertical,
                                                physics: ScrollPhysics(),
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => PermanentAdd()
                                                                  // VehicleEditCard(
                                                                  //     data:
                                                                  //     _vehicleModelData,
                                                                  //     index:
                                                                  //     index)
                                                          ));
                                                    },
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                      children: [
                                                        _permanentAddress.result[0].status
                                                            .toString() ==
                                                            "Pending"
                                                            ? Container(
                                                          width: 90,
                                                          //color: Colors.amber[600],
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xffFBE4BB),
                                                              borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(8))),
                                                          // color: Colors.blue[600],
                                                          alignment:
                                                          Alignment
                                                              .center,
                                                          child:
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.all(
                                                                6.0),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .hourglass_top_outlined,
                                                                  size:
                                                                  15,
                                                                  color:
                                                                  Color(0xffC47F00),
                                                                ),
                                                                Text(
                                                                  'PENDING',
                                                                  style: TextStyle(
                                                                      color: Color(0xffC47F00),
                                                                      fontWeight: FontWeight.bold,
                                                                      fontFamily: 'PoppinsLight',
                                                                      fontSize: 12),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                            : _permanentAddress.result[0].status
                                                            .toString() ==
                                                            "Approved"
                                                            ? Container(
                                                          width: 90,
                                                          //color: Colors.amber[600],
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xffA7F3D0),
                                                              borderRadius:
                                                              BorderRadius.all(Radius.circular(8))),
                                                          // color: Colors.blue[600],
                                                          alignment:
                                                          Alignment
                                                              .center,
                                                          child:
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.all(6.0),
                                                            child:
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.check_circle,
                                                                  size: 14,
                                                                  color: Colors.green,
                                                                ),
                                                                Text(
                                                                  'Approved',
                                                                  style: TextStyle(color: Color(0xff059669), fontWeight: FontWeight.bold, fontFamily: 'PoppinsLight', fontSize: 12),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                            : _permanentAddress.result[0].status.toString() ==
                                                            "Rejected"
                                                            ? Container(
                                                          width:
                                                          90,
                                                          //color: Colors.amber[600],
                                                          decoration: BoxDecoration(
                                                              color: Color(0xffFECACA),
                                                              borderRadius: BorderRadius.all(Radius.circular(8))),
                                                          // color: Colors.blue[600],
                                                          alignment:
                                                          Alignment.center,
                                                          child:
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.all(6.0),
                                                            child:
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.cancel,
                                                                  size: 15,
                                                                  color: Colors.red,
                                                                ),
                                                                Text(
                                                                  'Rejected',
                                                                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontFamily: 'PoppinsLight', fontSize: 12),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                            : Container(
                                                          width:
                                                          90,
                                                          //color: Colors.amber[600],
                                                          decoration: BoxDecoration(
                                                              color: Color(0xffFBE4BB),
                                                              borderRadius: BorderRadius.all(Radius.circular(8))),
                                                          // color: Colors.blue[600],
                                                          alignment:
                                                          Alignment.center,
                                                          child:
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.all(6.0),
                                                            child:
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.hourglass_top_outlined,
                                                                  size: 15,
                                                                  color: Color(0xffC47F00),
                                                                ),
                                                                Text(
                                                                  'PENDING',
                                                                  style: TextStyle(color: Color(0xffC47F00), fontWeight: FontWeight.bold, fontFamily: 'PoppinsLight', fontSize: 12),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        SizedBox(
                                                          width: 350,
                                                          child: Text(
                                                            _permanentAddress
                                                                .result[0]
                                                                .house
                                                                .toString() +
                                                                ', ' +
                                                                _permanentAddress
                                                                    .result[0]
                                                                    .area
                                                                    .toString() +
                                                                ', ' +
                                                                _permanentAddress
                                                                    .result[0]
                                                                    .landmark
                                                                    .toString()+
                                                                ', ' +
                                                                _permanentAddress
                                                                    .result[0]
                                                                    .city
                                                                    .toString() +
                                                                ', ' +
                                                                _permanentAddress
                                                                    .result[0]
                                                                    .state
                                                                    .toString() +
                                                                ', ' +
                                                                _permanentAddress
                                                                    .result[0]
                                                                    .country
                                                                    .toString() +
                                                                ', ',
                                                            maxLines: 5,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            // softWrap:
                                                            //     false,
                                                            style:
                                                            k16F87Black400HT,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ),
                                      ),
                                      _permanentAddress ==null?
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5)),
                                            textColor: Colors.white,
                                            color: Color(0xff3E66FB),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Text(
                                                // ignore: unrelated_type_equality_checks
                                                '+Add Address',
                                                style: k18Fwhite400BT,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => PermanentAdd()));
                                            },
                                          ),
                                        ],
                                      ) :
                                      SizedBox(),

                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CurrentAdd()));
                              },
                              child: Container(
                                width: 300,
                                child: Card(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Current Address',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'PoppinsLight',
                                            fontSize: 18),
                                      ),
                                      Divider(
                                        color: Colors.black54,
                                      ),
                                      Container(
                                        child: Image
                                            .asset(
                                          'assets/images/home.png',
                                          height:
                                          100,
                                          width:
                                          100,
                                        ),
                                      ),

                                      _temporaryAddress == null
                                          ? SizedBox()
                                          : Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12, right: 12),
                                          child: Container(
                                            child: ListView.builder(
                                                itemCount:
                                                _temporaryAddress.result.length,
                                                scrollDirection: Axis.vertical,
                                                physics: ScrollPhysics(),
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => CurrentAdd()
                                                                  // VehicleEditCard(
                                                                  //     data:
                                                                  //     _vehicleModelData,
                                                                  //     index:
                                                                  //     index)
                                                          ));
                                                    },
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                      children: [
                                                        _temporaryAddress.result[0].status
                                                            .toString() ==
                                                            "Pending"
                                                            ? Container(
                                                          width: 90,
                                                          //color: Colors.amber[600],
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xffFBE4BB),
                                                              borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(8))),
                                                          // color: Colors.blue[600],
                                                          alignment:
                                                          Alignment
                                                              .center,
                                                          child:
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.all(
                                                                6.0),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .hourglass_top_outlined,
                                                                  size:
                                                                  15,
                                                                  color:
                                                                  Color(0xffC47F00),
                                                                ),
                                                                Text(
                                                                  'PENDING',
                                                                  style: TextStyle(
                                                                      color: Color(0xffC47F00),
                                                                      fontWeight: FontWeight.bold,
                                                                      fontFamily: 'PoppinsLight',
                                                                      fontSize: 12),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                            : _temporaryAddress.result[0].status
                                                            .toString() ==
                                                            "Approved"
                                                            ? Container(
                                                          width: 90,
                                                          //color: Colors.amber[600],
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xffA7F3D0),
                                                              borderRadius:
                                                              BorderRadius.all(Radius.circular(8))),
                                                          // color: Colors.blue[600],
                                                          alignment:
                                                          Alignment
                                                              .center,
                                                          child:
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.all(6.0),
                                                            child:
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.check_circle,
                                                                  size: 14,
                                                                  color: Colors.green,
                                                                ),
                                                                Text(
                                                                  'Approved',
                                                                  style: TextStyle(color: Color(0xff059669), fontWeight: FontWeight.bold, fontFamily: 'PoppinsLight', fontSize: 12),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                            : _temporaryAddress.result[0].status.toString() ==
                                                            "Rejected"
                                                            ? Container(
                                                          width:
                                                          90,
                                                          //color: Colors.amber[600],
                                                          decoration: BoxDecoration(
                                                              color: Color(0xffFECACA),
                                                              borderRadius: BorderRadius.all(Radius.circular(8))),
                                                          // color: Colors.blue[600],
                                                          alignment:
                                                          Alignment.center,
                                                          child:
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.all(6.0),
                                                            child:
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.cancel,
                                                                  size: 15,
                                                                  color: Colors.red,
                                                                ),
                                                                Text(
                                                                  'Rejected',
                                                                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontFamily: 'PoppinsLight', fontSize: 12),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                            : Container(
                                                          width:
                                                          90,
                                                          //color: Colors.amber[600],
                                                          decoration: BoxDecoration(
                                                              color: Color(0xffFBE4BB),
                                                              borderRadius: BorderRadius.all(Radius.circular(8))),
                                                          // color: Colors.blue[600],
                                                          alignment:
                                                          Alignment.center,
                                                          child:
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.all(6.0),
                                                            child:
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.hourglass_top_outlined,
                                                                  size: 15,
                                                                  color: Color(0xffC47F00),
                                                                ),
                                                                Text(
                                                                  'PENDING',
                                                                  style: TextStyle(color: Color(0xffC47F00), fontWeight: FontWeight.bold, fontFamily: 'PoppinsLight', fontSize: 12),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        SizedBox(
                                                          width: 350,
                                                          child: Text(
                                                            _temporaryAddress
                                                                .result[0]
                                                                .house
                                                                .toString() +
                                                                ', ' +
                                                                _temporaryAddress
                                                                    .result[0]
                                                                    .area
                                                                    .toString() +
                                                                ', ' +
                                                                _temporaryAddress
                                                                    .result[0]
                                                                    .landmark
                                                                    .toString()+
                                                                ', ' +
                                                                _temporaryAddress
                                                                    .result[0]
                                                                    .city
                                                                    .toString() +
                                                                ', ' +
                                                                _temporaryAddress
                                                                    .result[0]
                                                                    .state
                                                                    .toString() +
                                                                ', ' +
                                                                _temporaryAddress
                                                                    .result[0]
                                                                    .country
                                                                    .toString() +
                                                                ', ',
                                                            maxLines: 5,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            // softWrap:
                                                            //     false,
                                                            style:
                                                            k16F87Black400HT,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ),
                                      ),
                                      _temporaryAddress ==null?
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5)),
                                            textColor: Colors.white,
                                            color: Color(0xff3E66FB),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Text(
                                                // ignore: unrelated_type_equality_checks
                                                '+Add Address',
                                                style: k18Fwhite400BT,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => CurrentAdd()));
                                            },
                                          ),
                                        ],
                                      ) : SizedBox(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OfficeAdd()));
                              },
                              child: Container(
                                width: 300,
                                child: Card(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Office Address',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'PoppinsLight',
                                            fontSize: 18),
                                      ),
                                      Divider(
                                        color: Colors.black54,
                                      ),
                                      Container(
                                        child: Image
                                            .asset(
                                          'assets/images/office.jpg',
                                          height:
                                          100,
                                          width:
                                          100,
                                        ),
                                      ),

                                      _officeAddress == null
                                          ? SizedBox()
                                          : Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12, right: 12),
                                          child: Container(
                                            child: ListView.builder(
                                                itemCount:
                                                _officeAddress.result.length,
                                                scrollDirection: Axis.vertical,
                                                physics: ScrollPhysics(),
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => OfficeAdd()
                                                                  // VehicleEditCard(
                                                                  //     data:
                                                                  //     _vehicleModelData,
                                                                  //     index:
                                                                  //     index)
                                                          ));
                                                    },
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                      children: [
                                                        _officeAddress.result[0].status
                                                            .toString() ==
                                                            "Pending"
                                                            ? Container(
                                                          width: 90,
                                                          //color: Colors.amber[600],
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xffFBE4BB),
                                                              borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(8))),
                                                          // color: Colors.blue[600],
                                                          alignment:
                                                          Alignment
                                                              .center,
                                                          child:
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.all(
                                                                6.0),
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .hourglass_top_outlined,
                                                                  size:
                                                                  15,
                                                                  color:
                                                                  Color(0xffC47F00),
                                                                ),
                                                                Text(
                                                                  'PENDING',
                                                                  style: TextStyle(
                                                                      color: Color(0xffC47F00),
                                                                      fontWeight: FontWeight.bold,
                                                                      fontFamily: 'PoppinsLight',
                                                                      fontSize: 12),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                            : _officeAddress.result[0].status
                                                            .toString() ==
                                                            "Approved"
                                                            ? Container(
                                                          width: 90,
                                                          //color: Colors.amber[600],
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xffA7F3D0),
                                                              borderRadius:
                                                              BorderRadius.all(Radius.circular(8))),
                                                          // color: Colors.blue[600],
                                                          alignment:
                                                          Alignment
                                                              .center,
                                                          child:
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.all(6.0),
                                                            child:
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.check_circle,
                                                                  size: 14,
                                                                  color: Colors.green,
                                                                ),
                                                                Text(
                                                                  'Approved',
                                                                  style: TextStyle(color: Color(0xff059669), fontWeight: FontWeight.bold, fontFamily: 'PoppinsLight', fontSize: 12),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                            : _officeAddress.result[0].status.toString() ==
                                                            "Rejected"
                                                            ? Container(
                                                          width:
                                                          90,
                                                          //color: Colors.amber[600],
                                                          decoration: BoxDecoration(
                                                              color: Color(0xffFECACA),
                                                              borderRadius: BorderRadius.all(Radius.circular(8))),
                                                          // color: Colors.blue[600],
                                                          alignment:
                                                          Alignment.center,
                                                          child:
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.all(6.0),
                                                            child:
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.cancel,
                                                                  size: 15,
                                                                  color: Colors.red,
                                                                ),
                                                                Text(
                                                                  'Rejected',
                                                                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontFamily: 'PoppinsLight', fontSize: 12),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                            : Container(
                                                          width:
                                                          90,
                                                          //color: Colors.amber[600],
                                                          decoration: BoxDecoration(
                                                              color: Color(0xffFBE4BB),
                                                              borderRadius: BorderRadius.all(Radius.circular(8))),
                                                          // color: Colors.blue[600],
                                                          alignment:
                                                          Alignment.center,
                                                          child:
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.all(6.0),
                                                            child:
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.hourglass_top_outlined,
                                                                  size: 15,
                                                                  color: Color(0xffC47F00),
                                                                ),
                                                                Text(
                                                                  'PENDING',
                                                                  style: TextStyle(color: Color(0xffC47F00), fontWeight: FontWeight.bold, fontFamily: 'PoppinsLight', fontSize: 12),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        SizedBox(
                                                          width: 350,
                                                          child: Text(
                                                            _officeAddress
                                                                .result[0]
                                                                .house
                                                                .toString() +
                                                                ', ' +
                                                                _officeAddress
                                                                    .result[0]
                                                                    .area
                                                                    .toString() +
                                                                ', ' +
                                                                _officeAddress
                                                                    .result[0]
                                                                    .landmark
                                                                    .toString()+
                                                                ', ' +
                                                                _officeAddress
                                                                    .result[0]
                                                                    .city
                                                                    .toString() +
                                                                ', ' +
                                                                _officeAddress
                                                                    .result[0]
                                                                    .state
                                                                    .toString() +
                                                                ', ' +
                                                                _officeAddress
                                                                    .result[0]
                                                                    .country
                                                                    .toString() +
                                                                ', ',
                                                            maxLines: 5,
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                            // softWrap:
                                                            //     false,
                                                            style:
                                                            k16F87Black400HT,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ),
                                      ),
                                      _officeAddress ==null?
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5)),
                                            textColor: Colors.white,
                                            color: Color(0xff3E66FB),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Text(
                                                // ignore: unrelated_type_equality_checks
                                                '+Add Address',
                                                style: k18Fwhite400BT,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => OfficeAdd()));
                                            },
                                          ),
                                        ],
                                      ) : SizedBox(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
