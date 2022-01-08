// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_emptra/models/getListModel/getEducationModel.dart';
// import 'package:flutter_emptra/models/getListModel/getEmployeementModel.dart';
// import 'package:flutter_emptra/pages/individual/uploadDocument/employment_upload_document.dart';
// import 'package:flutter_emptra/widgets/constant.dart';
// import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter_emptra/domain/api_url.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class HrDetailAdd extends StatefulWidget {
//   int index;
//   GetEmployeementHistoryModel data;
//   HrDetailAdd({this.data,this.index});
//
//   @override
//   _HrDetailAddState createState() => _HrDetailAddState();
// }
//
// class _HrDetailAddState extends State<HrDetailAdd> {
//   String name = "";
//   bool changeButton = false;
//   var employeeId;
//   final aboutController = TextEditingController();
//   int id = 1;
//   TextEditingController _companyName = TextEditingController();
//   TextEditingController _hrName = TextEditingController();
//   TextEditingController _hrEmail = TextEditingController();
//   TextEditingController _hrPhone = TextEditingController();
//   bool _isLoading = false;
//   TextEditingController _title = TextEditingController();
//   TextEditingController _toDatecontroller = TextEditingController();
//   TextEditingController _fromDatecontroller = TextEditingController();
//   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
//   String employementStatus;
//
//
//   _addHrDetails({String id}) async {
//     SharedPreferences session = await SharedPreferences.getInstance();
//     var userId = session.getInt("userId");
//     String email = session.getString("email");
//     String firstName = session.getString("firstName");
//     String lastName = session.getString("lastName");
//
//     var currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
//     setState(() {
//       _isLoading = true;
//     });
//
//     var dio = Dio();
//     Map data = {
//       "userId": userId,
//       "userFirstName": firstName,
//       "userLastName": lastName,
//       "organizationId": id,
//       "organizationName": _companyName.text,
//       "hrName":_hrName.text,
//       "hrEmail" :_hrEmail.text,
//       "hrNumber" : _hrPhone.text,
//       "status" : "Pending",
//       "requestBy": email,
//       "uploadedStatus": "Pending"
//
//     };
//     // print(data);
//     //print(jsonEncode(data));
//     var response = await dio.post("${Api.addHr}",
//         options: Options(headers: {
//           HttpHeaders.contentTypeHeader: "application/json",
//           "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
//           "versionnumber": "v1"
//         }),
//         data: data);
//     print(response.data);
//     if (response.statusCode == 200) {
//       if (response.data['code'] == 100) {
//
//         setState(() {
//           Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       EmployementUploadDoc()
//               ));
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _isLoading = false;
//         });
//         success(response.data['message']);
//       }
//     } else {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   success(String value) {
//     // ignore: deprecated_member_use
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           "$value",
//           style: k13Fwhite400BT,
//         ),
//         backgroundColor: Colors.black,
//         duration: Duration(seconds: 3),
//         action: SnackBarAction(
//           label: 'OK',
//           onPressed: () {
//             // Code to execute.
//           },
//         ),
//       ),
//     );
//   }
//
//   hello() async {
//     super.initState();
//     _companyName.text = widget.data['employerName'];
//     employeeId = widget.data['employerId'];
//     _title.text = widget.data['designation'];
//     _toDatecontroller.text = widget.data['to'];
//     _fromDatecontroller.text = widget.data['from'];
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     hello();
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
//           body: SingleChildScrollView(
//             child: Form(
//               key: _formkey,
//               child: Padding(
//                 padding: const EdgeInsets.all(18.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     SizedBox(height: 10),
//                     IconButton(
//                       icon: Icon(Icons.close,size: 30,),
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     BottomBarIndivitual()));
//                       },
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       'Add Hr Details',
//                       style: TextStyle(
//                           color: Colors.black87,
//                           fontFamily: 'PoppinsBold',
//                           height: 1.3,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 32),
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       'Please tell us about your hr details',
//                       style: TextStyle(
//                           color: Colors.black54,
//                           fontFamily: 'PoppinsLight',
//                           fontSize: 18),
//                     ),
//                     SizedBox(height: 30),
//                     Text(
//                       'Company Name',
//                       style: kForteenText,
//                     ),
//                     TextFormField(
//                       controller: _companyName,
//                       style: k22InputText,
//                       decoration: InputDecoration(
//                         isDense: true,
//                         hintText: "@Google",
//                         hintStyle: k18F87Black400HT
//                       ),
//                       validator: (value) {
//                         if (value.isEmpty) {
//                           return "company name cannot be empty";
//                         }
//                         return null;
//                       },
//                       onSaved: (String name) {},
//                       onChanged: (value) {
//                         name = value;
//                         setState(() {});
//                       },
//                     ),
//                     SizedBox(height: 25),
//                     Text(
//                       'Hr Name',
//                       style: kForteenText,
//                     ),
//                     TextFormField(
//                       controller: _hrName,
//                       decoration: InputDecoration(
//                         isDense: true,
//                         hintText: "@HrName",
//                         hintStyle: k18F87Black400HT
//                       ),
//                       style: k22InputText,
//
//                       // validator: (String value) {
//                       //   if (value.isEmpty) {
//                       //     return "Please enter organization";
//                       //   }
//                       //   if (value.length < 9) {
//                       //     return "Please enter valid organization";
//                       //   }
//                       //   return null;
//                       // },
//                       onSaved: (String organization) {},
//                     ),
//                     SizedBox(height: 25),
//                     Text(
//                       'Hr Email',
//                       style: kForteenText,
//                     ),
//                     TextFormField(
//                       controller: _hrEmail,
//                       decoration: InputDecoration(
//                         isDense: true,
//                         hintText: "@HrEmail",
//                         hintStyle: k18F87Black400HT
//
//                       ),
//                       style: k22InputText,
//
//                       // validator: (String value) {
//                       //   if (value.isEmpty) {
//                       //     return "Please enter organization";
//                       //   }
//                       //   if (value.length < 9) {
//                       //     return "Please enter valid organization";
//                       //   }
//                       //   return null;
//                       // },
//                       onSaved: (String organization) {},
//                     ),
//                     SizedBox(height: 25),
//                     Text(
//                       'Hr phone',
//                       style: kForteenText,
//                     ),
//                     TextFormField(
//                       controller: _hrPhone,
//                       decoration: InputDecoration(
//                         isDense: true,
//                         hintText: "@HrPhone",
//                         hintStyle: k18F87Black400HT
//                       ),
//                       style: k22InputText,
//
//                       // validator: (String value) {
//                       //   if (value.isEmpty) {
//                       //     return "Please enter organization";
//                       //   }
//                       //   if (value.length < 9) {
//                       //     return "Please enter valid organization";
//                       //   }
//                       //   return null;
//                       // },
//                       onSaved: (String organization) {},
//                     ),
//                     SizedBox(height: 25),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Verification Status',
//                           style: kForteenText,
//                         ),
//                         Container(
//                           //color: Colors.amber[600],
//                           decoration: BoxDecoration(
//                               color: Color(0xffFECACA),
//                               borderRadius: BorderRadius.all(
//                                   Radius.circular(8))),
//                           // color: Colors.blue[600],
//                           alignment: Alignment.center,
//                           child: Padding(
//                             padding: const EdgeInsets.all(6.0),
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   Icons.hourglass_top_outlined,
//                                   size: 15,
//                                   color: Colors.red,
//                                 ),
//                                 Text(
//                                   'PENDING',
//                                   style: TextStyle(
//                                       color: Colors.red,
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily: 'PoppinsLight',
//                                       fontSize: 12),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//
//
//
//                     SizedBox(height:20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         RaisedButton(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5)),
//                           textColor: Colors.white,
//                           color: Color(0xff3E66FB),
//                           child: Padding(
//                             padding: const EdgeInsets.all(14.0),
//                             child: Text(
//                               'Do it Later',
//                               style: k13Fwhite400BT,
//                             ),
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         EmployementUploadDoc()));
//                             // if (_formkey.currentState.validate()) {
//                             //   signup();
//                             // }
//                           },
//                         ),
//                         RaisedButton(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5)),
//                           textColor: Colors.white,
//                           color: Color(0xff3E66FB),
//                           child: Padding(
//                             padding: const EdgeInsets.all(14.0),
//                             child: Text(
//                               'Save & Next',
//                               style: k13Fwhite400BT,
//                             ),
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         EmployementUploadDoc()));
//                             // if (_formkey.currentState.validate()) {
//                             //   signup();
//                             // }
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
