import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';


class AllSet extends StatefulWidget {
  @override
  _AllSetState createState() => _AllSetState();
}

class _AllSetState extends State<AllSet> {
  String name = "";
  bool changeButton = false;


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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  //SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'All Set!',
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'PoppinsBold',
                              fontWeight: FontWeight.w600,
                              fontSize: 32),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'It will take just a minute..',
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'PoppinsLight',
                              fontSize: 18),
                        ),
                        SizedBox(height:30),
                        Row(
                          children: [
                            Container(
                              height:50,
                               width:50,
                              child: Image.asset(
                                'assets/images/avatar.gif', // and width here
                              ),
                            ),
                            SizedBox(width: 70,),
                            Text(
                              'Setting up your profile',
                              style: kForteenText,
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Container(
                              height:50,
                              width:50,
                              child: Image.asset(
                                'assets/images/loader.gif', // and width here
                              ),
                            ),
                            SizedBox(width: 70,),
                            Text(
                              'Calculating ET score',
                              style: kForteenText,
                            ),
                          ],
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
                                padding: const EdgeInsets.all(14.0),
                                child: Text(
                                  'Next',
                                  style: k13Fwhite400BT,
                                ),
                              ),
                              onPressed: () {

                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => BottomBarIndivitual(),
                                    ),
                                        (Route<dynamic> route) => false);
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

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
