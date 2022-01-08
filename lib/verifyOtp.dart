// import 'dart:convert';
// import 'dart:io';
// import 'package:cool_alert/cool_alert.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_emptra/domain/api_url.dart';
//
// import 'package:flutter_emptra/signup.dart';
// import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
// import 'package:flutter_emptra/widgets/constant.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class VerifyOtp extends StatefulWidget {
//   @override
//   _VerifyOtpState createState() => _VerifyOtpState();
// }
//
// class _VerifyOtpState extends State<VerifyOtp> {
//   String name = "";
//   bool changeButton = false;
//   TextEditingController _phone = TextEditingController();
//
//   bool _isLoading = false;
//   TextEditingController _phoneNumber = TextEditingController();
//   TextEditingController _otp = TextEditingController();
//   bool putOtp = false;
//   var chechOtp;
//   final GlobalKey<FormState> _phoneVerifyform = GlobalKey<FormState>();
//
//   checkPhone() async {
//     var dio = Dio();
//     setState(() {
//       _isLoading = true;
//     });
//     Map data = {
//       "phone": _phoneNumber.text,
//     };
//     print(jsonEncode(data));
//     var response = await dio.post(
//       Api.checkPhone,
//       options: Options(headers: {
//         HttpHeaders.contentTypeHeader: "application/json",
//         "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
//         "versionnumber": "v1"
//       }),
//       data: data,
//     );
//     print(response.data);
//     if (response.statusCode == 200) {
//       if (response.data['code'] == 100) {
//         setState(() {
//           _isLoading = false;
//           sendOtp();
//         });
//       } else {
//         setState(() {
//           _isLoading = false;
//         });
//         alertbox(response.data['message']);
//       }
//     } else {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   sendOtp() async {
//     SharedPreferences session = await SharedPreferences.getInstance();
//     var dio = Dio();
//     setState(() {
//       _isLoading = true;
//     });
//     // int etId = session.getInt("etId");
//     Map data = {
//       //  "userId": session.getInt("etId"),
//       //"userId": session.getInt("userId"),
//       // id h int  or  ("etId").toString
//       "ph_no": _phoneNumber.text.trim()
//     }; //phone h string  or    _phoneNumber.toInt
//     print(jsonEncode(data));
//     var response = await dio.post(
//       Api.sendOtp,
//       options: Options(headers: {
//         HttpHeaders.contentTypeHeader: "application/json",
//         "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
//         "versionnumber": "v1"
//       }),
//       data: data,
//     );
//     if (response.statusCode == 200) {
//       print(response.data);
//       print(response.data['code']);
//       if (response.data['code'] == 100) {
//         print("trueeeeee");
//         String verificationId = response.data['verificationId'];
//         // int userId = response.data['etId'];
//         session.setString("verificationId", verificationId);
//         print(response.data['verificationId']);
//         setState(() {
//           chechOtp=response.data['chechOtp'];
//           putOtp=true;
//         });
//       } else {
//         setState(() {
//           _isLoading = false;
//         });
//         alertbox(response.data['message']);
//       }
//     }
//     setState(() {
//       _isLoading = false;
//     });
//   }
//
//   verifyOtp() async {
//
//     SharedPreferences session = await SharedPreferences.getInstance();
//     var dio = Dio();
//     setState(() {
//       _isLoading = true;
//     });
//     Map data = {
//       "ph_no": _phoneNumber.text.trim(),
//       "otp": _otp.text,
//       "verificationId": session.getString("verificationId"),
//     };
//     print(jsonEncode(data));
//     var response = await dio.post(
//       Api.verifyOtp,
//       options: Options(headers: {
//         HttpHeaders.contentTypeHeader: "application/json",
//         "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
//         "versionnumber": "v1"
//       }),
//       data: data,
//     );
//
//     if (response.statusCode == 200) {
//       print(response.data);
//       print(response.data['code']);
//       if (response.data['code'] == 100) {
//         print("trueeeeee");
//         // int etId = response.data['etId'];
//         // // int userId = response.data['etId'];
//         // session.setInt("etId", etId);
//         // session.setInt("userId", userId);
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => BottomBarIndivitual()));
//         // alertbox(response.data['message']);
//       }
//       else {
//         alertbox(response.data['message']);
//       }
//       // int etid=session.getInt("etId");
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//
//   alertbox(String value) {
//     CoolAlert.show(
//       context: context,
//       type: CoolAlertType.error,
//       title: 'Oops...',
//       text: value,
//     );
//   }
//
//
//   success(String value) {
//     CoolAlert.show(
//       context: context,
//       type: CoolAlertType.success,
//       title: '',
//       text: value,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Material(
//         color: Color(0xffF8F7F3),
//         child: _isLoading == true
//             ? Center(child: CircularProgressIndicator())
//             : Scaffold(
//                 body: SingleChildScrollView(
//                   child: Form(
//                     key: _phoneVerifyform,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Container(
//                               height: 220,
//                               width: 200,
//                               child: Image.asset(
//                                 'assets/images/autherization.png', // and width here
//                               ),
//                             ),
//                           ],
//                         ),
//                         Container(
//                           height: 80,
//                           width: 120,
//                           child: Image.asset(
//                             'assets/images/logofin.png', // and width here
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Text(
//                           'Login',
//                           style: TextStyle(
//                               color: Colors.black87,
//                               height: 1.2,
//                               fontFamily: 'PoppinsBold',
//                               fontWeight: FontWeight.w500,
//                               fontSize: 32),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           'Get access to your orders, lab tests &',
//                           style: k16F87Black400HT,
//                         ),
//                         Text(
//                           'doctor consultations',
//                           style: k16F87Black400HT,
//                         ),
//                         SizedBox(height: 20),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Indivitual',
//                               style: TextStyle(
//                                   color: Color(0xff1D4ED8),
//                                   fontFamily: 'PoppinsLight',
//                                   fontSize: 14),
//                             ),
//                             SizedBox(width: 20),
//                             Text(
//                               'Organization',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Color(0xff475569),
//                                   fontFamily: 'PoppinsLight',
//                                   fontSize: 14),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10),
//                         Padding(
//                           padding: const EdgeInsets.all(20.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Phone Number',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black45,
//                                     fontFamily: 'PoppinsBold',
//                                     fontSize: 14),
//                               ),
//                               TextFormField(
//                                 controller: _phoneNumber,
//                                 decoration: InputDecoration(
//                                   isDense: true,
//                                   hintStyle: TextStyle(
//                                     height: 1.5,
//                                     fontSize: 18.0,
//                                     fontFamily: 'PoppinsLight',
//                                     color: Colors.black87,
//                                   ),
//                                   hintText: "Enter Your phone Number",
//                                 ),
//                                 style: k22InputText,
//                                 keyboardType: TextInputType.number,
//                                 validator: (value) {
//                                   if (value.isEmpty) {
//                                     return "Phone Number cannot be empty";
//                                   } else if (value.length < 10) {
//                                     return "Phone Number length should be atleast 10";
//                                   }
//                                   return null;
//                                 },
//                                 onSaved: (String name) {},
//                                 onChanged: (value) {
//                                   name = value;
//                                   setState(() {});
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                         RaisedButton(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(7)),
//                           textColor: Colors.white,
//                           color: Color(0xff3E66FB),
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                                 left: 70, right: 70, top: 10, bottom: 10),
//                             child: Text(
//                               "Send OTP",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                                 fontFamily: 'PoppinsLight',
//                               ),
//                             ),
//                           ),
//                           onPressed: () {
//                             if (_phoneVerifyform.currentState.validate()) {
//                               checkPhone();
//                             }
//                             // Navigator.push(
//                             //     context,
//                             //     MaterialPageRoute(
//                             //         builder: (context) =>
//                             //             BottomBarIndivitual()));
//                           },
//                         ),
//                         Visibility(child: SizedBox(height: 10,)),
//                         Visibility(
//                           visible: putOtp,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 20.0),
//                                 child: Text(
//                                   'Verify OTP',
//                                   style: kForteenText,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Visibility(
//                           visible: putOtp,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 20.0,bottom: 20.0),
//                             child: TextFormField(
//                               controller: _otp,
//                               style: k22InputText,
//                               decoration: InputDecoration(
//                                 isDense: true,
//                                 hintText: "@OTP",
//                                 hintStyle: k18F87Black400HT,
//                               ),
//                               keyboardType: TextInputType.number,
//                               validator: (value) {
//                                 if (value.isEmpty) {
//                                   return "otpcannot be empty";
//                                 }
//                                 return null;
//                               },
//                               onSaved: (String name) {},
//                               onChanged: (value) {
//                                 name = value;
//                                 setState(() {});
//                               },
//                             ),
//                           ),
//                         ),
//                         Visibility(
//                           visible: putOtp,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               RaisedButton(
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(5)),
//                                 textColor: Colors.white,
//                                 color: Color(0xff3E66FB),
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 70, right: 70, top: 10, bottom: 10),
//                                   child: Text(
//                                     'Verify OTP',
//                                     style: k13Fwhite400BT,
//                                   ),
//                                 ),
//                                 onPressed: () {
//                                   if (_phoneVerifyform.currentState.validate()) {
//                                     verifyOtp();
//                                   }
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                         Visibility(child: SizedBox(height: 10,)),
//                         Text(
//                           "By logging in, you agree to our Terms and",
//                           style: k13Fblack400BT,
//                         ),
//                         Text(
//                           "Conditions & Privacy Policy",
//                           style: k13Fblack400BT,
//                         ),
//                         TextButton(
//                           child: Text(
//                             "Need Help? Get In Touch",
//                             style: TextStyle(
//                                 color: Colors.indigo,
//                                 fontFamily: 'Inter',
//                                 fontSize: 15),
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => SignUp()));
//                           },
//                         ),
//
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }
