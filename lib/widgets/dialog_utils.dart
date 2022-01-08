import 'package:flutter/material.dart';
import 'package:flutter_emptra/widgets/constant.dart';

class DialogUtils {
 static successDialog( BuildContext context, String value) {
    // ignore: deprecated_member_use
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "$value",
          style:  k13Fwhite400BT,
        ),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            // Code to execute.
          },
        ),
      ),
    );
  }
}