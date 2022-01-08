import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/models/getListModel/getEtScore.dart';
import 'package:flutter_emptra/models/getListModel/getHealthScore.dart';
import 'package:flutter_emptra/models/getListModel/getLearningScore.dart';
import 'package:flutter_emptra/models/getListModel/getProfileinfoModel.dart';
import 'package:flutter_emptra/models/getListModel/getSocialScore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class DownloadProfile extends StatefulWidget {
  @override
  _DownloadProfileState createState() => _DownloadProfileState();
}

class _DownloadProfileState extends State<DownloadProfile> {

  bool _isLoading = true;
  GetPersonalInfoHistoryModel _personalInfoHistoryData;
  GetEtScore _etScore;
  GetHealthScore _healthScore;
  GetLearningScore _learningScore;
  GetSocialScore _socialSco;
  String _profileUrl;

  getSocialScore() async {
    try{
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();

      var response = await dio.get(
        "${Api.socialScore}/$userId",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
          "versionnumber": "v1"
        }),
      );
      if (response.statusCode == 200) {
        print("!!!!!");
        setState(() {
          //  _socialSco=response.data["socialScore"];
          _socialSco = GetSocialScore.fromJson(response.data);
          // print(0.1 * double.tryParse(_socialSco.socialScore.toString()));
          //_socialSco = getSocialScoreFromJson(response.data);
          // fromJson(response.data);

          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch(e){
      print(e);
    }
  }

  getLearningScore() async {
    try{
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();
      var response = await dio.get(
        "${Api.learningScore}/$userId",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
          "versionnumber": "v1"
        }),
      );
      if (response.statusCode == 200) {
        print(response.data);
        setState(() {
          print("!!!!!");
          _learningScore = GetLearningScore.fromJson(response.data);
          print(response.data['result']);
          print(_learningScore);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch(e){
      print(e);
    }
  }

  getHealthScore() async {
    try{
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();
      var response = await dio.get(
        "${Api.healthScore}/$userId",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
          "versionnumber": "v1"
        }),
      );
      if (response.statusCode == 200) {
        print(response.data);
        setState(() {
          print("!!!!!");
          _healthScore = GetHealthScore.fromJson(response.data);
          print(response.data['result']);
          print(_healthScore);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch(e){
      print(e);
    }
  }

  getEtScore() async {
    try{
      SharedPreferences session = await SharedPreferences.getInstance();
      var userId = session.getInt("userId");
      setState(() {
        _isLoading = true;
      });
      var dio = Dio();

      var response = await dio.get(
        "${Api.etScore}/$userId",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
          "versionnumber": "v1"
        }),
      );
      if (response.statusCode == 200) {
        print("!!!!!");
        setState(() {
          //  _socialSco=response.data["socialScore"];

          _etScore = GetEtScore.fromJson(response.data);
          // print(0.1 * double.tryParse(_socialSco.socialScore.toString()));
          //_socialSco = getSocialScoreFromJson(response.data);
          // fromJson(response.data);

          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch(e){
      print(e);
    }
  }

  getProfile() async {
    try{
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
          setState(() {
            _isLoading = false;
            print("!!!!!");
            _personalInfoHistoryData =
                GetPersonalInfoHistoryModel.fromJson(response.data);
            print(_personalInfoHistoryData);
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
    } catch(e){
      print(e);
    }
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();



  @override
  void initState() {
    super.initState();
    hello();
  }

  hello() async {
    try{
      await getProfile();
      await getEtScore();
      await getHealthScore();
      await getSocialScore();
      await getLearningScore();
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
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
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
                                      BottomBarIndivitual()
                              ));
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Downloa Profile',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'PoppinsBold',
                            height: 1.3,
                            fontWeight: FontWeight.w600,
                            fontSize: 32),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'you can proceed with',
                      style: kForteenText,
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      textColor: Colors.white,
                      color: Color(0xff3E66FB),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10),
                        child: Text(
                          "Verified Profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'PoppinsLight',
                          ),
                        ),
                      ),
                      onPressed: () {_createPDF();},

                      // onPressed: () async {
                      //
                      //   final pdfFile = await PdfParagraphApi.generate();
                      //
                      //   PdfApi.openFile(pdfFile);
                      // },
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      textColor: Colors.white,
                      color: Color(0xff3E66FB),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10),
                        child: Text(
                          "Not Verified Profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'PoppinsLight',
                          ),
                        ),
                      ),
                      onPressed: () {_createPDF();},
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
  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();
    //final vpage = document.pages.add();
    page.graphics.drawImage(
        PdfBitmap(await _readImageData('logofin.png')),
        Rect.fromLTWH(0, 100, 300, 250));

    page.graphics.drawString(


      'First Name '+'${_personalInfoHistoryData
        .result.personalInfo.personal.firstName
        .toString()}'+
        '\n''TrueID '+_personalInfoHistoryData
        .result.userId
        .toString()+
        '\n''TrueKey '+_personalInfoHistoryData
        .result.etKey
        .toString(),
      PdfStandardFont(PdfFontFamily.helvetica, 30),);
    page.graphics.drawString(


      'First Name '+'${_personalInfoHistoryData
          .result.personalInfo.personal.firstName
          .toString()}'+
          '\n''TrueID '+_personalInfoHistoryData
          .result.userId
          .toString()+
          '\n''TrueKey '+_personalInfoHistoryData
          .result.etKey
          .toString(),
      PdfStandardFont(PdfFontFamily.helvetica, 30),);
    //
    // vpage.graphics.drawString('Welcome to Truegy!',
    //     PdfStandardFont(PdfFontFamily.helvetica, 30));

    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 30),
        cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

    grid.columns.add(count: 3);
    grid.headers.add(1);

    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Learning Score';
    header.cells[1].value = 'Social Score';
    header.cells[2].value = 'Health Score';

    PdfGridRow row = grid.rows.add();
    row.cells[0].value = _learningScore.learningScore.toString();
    row.cells[1].value = _socialSco.socialScore.toString();
    row.cells[2].value = '0';
    //_healthScore.healthScore.toString();

    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));


    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, _personalInfoHistoryData
        .result.personalInfo.personal.firstName
        .toString()+'.truegy'+'.pdf');
  }
}
Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final path = (await getExternalStorageDirectory()).path;
  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open('$path/$fileName');
}
Future<Uint8List> _readImageData(String name) async {
  final data = await rootBundle.load('assets/images/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}


