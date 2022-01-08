import 'dart:convert';
import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_emptra/amplifyconfiguration.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/models/getListModel/getEducationModel.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class EducationEditCard extends StatefulWidget {
  //final dynamic data;
  int index;
  GetEducationHistoryModel data;

  EducationEditCard({this.data, this.index});

  @override
  _EducationEditCardState createState() => _EducationEditCardState();
}

class _EducationEditCardState extends State<EducationEditCard> {
  String name = "";
  DateTime initialDate = DateTime.utc(1970, 1, 1);
  bool changeButton = false;
  bool _checkbox = true;
  final maxLines = 4;
  int id = 1;
  GetEducationHistoryModel _empdata;
  final aboutController = TextEditingController();
  TextEditingController _name = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String employementStatus;
  bool _isLoading = false;
  DateTime _selectedFromDate;
  DateTime _selectedTodate;
  TextEditingController _toDatecontroller = TextEditingController();
  TextEditingController _fromDatecontroller = TextEditingController();
  final cgpaText = TextEditingController();
  final companyAutoSuggestionname = TextEditingController();
  List<String> customerAutosuggest = [];
  var instituteName;
  TextEditingController _cgpaText = TextEditingController();
  bool editable = false;

  bool _isAmplifyConfigured = false;
  String _uploadFileResult = '';
  String _getUrlResult = '';
  String _removeResult = '';
  bool editbutton = false;
  TextEditingController _about = TextEditingController();
  TextEditingController _designation = TextEditingController();
  GetEducationHistoryModel _educationHistoryData;
  DateTime _selectedDate;
  List<String> industryAutosuggest = [];
  var isworking;
  bool loader = false;
  TextEditingController _instituteId = TextEditingController();
  TextEditingController _companyName = TextEditingController();

  @override
  void initState() {
    super.initState();
    hello();
  }

  hello() async {
    configureAmplify();
  }

  getEducationHistory() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();
      var response = await dio.get(
        "${Api.educationHistoryList}/$userId",
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
            print("!!!!!");
            _educationHistoryData =
                GetEducationHistoryModel.fromJson(response.data);
            print(_educationHistoryData);
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
    } catch (e) {
      print(e);
    }
  }

  _addEducation({String id}) async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    var currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    setState(() {
      _isLoading = true;
    });

    var dio = Dio();
    Map data = {
      "userId": userId,
      "employerId": _instituteId.toString(),
      "designation": _designation.text,
      "employerName": _companyName.text,
      "from": _fromDatecontroller.text,
      "isWorking": _checkbox,
      "to": _toDatecontroller.text == null || _toDatecontroller.text == ''
          ? currentDate
          : _toDatecontroller.text
    };
    print(data);
    print(jsonEncode(data));
    var response = await dio.put("${Api.updateEmployment}/$id",
        // ("${Api.addEmployment}",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
          "versionnumber": "v1"
        }),
        data: data);
    print(response.data);
    if (response.statusCode == 200) {
      getEducationHistory();

      if (response.data['code'] == 100) {
        //  success("Added Successfully");
        setState(() {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => BottomBarIndivitual()));
          _isLoading = false;
          getEducationHistory();
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
      final name =
          '${widget.data.result[widget.index].sId}' + pickResult.files[0].name;
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

  uploadDoc(String url) async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    String email = session.getString("email");
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });
    Map data = {
      "userId": userId.toString(),
      "organizationId": widget.data.result[widget.index].instituteId.toString(),
      "organizationName":
          widget.data.result[widget.index].instituteName.toString(),
      "docType": "employment",
      "docUrl": url.toString(),
      "uploadedStatus": "Success",
      "status": "Pending",
      "requestBy": email.toString()
    };

//  print(jsonEncode(data));
    // print(response.data);
    var response = await dio.post("${Api.uploaddoc}",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
          "versionnumber": "v1"
        }),
        data: data);
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      if (response.data['code'] == 100) {
        print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BottomBarIndivitual()));
        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BottomBarIndivitual()));
        //  success(response.data['message']);
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
      await uploadDoc(url);
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

  _deleteEducation({String id}) async {
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.delete(
      "${Api.deleteEducation}/$id",
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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BottomBarIndivitual()));
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
                          height: 800,
                          padding: new EdgeInsets.all(12.0),
                          child: Column(
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
                                    //             BottomBarIndivitual()));
                                  },
                                ),
                              ),
                              Center(
                                child: CircleAvatar(
                                  backgroundImage:
                                      '${widget.data.result[widget.index].website}' ==
                                              ""
                                          ? AssetImage(
                                              "assets/images/education.png")
                                          : NetworkImage(
                                              'https://logo.clearbit.com/' +
                                                  '${widget.data.result[widget.index].website}'),
                                  radius: 70,
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              SizedBox(height: 15),
                              editable == false
                                  ? Text(
                                      '${widget.data.result[widget.index].specialization}',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: 'PoppinsBold',
                                          fontSize: 24),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Text(
                                            'Study',
                                            style: kForteenText,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: TextFormField(
                                            controller: _name,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              hintText:
                                                  "Btech Computer Science",
                                              hintStyle: k18F87Black400HT,
                                            ),
                                            style: k22InputText,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return "Study cannot be empty";
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
                                      ],
                                    ),
                              editable == false
                                  ? Container(
                                      width: 80,
                                      //color: Colors.amber[600],
                                      decoration: BoxDecoration(
                                          color: Color(0xffFBE4BB),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      // color: Colors.blue[600],
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.hourglass_top_outlined,
                                              size: 15,
                                              color: Color(0xffC47F00),
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
                                  : Container(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, right: 15, left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 15),
                                    Text(
                                      'Institute Name',
                                      style: kForteenText,
                                    ),
                                    editable == false
                                        ? Text(
                                            '${widget.data.result[widget.index].instituteName}',
                                            style: k20Text)
                                        : TextFormField(
                                            controller: _instituteId,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              hintText: "Institute Name",
                                              hintStyle: k18F87Black400HT,
                                            ),
                                            style: k22InputText,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return "Institute name cannot be empty";
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
                                      'CGPA',
                                      style: kForteenText,
                                    ),
                                    editable == false
                                        ? Text(
                                            '${widget.data.result[widget.index].cgpa}',
                                            style: k20Text)
                                        : TextFormField(
                                            controller: _cgpaText,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              hintText: "100%",
                                              hintStyle: k18F87Black400HT,
                                            ),
                                            keyboardType: TextInputType.number,
                                            style: k22InputText,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return "CGPA cannot be empty";
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
                                      'From',
                                      style: kForteenText,
                                    ),
                                    editable == false
                                        ? Text(
                                            '${widget.data.result[widget.index].from}',
                                            style: k20Text)
                                        : GestureDetector(
                                            onTap: () => _selectFromdate(),
                                            child: AbsorbPointer(
                                              child: TextField(
                                                controller: _fromDatecontroller,
                                                style: k22InputText,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText: "Start Date",
                                                  hintStyle: k18F87Black400HT,
                                                ),
                                              ),
                                            ),
                                          ),
                                    SizedBox(height: 25),
                                    Text(
                                      'To',
                                      style: kForteenText,
                                    ),
                                    editable == false
                                        ? Text(
                                            '${widget.data.result[widget.index].to}',
                                            style: k20Text)
                                        : GestureDetector(
                                            onTap: () => _selectTodate(),
                                            child: AbsorbPointer(
                                              child: TextField(
                                                controller: _toDatecontroller,
                                                style: k22InputText,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText: "End Date",
                                                  hintStyle: k18F87Black400HT,
                                                ),
                                              ),
                                            ),
                                          ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    // _educationHistoryData== null
                                    //     ? Column(
                                    //   children: [
                                    //     SizedBox(
                                    //       height: 10,
                                    //     ),
                                    //     Row(
                                    //       mainAxisAlignment:
                                    //       MainAxisAlignment
                                    //           .spaceBetween,
                                    //       children: [
                                    //         RaisedButton(
                                    //           shape:
                                    //           RoundedRectangleBorder(
                                    //               borderRadius:
                                    //               BorderRadius
                                    //                   .circular(
                                    //                   5)),
                                    //           textColor: Colors.white,
                                    //           color: Color(0xff3E66FB),
                                    //           child: Padding(
                                    //             padding:
                                    //             const EdgeInsets
                                    //                 .only(
                                    //                 top: 12,
                                    //                 bottom: 12),
                                    //             child: Text(
                                    //               'Submit',
                                    //               style: k13Fwhite400BT,
                                    //             ),
                                    //           ),
                                    //           onPressed: () {
                                    //             _addEducation(
                                    //               id:  '${widget.data.result[widget.index]
                                    //                   .sId}',
                                    //               //
                                    //               // widget.empdata
                                    //               // ["_id"]
                                    //             );
                                    //           },
                                    //         ),
                                    //         RaisedButton(
                                    //           shape:
                                    //           RoundedRectangleBorder(
                                    //               borderRadius:
                                    //               BorderRadius
                                    //                   .circular(
                                    //                   5)),
                                    //           textColor: Colors.white,
                                    //           color: Color(0xffDC2626),
                                    //           child: Padding(
                                    //             padding:
                                    //             EdgeInsets.only(
                                    //                 top: 12.0,
                                    //                 bottom: 12.0),
                                    //             child: Text(
                                    //               'Delete Card',
                                    //               style: k13Fwhite400BT,
                                    //             ),
                                    //           ),
                                    //           onPressed: () {
                                    //             _deleteEducation(
                                    //               id:  '${widget.data.result[widget.index]
                                    //                   .sId}',
                                    //               //
                                    //               // widget.empdata
                                    //               // ["_id"]
                                    //             );
                                    //           },
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ],
                                    // )
                                    //     : Column(
                                    //   crossAxisAlignment:
                                    //   CrossAxisAlignment.start,
                                    //   children: [
                                    //     SizedBox(
                                    //       height: 20,
                                    //     ),
                                    //     FlatButton(
                                    //       onPressed: () {
                                    //         setState(() {
                                    //           editbutton = true;
                                    //         });
                                    //       },
                                    //       child: Padding(
                                    //         padding:
                                    //         const EdgeInsets
                                    //             .only(
                                    //             top: 12.0,
                                    //             bottom: 12),
                                    //         child: Text(
                                    //           'Edit Details',
                                    //           style: TextStyle(
                                    //               color: Color(
                                    //                   0xff3E66FB),
                                    //               fontFamily:
                                    //               'PoppinsLight',
                                    //               fontWeight:
                                    //               FontWeight
                                    //                   .w500,
                                    //               fontSize: 14),
                                    //         ),
                                    //       ),
                                    //       textColor: Colors.white,
                                    //       shape: RoundedRectangleBorder(
                                    //           side: BorderSide(
                                    //               color: Color(
                                    //                   0xff3E66FB),
                                    //               width: 1,
                                    //               style: BorderStyle
                                    //                   .solid),
                                    //           borderRadius:
                                    //           BorderRadius
                                    //               .circular(5)),
                                    //     ),
                                    //     SizedBox(
                                    //       height: 15,
                                    //     ),
                                    //     Row(
                                    //       mainAxisAlignment:
                                    //       MainAxisAlignment
                                    //           .spaceBetween,
                                    //       children: [
                                    //         RaisedButton(
                                    //           shape: RoundedRectangleBorder(
                                    //               borderRadius:
                                    //               BorderRadius
                                    //                   .circular(
                                    //                   5)),
                                    //           textColor:
                                    //           Colors.white,
                                    //           color:
                                    //           Color(0xffDC2626),
                                    //           child: Padding(
                                    //             padding:
                                    //             EdgeInsets.only(
                                    //                 top: 12.0,
                                    //                 bottom:
                                    //                 12.0),
                                    //             child: Text(
                                    //               'Delete Card',
                                    //               style:
                                    //               k13Fwhite400BT,
                                    //             ),
                                    //           ),
                                    //           onPressed: () {
                                    //             _deleteEducation(
                                    //               id:  '${widget.data.result[widget.index]
                                    //                   .sId}',
                                    //               //
                                    //               // widget.empdata
                                    //               // ["_id"]
                                    //             );
                                    //           },
                                    //         ),
                                    //         RaisedButton(
                                    //           shape: RoundedRectangleBorder(
                                    //               borderRadius:
                                    //               BorderRadius
                                    //                   .circular(
                                    //                   5)),
                                    //           textColor:
                                    //           Colors.white,
                                    //           color:
                                    //           Color(0xff3E66FB),
                                    //           child: Padding(
                                    //             padding:
                                    //             EdgeInsets.only(
                                    //                 top: 12.0,
                                    //                 bottom:
                                    //                 12.0),
                                    //             child: Row(
                                    //               mainAxisSize:
                                    //               MainAxisSize
                                    //                   .min,
                                    //               children: [
                                    //                 Icon(
                                    //                   Icons
                                    //                       .upload_outlined,
                                    //                   size: 20,
                                    //                   color: Colors
                                    //                       .white,
                                    //                 ),
                                    //                 SizedBox(
                                    //                     width: 5.0),
                                    //                 Text(
                                    //                   'Upload Document',
                                    //                   style:
                                    //                   k13Fwhite400BT,
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //           ),
                                    //           onPressed: () {
                                    //           },
                                    //           // onPressed:
                                    //           //     uploadButtonTask,
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(height: 15),
                                    // editbutton == false
                                    //     ? FlatButton(
                                    //   onPressed: () {
                                    //     setState(() {
                                    //       editbutton = true;
                                    //     });
                                    //   },
                                    //   child: Padding(
                                    //     padding:
                                    //     const EdgeInsets.only(
                                    //         top: 12.0,
                                    //         bottom: 12),
                                    //     child: Text(
                                    //       'Edit Details',
                                    //       style: TextStyle(
                                    //           color:
                                    //           Color(0xff3E66FB),
                                    //           fontFamily:
                                    //           'PoppinsLight',
                                    //           fontWeight:
                                    //           FontWeight.w500,
                                    //           fontSize: 14),
                                    //     ),
                                    //   ),
                                    //   textColor: Colors.white,
                                    //   shape: RoundedRectangleBorder(
                                    //       side: BorderSide(
                                    //           color:
                                    //           Color(0xff3E66FB),
                                    //           width: 1,
                                    //           style: BorderStyle
                                    //               .solid),
                                    //       borderRadius:
                                    //       BorderRadius.circular(
                                    //           5)),
                                    // )
                                    //     : Row(
                                    //   mainAxisAlignment:
                                    //   MainAxisAlignment
                                    //       .spaceBetween,
                                    //   children: [
                                    //     FlatButton(
                                    //       onPressed: () {
                                    //         setState(() {
                                    //           editbutton = false;
                                    //         });
                                    //       },
                                    //       child: Padding(
                                    //         padding:
                                    //         const EdgeInsets
                                    //             .only(
                                    //             top: 10.0,
                                    //             bottom: 10),
                                    //         child: Text(
                                    //           'Cancel',
                                    //           style: TextStyle(
                                    //               color: Color(
                                    //                   0xff3E66FB),
                                    //               fontFamily:
                                    //               'PoppinsLight',
                                    //               fontWeight:
                                    //               FontWeight
                                    //                   .w500,
                                    //               fontSize: 15),
                                    //         ),
                                    //       ),
                                    //       textColor: Colors.white,
                                    //       shape: RoundedRectangleBorder(
                                    //           side: BorderSide(
                                    //               color: Color(
                                    //                   0xff3E66FB),
                                    //               width: 1,
                                    //               style: BorderStyle
                                    //                   .solid),
                                    //           borderRadius:
                                    //           BorderRadius
                                    //               .circular(5)),
                                    //     ),
                                    //     RaisedButton(
                                    //       shape:
                                    //       RoundedRectangleBorder(
                                    //           borderRadius:
                                    //           BorderRadius
                                    //               .circular(
                                    //               5)),
                                    //       textColor: Colors.white,
                                    //       color: Color(0xff3E66FB),
                                    //       child: Padding(
                                    //         padding:
                                    //         const EdgeInsets
                                    //             .only(
                                    //             top: 12,
                                    //             bottom: 12),
                                    //         child: Text(
                                    //           'Done',
                                    //           style: k13Fwhite400BT,
                                    //         ),
                                    //       ),
                                    //       onPressed: () {
                                    //         _addEducation(
                                    //           id:  '${widget.data.result[widget.index]
                                    //               .sId}',
                                    //
                                    //         );
                                    //       },
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(height: 15),
                                    // editbutton == false
                                    //     ? Row(
                                    //   mainAxisAlignment:
                                    //   MainAxisAlignment
                                    //       .spaceBetween,
                                    //   children: [
                                    //     RaisedButton(
                                    //       shape:
                                    //       RoundedRectangleBorder(
                                    //           borderRadius:
                                    //           BorderRadius
                                    //               .circular(
                                    //               5)),
                                    //       textColor: Colors.white,
                                    //       color: Color(0xffDC2626),
                                    //       child: Padding(
                                    //         padding:
                                    //         EdgeInsets.only(
                                    //             top: 12.0,
                                    //             bottom: 12.0),
                                    //         child: Text(
                                    //           'Delete Card',
                                    //           style: k13Fwhite400BT,
                                    //         ),
                                    //       ),
                                    //       onPressed: () {
                                    //         _deleteEducation(
                                    //           id:  '${widget.data.result[widget.index]
                                    //               .sId}',
                                    //
                                    //         );
                                    //       },
                                    //     ),
                                    //     RaisedButton(
                                    //       shape:
                                    //       RoundedRectangleBorder(
                                    //           borderRadius:
                                    //           BorderRadius
                                    //               .circular(
                                    //               5)),
                                    //       textColor: Colors.white,
                                    //       color: Color(0xff3E66FB),
                                    //       child: Padding(
                                    //         padding:
                                    //         EdgeInsets.only(
                                    //             top: 12.0,
                                    //             bottom: 12.0),
                                    //         child: Row(
                                    //           mainAxisSize:
                                    //           MainAxisSize.min,
                                    //           children: [
                                    //             Icon(
                                    //               Icons
                                    //                   .upload_outlined,
                                    //               size: 20,
                                    //               color:
                                    //               Colors.white,
                                    //             ),
                                    //             SizedBox(
                                    //                 width: 5.0),
                                    //             Text(
                                    //               'Upload Document',
                                    //               style:
                                    //               k13Fwhite400BT,
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       ),
                                    //       onPressed:
                                    //       uploadButtonTask,
                                    //     ),
                                    //   ],
                                    // )
                                    //     : Center(
                                    //   child: RaisedButton(
                                    //     shape:
                                    //     RoundedRectangleBorder(
                                    //         borderRadius:
                                    //         BorderRadius
                                    //             .circular(
                                    //             5)),
                                    //     textColor: Colors.white,
                                    //     color: Color(0xffDC2626),
                                    //     child: Padding(
                                    //       padding: EdgeInsets.only(
                                    //           top: 12.0,
                                    //           bottom: 12.0),
                                    //       child: Text(
                                    //         'Delete Card',
                                    //         style: k13Fwhite400BT,
                                    //       ),
                                    //     ),
                                    //     onPressed: () {
                                    //       _deleteEducation(
                                    //         id:  '${widget.data.result[widget.index]
                                    //             .sId}',
                                    //         // widget.empdata
                                    //         // ["_id"]
                                    //       );
                                    //     },
                                    //   ),
                                    // )
                                    // Row(
                                    //   mainAxisAlignment:
                                    //   MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     RaisedButton(
                                    //       shape: RoundedRectangleBorder(
                                    //           borderRadius:
                                    //           BorderRadius.circular(5)),
                                    //       textColor: Colors.white,
                                    //       color: Color(0xffDC2626),
                                    //       child: Padding(
                                    //         padding: const EdgeInsets.only(
                                    //             top: 12.0, bottom: 12.0),
                                    //         child: Text(
                                    //           'Delete Card',
                                    //           style: k13Fwhite400BT,
                                    //         ),
                                    //       ),
                                    //       onPressed: () {
                                    //         _deleteSocial(
                                    //           id: '${widget.data.result[widget.index].id}',
                                    //         );
                                    //       },
                                    //     ),
                                    //
                                    //     RaisedButton(
                                    //       shape: RoundedRectangleBorder(
                                    //           borderRadius:
                                    //           BorderRadius.circular(
                                    //               5)),
                                    //       textColor: Colors.white,
                                    //       color: Color(0xff3E66FB),
                                    //       child: Padding(
                                    //         padding:
                                    //         const EdgeInsets.only(
                                    //             top: 10.0,
                                    //             bottom: 10.0),
                                    //         child: Row(
                                    //           mainAxisSize:
                                    //           MainAxisSize.min,
                                    //           children: [
                                    //             Icon(
                                    //               Icons.upload_outlined,
                                    //               size: 20,
                                    //               color: Colors.white,
                                    //             ),
                                    //             SizedBox(width: 5.0),
                                    //             Text(
                                    //               'Upload Document',
                                    //               style: k13Fwhite400BT,
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       ),
                                    //
                                    //       //     bool editable =false ;
                                    //       // editable =!editable
                                    //       // editable ==true ?
                                    //       //     textedition filed:text ;
                                    //       // onPressed: () {
                                    //       // },
                                    //       onPressed: uploadButtonTask,
                                    //     )
                                    //
                                    //   ],
                                    // )

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
                                            _deleteEducation(
                                              id: '${widget.data.result[widget.index].sId}',
                                            );
                                          },
                                        ),
                                        RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          textColor: Colors.white,
                                          color: Color(0xff3E66FB),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0, bottom: 10.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
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

                                          //     bool editable =false ;
                                          // editable =!editable
                                          // editable ==true ?
                                          //     textedition filed:text ;
                                          // onPressed: () {
                                          // },
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
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                    },
                    minimumDate: initialDate,
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
        ..text = DateFormat('dd-MM-yyyy').format(_selectedTodate)
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
        initialDate = pickedDate;
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

// Row(
//   mainAxisAlignment:
//       MainAxisAlignment.spaceBetween,
//   children: [
//     editable ==false ?FlatButton(
//       onPressed: () {
//         // setState(() {
//         //   editable =!editable;
//         // });
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     EducationEditableCard()));
//       },
//       child: Padding(
//         padding:
//         const EdgeInsets.only(
//             top: 15.0,
//             bottom: 15),
//         child: Text(
//           'Edit Profile',
//           style: TextStyle(
//               color:
//               Color(0xff3E66FB),
//               fontFamily:
//               'PoppinsLight',
//               fontWeight:
//               FontWeight.w500,
//               fontSize: 14),
//         ),
//       ),
//       textColor: Colors.white,
//       shape: RoundedRectangleBorder(
//           side: BorderSide(
//               color:
//               Color(0xff3E66FB),
//               width: 1,
//               style: BorderStyle
//                   .solid),
//           borderRadius:
//           BorderRadius.circular(
//               5)),
//     ):
//     FlatButton(
//       onPressed: () {
//         // setState(() {
//         //   editable =!editable;
//         // });
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     EducationEditCard()));
//       },
//       child: Padding(
//         padding:
//         const EdgeInsets.only(
//             top: 14.0,
//             bottom: 14.0),
//         child: Text(
//           'Done',
//           style: TextStyle(
//               color:
//               Color(0xff3E66FB),
//               fontFamily:
//               'PoppinsLight',
//               fontWeight:
//               FontWeight.w500,
//               fontSize: 14),
//         ),
//       ),
//       textColor: Colors.white,
//       shape: RoundedRectangleBorder(
//           side: BorderSide(
//               color:
//               Color(0xff3E66FB),
//               width: 1,
//               style: BorderStyle
//                   .solid),
//           borderRadius:
//           BorderRadius.circular(
//               5)),
//     ),
//
//     RaisedButton(
//       shape: RoundedRectangleBorder(
//           borderRadius:
//               BorderRadius.circular(5)),
//       textColor: Colors.white,
//       color: Color(0xff3E66FB),
//       child: Padding(
//         padding:
//         const EdgeInsets.only(
//             top: 14.0,
//             bottom: 14.0),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               Icons.upload_outlined,
//               size: 25,
//               color: Colors.white,
//             ),
//             SizedBox(width: 5.0),
//             Text(
//               'Upload Document',
//               style: k13Fwhite400BT,
//             ),
//           ],
//         ),
//       ),
//
//     //     bool editable =false ;
//     // editable =!editable
//     // editable ==true ?
//     //     textedition filed:text ;
//
//       onPressed: () {
//           //_openFileExplorer();
//       }
//     ),
//   ],
// ),
