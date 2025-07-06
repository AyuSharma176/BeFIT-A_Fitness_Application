import 'dart:ui';
import 'package:befit/services/frostedGlassEffect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:befit/services/app_theme.dart';
import '../main.dart'; // Assuming GEMINI_API_KEY is defined here
import 'Suggested_page.dart'; // Assuming Progresspage is defined here
import 'package:befit/services/motivational_service.dart';
import 'chat_page.dart'; // Assuming this is not directly used in MainHomePage but might be part of the app
import 'package:google_fonts/google_fonts.dart';
import 'cardio_section.dart'; // Assuming this is not directly used in MainHomePage but might be part of the app
import 'package:shared_preferences/shared_preferences.dart';

// Define GEMINI_API_KEY if it's not in main.dart or pass it as a constructor parameter
// For this example, I'm assuming it's accessible globally or from main.dart
// If not, you'll need to define: const String GEMINI_API_KEY = "YOUR_API_KEY_HERE";

class MainHomePage extends StatefulWidget {
  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  final user = FirebaseAuth.instance.currentUser;
  late Future<String> _quoteFuture;

  String name = 'Loading...';
  String chatResponse = ''; // Not directly used in this snippet, but kept from original
  String? calorieResult; // From SharedPreferences
  String? proteinResult; // From SharedPreferences
  String? waterIntake; // Fetched from Firestore
  String? stepsCount; // Fetched from Firestore
  String? calorieBurnedToday; // Fetched from Firestore

  @override
  void initState() {
    super.initState();
    // Initialize the quote future
    _quoteFuture = MotivationService(GEMINI_API_KEY).getQuote();
    // Load user's display name from Firestore
    loadUserData();
    // Load calorie and protein results from SharedPreferences
    loadResults();
    // Load daily activity data (steps, water, calories burned) from Firestore
    loadDailyActivityData();
  }

  /// Fetches the user's name from Firestore based on their UID.
  Future<void> loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        final data = doc.data();
        setState(() {
          name = data?['name'] ?? user.displayName ?? 'User';
        });
      } catch (e) {
        print("Error fetching user data: $e");
        setState(() {
          name = 'User'; // Fallback name on error
        });
      }
    } else {
      setState(() {
        name = 'Guest'; // If no user is logged in
      });
    }
  }

  /// Loads last saved calorie and protein results from SharedPreferences.
  Future<void> loadResults() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      calorieResult = prefs.getString('last_calorie_result');
      proteinResult = prefs.getString('last_protein_result');
    });
  }

  /// Loads daily activity data (stepCount, waterCups, calorieBurned) from Firestore.
  /// Assumes data is stored under 'users/{uid}/dailyActivity/{YYYY-MM-DD}'.
  Future<void> loadDailyActivityData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Format today's date to match the Firestore document ID format (e.g., "2025-07-06")
        final today = DateTime.now();
        final formattedDate = "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

        print('Attempting to load daily activity for user: ${user.uid} on date: $formattedDate');

        // Construct the Firestore path to the daily activity document
        final docSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('activity_logs') // ✅ Corrected from 'dailyActivity'
            .doc(formattedDate)
            .get();

        if (docSnapshot.exists) {
          // If the document exists, retrieve its data
          final data = docSnapshot.data();
          print('Daily activity document found. Data: $data');

          setState(() {
            // Assign fetched values to state variables, defaulting to '0' if null
            stepsCount = data?['stepCount']?.toString() ?? '0';
            waterIntake = data?['waterCups']?.toString() ?? '0';
            calorieBurnedToday = data?['calorieBurned']?.toString() ?? '0';
          });
          print('Steps loaded: $stepsCount, Water loaded: $waterIntake, Calories Burned loaded: $calorieBurnedToday');
        } else {
          // If the document does not exist for today, set default '0' values
          print("No daily activity data found for today: $formattedDate (Document does not exist)");
          setState(() {
            stepsCount = '0';
            waterIntake = '0';
            calorieBurnedToday = '0';
          });
        }
      } catch (e) {
        // Catch any errors during Firestore fetching and set 'NA'
        print("Error fetching daily activity data: $e");
        setState(() {
          stepsCount = 'Start';
          waterIntake = 'Start';
          calorieBurnedToday = 'Start';
        });
      }
    } else {
      // If no user is logged in, set 'NA'
      print("No user logged in, cannot load daily activity data.");
      setState(() {
        stepsCount = 'Start';
        waterIntake = 'Start';
        calorieBurnedToday = 'Start';
      });
    }
  }

  /// Refreshes the motivational quote.
  void _refreshQuote() {
    setState(() {
      _quoteFuture = MotivationService(GEMINI_API_KEY).getQuote();
    });
  }

  /// Returns a greeting based on the current time of day.
  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  /// Helper function to display 'NA' for null, empty, or '0' values.
  String displayValue(String? value, {String? fallback}) {
    if (value == null || value.isEmpty || value == '0') {
      return fallback ?? 'NA'; // Use fallback if provided, else default to 'NA'
    }
    return value;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.appBarBg, AppTheme.backgroundColor, AppTheme.appBarBg],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // Motivational Quote Section
                FutureBuilder<String>(
                  future: _quoteFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Text(
                        "❌ Couldn't load quote",
                        style: TextStyle(color: Colors.white),
                      );
                    } else {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.appBarBg.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                '"${snapshot.data!}"',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.refresh, color: Colors.white70),
                              onPressed: _refreshQuote,
                              tooltip: "Refresh Quote",
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),

                // Greeting and User Name
                Text(
                  '${getGreeting()},',
                  style: GoogleFonts.notoSans(
                    color: AppTheme.textColor,
                    fontSize: 18,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 0),
                        blurRadius: 10,
                        color: AppTheme.textShadowColor,
                      ),
                    ],
                  ),
                ),
                Text(
                  name,
                  style: GoogleFonts.oswald(
                    color: AppTheme.textColor,
                    fontSize: 40,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 0),
                        blurRadius: 50,
                        color: AppTheme.textShadowColor.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Workout Streak Section
                buildWorkoutStreak(),

                const SizedBox(height: 10),

                // Daily Goals Card (now includes Firestore data)
                buildDailyGoals(),

                const SizedBox(height: 20),

                // Start Workout Button
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(AppTheme.appBarBg),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Progresspage()),
                      ),
                      child: const Text('Start Workout'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the workout streak display.
  Widget buildWorkoutStreak() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.84,
        height: 120,
        decoration: BoxDecoration(
          color: AppTheme.appBarBg.withOpacity(0.20),
          borderRadius: BorderRadius.circular(28.0),
          boxShadow: [
            BoxShadow(
              color: AppTheme.appBarBg.withOpacity(0.20),
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Workout Streak',
              style: GoogleFonts.notoSans(
                color: AppTheme.textColor,
                fontSize: 22,
                shadows: [
                  Shadow(
                    offset: Offset(0, 0),
                    blurRadius: 10,
                    color: AppTheme.textShadowColor,
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.76,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.appBarBg,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: FrostedGlassBox(
                width: double.infinity,
                height: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(7, (index) {
                    return index == 6
                        ? Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppTheme.backgroundColor, width: 2),
                        color: Colors.white.withOpacity(0.1),
                      ),
                      child: const Text('🔥'),
                    )
                        : const Text('🔥');
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the daily goals display, including data from SharedPreferences and Firestore.
  Widget buildDailyGoals() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.84,
        height: 350,
        decoration: BoxDecoration(
          color: AppTheme.appBarBg.withOpacity(0.35),
          borderRadius: BorderRadius.circular(28.0),
          boxShadow: [
            BoxShadow(
              color: AppTheme.appBarBg.withOpacity(0.35),
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Daily Goals',
              style: GoogleFonts.notoSans(
                color: AppTheme.textColor,
                fontSize: 22,
                shadows: [
                  Shadow(
                    offset: Offset(0, 0),
                    blurRadius: 10,
                    color: AppTheme.textShadowColor,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Display Protein from SharedPreferences
                dailyGoalsTile('Protein', displayValue(proteinResult, fallback:'+/-')),
                // Display Calories from SharedPreferences
                dailyGoalsTile('Calories', displayValue(calorieResult, fallback:'+/-')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Display Water from Firestore (waterCups)
                dailyGoalsTile('Water', '${displayValue(waterIntake)} cups'),
                // Display Steps from Firestore (stepCount)
                dailyGoalsTile('Steps', displayValue(stepsCount)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// A reusable tile widget for displaying daily goals.
  Widget dailyGoalsTile(String title, String value) {
    double height = 130;
    double radius = height / 2;
    return Container(
      width: MediaQuery.of(context).size.width * 0.34,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: AppTheme.appBarBg.withOpacity(0.80),
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.notoSans(
                    color: AppTheme.textColor,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: GoogleFonts.notoSans(
                    color: AppTheme.textColor,
                    fontSize: 28,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}