import 'package:flutter/material.dart';
import 'package:befit/services/app_theme.dart';


import 'Subscription_page.dart'; // Import the target page

class premiumpage extends StatelessWidget {
   premiumpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title:  Text('вєƒιт Premium'),
      ),
      body: Padding(
        padding:  EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Unlock Premium Features 🏆',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
             SizedBox(height: 16),
            Text(
              'Why go Premium?',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
             SizedBox(height: 12),
            _buildPremiumTile(Icons.fitness_center, 'Advanced Workout Plans'),
            _buildPremiumTile(Icons.restaurant_menu, 'Custom Diet Plans'),
            _buildPremiumTile(Icons.bar_chart, 'Detailed Progress Analytics'),
            _buildPremiumTile(Icons.self_improvement, 'Personal Coaching Tips'),
            _buildPremiumTile(Icons.lock_open, 'Ad-Free Experience'),

             Spacer(),

            Center(
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                splashColor: AppTheme.primaryColor.withOpacity(0.3),
                highlightColor: AppTheme.primaryColor.withOpacity(0.1),
                onTap: () {
                  // Navigate to Subscription Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  SubscriptionPage()),
                  );
                },
                child: Ink(
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.4),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child:  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    child: Text(
                      'Upgrade to Premium',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumTile(IconData icon, String text) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primaryColor, size: 28),
           SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.drawerIconColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
