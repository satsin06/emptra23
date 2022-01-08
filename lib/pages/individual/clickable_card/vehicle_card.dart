import 'dart:convert';
import 'dart:io';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/models/getListModel/getVehicleModel.dart';
import '../add/account/vehicle_add.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/vehiclecard_editable.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VehicleCard extends StatefulWidget {
  @override
  _VehicleCardState createState() => _VehicleCardState();
}

class _VehicleCardState extends State<VehicleCard> {
  String name = "";
  final maxLines = 4;
  int id = 1;
  GetVehicleModel _vehicleModelData;
  final aboutController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _isLoading = false;
  GlobalKey<AutoCompleteTextFieldState<String>> institutename = new GlobalKey();
  final companyAutoSuggestionname = TextEditingController();

  @override
  void initState() {
    super.initState();
    getVehicle();
  }

  getVehicle() async {
    try{
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    //   print("${Api.educationHistoryList}/$userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.get(
      "${Api.vehicleHistoryList}/$userId",
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
          _vehicleModelData = GetVehicleModel.fromJson(response.data);
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
  } catch(e){
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
                            SizedBox(height: 10),
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
                            SizedBox(height: 10,),
                            Text(
                              'Add Vehicles',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'PoppinsBold',
                                  height: 1.3,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 32),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VehicleAdd()));
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
                                        Icon(
                                          Icons.add,
                                          size: 50,
                                        ),
                                        Text(
                                          'Add Vehicle',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'PoppinsLight',
                                              fontSize: 18),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Add detail of the vehicles owned by you',
                                          style: kForteenText,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            _vehicleModelData == null
                                ? SizedBox()
                                // :  _vehicleModelData.result == null
                                // ? SizedBox()
                                : Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12, right: 12),
                                      child: Container(
                                        width: 200,
                                        child: ListView.builder(
                                            itemCount:
                                                _vehicleModelData.result.length,
                                            scrollDirection: Axis.vertical,
                                            physics: ScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              VehicleEditCard(
                                                                  data:
                                                                      _vehicleModelData,
                                                                  index:
                                                                      index)));
                                                },
                                                child: Container(
                                                  height: 210,
                                                  child: Card(
                                                    elevation: 1,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              17.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          _vehicleModelData
                                                                      .result[
                                                                          index]
                                                                      .vehicleCategory
                                                                      .toString() ==
                                                                  "Car"
                                                              ? Container(
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/carr.png',
                                                                    height: 60,
                                                                    width: 150,
                                                                  ),
                                                                )
                                                              : _vehicleModelData
                                                                          .result[
                                                                              index]
                                                                          .vehicleCategory
                                                                          .toString() ==
                                                                      "Bike"
                                                                  ? Container(
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/images/motorcycle.jpg',
                                                                        height:
                                                                            60,
                                                                        width:
                                                                            150,
                                                                      ),
                                                                    )
                                                                  : _vehicleModelData
                                                                              .result[
                                                                                  index]
                                                                              .vehicleCategory
                                                                              .toString() ==
                                                                          "Truck"
                                                                      ? Container(
                                                                          child:
                                                                              Image.asset(
                                                                            'assets/images/truck.jpg',
                                                                            height:
                                                                                60,
                                                                            width:
                                                                                150,
                                                                          ),
                                                                        )
                                                                      : _vehicleModelData.result[index].vehicleCategory.toString() ==
                                                                              "Bus"
                                                                          ? Container(
                                                                              child: Image.asset(
                                                                              'assets/images/bus.png',
                                                                              height: 60,
                                                                              width: 150,
                                                                            ))
                                                                          : _vehicleModelData.result[index].vehicleCategory.toString() == "Three Wheeler"
                                                                              ? Container(
                                                                                  child: Image.asset(
                                                                                    'assets/images/three-wheeler.png',
                                                                                    height: 60,
                                                                                    width: 150,
                                                                                  ),
                                                                                )
                                                                              : SizedBox(),
                                                          _vehicleModelData
                                                                      .result[
                                                                          index]
                                                                      .status
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
                                                              : _vehicleModelData
                                                                          .result[
                                                                              index]
                                                                          .status
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
                                                                  : _vehicleModelData
                                                                              .result[index]
                                                                              .status ==
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
                                                          Text(
                                                            _vehicleModelData
                                                                .result[index]
                                                                .selectBrand,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            maxLines: 1,
                                                            softWrap: false,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color:
                                                                    Colors.blue,
                                                                fontFamily:
                                                                    'PoppinsLight',
                                                                fontSize: 16),
                                                          ),
                                                          Text(
                                                            _vehicleModelData
                                                                .result[index]
                                                                .selectModel
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            maxLines: 1,
                                                            softWrap: false,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black87,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    'PoppinsLight',
                                                                fontSize: 16),
                                                          ),
                                                          Text(
                                                            _vehicleModelData
                                                                .result[index]
                                                                .carRegistrationState
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            maxLines: 1,
                                                            softWrap: false,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black87,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    'PoppinsLight',
                                                                fontSize: 16),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                  ),

                            SizedBox(height: 20),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     RaisedButton(
                            //       shape: RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.circular(5)),
                            //       textColor: Colors.white,
                            //       color: Color(0xff3E66FB),
                            //       child: Padding(
                            //         padding: const EdgeInsets.all(14.0),
                            //         child: Text(
                            //           'Next',
                            //           style: k13Fwhite400BT,
                            //         ),
                            //       ),
                            //       onPressed: () {
                            //         // addEducation();
                            //         Navigator.push(
                            //             context,
                            //             MaterialPageRoute(
                            //                 builder: (context) => BasicSkill()));
                            //         // if (_formkey.currentState.validate()) {
                            //         //   signup();
                            //         // }
                            //       },
                            //     ),
                            //   ],
                            // ),
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
