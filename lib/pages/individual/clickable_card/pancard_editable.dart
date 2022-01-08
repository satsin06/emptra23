import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/models/getListModel/getPenDetail.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/adhar_webUrl.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/pan_webUrl.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'dart:io';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter_emptra/amplifyconfiguration.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PenCardEdit extends StatefulWidget {
  @override
  _PenCardEditState createState() => _PenCardEditState();
}

class _PenCardEditState extends State<PenCardEdit> {
  DateTime _selectedFromDate;
  String name = "";
  DateTime  initialDate= DateTime.utc(1970, 1, 1);
  TextEditingController _fromDatecontroller = TextEditingController();
  bool _isLoading = false;
  TextEditingController _name = TextEditingController();
  String _gender;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _dropDownValue;
  bool _isAmplifyConfigured = false;
  String _uploadFileResult = '';
  String _getUrlResult = '';
  String _removeResult = '';
  final aboutController = TextEditingController();
  GetPenCardDetail _getPenCardDetail;


  @override
  void initState() {
    super.initState();
    hello();
  }

  hello() async {
    await configureAmplify();
    await getPanDetail();
  }

  getPanDetail() async {
    try{
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.get(
      "${Api.getPenDetails}/$userId/PANCR",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
    );
    if (response.statusCode == 200) {
      if (response.data['code'] == 100) {
        setState(() {
          _getPenCardDetail = GetPenCardDetail.fromJson(response.data);
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
  }
    catch(e){
      print(e);
    }
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
      final name = pickResult.files[0].name;
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

  addPen(String url) async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    var email = session.getString("email");
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });


    Map data = {
      "userId": userId,
      "organizationId": "2",
      "organizationName": "PAN Card",
      "userName": _name.text ,
      "dob": _fromDatecontroller.text,
      "gender": _gender,
      "docType": "PANCR",
      "docUrl": url,
      "uploadedStatus": "Success",
      "status": "Pending",
      "requestBy":email
    };
    print(jsonEncode(data));
    var response = await dio.post("${Api.addGovermentDoc}",
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
            MaterialPageRoute(builder: (context) => BottomBarIndivitual(index: 1,)));
        setState(() {
          _isLoading = false;
        });
        success(response.data['message']);
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

  void uploadButtonTask() async {
    try {
      await upload();
      String url = await getUrl();
      print('_removeResult:' + _removeResult);
      await addPen(url);
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

  auto() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });
    Map data = {"userId": userId, "docType": "PANCR"};
    print(jsonEncode(data));
    var response = await dio.post("${Api.digiLocker}",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
          "versionnumber": "v1"
        }),
        data: data);
    print(response.data);
    if (response.statusCode == 200) {
      if (response.data['code'] == 103) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PanWebUrl(),
            ));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Card(
                elevation: 1,
                child: Container(
                    height: 700,
                    padding: new EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                              Navigator.pop(context);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             BottomBarIndivitual(index: 1,)));
                            },
                          ),
                        ),
                        CircleAvatar(
                          radius: 50,
                          child: CircleAvatar(
                            backgroundImage:
                            AssetImage("assets/images/pan.png"),
                            radius: 50,
                          ),
                        ),
                        Text(
                          'Pen Card',
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'PoppinsBold',
                              fontSize: 24),
                        ),
                        _getPenCardDetail == null
                            ? Container(
                          width: 80,
                          //color: Colors.amber[600],
                          decoration: BoxDecoration(
                              color:
                              Color(
                                  0xffFBE4BB),
                              borderRadius: BorderRadius
                                  .all(Radius
                                  .circular(
                                  8))),
                          // color: Colors.blue[600],
                          alignment:
                          Alignment.center,
                          child: Padding(
                            padding:
                            const EdgeInsets
                                .all(6.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons
                                      .hourglass_top_outlined,
                                  size: 15,
                                  color: Color(
                                      0xffC47F00),
                                ),
                                Text(
                                  'PENDING',
                                  style: TextStyle(
                                      color: Color(
                                          0xffC47F00),
                                      fontWeight:
                                      FontWeight
                                          .bold,
                                      fontFamily:
                                      'PoppinsLight',
                                      fontSize:
                                      12),
                                ),
                              ],
                            ),
                          ),
                        ):
                        _getPenCardDetail.result.status.toString() == "Approved"
                            ? Container(
                          width: 90,
                          //color: Colors.amber[600],
                          decoration: BoxDecoration(
                              color: Color(0xffA7F3D0),
                              borderRadius:
                              BorderRadius.all(Radius.circular(8))),
                          // color: Colors.blue[600],
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 14,
                                  color: Colors.green,
                                ),
                                Text(
                                  'Approved',
                                  style: TextStyle(
                                      color: Color(0xff059669),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'PoppinsLight',
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ):
                        _getPenCardDetail.result.status.toString() == "Rejected"
                            ?  Container(
                          //color: Colors.amber[600],
                          decoration: BoxDecoration(
                              color: Color(
                                  0xffFECACA),
                              borderRadius: BorderRadius
                                  .all(Radius
                                  .circular(
                                  8))),
                          // color: Colors.blue[600],
                          alignment:
                          Alignment.center,
                          child: Padding(
                            padding:
                            const EdgeInsets
                                .all(6.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons
                                      .cancel,
                                  size: 15,
                                  color: Colors
                                      .red,
                                ),
                                Text(
                                  'Rejected',
                                  style: TextStyle(
                                      color: Colors
                                          .red,
                                      fontWeight:
                                      FontWeight
                                          .bold,
                                      fontFamily:
                                      'PoppinsLight',
                                      fontSize:
                                      12),
                                ),
                              ],
                            ),
                          ),
                        ):
                        Container(
                          width: 80,
                          //color: Colors.amber[600],
                          decoration: BoxDecoration(
                              color:
                              Color(
                                  0xffFBE4BB),
                              borderRadius: BorderRadius
                                  .all(Radius
                                  .circular(
                                  8))),
                          // color: Colors.blue[600],
                          alignment:
                          Alignment.center,
                          child: Padding(
                            padding:
                            const EdgeInsets
                                .all(6.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons
                                      .hourglass_top_outlined,
                                  size: 15,
                                  color: Color(
                                      0xffC47F00),
                                ),
                                Text(
                                  'PENDING',
                                  style: TextStyle(
                                      color: Color(
                                          0xffC47F00),
                                      fontWeight:
                                      FontWeight
                                          .bold,
                                      fontFamily:
                                      'PoppinsLight',
                                      fontSize:
                                      12),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Stack(
                          children: <Widget>[
                            _getPenCardDetail==null? Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Image(
                                image:
                                AssetImage('assets/images/pan_card.png'),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                alignment: Alignment.center,
                              ),
                            ):
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Image(
                                image:
                                AssetImage('assets/images/pan_cardd.png'),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                alignment: Alignment.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15,right: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 85),
                                  Text(
                                    'Name',
                                    style: kForteenText,
                                  ),
                                _getPenCardDetail==null?
                                  TextFormField(
                                    controller: _name,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: "Name",
                                      hintStyle: k18F87Black400HT,
                                    ),
                                    style: k22InputText,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Name cannot be empty";
                                      }
                                      return null;
                                    },
                                    onSaved: (String name) {},
                                    onChanged: (value) {
                                      name = value;
                                      setState(() {});
                                    },
                                  ):
                                  Text(
                                    _getPenCardDetail
                                        .result.userName,
                                    style: k20Text,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'DOB',
                                    style: kForteenText,
                                  ),
                                  _getPenCardDetail==null? GestureDetector(
                                    onTap: () => _selectFromdate(),
                                    child: AbsorbPointer(
                                      child: TextField(
                                        controller: _fromDatecontroller,
                                        style: k22InputText,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintText: "DOB",
                                          hintStyle: k18F87Black400HT,
                                        ),
                                      ),
                                    ),
                                  ):
                                  Text(
                                    _getPenCardDetail
                                        .result.dob,
                                    style: k20Text,
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    'Gender',
                                    style: kForteenText,
                                  ),
                                  _getPenCardDetail==null? DropdownButton(
                                    hint: _gender == null
                                        ? Text(
                                      'Gender',
                                      style: k18F87Black400HT,
                                    )
                                        : Text(
                                      _gender,
                                    ),
                                    isExpanded: true,
                                    iconSize: 30.0,
                                    style: k22InputText,
                                    items: [
                                      'Male',
                                      'Female',
                                      'Other',
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
                                          _gender = val;
                                        },
                                      );
                                    },
                                  ):
                                  Text(
                                    _getPenCardDetail
                                        .result.gender,
                                    style: k20Text,
                                  ),
                                  SizedBox(height: 10),
                                  _getPenCardDetail == null
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
                                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.upload_outlined,
                                                size: 15,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                'Upload Document',
                                                style: k13Fwhite400BT,
                                              ),
                                            ],
                                          ),
                                        ),
                                        onPressed: uploadButtonTask,
                                      ),
                                      _getPenCardDetail == null
                                          ? RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                5)),
                                        textColor:
                                        Colors.white,
                                        color: Color(
                                            0xff6840FD),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets
                                              .only(
                                              top: 10,
                                              bottom:
                                              10),
                                          child: Text(
                                            'Connect digilocker',
                                            style:
                                            k13Fwhite400BT,
                                          ),
                                        ),
                                        onPressed: () {
                                          auto();
                                        },
                                      )
                                          : SizedBox(),
                                    ],
                                  ):SizedBox(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )))
          ],
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
