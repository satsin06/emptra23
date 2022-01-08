import 'package:flutter/material.dart';


Widget myAppBar() {
  return AppBar(
    title: Center(
      child: Container(
        height: 40,
        width: 120,
        child: Image.asset(
          'assets/images/logowhite.png',
          height: 30,
        ),
      ),
    ),
    // actions: <Widget>[
    //   IconButton(
    //     icon: Icon(Icons.qr_code),
    //     tooltip: 'Comment Icon',
    //     onPressed: () {}
    //   ),
    // ], //<Widget>[]
    backgroundColor: Colors.transparent,
    elevation: 50.0,
    leading: Builder(
      builder: (context) => IconButton(
        icon: new Icon(Icons.menu),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
    ),
    // ignore: deprecated_member_use
    brightness: Brightness.dark,
  );
}
