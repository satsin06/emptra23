import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/login.dart';
import 'pages/individual/registration/indivitual_registration/new_registration.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Material(
        color: Color(0xffff0000),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 220,
                      width: 200,
                      child: Image.asset(
                        'assets/images/autherization.png', // and width here
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Container(
                    height: 50,
                    width: 150,
                    child: Image.asset(
                      'assets/images/logo.png', // and width here
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    'Background\nChecks done\nfast and easy',
                    style: TextStyle(
                        color: Colors.black87,
                        height: 1.2,
                        fontFamily: 'PoppinsBold',
                        fontWeight: FontWeight.w500,
                        fontSize: 32),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Indivitual',
                      style: TextStyle(
                          color: Color(0xff1D4ED8),
                          fontFamily: 'PoppinsLight',
                          fontSize: 14),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Organization',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff475569),
                          fontFamily: 'PoppinsLight',
                          fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(padding: const EdgeInsets.all(8)),
                Center(
                  child: RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8.0, left: 25.0, right: 25.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.googlePlus,
                            color: Colors.redAccent,
                            size: 30.0,
                          ),
                          const SizedBox(width: 20.0),
                          Text(
                            "Sign up with Google",
                            style: TextStyle(
                              color: Color(0xff33405D),
                              fontSize: 14,
                              fontFamily: 'PoppinsLight',
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 7),
                Center(
                  child: RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8.0, left: 25.0, right: 25.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.linkedin,
                            color: Colors.blue,
                            size: 30.0,
                          ),
                          SizedBox(width: 20.0),
                          Text(
                            "Sign up with Linkedin",
                            style: TextStyle(
                              fontFamily: 'PoppinsLight',
                              color: Color(0xff0077B7),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    textColor: Colors.white,
                    color: Color(0xff3E66FB),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 95,right: 95,top: 10,bottom: 10),
                      child:  Text(
                        "Sign Up ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'PoppinsLight',
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              IndividualSignUp()));
                    },
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have a account?",
                      style: TextStyle(
                        color: Color(0xff666666),
                        fontSize: 15,
                        fontFamily: 'PoppinsLight',
                      ),
                    ),
                    TextButton(
                      child: Text(
                        " Sign in",
                        style: TextStyle(
                          color: Color(0xff0161FE),
                          fontSize: 15,
                          fontFamily: 'PoppinsLight',
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                  Login()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
