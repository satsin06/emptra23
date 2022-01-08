import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_emptra/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_emptra/widgets/bottom_bar_indivitual.dart';

void main() {
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         scaffoldBackgroundColor: Color(0xfff8f8f8),
//       ),
//       //  home: EmploymentHistory(),
//       //home: Industry(),
//       //  home: LearningPage(),
//       // home: PhoneVerify(),
//       home: SettingPage(),
//       // home: HealthAdd(),
//       // home: BasicSkill(),
//       // home: BottomBarIndivitual(),
//     );
//   }
// }

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int userId;
  checkLoginStatus() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    setState(() {
      userId = session.getInt('userId');
    });
    print(userId);
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   disabledColor: AppTheme.themeColor,
      // ),
        home:userId == null
            ? Login()
            :BottomBarIndivitual(),
      // Industry()
    );
  }
}
