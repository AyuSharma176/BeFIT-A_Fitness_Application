import 'package:flutter/material.dart';
import 'package:befit/services/app_theme.dart';

class Aboutpage extends StatelessWidget {
  const Aboutpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.appBarBg,
            AppTheme.backgroundColor,
            AppTheme.appBarBg,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: AppTheme.iconColor),
          centerTitle: true,
          title: Text(
            'About Us',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
              fontFamily: 'Segoe UI',
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/Drawer_images/img.png'),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'вє ƒιт',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textColor,
                    fontFamily: 'Segoe UI',
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildInfoCard(
                title: 'About',
                content:
                    'BeFit is your personal fitness companion designed to guide you towards a healthier lifestyle. Whether you’re tracking your BMI, planning your meals, or following your workout progress, BeFit empowers you every step of the way.',
              ),
              const SizedBox(height: 16),
              _buildInfoCard(title: 'Developed By', content: 'Team вєƒιт'),
              const SizedBox(height: 16),
              _buildInfoCard(title: 'Version', content: '1.0.0'),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  '© 2025 BeFit Inc.',
                  style: TextStyle(
                    color: AppTheme.textColor.withAlpha(153),
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required String content}) {
    return Card(
      color: AppTheme.boxColor.withAlpha(102),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      shadowColor: AppTheme.boxColor.withAlpha(115),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                color: AppTheme.textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.textColor.withAlpha(179),
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
