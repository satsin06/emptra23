import 'dart:convert';
import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/amplifyconfiguration.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/models/getListModel/getProfileinfoModel.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ProfileEditCard extends StatefulWidget {
  @override
  _ProfileEditCardState createState() => _ProfileEditCardState();
}

class _ProfileEditCardState extends State<ProfileEditCard>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  String radioButtonItem = 'one';
  int id = 1;
  String url = '';
  String _gender;
  String name = "";
  var list;
  var _profilePic;
  var employeeId;
  var employeeName;
  bool employementStatus = false;
  BestTutorSite _site = BestTutorSite.private;
  bool _isLoading = false;
  DateTime initialDate = DateTime.utc(1970, 1, 1);
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  List<String> industryAutosuggest = [];
  final companyAutoSuggestionname = TextEditingController();
  DateTime _selectedTodate;
  GetPersonalInfoHistoryModel _personalInfoHistoryData;
  GlobalKey<AutoCompleteTextFieldState<String>> addIndustryForm =
  new GlobalKey();

  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _dob = TextEditingController();
  TextEditingController _webSite = TextEditingController();
  TextEditingController _about = TextEditingController();

  TextEditingController _profile = TextEditingController();
  TextEditingController _ctc = TextEditingController();
  TextEditingController _facebook = TextEditingController();
  TextEditingController _twitter = TextEditingController();
  TextEditingController _linkedIn = TextEditingController();
  TextEditingController _instagram = TextEditingController();

  bool _isAmplifyConfigured = false;
  String _uploadFileResult = '';
  String _getUrlResult = '';
  String _removeResult = '';
  final aboutController = TextEditingController();

  @override
  void initState() {
    super.initState();
    hello();
  }

  hello() async {
    _tabController = new TabController(length: 3, vsync: this);
    configureAmplify();
    await getProfile();
    await getCustomerName();
  }

  getCustomerName() async {
    print("2232");
    SharedPreferences session = await SharedPreferences.getInstance();
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });

    var response = await dio.get(
      Api.industryList,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
    );
    print(response.data);
    list = (response.data['result'][0]['industries']);
    print(list);
    for (int i = 0; i < list.length; i++) {
      industryAutosuggest.add(list[i]['industryName']);
      setState(() {
        _isLoading = false;
      });
      print(industryAutosuggest);
    }
  }

  getProfile() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.get(
      "${Api.profileInfo}/$userId",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
    );
    if (response.statusCode == 200) {
      print(response.data);
      if (response.data['code'] == 100) {
        String firstName =
        response.data['result']['personalInfo']['personal']['firstName'];
        session.setString("firstName", firstName);
        String lastName =
        response.data['result']['personalInfo']['personal']['lastName'];
        session.setString("lastName", lastName);
        String etKey = response.data['result']['etKey'];
        session.setString("etKey", etKey);
        setState(() {
          _isLoading = false;
          print("!!!!!");
          _personalInfoHistoryData =
              GetPersonalInfoHistoryModel.fromJson(response.data);
          print(_personalInfoHistoryData);
          _profilePic =
          _personalInfoHistoryData
              .result.personalInfo.personal.profilePicture ==
              ""
              ? 'https://emptradocs.s3.ap-south-1.amazonaws.com/529893-user.jpg'
              : _personalInfoHistoryData
              .result.personalInfo.personal.profilePicture
              .toString();
          _firstName.text = _personalInfoHistoryData
              .result.personalInfo.personal.firstName ==
              ""
              ? ""
              : _personalInfoHistoryData.result.personalInfo.personal.firstName
              .toString();
          _lastName.text = _personalInfoHistoryData
              .result.personalInfo.personal.lastName ==
              ""
              ? ""
              : _personalInfoHistoryData.result.personalInfo.personal.lastName
              .toString();
          _dob.text =
          _personalInfoHistoryData.result.personalInfo.personal.dob == ""
              ? ""
              : _personalInfoHistoryData.result.personalInfo.personal.dob
              .toString();
          _webSite.text = _personalInfoHistoryData
              .result.personalInfo.personal.website ==
              ""
              ? ""
              : _personalInfoHistoryData.result.personalInfo.personal.website
              .toString();

          employeeName = _personalInfoHistoryData
              .result.personalInfo.personal.industryName ==
              ""
              ? ""
              : _personalInfoHistoryData
              .result.personalInfo.personal.industryName
              .toString();

          employeeId = _personalInfoHistoryData
              .result.personalInfo.personal.industryId ==0
              ? ""
              : _personalInfoHistoryData.result.personalInfo.personal.industryId
              .toString();
          _gender =
          _personalInfoHistoryData.result.personalInfo.personal.gender ==""
              ? ""
              : _personalInfoHistoryData.result.personalInfo.personal.gender
              .toString();
          _about.text =
          _personalInfoHistoryData.result.personalInfo.personal.about ==""
              ? ""
              : _personalInfoHistoryData.result.personalInfo.personal.about
              .toString();
          _profile.text = _personalInfoHistoryData
              .result.personalInfo.professional.occupation ==""
              ? ""
              : _personalInfoHistoryData
              .result.personalInfo.professional.occupation
              .toString();
          _ctc.text = _personalInfoHistoryData
              .result.personalInfo.professional.ctc ==
              ""
              ? ""
              : _personalInfoHistoryData.result.personalInfo.professional.ctc
              .toString();
          _facebook.text =
          _personalInfoHistoryData.result.personalInfo.social.facebook ==
              ""
              ? ""
              : _personalInfoHistoryData.result.personalInfo.social.facebook
              .toString();
          _twitter.text =
          _personalInfoHistoryData.result.personalInfo.social.twitter ==
              ""
              ? ""
              : _personalInfoHistoryData.result.personalInfo.social.twitter
              .toString();
          _linkedIn.text =
          _personalInfoHistoryData.result.personalInfo.social.linkedin ==
              ""
              ? ""
              : _personalInfoHistoryData.result.personalInfo.social.linkedin
              .toString();
          _instagram.text = _personalInfoHistoryData
              .result.personalInfo.social.instagram ==
              ""
              ? ""
              : _personalInfoHistoryData.result.personalInfo.social.instagram
              .toString();
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

  // Future<void> createAndUploadFile() async {
  //   // Create a dummy file
  //   final exampleString = 'Example file contents';
  //   final tempDir = await getTemporaryDirectory();
  //   final exampleFile = File(tempDir.path + '/example.txt')
  //     ..createSync()
  //     ..writeAsStringSync(exampleString);
  //
  //   // Upload the file to S3
  //   try {
  //     final UploadFileResult result = await Amplify.Storage.uploadFile(
  //         local: exampleFile,
  //         key: 'ExampleKey',
  //         onProgress: (progress) {
  //           print("Fraction completed: " + progress.getFractionCompleted().toString());
  //         }
  //     );
  //     print('Successfully uploaded file: ${result.key}');
  //   } on StorageException catch (e) {
  //     print('Error uploading file: $e');
  //   }
  // }

  Future<String> upload() async {
    try {
      final pickResult = await FilePicker.platform.pickFiles(type: FileType.image);
      if (pickResult == null) {
        print('User canceled upload.');
        // return;
      }
      final name = pickResult.files[0].name;
      final fileInstance = File(pickResult.files[0].path);
      final result = await Amplify.Storage.uploadFile(
          key: name,
          local: fileInstance);
      return _uploadFileResult = result.key;
    } catch (e) {
      print('UploadFile Err: ');
    }
  }
  Future<String> getUrl() async {
    try {
      String key = _uploadFileResult;
      final result = await  Amplify.Storage.getUrl(
        key: key,
      );
      return  result.url;
    } catch (e) {
      print('UploadFile Err: ');
    }
  }

  // Future<String> getUrl() async {
  //   try {
  //     print('In getUrl');
  //     String key = _uploadFileResult;
  //     S3GetUrlOptions options = S3GetUrlOptions(
  //         accessLevel: StorageAccessLevel.guest, expires: 604798
  //     );
  //     GetUrlResult result =
  //         await Amplify.Storage.getUrl(key: key, options: options);
  //
  //     setState(() {
  //       _getUrlResult = result.url;
  //     });
  //     return result.url;
  //     print(url);
  //   } catch (e) {
  //     print('GetUrl Err: ' + e.toString());
  //   }
  // }


  // void upload() async {
  //   try {
  //     print('In upload');
  //     // final pickResult =
  //     //     await FilePicker.platform.pickFiles(allowCompression: true);
  //     final pickResult =
  //         await FilePicker.platform.pickFiles(type: FileType.image);
  //     if (pickResult == null) {
  //       print('User canceled upload.');
  //       return;
  //     }
  //     final local = File(pickResult.files[0].path);
  //     final name = pickResult.files[0].name;
  //     final key = '$name';
  //     Map<String, String> metadata = <String, String>{};
  //     metadata['name'] = 'filename';
  //     metadata['desc'] = 'A test file';
  //     S3UploadFileOptions options = S3UploadFileOptions(
  //         accessLevel: StorageAccessLevel.guest, metadata: metadata);
  //     UploadFileResult result = await Amplify.Storage.uploadFile(
  //         key: key,
  //         local: local,
  //         options: options,
  //         onProgress: (progress) {
  //           showDialog(
  //             context: context,
  //             builder: (context) {
  //               return Dialog(
  //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //                 elevation: 16,
  //                 child: Container(
  //                   height: 120,
  //                   child: Center(
  //                     child: Column(
  //                       children: [
  //                         SizedBox(height: 20,),
  //                         CircularProgressIndicator(),
  //                         SizedBox(height: 10,),
  //                         Text(
  //                             "PROGRESS: "+ progress.getFractionCompleted().toString(),
  //                             style: k16F87Black600HT
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             },
  //           );
  //          // print("PROGRESS: " + progress.getFractionCompleted().toString());
  //         });
  //     setState(() {
  //       _uploadFileResult = result.key;
  //     });
  //   } catch (e) {
  //     print('UploadFile Err: ' + e.toString());
  //   }
  // }

  // onProgress: (progress) {
  // showDialog(
  // context: context,
  // builder: (context) {
  // return Dialog(
  // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  // elevation: 16,
  // child: Container(
  // height: 120,
  // child: Center(
  // child: Column(
  // children: [
  // SizedBox(height: 20,),
  // CircularProgressIndicator(),
  // SizedBox(height: 10,),
  // Text(
  // "PROGRESS: "+ progress.getFractionCompleted().toString(),
  // style: k16F87Black600HT
  // ),
  // ],
  // ),
  // ),
  // ),
  // );
  // },
  // );
  // // print("PROGRESS: " + progress.getFractionCompleted().toString());
  // });

  // Future<String> getUrl() async {
  //   try {
  //     print('In getUrl');
  //     String key = _uploadFileResult;
  //     S3GetUrlOptions options = S3GetUrlOptions(
  //         accessLevel: StorageAccessLevel.guest, expires: 604798
  //     );
  //     GetUrlResult result =
  //         await Amplify.Storage.getUrl(key: key, options: options);
  //
  //     setState(() {
  //       _getUrlResult = result.url;
  //     });
  //     return result.url;
  //     print(url);
  //   } catch (e) {
  //     print('GetUrl Err: ' + e.toString());
  //   }
  // }

  // Future<String> getUrl() async {
  //   try {
  //     final GetUrlResult result =
  //     await Amplify.Storage.getUrl(key: 'ExampleKey');
  //     // NOTE: This code is only for demonstration
  //     // Your debug console may truncate the printed url string
  //     print('Got URL: ${result.url}');
  //   } on StorageException catch (e) {
  //     print('Error getting download URL: $e');
  //   }
  // }

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
      if (_formkey.currentState.validate()) {
        await updateProfilePhoto(url);
      }
    } catch (e) {
      print('Remove Err: ' + e.toString());
    }
  }

  setcustcode(vale) {
    print(vale);
    for (int i = 0; i < list.length; i++) {
      if (list[i]['industryName'] == vale) {
        setState(() {
          employeeId = list[i]['industryId'];
          employeeName = vale;
        });
        print(list[i]['industryId']);
      }
    }
  }

  _updateProfile({String url}) async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var email = session.getString("email");
    var userId = session.getInt("userId");
    var mobileno = session.getString("mobile_no");
    var industryName = session.getString("industryName");
    var industryId = session.getInt("industryId");
    var gender = session.getString("gender");
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });
    //  "profilePicture": url ==null ? "https://emptradocs.s3.ap-south-1.amazonaws.com/529893-user.jpg".toString():url,
    Map data = {
      "section": "personalInfo",
      "action": "update",
      "personalInfo": {
        "personal": {
          "firstName": _firstName.text.isEmpty == true ? "" : _firstName.text,
          "lastName": _lastName.text.isEmpty == true ? "" : _lastName.text,
          "dob": _dob.text.isEmpty == true ? "" : _dob.text,
          "email": email,
          "mobile_no": mobileno,
          "gender":
          _gender.toString().isEmpty == true ? gender : _gender.toString(),
          "industryId": employeeId == "" ? industryId : employeeId,
          "industryName": employeeName.toString().isEmpty == true ? ""
              : employeeName.toString(),
          "isMarried": employementStatus.toString().isEmpty == true
              ? ""
              : employementStatus,
          "about": _about.text.isEmpty == true ? "" : _about.text,
          "website": _webSite.text.isEmpty == true ? "" : _webSite.text,
          "profilePicture": url == "" ? "" : url,
          // "https://emptradocs.s3.ap-south-1.amazonaws.com/529893-user.jpg",
        },
        "professional": {
          "occupation": _profile.text.isEmpty == true ? "" : _profile.text,
          "ctc": _ctc.text.isEmpty == true ? "" : _ctc.text,
        },
        "social": {
          "facebook": _facebook.text.isEmpty == true ? "" : _facebook.text,
          "twitter": _twitter.text.isEmpty == true ? "" : _twitter.text,
          "linkedin": _linkedIn.text.isEmpty == true ? "" : _linkedIn.text,
          "instagram": _instagram.text.isEmpty == true ? "" : _instagram.text,
        }
      }
    };
    print(jsonEncode(data));
    var response = await dio.put(
      "${Api.updateProfile}/$userId",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
      data: data,
    );

    if (response.statusCode == 200) {
      // print(response.data);
      // print(response.data['code']);
      if (response.data['code'] == 100) {
        print(response.data);
        setState(() {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => BottomBarIndivitual()));
          _isLoading = false;
        });
        // alertbox(response.data['message']);
      } else {
        setState(() {
          _isLoading = false;
        });
        success(response.data['message']);
      }
      // int etid=session.getInt("etId");
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  updateProfilePhoto(String url) async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var email = session.getString("email");
    var userId = session.getInt("userId");
    var mobileno = session.getString("mobile_no");
    var industryName = session.getString("industryName");
    var industryId = session.getInt("industryId");
    var gender = session.getString("gender");
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });
    //  "profilePicture": url ==null ? "https://emptradocs.s3.ap-south-1.amazonaws.com/529893-user.jpg".toString():url,
    Map data = {
      "section": "personalInfo",
      "action": "update",
      "personalInfo": {
        "personal": {
          "firstName": _firstName.text.isEmpty == true ? "" : _firstName.text,
          "lastName": _lastName.text.isEmpty == true ? "" : _lastName.text,
          "dob": _dob.text.isEmpty == true ? "" : _dob.text,
          "email": email,
          "mobile_no": mobileno,
          "gender":
          _gender.toString().isEmpty == true ? gender : _gender.toString(),
          "industryId": employeeId == null ? industryId : employeeId,
          "industryName": employeeName.toString() == null
              ? industryName
              : employeeName.toString(),
          "isMarried": employementStatus.toString().isEmpty == true
              ? null
              : employementStatus,
          "about": _about.text.isEmpty == true ? null : _about.text,
          "website": _webSite.text.isEmpty == true ? null : _webSite.text,
          "profilePicture": url,
          // "https://emptradocs.s3.ap-south-1.amazonaws.com/529893-user.jpg",
        },
        "professional": {
          "occupation": _profile.text.isEmpty == true ? null : _profile.text,
          "ctc": _ctc.text.isEmpty == true ? null : _ctc.text,
        },
        "social": {
          "facebook": _facebook.text.isEmpty == true ? null : _facebook.text,
          "twitter": _twitter.text.isEmpty == true ? null : _twitter.text,
          "linkedin": _linkedIn.text.isEmpty == true ? null : _linkedIn.text,
          "instagram": _instagram.text.isEmpty == true ? null : _instagram.text,
        }
      }
    };
    print(jsonEncode(data));
    var response = await dio.put(
      "${Api.updateProfile}/$userId",
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
        "versionnumber": "v1"
      }),
      data: data,
    );

    if (response.statusCode == 200) {
      // print(response.data);
      // print(response.data['code']);
      if (response.data['code'] == 100) {
        print(response.data);
        setState(() {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => BottomBarIndivitual()));
          _isLoading = false;
        });
        // alertbox(response.data['message']);
      } else {
        setState(() {
          _isLoading = false;
        });
        success(response.data['message']);
      }
      // int etid=session.getInt("etId");
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
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                      ),
                      Card(
                        elevation: 1,
                        child: Container(
                          width: double.infinity,
                          height: 1250,
                          padding: new EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
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
                                    //             BottomBarIndivitual()));
                                  },
                                ),
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                      _personalInfoHistoryData==null?AssetImage(
                                        'assets/images/user.jpg', // and width here
                                      ):
                                      _personalInfoHistoryData
                                          .result
                                          .personalInfo
                                          .personal
                                          .profilePicture ==
                                          "" ||
                                          _personalInfoHistoryData
                                              .result
                                              .personalInfo
                                              .personal
                                              .profilePicture ==
                                              null
                                          ? AssetImage(
                                        'assets/images/user.jpg', // and width here
                                      )
                                          : NetworkImage(
                                          _personalInfoHistoryData
                                              .result
                                              .personalInfo
                                              .personal
                                              .profilePicture),
                                      radius: 70,
                                      backgroundColor: Colors.transparent,
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.edit_outlined,
                                      ),
                                      iconSize: 35,
                                      color: Colors.black, onPressed: () {},
                                      // splashColor: Colors.purple,
                                      //onPressed: uploadButtonTask,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                                width: 400,
                              ),
                              TabBar(
                                unselectedLabelColor: Colors.black,
                                labelColor: Colors.red,
                                tabs: [
                                  Tab(
                                    child: Text(
                                      'Personal',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 13),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      'Contact',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45,
                                          fontFamily: 'PoppinsLight',
                                          fontSize: 13),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      'Social',
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
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'First Name',
                                            style: kForteenText,
                                          ),
                                          TextFormField(
                                            controller: _firstName,
                                            style: k22InputText,
                                            decoration: InputDecoration(
                                                isDense: true,
                                                hintStyle:
                                                k18F87Black400HT,
                                                hintText: 'FirstName'),
                                            validator: (value) {
                                              if (value.length > 15) {
                                                return "First Name length should be atleast 15 words";
                                              }
                                              return null;
                                            },
                                            onSaved: (String name) {},
                                            onChanged: (value) {
                                              name = value;
                                              setState(() {});
                                            },
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'Last Name',
                                            style: kForteenText,
                                          ),
                                          TextFormField(
                                            controller: _lastName,
                                            style: k22InputText,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              hintStyle: k18F87Black400HT,
                                              hintText: 'LastName',
                                            ),
                                            validator: (value) {
                                              if (value.length > 15) {
                                                return "Last Name length should be atleast 15 words";
                                              }
                                              return null;
                                            },
                                            onSaved: (String name) {},
                                            onChanged: (value) {
                                              name = value;
                                              setState(() {});
                                            },
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'Date Of Birth',
                                            style: kForteenText,
                                          ),
                                          GestureDetector(
                                            onTap: () => _selectTodate(),
                                            child: AbsorbPointer(
                                              child: TextField(
                                                controller: _dob,
                                                style: k22InputText,
                                                decoration:
                                                InputDecoration(
                                                  isDense: true,
                                                  hintText: 'DOB',
                                                  hintStyle:
                                                  k18F87Black400HT,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'gender',
                                            style: kForteenText,
                                          ),
                                          DropdownButton(
                                            hint: _gender == null
                                                ? Text(_personalInfoHistoryData==null?'':
                                            _personalInfoHistoryData
                                                .result
                                                .personalInfo
                                                .personal
                                                .gender
                                                .toString(),
                                              style:
                                              k18F87Black400HT,
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
                                                return DropdownMenuItem<
                                                    String>(
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
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'Marital Status',
                                            style: kForteenText,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: <Widget>[
                                              Radio(
                                                value: 1,
                                                groupValue: id,
                                                onChanged: (val) {
                                                  setState(() {
                                                    radioButtonItem =
                                                    'TWO';
                                                    id = 1;
                                                    employementStatus =
                                                    false;
                                                    print(
                                                        employementStatus);
                                                  });
                                                },
                                              ),
                                              Text(
                                                'No',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontFamily:
                                                    'PoppinsLight',
                                                    fontSize: 12),
                                              ),
                                              Radio(
                                                value: 2,
                                                groupValue: id,
                                                onChanged: (val) {
                                                  setState(() {
                                                    radioButtonItem =
                                                    'One';
                                                    id = 2;
                                                    employementStatus =
                                                    true;
                                                    print(
                                                        employementStatus);
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Yes',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontFamily:
                                                    'PoppinsLight',
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'Website',
                                            style: kForteenText,
                                          ),
                                          TextFormField(
                                            controller: _webSite,
                                            style: k22InputText,
                                            decoration: InputDecoration(
                                                isDense: true,
                                                hintStyle:
                                                k18F87Black400HT,
                                                hintText: 'website'),
                                            validator: (value) {
                                              if (value.length > 50) {
                                                return "Website length should be atleast 50 words";
                                              }
                                              return null;
                                            },
                                            onSaved: (String name) {},
                                            onChanged: (value) {
                                              name = value;
                                              setState(() {});
                                            },
                                          ),
                                          SizedBox(height: 15),
                                          Text(
                                            'Industry',
                                            style: kForteenText,
                                          ),
                                          SimpleAutoCompleteTextField(
                                              key: addIndustryForm,
                                              style: k22InputText,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                hintText:
                                                _personalInfoHistoryData
                                                    .result
                                                    .personalInfo
                                                    .personal
                                                    .industryName
                                                    .toString(),
                                                hintStyle: k22InputText,
                                              ),
                                              controller:
                                              companyAutoSuggestionname,
                                              suggestions:
                                              industryAutosuggest,
                                              textChanged: (text) => this
                                                  .companyAutoSuggestionname
                                                  .text,
                                              clearOnSubmit: false,
                                              textSubmitted: (text) =>
                                                  setcustcode(
                                                    this
                                                        .companyAutoSuggestionname
                                                        .text,
                                                  )),
                                          SizedBox(height: 15),
                                          Text(
                                            'about',
                                            style: kForteenText,
                                          ),
                                          TextFormField(
                                            controller: _about,
                                            style: k22InputText,
                                            decoration: InputDecoration(
                                                isDense: true,
                                                hintStyle:
                                                k18F87Black400HT,
                                                hintText: 'about'),
                                            validator: (value) {
                                              if (value.length > 50) {
                                                return "about length should be atleast 50 words";
                                              }
                                              return null;
                                            },
                                            onSaved: (String name) {},
                                            onChanged: (value) {
                                              name = value;
                                              setState(() {});
                                            },
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          cancelDoneButton(),
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
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'Profile ',
                                            style: kForteenText,
                                          ),
                                          TextFormField(
                                            controller: _profile,
                                            style: k22InputText,
                                            decoration: InputDecoration(
                                                isDense: true,
                                                hintStyle:
                                                k18F87Black400HT,
                                                hintText: 'Profile'),
                                            validator: (value) {
                                              if (value.length > 30) {
                                                return "Profile length should be atleast 30 words";
                                              }
                                              return null;
                                            },
                                            onSaved: (String name) {},
                                            onChanged: (value) {
                                              name = value;
                                              setState(() {});
                                            },
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'CTC',
                                            style: kForteenText,
                                          ),
                                          TextFormField(
                                            controller: _ctc,
                                            style: k22InputText,
                                            decoration: InputDecoration(
                                                isDense: true,
                                                hintStyle:
                                                k18F87Black400HT,
                                                hintText: 'CTC'),
                                            validator: (value) {
                                              if (value.length > 30) {
                                                return "CTC length should be atleast 30 words";
                                              }
                                              return null;
                                            },
                                            onSaved: (String name) {},
                                            onChanged: (value) {
                                              name = value;
                                              setState(() {});
                                            },
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          cancelDoneButton(),
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
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'Facebook',
                                            style: kForteenText,
                                          ),
                                          TextFormField(
                                            controller: _facebook,
                                            style: k22InputText,
                                            decoration: InputDecoration(
                                                isDense: true,
                                                hintStyle:
                                                k18F87Black400HT,
                                                hintText:
                                                'www.facebook.com'),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'Twitter',
                                            style: kForteenText,
                                          ),
                                          TextFormField(
                                            controller: _twitter,
                                            style: k22InputText,
                                            decoration: InputDecoration(
                                                isDense: true,
                                                hintStyle:
                                                k18F87Black400HT,
                                                hintText:
                                                'www.twitter.com'),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'LinkedIn',
                                            style: kForteenText,
                                          ),
                                          TextFormField(
                                            controller: _linkedIn,
                                            style: k22InputText,
                                            decoration: InputDecoration(
                                                isDense: true,
                                                hintStyle:
                                                k18F87Black400HT,
                                                hintText:
                                                'www.linkedIn.com'),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            'Instagram',
                                            style: kForteenText,
                                          ),
                                          TextFormField(
                                            controller: _instagram,
                                            style: k22InputText,
                                            decoration: InputDecoration(
                                                isDense: true,
                                                hintStyle:
                                                k18F87Black400HT,
                                                hintText:
                                                'www.instagram.com'),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          cancelDoneButton(),
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
            )));
  }

  cancelDoneButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RaisedButton(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            textColor: Colors.white,
            color: Color(0xff3E66FB),
            child: Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: Text(
                'Done',
                style: k13Fwhite400BT,
              ),
            ),
            //onPressed: uploadButtonTask,

            onPressed: () {
              _updateProfile(url: url);
            }),
      ],
    );
  }

  radioButton() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            children: <Widget>[
              ListTile(
                title: const Text('Yes'),
                leading: Radio(
                  value: BestTutorSite.private,
                  groupValue: _site,
                  onChanged: (BestTutorSite value) {
                    setState(() {
                      print(_site);
                      _site = value;
                      employementStatus = true;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('No'),
                leading: Radio(
                  value: BestTutorSite.goverment,
                  groupValue: _site,
                  onChanged: (BestTutorSite value) {
                    setState(() {
                      _site = value;
                      print(_site);
                      employementStatus = false;
                    });
                  },
                ),
              ),
            ],
          );
        });
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
        _dob.text = pickedDate.toString();
      });
      _dob
        ..text = DateFormat('dd-MM-yyyy').format(_selectedTodate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _dob.text.length, affinity: TextAffinity.upstream));
    }
  }
}

enum BestTutorSite { private, goverment, both }
