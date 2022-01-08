import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/models/getListModel/getCourseModel.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter_emptra/amplifyconfiguration.dart';
import 'package:dio/dio.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoursesEditCard extends StatefulWidget {

  CoursesEditCard({this.data,this.index});
  int index;
  GetCourseHistoryModel data;

  @override
  _CoursesEditCardState createState() => _CoursesEditCardState();
}

class _CoursesEditCardState extends State<CoursesEditCard> {

  GetCourseHistoryModel _courseData;
  bool _isLoading = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isAmplifyConfigured = false;
  String _uploadFileResult = '';
  String _getUrlResult = '';
  String _removeResult = '';
  String name = "";
  final aboutController = TextEditingController();


  @override
  void initState() {
    super.initState();
    hello();
  }

  hello() async {
    await configureAmplify();
    await  getCourseHistory();
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
      final name = '${widget.data.result[widget.index].sId}'+pickResult.files[0].name;
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

  getCourseHistory() async {
    try{
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.get(
      "${Api.courseHistoryList}/$userId",
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
          _courseData = GetCourseHistoryModel.fromJson(response.data);
          print(_courseData);
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
      "organizationName":widget.data.result[widget.index].institution.toString(),
      "docType": "courses",
      "docUrl": url,
      "uploadedStatus": "Success",
      "status": "Pending",
      "requestBy": email
    };

    print(jsonEncode(data));

    var response = await dio.post("${Api.uploaddoc}",
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomBarIndivitual(
                    index: 2,
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


  _deleteCourse({String id}) async {
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.delete(
      "${Api.deleteCourse}/$id",
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
            context, MaterialPageRoute(builder: (context) =>   BottomBarIndivitual(index: 2,)));
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.close,size: 30.0,),
                            onPressed: () {
                              Navigator.pop(context);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             BottomBarIndivitual(index: 2,)));
                            },
                          ),
                        ),
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 70,
                            child: CircleAvatar(
                              backgroundImage:
                              AssetImage("assets/images/courseadd.png"),
                              radius: 70,
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 30, bottom: 10, right: 15, left: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 5,
                                ),
                                child: Text(
                                  'Course Name',
                                  style: kForteenText,
                                ),
                              ),
                              Text(
                                '${widget.data.result[widget.index]
                                    .name}',
                                style:  k20Text,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25, bottom: 5),
                                child: Text(
                                  'Course Details',
                                  style: kForteenText,
                                ),
                              ),
                              Text(
                                '${widget.data.result[widget.index]
                                    .institution}',
                                style:  k20Text,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25, bottom: 5),
                                child: Text(
                                  'From',
                                  style: kForteenText,
                                ),
                              ),
                              Text(
                                '${widget.data.result[widget.index]
                                    .from}',
                                style:  k20Text,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25, bottom: 5),
                                child: Text(
                                  'To',
                                  style: kForteenText,
                                ),
                              ),
                              Text(
                                '${widget.data.result[widget.index]
                                    .to}',
                                style:  k20Text,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 25, bottom: 5),
                                child: Text(
                                  'Details',
                                  style: kForteenText,
                                ),
                              ),
                              Text(
                                '${widget.data.result[widget.index]
                                    .description}',
                                style:  k20Text,
                              ),
                              SizedBox(height: 20),
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
                                      padding: const EdgeInsets.all(13.0),
                                      child: Text(
                                        'Delete',
                                        style: k13Fwhite400BT,
                                      ),
                                    ),
                                    onPressed: () {
                                      _deleteCourse(
                                        id:
                                        '${widget.data.result[widget.index]
                                            .sId}',
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
                                      padding: const EdgeInsets.only(top:10,bottom: 10),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            size: 25,
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
                                  ),
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
