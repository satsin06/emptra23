import 'dart:convert';
import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/amplifyconfiguration.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/models/getListModel/getEmployeementModel.dart';
import 'package:flutter_emptra/models/getListModel/getHrDetails.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ExperienceEditCard extends StatefulWidget {
  var index;
  GetEmployeementHistoryModel data;

  ExperienceEditCard({this.data, this.index});

  @override
  _ExperienceEditCardState createState() => _ExperienceEditCardState();
}

class _ExperienceEditCardState extends State<ExperienceEditCard>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isAmplifyConfigured = false;
  String _uploadFileResult = '';
  String _getUrlResult = '';
  String _removeResult = '';
  bool editbutton = false;
  String name = "";
  bool changeButton = false;
  bool _checkbox = true;
  final maxLines = 4;
  TextEditingController _about = TextEditingController();
  int id = 1;
  DateTime initialDate = DateTime.utc(1970, 1, 1);
  TextEditingController _designation = TextEditingController();
  DateTime _selectedDate;
  DateTime _selectedTodate;
  TextEditingController _toDatecontroller = TextEditingController();
  TextEditingController _fromDatecontroller = TextEditingController();
  TextEditingController _website = TextEditingController();
  var list;
  var employeeId;
  List<String> industryAutosuggest = [];
  final companyAutoSuggestionname = TextEditingController();
  var isworking;
  bool loader = false;
  GetEmployeementHistoryModel _employmentHistoryData;
  GetHrDetails _hrDetailsData;
  final aboutController = TextEditingController();
  TextEditingController _companyName = TextEditingController();
  TextEditingController _hrName = TextEditingController();
  TextEditingController _hrEmail = TextEditingController();
  TextEditingController _hrPhone = TextEditingController();

  @override
  void initState() {
    super.initState();
    hello();
  }

  hello() async {
    _tabController = new TabController(length: 2, vsync: this);
    configureAmplify();
    await getHrDetails();
    await getEmploymentHistory();
  }

  getEmploymentHistory() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();
      var response = await dio.get(
        "${Api.employmentHistoryList}/$userId",
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
            _employmentHistoryData =
                GetEmployeementHistoryModel.fromJson(response.data);
            print(_employmentHistoryData);
            _companyName.text =
                widget.data.result[widget.index].employerName.toString();
            _about.text = widget.data.result[widget.index].about.toString();
            _designation.text =
                widget.data.result[widget.index].designation.toString();
            _website.text = widget.data.result[widget.index].website.toString();
            _fromDatecontroller.text =
                widget.data.result[widget.index].from.toString();
            _toDatecontroller.text =
                widget.data.result[widget.index].to.toString();
            print(widget.data.result[widget.index].about.toString());
            //   getEducationHistory();
          });
        } else {
          setState(() {
            _isLoading = false;
          });
          //     getEducationHistory();
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        //   getEducationHistory();
      }
    } catch (e) {
      print(e);
    }
  }

  getHrDetails() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();

      var response = await dio.get(
        "${Api.hrDetail}/$userId/$employeeId",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
          "versionnumber": "v1"
        }),
      );
      print(response.data);
      if (response.statusCode == 200) {
        print(response.data);
        if (response.data['code'] == 100) {
          setState(() {
            print("!!!!!");
            _hrDetailsData = GetHrDetails.fromJson(response.data);
            print(_hrDetailsData);
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
      return result.url.substring(0, result.url.indexOf('?'));
      //  return result.url;
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
      await upload();
      String url = await getUrl();
      print('_removeResult:' + _removeResult);
      await uploadDoc(url);
    } catch (e) {
      print('Remove Err: ' + e.toString());
    }
  }

  uploadDoc(String url) async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    var email = session.getString("email");
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });

    Map data = {
      "userId": userId,
      "organizationId": widget.data.result[widget.index].sId.toString(),
      "organizationName":
          widget.data.result[widget.index].employerName.toString(),
      "docType": "help",
      "docUrl": url,
      "uploadedStatus": "Success",
      "status": "Pending",
      "requestBy": email
    };
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
                  builder: (context) => BottomBarIndivitual(
                        index: 4,
                      )));
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

  _addEmployment({String id}) async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    var currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    setState(() {
      _isLoading = true;
    });

    var dio = Dio();
    Map data = {
      "userId": userId,
      "employerId": widget.data.result[widget.index].sId.toString(),
      "designation": _designation.text,
      "website": _website.text,
      "employerName": widget.data.result[widget.index].employerName.toString(),
      "from": _fromDatecontroller.text,
      "isWorking": _checkbox,
      "about": _about.text,
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
      getEmploymentHistory();

      if (response.data['code'] == 100) {
        //  success("Added Successfully");
        setState(() {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => BottomBarIndivitual()));
          _isLoading = false;
          getEmploymentHistory();
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

  _addHrDetails({String id}) async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    String email = session.getString("email");
    String firstName = session.getString("firstName");
    String lastName = session.getString("lastName");

    var currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    setState(() {
      _isLoading = true;
    });

    var dio = Dio();
    Map data = {
      "userId": userId,
      "userFirstName": firstName,
      "userLastName": lastName,
      "organizationId": id,
      "organizationName": _companyName.text,
      "hrName": _hrName.text,
      "hrEmail": _hrEmail.text,
      "hrNumber": _hrPhone.text,
      "status": "Pending",
      "requestBy": email,
      "uploadedStatus": "Pending"
    };
    // print(data);
    //print(jsonEncode(data));
    var response = await dio.post("${Api.addHr}",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
          "versionnumber": "v1"
        }),
        data: data);
    print(response.data);
    if (response.statusCode == 200) {
      getHrDetails();
      if (response.data['code'] == 100) {
        setState(() {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => BottomBarIndivitual()));
          _isLoading = false;
          getHrDetails();
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

  _deleteExperience({String id}) async {
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.delete(
      "${Api.deleteEmployement}/$id",
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
                          height: 1100,
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
                                    Navigator.pop(context);
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             BottomBarIndivitual()));
                                  },
                                ),
                              ),
                              // Center(
                              //   child: CircleAvatar(
                              //     backgroundColor: Colors.indigo,
                              //     radius: 70,
                              //     child: CircleAvatar(
                              //       backgroundImage:
                              //       AssetImage("assets/images/du.jpg"),
                              //       radius: 70,
                              //       backgroundColor: Colors.transparent,
                              //     ),
                              //   ),
                              // ),
                              CircleAvatar(
                                radius: 70,
                                backgroundImage:
                                    '${widget.data.result[widget.index].website}' ==
                                            ""
                                        ? AssetImage(
                                            "assets/images/experience.png")
                                        : NetworkImage(
                                            'https://logo.clearbit.com/' +
                                                '${widget.data.result[widget.index].website}'),
                                backgroundColor: Colors.transparent,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              '${widget.data.result[widget.index].status}' ==
                                      "Pending"
                                  ? Container(
                                      width: 90,
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
                                  : '${widget.data.result[widget.index].status}' ==
                                          "Approved"
                                      ? Container(
                                          //color: Colors.amber[600],
                                          decoration: BoxDecoration(
                                              color: Color(0xffA7F3D0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          'PoppinsLight',
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : '${widget.data.result[widget.index].status}' ==
                                              "Rejected"
                                          ? Container(
                                              //color: Colors.amber[600],
                                              decoration: BoxDecoration(
                                                  color: Color(0xffFECACA),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8))),
                                              // color: Colors.blue[600],
                                              alignment: Alignment.center,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.cancel,
                                                      size: 15,
                                                      color: Colors.red,
                                                    ),
                                                    Text(
                                                      'Rejected',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'PoppinsLight',
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                              TabBar(
                                unselectedLabelColor: Colors.black,
                                labelColor: Colors.red,
                                tabs: [
                                  Tab(
                                    child: Text(
                                      'General ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 13),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      'HR Details',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 13),
                                    ),
                                  ),
                                ],
                                controller: _tabController,
                                indicatorSize: TabBarIndicatorSize.tab,
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20,
                                          bottom: 10,
                                          right: 15,
                                          left: 15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 25),
                                          Text(
                                            'Organization',
                                            style: kForteenText,
                                          ),
                                          editbutton == false
                                              ? Text(
                                                  '${widget.data.result[widget.index].employerName}',
                                                  style: k20Text,
                                                )
                                              : TextFormField(
                                                  enabled: false,
                                                  controller: _companyName,
                                                  style: k22InputText,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    hintStyle: k22InputText,
                                                    hintText:
                                                        '${widget.data.result[widget.index].employerName}',
                                                  ),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return "Job title cannot be empty";
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (String name) {},
                                                  onChanged: (value) {
                                                    name = value;
                                                    setState(() {
                                                      editbutton = true;
                                                    });
                                                  },
                                                ),
                                          SizedBox(height: 15),
                                          Text(
                                            'Job title',
                                            style: kForteenText,
                                          ),
                                          editbutton == false
                                              ? Text(
                                                  '${widget.data.result[widget.index].designation}',
                                                  style: k20Text,
                                                )
                                              : TextFormField(
                                                  controller: _designation,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText:
                                                        '${widget.data.result[widget.index].designation}',
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
                                                ),
                                          SizedBox(height: 25),
                                          Text(
                                            'Website',
                                            style: kForteenText,
                                          ),
                                          editbutton == false
                                              ? Text(
                                                  '${widget.data.result[widget.index].website}',
                                                  style: k20Text,
                                                )
                                              : TextFormField(
                                                  controller: _website,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText:
                                                        '${widget.data.result[widget.index].website}',
                                                    hintStyle: k18F87Black400HT,
                                                  ),
                                                  style: k22InputText,
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return "Website cannot be empty";
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
                                          editbutton == false
                                              ? Text(
                                                  '${widget.data.result[widget.index].from.toString()}',
                                                  style: k20Text,
                                                )
                                              : GestureDetector(
                                                  onTap: () => _selectDate(),
                                                  child: AbsorbPointer(
                                                    child: TextField(
                                                      controller:
                                                          _fromDatecontroller,
                                                      style: k22InputText,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        hintText:
                                                            '${widget.data.result[widget.index].from.toString()}',
                                                        hintStyle:
                                                            k18F87Black400HT,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          SizedBox(height: 25),
                                          Text(
                                            'To',
                                            style: kForteenText,
                                          ),
                                          editbutton == false
                                              ? Text(
                                                  '${widget.data.result[widget.index].to}',
                                                  style: k20Text,
                                                )
                                              : GestureDetector(
                                                  onTap: () => _selectTodate(),
                                                  child: AbsorbPointer(
                                                    child: TextField(
                                                      controller:
                                                          _toDatecontroller,
                                                      style: k22InputText,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        hintText:
                                                            '${widget.data.result[widget.index].to}',
                                                        hintStyle:
                                                            k18F87Black400HT,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          SizedBox(height: 25),
                                          Text(
                                            'About the job',
                                            style: kForteenText,
                                          ),
                                          editbutton == false
                                              ? Text(
                                                  '${widget.data.result[widget.index].about.toString()}',
                                                  style: k20Text,
                                                )
                                              : TextFormField(
                                                  controller: _about,
                                                  style: k22InputText,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    hintStyle: k18F87Black400HT,
                                                    hintText:
                                                        '${widget.data.result[widget.index].about.toString()}',
                                                  ),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return "About title cannot be empty";
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (String name) {},
                                                  onChanged: (value) {
                                                    name = value;
                                                    setState(() {
                                                      editbutton = true;
                                                    });
                                                  },
                                                ),
                                          SizedBox(height: 15),
                                          editbutton == false
                                              ? FlatButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      editbutton = true;
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 12.0,
                                                            bottom: 12),
                                                    child: Text(
                                                      'Edit Details',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff3E66FB),
                                                          fontFamily:
                                                              'PoppinsLight',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                  textColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color:
                                                              Color(0xff3E66FB),
                                                          width: 1,
                                                          style: BorderStyle
                                                              .solid),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    RaisedButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                      textColor: Colors.white,
                                                      color: Color(0xffDC2626),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 12.0,
                                                                bottom: 12.0),
                                                        child: Text(
                                                          'Delete',
                                                          style: k13Fwhite400BT,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        _deleteExperience(
                                                          id: '${widget.data.result[widget.index].sId}',
                                                          //
                                                          // widget.empdata
                                                          // ["_id"]
                                                        );
                                                      },
                                                    ),
                                                    RaisedButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                      textColor: Colors.white,
                                                      color: Color(0xff3E66FB),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 12,
                                                                bottom: 12),
                                                        child: Text(
                                                          'Done',
                                                          style: k13Fwhite400BT,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        _addEmployment(
                                                          id: '${widget.data.result[widget.index].sId}',
                                                          //
                                                          // widget.empdata
                                                          // ["_id"]
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                          SizedBox(height: 15),
                                          editbutton == false
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    RaisedButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                      textColor: Colors.white,
                                                      color: Color(0xffDC2626),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 12.0,
                                                                bottom: 12.0),
                                                        child: Text(
                                                          'Delete',
                                                          style: k13Fwhite400BT,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        _deleteExperience(
                                                          id: '${widget.data.result[widget.index].sId}',
                                                          //
                                                          // widget.empdata
                                                          // ["_id"]
                                                        );
                                                      },
                                                    ),
                                                    '${widget.data.result[widget.index].docUrl}'==null?
                                                    RaisedButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                      textColor: Colors.white,
                                                      color: Color(0xff3E66FB),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 12.0,
                                                                bottom: 12.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .upload_outlined,
                                                              size: 20,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            SizedBox(
                                                                width: 5.0),
                                                            Text(
                                                              'Upload Document',
                                                              style:
                                                                  k13Fwhite400BT,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      onPressed:
                                                          uploadButtonTask,
                                                    ):SizedBox()
                                                  ],
                                                )
                                              : SizedBox(),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20,
                                          bottom: 10,
                                          right: 15,
                                          left: 15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Name',
                                            style: kForteenText,
                                          ),
                                          _hrDetailsData.result == null
                                              ? TextFormField(
                                                  controller: _hrName,
                                                  style: k22InputText,
                                                  decoration: InputDecoration(
                                                      isDense: true,
                                                      hintStyle:
                                                          k18F87Black400HT,
                                                      hintText: "hrName"),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return "hrName";
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (String name) {},
                                                  onChanged: (value) {
                                                    name = value;
                                                    setState(() {
                                                      editbutton = true;
                                                    });
                                                  },
                                                )
                                              : Text(
                                                  _hrDetailsData.result.hrName,
                                                  style: k20Text),
                                          SizedBox(height: 15),
                                          Text(
                                            'Email',
                                            style: kForteenText,
                                          ),
                                          _hrDetailsData.result == null
                                              ? TextFormField(
                                                  controller: _hrEmail,
                                                  style: k22InputText,
                                                  decoration: InputDecoration(
                                                      isDense: true,
                                                      hintStyle:
                                                          k18F87Black400HT,
                                                      hintText: "hrEmail"),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return "hrEmail";
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (String name) {},
                                                  onChanged: (value) {
                                                    name = value;
                                                    setState(() {
                                                      editbutton = true;
                                                    });
                                                  },
                                                )
                                              : Text(
                                                  _hrDetailsData.result.hrEmail,
                                                  style: k20Text),
                                          SizedBox(height: 15),
                                          Text(
                                            'Hr Phone Number',
                                            style: kForteenText,
                                          ),
                                          _hrDetailsData.result == null
                                              ? TextFormField(
                                                  controller: _hrPhone,
                                                  style: k22InputText,
                                                  decoration: InputDecoration(
                                                      isDense: true,
                                                      hintStyle:
                                                          k18F87Black400HT,
                                                      hintText: "hrPhone"),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return "hrPhone";
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (String name) {},
                                                  onChanged: (value) {
                                                    name = value;
                                                    setState(() {
                                                      editbutton = true;
                                                    });
                                                  },
                                                )
                                              : Text(
                                                  _hrDetailsData.result.hrNumber
                                                      .toString(),
                                                  style: k20Text),
                                          SizedBox(height: 15),
                                          _hrDetailsData.result == null
                                              ? SizedBox()
                                              : Text(
                                                  'Review Status',
                                                  style: kForteenText,
                                                ),
                                          _hrDetailsData.result == null
                                              ? SizedBox()
                                              : _hrDetailsData.result.status ==
                                                      "Pending"
                                                  ? Container(
                                                      width: 85,
                                                      //color: Colors.amber[600],
                                                      decoration: BoxDecoration(
                                                          color:
                                                              Color(0xffFBE4BB),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          8))),
                                                      // color: Colors.blue[600],
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
                                                                  fontSize: 12),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : _hrDetailsData
                                                              .result.status ==
                                                          "Approved"
                                                      ? Container(
                                                          width: 85,
                                                          //color: Colors.amber[600],
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xffA7F3D0),
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
                                                                      .check_circle,
                                                                  size: 14,
                                                                  color: Colors
                                                                      .green,
                                                                ),
                                                                Text(
                                                                  'Approved',
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xff059669),
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
                                                        )
                                                      : _hrDetailsData.result
                                                                  .status ==
                                                              "Rejected"
                                                          ? Container(
                                                              width: 85,
                                                              //color: Colors.amber[600],
                                                              decoration: BoxDecoration(
                                                                  color: Color(
                                                                      0xffFECACA),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              8))),
                                                              // color: Colors.blue[600],
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        6.0),
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
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                              'PoppinsLight',
                                                                          fontSize:
                                                                              12),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : SizedBox(),
                                          _hrDetailsData.result == null
                                              ? Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        RaisedButton(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          textColor:
                                                              Colors.white,
                                                          color:
                                                              Color(0xff3E66FB),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 12,
                                                                    bottom: 12),
                                                            child: Text(
                                                              'Submit',
                                                              style:
                                                                  k13Fwhite400BT,
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            _addHrDetails(
                                                              id: '${widget.data.result[widget.index].sId}',
                                                              //
                                                              // widget.empdata
                                                              // ["_id"]
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              : Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    FlatButton(
                                                      onPressed: () {
                                                        // setState(() {
                                                        //   editbutton = true;
                                                        // });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 12.0,
                                                                bottom: 12),
                                                        child: Text(
                                                          'Edit Details',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff3E66FB),
                                                              fontFamily:
                                                                  'PoppinsLight',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                      textColor: Colors.white,
                                                      shape: RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: Color(
                                                                  0xff3E66FB),
                                                              width: 1,
                                                              style: BorderStyle
                                                                  .solid),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        RaisedButton(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          textColor:
                                                              Colors.white,
                                                          color:
                                                              Color(0xffDC2626),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 12.0,
                                                                    bottom:
                                                                        12.0),
                                                            child: Text(
                                                              'Delete',
                                                              style:
                                                                  k13Fwhite400BT,
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            _deleteExperience(
                                                              id: '${widget.data.result[widget.index].sId}',

                                                              // widget.empdata
                                                              // ["_id"]
                                                            );
                                                          },
                                                        ),
                                                        RaisedButton(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          textColor:
                                                              Colors.white,
                                                          color:
                                                              Color(0xff3E66FB),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 12.0,
                                                                    bottom:
                                                                        12.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .upload_outlined,
                                                                  size: 20,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                SizedBox(
                                                                    width: 5.0),
                                                                Text(
                                                                  'Upload Document',
                                                                  style:
                                                                      k13Fwhite400BT,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          onPressed: () {},
                                                          // onPressed:
                                                          //     uploadButtonTask,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                        ],
                                      ),
                                    ),
                                  ],
                                  controller: _tabController,
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

  _selectDate() async {
    DateTime pickedDate = await showModalBottomSheet<DateTime>(
      context: context,
      builder: (context) {
        DateTime tempPickedDate = _selectedDate ?? DateTime.now();
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

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        initialDate = pickedDate;
        _selectedDate = pickedDate;
        _fromDatecontroller.text = pickedDate.toString();
      });
      _fromDatecontroller
        ..text = DateFormat('dd-MM-yyyy').format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _fromDatecontroller.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}
