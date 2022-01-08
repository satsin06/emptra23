import 'dart:convert';
import 'dart:io';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/models/getListModel/getEducationModel.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/vehicle_card.dart';
import 'package:flutter_emptra/pages/individual/registration/indivitual_registration/basicskill.dart';
import 'package:flutter_emptra/pages/individual/registration/indivitual_registration/employmenthistory.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


class VehicleAdd extends StatefulWidget {
  @override
  _VehicleAddState createState() => _VehicleAddState();
}

class _VehicleAddState extends State<VehicleAdd> {
//  int etId = 764502;
//  String etId = "764502";
  String name = "";
  DateTime  initialDate= DateTime.utc(1970, 1, 1);
  final aboutController = TextEditingController();
  String _vehicleBrand;
  String _vehicleCategory;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  DateTime _selectedFromDate;
  TextEditingController _fromDatecontroller = TextEditingController();
  TextEditingController _selectModel = TextEditingController();
  TextEditingController _selectRcode = TextEditingController();
  TextEditingController _vehicleType = TextEditingController();
  TextEditingController _variantType = TextEditingController();
  TextEditingController _rcState = TextEditingController();
  TextEditingController _rcNo = TextEditingController();
  TextEditingController _transmissionType = TextEditingController();
  TextEditingController _chassisNo = TextEditingController();




  addVehicle() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });


    Map data =
    {
      "userId": userId,
      "vehicleCategory": _vehicleCategory.toString(),
      "selectBrand": _vehicleBrand.toString(),
      "selectModel": _selectModel.text,
      "vehicleType": _vehicleType.text,
      "registrationYear":_fromDatecontroller.text,
      "transmissionType": _transmissionType.text,
      "variant": _variantType.text,
      "carRegistrationState": _rcState.text,
      "selectCarSRtoCode": _selectRcode.text,
      "rcNo": _rcNo.text,
      "chassis": _chassisNo.text
    };

    print("${Api.addVehicle}/$userId");
    print(jsonEncode(data));
    var response = await dio.post("${Api.addVehicle}",
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
              MaterialPageRoute(builder: (BuildContext context) => VehicleCard()));
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
                                      VehicleCard()
                              ));
                        },
                      ),
                    ),
                    Text(
                      'Vehicle Add',
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'PoppinsBold',
                          height: 1.3,
                          fontWeight: FontWeight.w600,
                          fontSize: 32),
                    ),

                    Text(
                      'Please tell us about your vehicles Details',
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'PoppinsLight',
                          fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Vehicle Category',
                      style: kForteenText,
                    ),
                    DropdownButton(
                      hint: _vehicleCategory == null
                          ? Text(
                        'Vehicle Category',
                        style: k18F87Black400HT,
                      )
                          : Text(
                        _vehicleCategory,
                      ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: k22InputText,
                      items: [
                        'Car',
                        'Bike',
                        'Bus',
                        'Truck',
                        'Three Wheeler',
                      ].map(
                            (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                              () {
                                _vehicleCategory = val;
                          },
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Select Your Vehicle Brand',
                      style: kForteenText,
                    ),
                    DropdownButton(
                      hint: _vehicleBrand == null
                          ? Text(
                        'Vehicle Brand',
                        style: k18F87Black400HT,
                      )
                          : Text(
                        _vehicleBrand,
                      ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style: k22InputText,
                      items: [
                        'Kia', 'Jaguar', 'Rolls-Royce', 'Volvo', 'Porsche', 'Lamborghini', 'Jeep', 'Land Rover', 'MG', 'Maruti Suzuki', 'Hyundai', 'Honda', 'Tata', 'Toyota', 'Chevrolet', 'Ford', 'Mahindra', 'Scoda', 'Volkswagen', 'Nissan', 'Renault', 'Fiat', 'Mercedes-Benz', 'Audi', 'BMW', 'Tesla', 'Lexus', 'Ferrari', 'Bugatti', 'MINI', 'Citroen', 'Bentley', 'Mean Metal Motors', 'Maserati', 'Isuzu', 'Mitsubishi', 'Datsun', 'McLaren', 'Force Motors', 'Aston Martin', 'Haval'
                      ].map(
                            (val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                              () {
                            _vehicleBrand = val;
                          },
                        );
                      },
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Select Model',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _selectModel,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "Model",
                        hintStyle: k18F87Black400HT,
                      ),
                      style: k22InputText,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Model cannot be empty";
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
                      'Vehicle Type',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _vehicleType,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "Vehicle Type",
                        hintStyle: k18F87Black400HT,
                      ),
                      style: k22InputText,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Vehicle Type can't be empty";
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
                      'Variant',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _variantType,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "Variant",
                        hintStyle: k18F87Black400HT,
                      ),
                      style: k22InputText,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Variant can't be empty";
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
                      'Vehicle Registration State',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _rcState,
                      style: k22InputText,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "Vehicle Registration State",
                        hintStyle: k18F87Black400HT,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Vehicle Registration State can't be empty";
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
                      'Select vehicle\'s RTO Code',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _selectRcode,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "RTO Code",
                        hintStyle: k18F87Black400HT,
                      ),
                      style: k22InputText,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "RTO Code can't be empty";
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
                      'Registration year',
                      style: kForteenText,
                    ),
                    GestureDetector(
                      onTap: () => _selectFromdate(),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: _fromDatecontroller,
                          style: k22InputText,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: "2021",
                            hintStyle: k18F87Black400HT,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "year can't be empty";
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
                    ),
                    SizedBox(height: 25),
                    Text(
                      'RC No',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _rcNo,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "RC No",
                        hintStyle: k18F87Black400HT,
                      ),
                      style: k22InputText,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "RC No can't be empty";
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
                      'Transmission type',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _transmissionType,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "Transmission type",
                        hintStyle: k18F87Black400HT,
                      ),
                      style: k22InputText,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Transmission type can't be empty";
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
                      'Chassis No',
                      style: kForteenText,
                    ),
                    TextFormField(
                      controller: _chassisNo,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "Chassis No",
                        hintStyle: k18F87Black400HT,
                      ),
                      style: k22InputText,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Chassis No type can't be empty";
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
                              'Submit',
                              style: k13Fwhite400BT,
                            ),
                          ),
                          onPressed: () {
                            if (_formkey.currentState.validate()) {
                              addVehicle();
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
                    minimumDate: DateTime.utc(1979, 11, 9),
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
        initialDate=pickedDate;
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
