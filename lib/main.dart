import 'package:befit/pages/app_theme.dart';
import 'package:befit/pages/premium_page.dart';
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

void main() => runApp(BeFitApp());

class BeFitApp extends StatelessWidget {
  BeFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Be 𝓯𝓲𝓽',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: SignUpScreen(),
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
            'вє ƒιт',
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
              icon: Icon(Icons.settings_outlined),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              ),
            ),
          ],
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
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 6),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.calculate_outlined),
                label: 'Calculator',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant_menu),
                label: 'Diet',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.fitness_center),
                label: 'Workout',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
