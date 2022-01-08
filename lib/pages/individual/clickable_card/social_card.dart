import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/models/getListModel/getSocialModel.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter_emptra/amplifyconfiguration.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class SocialEditCard extends StatefulWidget {
  SocialEditCard({this.data, this.index});

  int index;
  GetSocialHistoryModel data;

  @override
  _SocialEditCardState createState() => _SocialEditCardState();
}

class _SocialEditCardState extends State<SocialEditCard> {
  bool _isLoading = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isAmplifyConfigured = false;
  String _uploadFileResult = '';
  String _getUrlResult = '';
  String _removeResult = '';
  String name = "";
  GetSocialHistoryModel _socialData;

  @override
  void initState() {
    super.initState();
    hello();
  }

  hello() async {
    configureAmplify();
    await getUrl();
    await getSocialHistory();
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

  getSocialHistory() async {
    try{
    SharedPreferences session = await SharedPreferences.getInstance();
    int userId = session.getInt("userId");
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.get(
      "${Api.helpHistoryList}/$userId",
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
          _socialData = GetSocialHistoryModel.fromJson(response.data);
          print(_socialData);
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
      "organizationName":
          widget.data.result[widget.index].partnerName.toString(),
      "docType": "help",
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

  _deleteSocial({String id}) async {
    setState(() {
      _isLoading = true;
    });
    var dio = Dio();
    var response = await dio.delete(
      "${Api.deleteSocial}/$id",
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
                builder: (context) => BottomBarIndivitual(
                      index: 4,
                    )));
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
                          height: 700,
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
                                    //             BottomBarIndivitual(
                                    //               index: 4,
                                    //             )));
                                  },
                                ),
                              ),
                              Center(
                                child: CircleAvatar(
                                  backgroundColor: Colors.indigo,
                                  radius: 70,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage("assets/images/vin.png"),
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
                                        'Help Partner',
                                        style: kForteenText,
                                      ),
                                    ),
                                    Text(
                                      '${widget.data.result[widget.index].partnerName}',
                                      style: k20Text,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 25,
                                        bottom: 5,
                                      ),
                                      child: Text(
                                        'Help Type',
                                        style: kForteenText,
                                      ),
                                    ),
                                    Text(
                                      '${widget.data.result[widget.index].helpType}',
                                      style: k20Text,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 25,
                                        bottom: 5,
                                      ),
                                      child: Text(
                                        'Date',
                                        style: kForteenText,
                                      ),
                                    ),
                                    Text(
                                      '${widget.data.result[widget.index].date}',
                                      style: k20Text,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 25,
                                        bottom: 5,
                                      ),
                                      child: Text(
                                        'Details',
                                        style: kForteenText,
                                      ),
                                    ),
                                    Text(
                                      '${widget.data.result[widget.index].details}',
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
                                            _deleteSocial(
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

                                                //     bool editable =false ;
                                                // editable =!editable
                                                // editable ==true ?
                                                //     textedition filed:text ;
                                                // onPressed: () {
                                                // },
                                                onPressed: uploadButtonTask,
                                              )

                                        // Text(
                                        //   '${widget.data.result[widget.index].comment.toString()}',
                                        //   style: k20Text,
                                        // )!=null?
                                        // SizedBox():RaisedButton(
                                        //   shape: RoundedRectangleBorder(
                                        //       borderRadius:
                                        //       BorderRadius.circular(
                                        //           5)),
                                        //   textColor: Colors.white,
                                        //   color: Color(0xff3E66FB),
                                        //   child: Padding(
                                        //     padding:
                                        //     const EdgeInsets.only(
                                        //         top: 10.0,
                                        //         bottom: 10.0),
                                        //     child: Row(
                                        //       mainAxisSize:
                                        //       MainAxisSize.min,
                                        //       children: [
                                        //         Icon(
                                        //           Icons.upload_outlined,
                                        //           size: 20,
                                        //           color: Colors.white,
                                        //         ),
                                        //         SizedBox(width: 5.0),
                                        //         Text(
                                        //           'Upload Document',
                                        //           style: k13Fwhite400BT,
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        //
                                        //   //     bool editable =false ;
                                        //   // editable =!editable
                                        //   // editable ==true ?
                                        //   //     textedition filed:text ;
                                        //   // onPressed: () {
                                        //   // },
                                        //   onPressed: uploadButtonTask,
                                        // )
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


