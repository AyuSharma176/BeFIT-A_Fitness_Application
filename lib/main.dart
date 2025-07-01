// import 'package:befit/pages/app_theme.dart';
// import 'package:befit/pages/premium_page.dart';
// import 'package:flutter/material.dart';
// import 'package:befit/pages/About_page.dart';
// import 'package:befit/pages/BMI_calculator.dart';
// import 'package:befit/pages/Progress_page.dart';
// import 'package:befit/pages/Settings_page.dart';
// import 'package:befit/pages/Suggested_page.dart';
// import 'package:befit/pages/home_page.dart';
// import 'package:befit/pages/intake_page.dart';
// import 'package:befit/pages/login_page.dart';

//
// void main() => runApp(BeFitApp());
//
// class BeFitApp extends StatelessWidget {
//   BeFitApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Be 𝓯𝓲𝓽',
//       debugShowCheckedModeBanner: false,
//       theme: AppTheme.theme,
//       home: HomeScreen(),
//     );
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 2;
//
//   final List<Widget> _pages = [
//     BMIcalculatorPage(),
//     DietPage(),
//     MainHomePage(),
//     SuggestedPage(),
//     ProfilePage(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage('assets/gradients/gradient_bg.png'),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           title: Text(
//             'вє ƒιт',
//             style: TextStyle(
//               fontSize: 30,
//               fontWeight: FontWeight.w800,
//               letterSpacing: 2,
//               color: Colors.white,
//               fontFamily: 'Segoe UI',
//             ),
//           ),
//           leading: Builder(
//             builder: (context) => IconButton(
//               icon: Icon(Icons.menu),
//               onPressed: () => Scaffold.of(context).openDrawer(),
//             ),
//           ),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.settings_outlined),
//               onPressed: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SettingsPage()),
//               ),
//             ),
//           ],
//         ),
//         drawer: Drawer(
//           child: Container(
//             color: Colors.white,
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: [
//                 DrawerHeader(
//                   decoration: BoxDecoration(
//                     color: AppTheme.drawerHeaderBg,
//                     image: DecorationImage(
//                       image: AssetImage('assets/Drawer_images/bmi1.png'),
//                       fit: BoxFit.cover,
//                       opacity: 0.6,
//                     ),
//                   ),
//                   child: Align(
//                     alignment: Alignment.bottomLeft,
//                     child: Text(
//                       'Welcome, Champ! 💪',
//                       style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.bar_chart, color: AppTheme.drawerIconColor),
//                   title: Text('Progress', style: TextStyle(color: Colors.black)),
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => Progresspage()),
//                   ),
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.money, color: AppTheme.drawerIconColor),
//                   title: Text('вєƒιт Premium', style: TextStyle(color: Colors.black)),
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => premiumpage()),
//                   ),
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.info_outline, color: AppTheme.drawerIconColor),
//                   title: Text('About Us', style: TextStyle(color: Colors.black)),
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => Aboutpage()),
//                   ),
//                 ),
//                 ListTile(
//                   leading: Icon(Icons.logout, color: AppTheme.logoutColor),
//                   title: Text('Logout', style: TextStyle(color: Colors.black)),
//                   onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => SignUpScreen()),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         body: _pages[_selectedIndex],
//         bottomNavigationBar: Container(
//           decoration: BoxDecoration(
//             color: Colors.black,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//             ),
//           ),
//           padding: EdgeInsets.symmetric(vertical: 6),
//           child: BottomNavigationBar(
//             currentIndex: _selectedIndex,
//             onTap: _onItemTapped,
//             items: [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.calculate_outlined),
//                 label: 'Calculator',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.restaurant_menu),
//                 label: 'Diet',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home_outlined),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.fitness_center),
//                 label: 'Workout',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person_outline),
//                 label: 'Profile',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:befit/pages/app_theme.dart';
import 'package:befit/pages/premium_page.dart';
import 'package:befit/pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:befit/pages/About_page.dart';
import 'package:befit/pages/BMI_calculator.dart';
import 'package:befit/pages/Progress_page.dart';
import 'package:befit/pages/Settings_page.dart';
import 'package:befit/pages/Suggested_page.dart';
import 'package:befit/pages/home_page.dart';
import 'package:befit/pages/intake_page.dart';
import 'package:befit/pages/login_page.dart';
import 'package:befit/pages/profile_page.dart';
import 'package:flutter_svg/flutter_svg.dart';


void main() => runApp(BeFitApp());

class BeFitApp extends StatelessWidget {
  BeFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Be 𝓯𝓲𝓽',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2;
  bool _showSettings = false;

  Widget _buildNavItem(IconData icon, IconData activeIcon, String label, int index) {
    final bool isSelected = index == _selectedIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: Colors.white,
            ),
            // const SizedBox(height: 4),
            // Text(
            //   label,
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 10,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildSvgNavItem(String icon, String activeIcon, String label, int index) {
    final bool isSelected = index == _selectedIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              isSelected ? activeIcon : icon,
              width: 24,
              height: 24,
              color: Colors.white,
            ),
            // const SizedBox(height: 4),
            // Text(
            //   label,
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 10,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }


  final List<Widget> _pages = [
    BMIcalculatorPage(),
    DietPage(),
    MainHomePage(),
    SuggestedPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/gradients/gradient_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            _selectedIndex == 2 ? '' : 'вє ƒιт',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
              color: Colors.white,
              fontFamily: 'Segoe UI',
            ),
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {
                setState(() {
                  _showSettings = !_showSettings;
                });
              },
            ),
          ],
          // actions: [
          //   IconButton(
          //     icon: Icon(Icons.settings_outlined),
          //     onPressed: () => Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => SettingsPage()),
          //     ),
          //   ),
          // ],
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: AppTheme.drawerHeaderBg,
                    image: DecorationImage(
                      image: AssetImage('assets/Drawer_images/img.png'),
                      fit: BoxFit.cover,
                      opacity: 0.6,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Welcome, Champ! 💪',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.bar_chart, color: AppTheme.drawerIconColor),
                  title: Text('Progress', style: TextStyle(color: Colors.black)),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Progresspage()),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.money, color: AppTheme.drawerIconColor),
                  title: Text('вєƒιт Premium', style: TextStyle(color: Colors.black)),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => premiumpage()),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.info_outline, color: AppTheme.drawerIconColor),
                  title: Text('About Us', style: TextStyle(color: Colors.black)),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Aboutpage()),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.logout, color: AppTheme.logoutColor),
                  title: Text('Logout', style: TextStyle(color: Colors.black)),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  ),
                ),
              ],
            ),
          ),
        ),
        // body: _pages[_selectedIndex],
        body: Stack(
          children: [
            _pages[_selectedIndex],
            if (_showSettings)
              Positioned(
                top: kToolbarHeight,
                right: 16,
                left: 16,
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(8),
                  child: SettingsDropdown(
                    onClose: () {
                      setState(() {
                        _showSettings = false;
                      });
                    },
                  ),
                ),
              ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppTheme.appBarBg,
            // borderRadius: const BorderRadius.only(
            //   topLeft: Radius.circular(20),
            //   topRight: Radius.circular(20),
            // ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
          height: 70,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double itemWidth = constraints.maxWidth / 5;
              return Stack(
                children: [
                  Row(
                    children: [
                      _buildNavItem(Icons.calculate_outlined, Icons.calculate, 'Calculator', 0),
                      _buildNavItem(Icons.egg_alt_outlined, Icons.egg_alt, 'Diet', 1),
                      _buildNavItem(Icons.home_outlined, Icons.home, 'Home', 2),
                      _buildSvgNavItem('assets/navbar_icons/dumbell_outlined.svg',
                          'assets/navbar_icons/dumbell.svg', 'Workout', 3),
                      _buildNavItem(Icons.person_outline, Icons.person, 'Profile', 4),
                    ],
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    left: _selectedIndex * itemWidth + (itemWidth / 2) - 20,
                    bottom: 8,
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
