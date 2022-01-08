import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/domain/api_url.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddAmount extends StatefulWidget {
  @override
  _AddAmountState createState() => _AddAmountState();
}

class _AddAmountState extends State<AddAmount> {


  bool _isLoading = false;
  Razorpay _razorpay;
  var amount ;
  TextEditingController _amo = TextEditingController();
  final GlobalKey<FormState> _phoneVerifyform = GlobalKey<FormState>();
  var msg ;
  // ignore: prefer_typing_uninitialized_variables

  @override
  void initState() {
    super.initState();
    _razorpay = new Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  openCheckout() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var userId = session.getInt("userId");
    var email = session.getString("email");
    var firstName = session.getString("firstName");
    var mobileno = session.getString("mobile_no");
    var id = session.getString("id");
    var options = {
      "key": "rzp_test_iCTIU8c54ivgRN",
      "amount": amount*100, // Convert Paisa to Rupees
      "name": firstName,
      "description": userId,
      "timeout": "180",
      "order_id":id,
      "theme.color": "#3E66FB",
      "currency": "INR",
      "prefill": {"contact": mobileno,
        "email": email
      },
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  sendAmount() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var token = session.getString("token");
    try{
      SharedPreferences session = await SharedPreferences.getInstance();
      setState(() {
        _isLoading = true;
      });

      var dio = Dio();
      Map data = {
        "amount": amount,
      };
      print(data);

      print("${Api.orderId}");
      print(jsonEncode(data));
      var response = await dio.post("${Api.orderId}",
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "token":  token,
            "versionnumber": "v1"
          }),
          data: data);
      print(response.data);
      if (response.statusCode == 200) {

        if (response.data['code'] == 100) {
          print("vvvvvvvvvvvvvvvvvvvvsdddddddddddddddddddddddddddddddffffffffffffffffffffffffs");
          String id = response.data['data']['id'];
          session.setString("id", id);
          print(response.data['data']['id']);
          setState(() {
            openCheckout();
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
    } catch(e){
      print(e);
    }
  }

  sendAmo() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var token = session.getString("token");
    try{
      SharedPreferences session = await SharedPreferences.getInstance();
      setState(() {
        _isLoading = true;
      });

      var dio = Dio();
      Map data = {
        "amount": _amo.text,
      };
      print(data);

      print("${Api.orderId}");
      print(jsonEncode(data));
      var response = await dio.post("${Api.orderId}",
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "token":  token,
            "versionnumber": "v1"
          }),
          data: data);
      print(response.data);
      if (response.statusCode == 200) {

        if (response.data['code'] == 100) {
          print("vvvvvvvvvvvvvvvvvvvvsdddddddddddddddddddddddddddddddffffffffffffffffffffffffs");
          String id = response.data['data']['id'];
          session.setString("id", id);
          print(response.data['data']['id']);
          setState(() {
            openCheckout();
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
    } catch(e){
      print(e);
    }
  }

  addAmount() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    var token = session.getString("token");
    var userId = session.getInt("userId");
    var email = session.getString("email");
    var mobileno = session.getString("mobile_no");
    var paymentId = session.getString("paymentId");
    var id = session.getString("id");

    try{
      SharedPreferences session = await SharedPreferences.getInstance();
      setState(() {
        _isLoading = true;
      });

      var dio = Dio();
      Map data = {
        "userId": userId,
        "amount": amount,
        "email": email,
        "contact": mobileno,
        "card_id": null,
        "order_id": id,
        "payment_id": paymentId
      };
      print(data);

      print("${Api.addAmount}");
      print(jsonEncode(data));
      var response = await dio.post("${Api.addAmount}",
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            "token": "kxizbm3c5q1n804k3njinru7wuytrya5",
            "versionnumber": "v1"
          }),
          data: data);
      print(response.data);
      if (response.statusCode == 200) {
        if (response.data['code'] == 100) {
          setState(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BottomBarIndivitual()));
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
    } catch(e){
      print(e);
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) async {
    SharedPreferences session = await SharedPreferences.getInstance();
    print("Pament success");
    success("SUCCESS: " + response.paymentId);
    String paymentId = response.paymentId;
    session.setString("paymentId", paymentId);
    print("ajajajjajajajjajajajajjajajajjajajajjajajajajjajajajja");
    print(response.paymentId);
    print("ajajajjajajajjajajajajjajajajjajajajjajajajajjajajajja");
    addAmount();
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    success("ERROR: " + response.code.toString() + " - " + jsonDecode(response.message)['error']['description']);
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    success("EXTERNAL_WALLET: " + response.walletName);
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
              child: Form(
                key: _phoneVerifyform,
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
                            Navigator.pop(context);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             BottomBarIndivitual(index: 1,)
                            //     ));
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Add Credits',
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
                        'Add amount you want to proceed with',
                        style: kForteenText,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _amo,
                        decoration: InputDecoration(
                          isDense: true,
                          hintStyle: TextStyle(
                            height: 1.5,
                            fontSize: 18.0,
                            fontFamily: 'PoppinsLight',
                            color: Colors.black87,
                          ),
                          hintText: "Enter Your Amount",
                        ),
                        style: k22InputText,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Amount cannot be empty";
                          }return null;
                        },
                        // onSaved: (String name) {},
                        // onChanged: (value) {
                        //   name = value;
                        //   setState(() {});
                        // },
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            textColor: Colors.white,
                            color: Color(0xff3E66FB),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10),
                              child: Text(
                                "Add amount",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'PoppinsLight',
                                ),
                              ),
                            ),
                            onPressed: () {
                              amount=int.parse(_amo.text.toString());
                              if (_phoneVerifyform.currentState.validate()) {
                                sendAmount();
                              }
                            },
                          ),
                          SizedBox(width: 20,)
                        ],
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          setState(() {
                            amount = 100 ;
                            print(amount);
                          });
                          sendAmount();
                        },
                        child: Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5
                            ),
                            borderRadius:
                            BorderRadius.circular(12.0),
                          ),
                          child: Center(
                            child: Text("₹ 100",
                                style:k22InputText),
                          )
                      ),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          setState(() {
                            amount = 200 ;
                            print(amount);
                            sendAmount();
                          });
                        },
                        child:   Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5
                            ),
                            borderRadius:
                            BorderRadius.circular(12.0),
                          ),
                          child: Center(
                            child: Text("₹ 200",
                                style:k22InputText),
                          )
                      ),),
                      SizedBox(height: 20),
                      InkWell(

                        onTap: () {
                          setState(() {
                            amount = 500 ;
                            print(amount);
                            sendAmount();
                          });
                        },
                        child: Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5
                            ),
                            borderRadius:
                            BorderRadius.circular(12.0),
                          ),
                          child: Center(
                            child: Text("₹ 500",
                                style:k22InputText),
                          )
                      ),),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          setState(() {
                            amount = 1000;
                            print(amount);
                            sendAmount();
                          });
                        },
                        child: Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5
                            ),
                            borderRadius:
                            BorderRadius.circular(12.0),
                          ),
                          child: Center(
                            child: Text("₹ 1000",
                                style:k22InputText),
                          )
                      ),),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          setState(() {
                            amount = 2000 ;
                            print(amount);
                            sendAmount();
                          });
                        },
                        child: Container(
                        width: 100,
                          height: 35,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5
                            ),
                            borderRadius:
                            BorderRadius.circular(12.0),
                          ),
                          child: Center(
                            child: Text("₹ 2000",
                                style:k22InputText),
                          )
                      ),),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
