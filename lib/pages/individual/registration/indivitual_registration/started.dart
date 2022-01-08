import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_emptra/pages/individual/registration/indivitual_registration/digilocker.dart';
import 'package:flutter_emptra/pages/individual/registration/indivitual_registration/employmenthistory.dart';
import 'package:flutter_emptra/widgets/constant.dart';


class Started extends StatefulWidget {
  @override
  _StartedState createState() => _StartedState();
}

class _StartedState extends State<Started> {
  String name = "";
  bool changeButton = false;
  int id = 1;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String employementStatus;
  bool _isLoading = false;


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
                  Container(
                    child: Image.asset(
                      'assets/images/topbar.png', // and width here
                    ),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Identification',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: 'PoppinsLight',
                                  fontSize: 18),
                            ),
                            Icon(
                              Icons.check_circle,
                              size: 25,
                              color: Color(0xff3E66FB),
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Employment',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'PoppinsLight',
                                  fontSize: 20),
                            ),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              textColor: Colors.white,
                              color: Color(0xff3E66FB),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10,top: 18,right: 10, bottom:18),
                                child: Text(
                                  'Continue',
                                  style: k13Fwhite400BT,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EmploymentHistory()));
                                // if (_formkey.currentState.validate()) {
                                //   signup();
                                // }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 25),
                        Text(
                          'Eduaction',
                          style: TextStyle(
                              color: Colors.black45,
                              fontFamily: 'PoppinsLight',
                              fontSize: 18),
                        ),
                        SizedBox(height: 25),
                        Text(
                          'Skill',
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'PoppinsLight',
                              fontSize: 18),
                        ),
                        SizedBox(height: 30),

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
