import 'package:flutter/material.dart';
import '../pages/individual/application_main_page/about_page/about_page.dart';
import '../pages/individual/application_main_page/learning_page/learning_page.dart';
import '../pages/individual/application_main_page/account_page/account_page.dart';
import '../pages/individual/application_main_page/health_page/health_page.dart';
import '../pages/individual/application_main_page/social_page/social_page.dart';


// class BottomBarIndivitual extends StatefulWidget {
//   final int index;
//
//   const BottomBarIndivitual({Key key, this.index = 0}) : super(key: key);
//
//   @override
//   _BottomBarIndivitualState createState() => _BottomBarIndivitualState();
// }
//
// class _BottomBarIndivitualState extends State<BottomBarIndivitual> {
//   int _selectedIndex = 0;
//
//   static List<Widget> _widgetOptions = <Widget>[
//  //  ProfileController = Get.put(AboutPage()),
//     AboutPage(),
//     AccountPage(),
//     LearningPage(),
//     HealthPage(),
//     HelpPage(),
//   ];
//
//   void initState() {
//     super.initState();
// _selectedIndex = widget.index;    // getEducationHistory();
//   }
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
//         bottomNavigationBar: BottomNavigationBar(
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home_sharp),
//               // ignore: deprecated_member_use
//               title: Text('About'),
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.account_box_outlined),
//               // ignore: deprecated_member_use
//               title: Text('Account'),
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.menu_book),
//               // ignore: deprecated_member_use
//               title: Text('Learning'),
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.favorite_outline_outlined),
//               // ignore: deprecated_member_use
//               title: Text('Health'),
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.emoji_emotions_outlined),
//               // ignore: deprecated_member_use
//               title: Text('Social'),
//             ),
//           ],
//           iconSize: 25,
//           currentIndex: _selectedIndex,
//           selectedItemColor: Colors.indigo,
//           unselectedItemColor: Colors.grey[700],
//           unselectedFontSize: 13,
//           selectedFontSize: 14,
//           type: BottomNavigationBarType.fixed,
//           onTap: _onItemTapped,
//         ),
//       ),
//     );
//   }
// }



class BottomBarIndivitual extends StatefulWidget {
  final int index;

  const BottomBarIndivitual({Key key, this.index = 0}) : super(key: key);
  @override
  _BottomBarIndivitualState createState() => _BottomBarIndivitualState();
}

class _BottomBarIndivitualState extends State<BottomBarIndivitual> {
  int _selectedIndex = 0;
 List<Widget> _widgetOptions = <Widget>[
    //  ProfileController = Get.put(AboutPage()),
    AboutPage(),
    AccountPage(),
    LearningPage(),
    HealthPage(),
    HelpPage(),
  ];
  void initState() {
    super.initState();
_selectedIndex = widget.index;    // getEducationHistory();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_sharp),
                // ignore: deprecated_member_use
                label: 'About',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_box_outlined),
                // ignore: deprecated_member_use
                label: 'Account',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book),
                // ignore: deprecated_member_use
                label:'Learning',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline_outlined),
                // ignore: deprecated_member_use
                label: 'Health',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.emoji_emotions_outlined),
                // ignore: deprecated_member_use
                label: 'Social',
              ),
            ],
            iconSize: 25,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.indigo,
            unselectedItemColor: Colors.grey[700],
            unselectedFontSize: 13,
            selectedFontSize: 14,
            type: BottomNavigationBarType.fixed,
            onTap: _onItemTapped,
          ),
      ),
    );
  }
}
