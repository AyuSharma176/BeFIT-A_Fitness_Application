import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/app_theme.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Loading...';
  String email = '';
  String photoUrl = '';
  String gender = '';
  int streakCount = 0;
  int totalSteps = 0;
  double calorieBurned = 0;
  int waterCups = 0;

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchTodayStats();
  }

  Future<void> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        final data = doc.data();

        setState(() {
          name = data?['name'] ?? user.displayName ?? 'No Name';
          email = data?['email'] ?? user.email ?? 'No Email';
          photoUrl = data?['photoUrl'] ?? user.photoURL ?? '';
          gender = data?['gender'] ?? '';
          streakCount = data?['streak'] ?? 0;
        });
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
  }

  Future<void> fetchTodayStats() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final today = DateTime.now();
        final todayKey =
            "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('activity_logs')
            .doc(todayKey)
            .get();

        if (doc.exists) {
          final data = doc.data();
          setState(() {
            totalSteps = data?['stepCount'] ?? 0;
            calorieBurned = (data?['calorieBurned'] ?? 0).toDouble();
            waterCups = data?['waterCups'] ?? 0;
          });
        } else {
          setState(() {
            totalSteps = 0;
            calorieBurned = 0;
            waterCups = 0;
          });
        }
      } catch (e) {
        print("Error fetching today's activity log: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.appBarBg,
              AppTheme.backgroundColor,
              AppTheme.appBarBg,
            ],
            stops: [0, 0.6, 1],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                Text(
                  "Your Profile",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 12,
                        color: Colors.black45,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildProfileHeader(),
                const SizedBox(height: 28),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your Stats",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.95),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildStatCard(
                  Icons.emoji_events,
                  "Streak",
                  "$streakCount days",
                  Colors.amber,
                ),
                const SizedBox(height: 16),
                _buildStatCard(
                  Icons.directions_walk,
                  "Today's Steps",
                  "$totalSteps",
                  Colors.tealAccent,
                ),
                const SizedBox(height: 16),
                _buildStatCard(
                  Icons.local_fire_department,
                  "Calories Burned",
                  "${calorieBurned.toStringAsFixed(1)} kcal",
                  Colors.redAccent,
                ),
                const SizedBox(height: 16),
                _buildStatCard(
                  Icons.local_drink,
                  "Water Intake",
                  "$waterCups cups",
                  Colors.cyanAccent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    ImageProvider imageProvider;

    if (photoUrl.isNotEmpty) {
      imageProvider = NetworkImage(photoUrl);
    } else if (gender == 'Male') {
      imageProvider = AssetImage('assets/images/default_male.png');
    } else if (gender == 'Female') {
      imageProvider = AssetImage('assets/images/default_female.png');
    } else {
      imageProvider = AssetImage('assets/images/default.png');
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white24, width: 2),
          ),
          child: CircleAvatar(radius: 50, backgroundImage: imageProvider),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          email,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    IconData icon,
    String label,
    String value,
    Color iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.25),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.25),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 28, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
