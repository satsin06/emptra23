import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/pages/individual/clickable_card/adhar_webUrl.dart';
import 'package:flutter_emptra/pages/individual/registration/indivitual_registration/allset.dart';
import 'package:flutter_emptra/widgets/constant.dart';

class DigiLocker extends StatefulWidget {
  @override
  _DigiLockerState createState() => _DigiLockerState();
}

class _DigiLockerState extends State<DigiLocker> {
  String name = "";
  bool changeButton = false;
  int id = 1;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String employementStatus;
  bool _isLoading = false;


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
                    SizedBox(height: 12),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                      'Save & Exit',
                      style: kForteenText,
                    ),),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 8,
                          color: Color(0xff3E66FB),
                        ),
                        Container(
                          width: 250,
                          height: 8,
                          color: Color(0xffCBD5E1),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Connect your \nDigilocker',
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'PoppinsBold',
                          height: 1.3,
                          fontWeight: FontWeight.w600,
                          fontSize: 32),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Connect your digilocker account to increase your ET score',
                      style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'PoppinsLight',
                          fontSize: 18),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: Container(
                        height:200,
                        width: 200,
                        child: Image.asset('assets/images/etscore.png'),
                      ),
                    ),
                    Center(
                      child: FlatButton(
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>AdharWebUrl(),
                              )
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top:15.0,bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height:30,
                                width: 30,
                                child: Image.asset('assets/images/digiimage.png'),
                              ),
                              Text(
                                'Connect via Digilocker',
                                style: TextStyle(
                                    color: Color(0xff6840FD),
                                    fontFamily: 'PoppinsLight',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(side: BorderSide(
                            color: Color(0xff6840FD),
                            width: 2,
                            style: BorderStyle.solid
                        ), borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          textColor: Colors.white,
                          color: Color(0xff3E66FB),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10,top: 18,right: 10, bottom:18),
                            child: Text(
                              'Next',
                              style: k13Fwhite400BT,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AllSet()));
                            // if (_formkey.currentState.validate()) {
                            //   signup();
                            // }
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
}
