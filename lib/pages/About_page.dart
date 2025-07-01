import 'package:flutter/material.dart';
import 'package:befit/pages/app_theme.dart';

class Aboutpage extends StatelessWidget {
  const Aboutpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.drawerHeaderBg,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'About Us',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Segoe UI',
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Center(
              child: Image.asset('assets/Drawer_images/bmi1.png', height: 100),
            ),
            SizedBox(height: 20),
            Text(
              'вє ƒιт',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontFamily: 'Segoe UI',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'BeFit is your personal fitness companion designed to guide you towards a healthier lifestyle. Whether you’re tracking your BMI, planning your meals, or following your workout progress, BeFit empowers you every step of the way.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.4,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 30),
            Text(
              'Developed By',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Team вєƒιт',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 30),
            Text(
              'Version',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '1.0.0',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
