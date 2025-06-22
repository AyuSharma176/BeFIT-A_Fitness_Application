import 'package:flutter/material.dart';
import 'package:befit/pages/app_theme.dart';

import 'About_page.dart';
import 'login_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = false;
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.drawerHeaderBg,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Segoe UI',
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text(
              'Dark Mode',
              style: TextStyle(color: Colors.black),
            ),
            value: _darkMode,
            onChanged: (val) {
              setState(() {
                _darkMode = val;
              });
            },
            secondary: Icon(Icons.dark_mode, color: Colors.black),
          ),
          Divider(color: Colors.grey[300]),

          SwitchListTile(
            title: Text(
              'Notifications',
              style: TextStyle(color: Colors.black),
            ),
            value: _notifications,
            onChanged: (val) {
              setState(() {
                _notifications = val;
              });
            },
            secondary: Icon(Icons.notifications, color: Colors.black),
          ),
          Divider(color: Colors.grey[300]),

          ListTile(
            leading: Icon(Icons.lock_outline, color: Colors.black),
            title: Text('Change Password', style: TextStyle(color: Colors.black)),
            onTap: () {
              // Handle change password action
            },
          ),
          Divider(color: Colors.grey[300]),

          ListTile(
            leading: Icon(Icons.info_outline, color: Colors.black),
            title: Text('App Info', style: TextStyle(color: Colors.black)),
            onTap: () {
              // Navigate to About page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Aboutpage()),
              );
            },
          ),
          Divider(color: Colors.grey[300]),

          ListTile(
            leading: Icon(Icons.logout, color: AppTheme.logoutColor),
            title: Text('Logout', style: TextStyle(color: Colors.black)),
            onTap: () {
              // Handle logout logic
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
