// import 'dart:convert';
// import 'dart:io';
//
// import 'package:autocomplete_textfield/autocomplete_textfield.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_emptra/domain/api_url.dart';
// import 'package:flutter_emptra/models/getListModel/getEmployeementModel.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// class  {
// String name = "";
// bool changeButton = false;
// bool _checkbox = true;
// final maxLines = 4;
// DateTime initialDate = DateTime.utc(1970, 1, 1);
// final aboutController = TextEditingController();
// int id = 1;
//
// // String userId = '406451';
// // String userId = '406451';
// TextEditingController _designation = TextEditingController();
// TextEditingController _website = TextEditingController();
// final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
// String employementStatus;
// bool _isLoading = false;
// DateTime _selectedDate;
// DateTime _selectedTodate;
// TextEditingController _toDatecontroller = TextEditingController();
// TextEditingController _fromDatecontroller = TextEditingController();
// final TextEditingController _typeAheadController = TextEditingController();
// var list;
// var employeeId;
// var isworking;
// List customerList = [];
// GlobalKey<AutoCompleteTextFieldState> key = new GlobalKey();
// bool loader = false;
// var textValue;
// GetEmployeementHistoryModel _employmentHistoryData;
//
// getEmploymentHistory() async {
// SharedPreferences session = await SharedPreferences.getInstance();
// var userId = session.getInt("userId");
// setState(() {
// _isLoading = true;
// });
// var dio = Dio();
// var response = await dio.get(
// "${Api.employmentHistoryList}/$userId",
// options: Options(headers: {
// HttpHeaders.contentTypeHeader: "application/json",
// "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
// "versionnumber": "v1"
// }),
// );
// if (response.statusCode == 200) {
// print(response.data);
// if (response.data['code'] == 100) {
// setState(() {
// print("!!!!!");
// _employmentHistoryData =
// GetEmployeementHistoryModel.fromJson(response.data);
// print(_employmentHistoryData);
// _isLoading = false;
// });
// } else {
// setState(() {
// _isLoading = false;
// });
// }
// } else {
// setState(() {
// _isLoading = false;
// });
// }
// }
// }