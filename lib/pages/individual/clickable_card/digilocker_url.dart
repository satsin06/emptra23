// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
// import 'package:flutter_emptra/widgets/constant.dart';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//
// class DigiLockerUrl extends StatefulWidget {
//   @override
//   _DigiLockerUrl createState() => _DigiLockerUrl();
// }
//
// class _DigiLockerUrl extends State<DigiLockerUrl> {
//
//   bool _isLoading = false;
//   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
//   InAppWebViewController _webViewController;
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
//                 child: Container(
//               child: Column(children: <Widget>[
//               Expanded(
//               child:InAppWebView(
//               initialUrl: "https://flutter.dev/",
//                 initialOptions: InAppWebViewGroupOptions(
//                     crossPlatform: InAppWebViewOptions(
//                       debuggingEnabled: true,
//                     )
//                 ),
//                 onWebViewCreated: (InAppWebViewController controller) {
//                   _webViewController = controller;
//                 },
//                 onLoadStart: (InAppWebViewController controller, String url) {
//
//                 },
//                 onLoadStop: (InAppWebViewController controller, String url) {
//
//                 },
//               ),
//             ),
//               ])),
//       ),
//               ),
//             ),
//           ),
//         ),
//     );
//   }
// }
//
