import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/models/getListModel/getAdhaarDetail.dart';
import 'package:flutter_emptra/models/getListModel/getPenDetail.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../widgets/drawer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_emptra/domain/api_url.dart';

class PanWebUrl extends StatefulWidget {
  @override
  _PanWebUrl createState() => _PanWebUrl();
}

class _PanWebUrl extends State<PanWebUrl> {
  bool _isLoading = false;

  GetPenCardDetail _getPenCardDetail;


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
  }catch(e){
      print(e);
    }
  }
  panStatus() async {
    try{
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });
    Map data = {
      "userId": userId,
      "docType": "PANCR"
    };
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
      if (response.data['code'] == 100) {
        getPanDetail();
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
  }catch(e){
      print(e);
    }
  }

  _auto({String code}) async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    var dio = Dio();
    setState(() {
      _isLoading = true;
    });
    Map data = {
      "code":code.toString(),
      "userId": userId
    };
    print(jsonEncode(data));
    var response = await dio.post("${Api.digiLockersync}",
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
          "versionnumber": "v1"
        }),
        data: data);
    panStatus();
    getPanDetail();
    if (response.statusCode == 200) {
      if (response.data['code'] == 100) {
        panStatus();
        setState(() {
          _isLoading = false;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>BottomBarIndivitual(index:1),
              )
          );
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
  void initState() {
    super.initState();
    //hello();
  }
  hello() async {

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
          appBar: AppBar(
            title: Center(
              child: Container(
                height: 40,
                width: 120,
                child: Image.asset(
                  'assets/images/logofin.png',
                  height: 30,
                ),
              ),
            ),

            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.messenger_outline),
                iconSize:30,
                tooltip: 'Comment Icon',
                color: Color(0xff3E66FB),
                onPressed: () {

                },
              ),
            ], //<Widget>[]
            backgroundColor: Colors.transparent,
            elevation: 50.0,
            leading: Builder(
              builder: (context) => IconButton(
                icon: new Icon(Icons.menu),
                iconSize:30,
                color: Color(0xff3E66FB),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            // ignore: deprecated_member_use
            brightness: Brightness.dark,
          ),
          drawer: MyDrawer(),
          body: WebView(
            initialUrl:
            "https://stage.integrationapis.emptra.com/digilocker/authorizeMobile",
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (url) {
              // print(url);
              if (url.contains('http://stage.integrationapis.emptra.com/webhook/digilockerMobile?code=')) {
                String webtoken = url.replaceAll('http://stage.integrationapis.emptra.com/webhook/digilockerMobile?code=','');
                webtoken = webtoken.replaceAll('&state=GET', '');
                print(webtoken);
                _auto(code:webtoken);
              }
            },
          ),
        ),
      ),
    );
  }
}



// WebView(
// initialUrl: 'https://google.com',
// navigationDelegate: (request) {
// if (request.url.contains('mail.google.com')) {
// print('Trying to open Gmail');
// Navigator.pop(context); // Close current window
// return NavigationDecision.prevent; // Prevent opening url
// } else if (request.url.contains('youtube.com')) {
// print('Trying to open Youtube');
// return NavigationDecision.navigate; // Allow opening url
// } else {
// return NavigationDecision.navigate; // Default decision
// }
// },
// ),

