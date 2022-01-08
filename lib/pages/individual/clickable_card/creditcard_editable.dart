import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';
import 'package:flutter_emptra/widgets/constant.dart';

class CreditCardEdit extends StatefulWidget {
  @override
  _CreditCardEditState createState() => _CreditCardEditState();
}

class _CreditCardEditState extends State<CreditCardEdit> {
  bool _isLoading = false;
  String fileName;
  String name;
  bool changeButton = false;
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final _formKey = GlobalKey<FormState>();
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
    return Material(
      color: Color(0xffF8F7F3),
      child: Scaffold(
        body: _isLoading == true
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                      ),
                      Card(
                        elevation: 1,
                        child: Container(
                          height: 700,
                          padding: new EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(Icons.close,size: 30.0,),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BottomBarIndivitual()));
                                  },
                                ),
                              ),
                              Center(
                                child: CircleAvatar(
                                  backgroundColor: Colors.indigo,
                                  radius: 50,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        AssetImage("assets/images/bank.png"),
                                    radius: 50,
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                              ),
                              Text(
                                'Creadit Card',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: 'PoppinsBold',
                                    fontSize: 24),
                              ),
                              Container(
                                height: 30,
                                width: 80,
                                //color: Colors.amber[600],
                                decoration: BoxDecoration(
                                    color: Color(0xffFECACA),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                // color: Colors.blue[600],
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.hourglass_top_outlined,
                                        size: 15,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        'PENDING',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'PoppinsLight',
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Image(
                                      image: AssetImage(
                                          'assets/images/credit_card.png'),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 80.0, left: 10),
                                        child: TextFormField(
                                          controller: _name,

                                          decoration: InputDecoration(
                                            isDense: true,
                                            hintText: "%XXXXXXXXX",
                                            hintStyle: k18F87Black400HT,
                                          ),
                                          style: k22InputText,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "Name cannot be empty";
                                            }
                                            return null;
                                          },
                                          onSaved: (String name) {},
                                          onChanged: (value) {
                                            name = value;
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                             left: 10),
                                        child: TextFormField(
                                          controller: _email,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            hintText: "01300XXXXXXXX",
                                            hintStyle: k18F87Black400HT,
                                          ),
                                          style: k22InputText,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "Name cannot be empty";
                                            }
                                            return null;
                                          },
                                          onSaved: (String name) {},
                                          onChanged: (value) {
                                            name = value;
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15.0, left: 10),
                                        child: TextFormField(
                                          controller: _phone,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            hintText: "sbi",
                                            hintStyle: k18F87Black400HT,
                                          ),
                                          style: k22InputText,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "Name cannot be empty";
                                            }
                                            return null;
                                          },
                                          onSaved: (String name) {},
                                          onChanged: (value) {
                                            name = value;
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 30, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      textColor: Colors.white,
                                      color: Color(0xff3E66FB),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.upload_outlined,
                                              size: 25,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              'Upload Document',
                                              style: k13Fwhite400BT,
                                            ),
                                          ],
                                        ),
                                      ),
                                      onPressed: (){}
                                      //=> _openFileExplorer(),
                                    ),
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      textColor: Colors.white,
                                      color: Color(0xff6840FD),
                                      child: Padding(
                                        padding: const EdgeInsets.all(14.0),
                                        child: Text(
                                          'Connect via digilocker',
                                          style: k13Fwhite400BT,
                                        ),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
