// import 'package:flutter/material.dart';
// import 'package:befit/pages/app_theme.dart';
//
// import 'About_page.dart';
// import 'SignUp_screen.dart';
//
// class SettingsPage extends StatefulWidget {
//   SettingsPage({super.key});
//
//   @override
//   State<SettingsPage> createState() => _SettingsPageState();
// }
//
// class _SettingsPageState extends State<SettingsPage> {
//   bool _darkMode = false;
//   bool _notifications = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: AppTheme.drawerHeaderBg,
//         iconTheme: IconThemeData(color: Colors.white),
//         title: Text(
//           'Settings',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//             fontFamily: 'Segoe UI',
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: ListView(
//         children: [
//           SwitchListTile(
//             title: Text(
//               'Dark Mode',
//               style: TextStyle(color: Colors.black),
//             ),
//             value: _darkMode,
//             onChanged: (val) {
//               setState(() {
//                 _darkMode = val;
//               });
//             },
//             secondary: Icon(Icons.dark_mode, color: Colors.black),
//           ),
//           Divider(color: Colors.grey[300]),
//
//           SwitchListTile(
//             title: Text(
//               'Notifications',
//               style: TextStyle(color: Colors.black),
//             ),
//             value: _notifications,
//             onChanged: (val) {
//               setState(() {
//                 _notifications = val;
//               });
//             },
//             secondary: Icon(Icons.notifications, color: Colors.black),
//           ),
//           Divider(color: Colors.grey[300]),
//
//           ListTile(
//             leading: Icon(Icons.lock_outline, color: Colors.black),
//             title: Text('Change Password', style: TextStyle(color: Colors.black)),
//             onTap: () {
//               // Handle change password action
//             },
//           ),
//           Divider(color: Colors.grey[300]),
//
//           ListTile(
//             leading: Icon(Icons.info_outline, color: Colors.black),
//             title: Text('App Info', style: TextStyle(color: Colors.black)),
//             onTap: () {
//               // Navigate to About page
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => Aboutpage()),
//               );
//             },
//           ),
//           Divider(color: Colors.grey[300]),
//
//           ListTile(
//             leading: Icon(Icons.logout, color: AppTheme.logoutColor),
//             title: Text('Logout', style: TextStyle(color: Colors.black)),
//             onTap: () {
//               // Handle logout logic
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SignUpScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//above code saved as backup

import 'package:befit/pages/forgot.dart';
import 'package:befit/services/app_theme.dart';
import 'package:befit/services/frostedGlassEffect.dart';
import 'package:flutter/material.dart';
import 'About_page.dart';
import 'SignUp_screen.dart';

class SettingsDropdown extends StatefulWidget {
  SettingsDropdown({super.key, required this.onClose});

  final VoidCallback onClose;

  @override
  State<SettingsDropdown> createState() => _SettingsDropdownState();
}

class _SettingsDropdownState extends State<SettingsDropdown> {
  bool _darkMode = false;
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return FrostedGlassBox(
      height: 400,
      width: 400,
      // color: Colors.white.withOpacity(0.95),
      // padding: EdgeInset s.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 1, width: 50,),
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Segoe UI',
                  color: AppTheme.titleTextColor
                ),
                // textAlign: TextAlign.center,
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: widget.onClose,
                color: AppTheme.titleTextColor,
              ),
            ],
          ),
          Divider(),
          SwitchListTile(
            title: Text('Dark Mode', style: TextStyle(color: AppTheme.titleTextColor),),
            value: _darkMode,
            onChanged: (val) {
              setState(() {
                _darkMode = val!;
              });
            },
            secondary: Icon(Icons.dark_mode, color: AppTheme.titleTextColor),
          ),
          SwitchListTile(
            title: Text('Notifications', style: TextStyle(color: AppTheme.titleTextColor),),
            value: _notifications,
            onChanged: (val) {
              setState(() {
                _notifications = val;
              });
            },
            secondary: Icon(Icons.notifications, color: AppTheme.titleTextColor),
          ),
          ListTile(
            leading: Icon(Icons.lock_outline, color: AppTheme.titleTextColor),
            title: Text('Change Password', style: TextStyle(color: AppTheme.titleTextColor),),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Forgot()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline, color: AppTheme.titleTextColor),
            title: Text('App Info', style: TextStyle(color: AppTheme.titleTextColor),),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Aboutpage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: AppTheme.titleTextColor),
            title: Text('Logout', style: TextStyle(color: AppTheme.titleTextColor),),
            onTap: () {
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
