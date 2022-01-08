import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/models/getListModel/getVehicleModel.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/vehicle_card.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter_emptra/amplifyconfiguration.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class VehicleEditCard extends StatefulWidget {
  VehicleEditCard({this.data, this.index});

  int index;
  GetVehicleModel data;

  @override
  _VehicleEditCardState createState() => _VehicleEditCardState();
}

class _VehicleEditCardState extends State<VehicleEditCard> {
  bool _isLoading = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isAmplifyConfigured = false;
  String _uploadFileResult = '';
  String _getUrlResult = '';
  String _removeResult = '';
  String name = "";
  GetVehicleModel _vehicleModelData;
  @override
  void initState() {
    super.initState();
    hello();
  }

  hello() async {
    configureAmplify();
    await getUrl();
    await getVehicle();
  }

  void configureAmplify() async {
    // First add plugins (Amplify native requirements)
    AmplifyStorageS3 storage = new AmplifyStorageS3();
    AmplifyAuthCognito auth = new AmplifyAuthCognito();
    Amplify.addPlugins([auth, storage]);
    try {
      // Configure
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print(
          'Amplify was already configured. Looks like app restarted on android.');
    }
    setState(() {
      _isAmplifyConfigured = true;
    });
  }

  void upload() async {
    try {
      print('In upload');
      final pickResult =
      await FilePicker.platform.pickFiles(allowCompression: true);
      // FilePickerResult? pickResult = await FilePicker.platform.pickFiles(type: FileType.image);

      if (pickResult == null) {
        print('User canceled upload.');
        return;
      }
      // final local = File(pickResult.files.single.path);
      final local = File(pickResult.files[0].path);
      final onprogress = File(pickResult.files[0].path);
      final name =
          '${widget.data.result[widget.index].id}' + pickResult.files[0].name;
      //  final extension = local.path.split('.').last.toLowerCase();
      final key = '$name';
      Map<String, String> metadata = <String, String>{};
      metadata['name'] = 'filename';
      metadata['desc'] = 'A test file';
      S3UploadFileOptions options = S3UploadFileOptions(
          accessLevel: StorageAccessLevel.guest, metadata: metadata);
      UploadFileResult result = await Amplify.Storage.uploadFile(
        key: key,
        local: local,
        options: options,
      );
      setState(() {
        _uploadFileResult = result.key;
      });
    } catch (e) {
      print('UploadFile Err: ' + e.toString());
    }
  }

  Future<String> getUrl() async {
    try {
      print('In getUrl');
      String key = _uploadFileResult;
      S3GetUrlOptions options = S3GetUrlOptions(
        accessLevel: StorageAccessLevel.guest,
        //expires: 10000
      );
      GetUrlResult result =
      await Amplify.Storage.getUrl(key: key, options: options);

      setState(() {
        _getUrlResult = result.url;
      });
      //return result.url.substring(0, result.url.indexOf('?'));
      return result.url;
    } catch (e) {
      print('GetUrl Err: ' + e.toString());
    }
  }

  void remove() async {
    try {
      print('In remove');
      String key = _uploadFileResult;
      RemoveOptions options =
      RemoveOptions(accessLevel: StorageAccessLevel.guest);
      RemoveResult result =
      await Amplify.Storage.remove(key: key, options: options);

      setState(() {
        _removeResult = result.key;
      });
      print('_removeResult:' + _removeResult);
    } catch (e) {
      print('Remove Err: ' + e.toString());
    }
  }

  void uploadButtonTask() async {
    try {
      _isAmplifyConfigured = true;
      await upload();
      String url = await getUrl();
      await uploaddoc(url);
    } catch (e) {
      print('Remove Err: ' + e.toString());
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

  getVehicle() async {
    try{
    SharedPreferences session = await SharedPreferences.getInstance();
    int userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.get(
      "${Api.vehicleList}/$userId",
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
          _vehicleModelData = GetVehicleModel.fromJson(response.data);
          print(_vehicleModelData);
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

  uploaddoc(String url) async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    var email = session.getString("email");
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });

    Map data = {
      "userId": userId.toInt(),
      "organizationId": widget.data.result[widget.index].id.toString(),
      "organizationName":"vehicleVerification",
      "docType": "vehicleVerification",
      "docUrl": url.toString(),
      "uploadedStatus": "Success",
      "status": "Pending",
      "requestBy": email.toString()
    };

    print(jsonEncode(data));
    var response = await dio.post("${Api.uploaddoc}",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
          "versionnumber": "v1"
        }),
        data: data);
    if (response.statusCode == 200) {
      if (response.data['code'] == 100) {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VehicleCard()));
          _isLoading = false;
        });
        //success(response.data['message']);
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

  _deleteVehicle({String id}) async {
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.delete(
      "${Api.deleteVehicle}/$id",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
    );
    print(response.data);
    if (response.statusCode == 200) {
      if (response.statusCode == 100) {
        success(response.data['message']);
        setState(() {
          _isLoading = false;
        });
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VehicleCard()
            ));
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
                    height:930,
                    padding: new EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                        widget.data.result[widget.index]
                            .vehicleCategory
                            .toString() ==
                            "Car"
                            ? Container(
                          child:
                          Image.asset(
                            'assets/images/carr.png',
                            height: 80,
                            width: 150,
                          ),
                        )
                            :  widget.data.result[widget.index].vehicleCategory
                            .toString() ==
                            "Bike"
                            ? Container(
                          child: Image
                              .asset(
                            'assets/images/motorcycle.jpg',
                            height: 80,
                            width: 150,
                          ),
                        )
                            : widget.data.result[widget.index].vehicleCategory
                            .toString() ==
                            "Truck"
                            ? Container(
                          child: Image
                              .asset(
                            'assets/images/truck.jpg',
                            height:
                            80,
                            width:
                            150,
                          ),
                        )
                            : widget.data.result[widget.index].vehicleCategory
                            .toString() ==
                            "Bus"
                            ? Container(
                            child: Image
                                .asset(
                              'assets/images/bus.png',
                              height:
                              80,
                              width:
                              150,
                            ))
                            : widget.data.result[widget.index].vehicleCategory.toString() ==
                            "Three Wheeler"
                            ? Container(
                          child: Image.asset(
                            'assets/images/three-wheeler.png',
                            height: 80,
                            width: 150,
                          ),
                        )
                            : SizedBox(),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 10, right: 15, left: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Brand',
                                style: kForteenText,
                              ),
                              Text(
                                '${widget.data.result[widget.index].selectBrand}',
                                style: k20Text,
                              ),
                              SizedBox(height: 20,),
                              Text(
                                'Model',
                                style: kForteenText,
                              ),
                              Text(
                                '${widget.data.result[widget.index].selectModel}',
                                style: k20Text,
                              ),
                              SizedBox(height: 20,),
                              Text(
                                'Variant',
                                style: kForteenText,
                              ),
                              Text(
                                '${widget.data.result[widget.index].variant}',
                                style: k20Text,
                              ),
                              SizedBox(height: 20,),
                              Text(
                                'Transmission type',
                                style: kForteenText,
                              ),
                              Text(
                                '${widget.data.result[widget.index].transmissionType}',
                                style: k20Text,
                              ),
                              SizedBox(height: 20,),
                              Text(
                                'Vehicle Type',
                                style: kForteenText,
                              ),
                              Text(
                                '${widget.data.result[widget.index].vehicleType}',
                                style: k20Text,
                              ),
                              SizedBox(height: 20,),
                              Text(
                                'Registration State',
                                style: kForteenText,
                              ),
                              Text(
                                '${widget.data.result[widget.index].carRegistrationState}',
                                style: k20Text,
                              ),
                              SizedBox(height: 20,),
                              Text(
                                'RTO Code',
                                style: kForteenText,
                              ),
                              Text(
                                '${widget.data.result[widget.index].selectCarSRtoCode}',
                                style: k20Text,
                              ),
                              SizedBox(height: 20,),
                              Text(
                                'Registration Year',
                                style: kForteenText,
                              ),
                              Text(
                                '${widget.data.result[widget.index].registrationYear}',
                                style: k20Text,
                              ),
                              SizedBox(height: 20,),
                              Text(
                                'RC No',
                                style: kForteenText,
                              ),
                              Text(
                                '${widget.data.result[widget.index].rcNo}',
                                style: k20Text,
                              ),
                              SizedBox(height: 20,),
                              Text(
                                'Chassis No',
                                style: kForteenText,
                              ),
                              Text(
                                '${widget.data.result[widget.index].chassis}',
                                style: k20Text,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(5)),
                                    textColor: Colors.white,
                                    color: Color(0xffDC2626),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12.0, bottom: 12.0),
                                      child: Text(
                                        'Delete',
                                        style: k13Fwhite400BT,
                                      ),
                                    ),
                                    onPressed: () {
                                      _deleteVehicle(
                                        id: '${widget.data.result[widget.index].id}',
                                      );
                                    },
                                  ),

                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(
                                            5)),
                                    textColor: Colors.white,
                                    color: Color(0xff3E66FB),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          top: 10.0,
                                          bottom: 10.0),
                                      child: Row(
                                        mainAxisSize:
                                        MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.upload_outlined,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 5.0),
                                          Text(
                                            'Upload Document',
                                            style: k13Fwhite400BT,
                                          ),
                                        ],
                                      ),
                                    ),
                                    onPressed: uploadButtonTask,
                                  )
                                ],
                              ),
                            ],
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
