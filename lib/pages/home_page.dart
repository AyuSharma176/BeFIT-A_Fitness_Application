import 'dart:ui';
import 'package:befit/services/frostedGlassEffect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:befit/services/app_theme.dart';
import 'package:befit/services/motivational_service.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../services/dark_mode_controller.dart';
import 'chat_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cardio_section.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key}); // Added key for best practice

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}
class _MainHomePageState extends State<MainHomePage> {

  final ThemeController themeController = Get.find();
  final user = FirebaseAuth.instance.currentUser;

  final User? _user = FirebaseAuth.instance.currentUser; // Use _user for consistency

  late Future<String> _quoteFuture;

  String _name = 'Loading...'; // Use _name for state variables
  String _chatResponse = ''; // Not directly used in this snippet, but kept from original
  String? _calorieResult; // From SharedPreferences
  String? _proteinResult; // From SharedPreferences
  String? _waterIntake; // Fetched from Firestore
  String? _stepsCount; // Fetched from Firestore
  String? _calorieBurnedToday; // Fetched from Firestore
  int _streakCount = 0; // Use _streakCount for consistency

  @override
  void initState() {
    super.initState();
    // Initialize the quote future
    _quoteFuture = MotivationService(GEMINI_API_KEY).getQuote();
    // Load user's display name from Firestore
    _loadUserData();
    // Load calorie and protein results from SharedPreferences
    _loadResults();
    // Load daily activity data (steps, water, calories burned) from Firestore
    _loadDailyActivityData();
    _loadStreakCount();
  }

  /// Fetches the user's name from Firestore based on their UID.
  Future<void> _loadUserData() async {
    if (_user != null) {
      try {
        final doc = await FirebaseFirestore.instance.collection('users').doc(_user!.uid).get();
        final data = doc.data();
        setState(() {
          _name = data?['name'] ?? _user!.displayName ?? 'User';
        });
      } catch (e) {
        debugPrint("Error fetching user data: $e"); // Use debugPrint for Flutter logs
        setState(() {
          _name = 'User'; // Fallback name on error
        });
      }
    } else {
      setState(() {
        _name = 'Guest'; // If no user is logged in
      });
    }
  }

  /// Loads last saved calorie and protein results from SharedPreferences.
  Future<void> _loadResults() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _calorieResult = prefs.getString('last_calorie_result');
      _proteinResult = prefs.getString('last_protein_result');
    });
  }

  /// Loads daily activity data (stepCount, waterCups, calorieBurned) from Firestore.
  /// Assumes data is stored under 'users/{uid}/activity_logs/{YYYY-MM-DD}'.
  Future<void> _loadDailyActivityData() async {
    if (_user != null) {
      try {
        // Format today's date to match the Firestore document ID format (e.g., "2025-07-06")
        final today = DateTime.now();
        final formattedDate = "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

        debugPrint('Attempting to load daily activity for user: ${_user!.uid} on date: $formattedDate');

        // Construct the Firestore path to the daily activity document
        final docSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(_user!.uid)
            .collection('activity_logs') // Corrected from 'dailyActivity' as per previous discussion
            .doc(formattedDate)
            .get();

        if (docSnapshot.exists) {
          // If the document exists, retrieve its data
          final data = docSnapshot.data();
          debugPrint('Daily activity document found. Data: $data');

          setState(() {
            // Assign fetched values to state variables, defaulting to '0' if null
            _stepsCount = data?['stepCount']?.toString() ?? '0';
            _waterIntake = data?['waterCups']?.toString() ?? '0';
            _calorieBurnedToday = data?['calorieBurned']?.toString() ?? '0';
          });
          debugPrint('Steps loaded: $_stepsCount, Water loaded: $_waterIntake, Calories Burned loaded: $_calorieBurnedToday');
        } else {
          // If the document does not exist for today, set default '0' values
          debugPrint("No daily activity data found for today: $formattedDate (Document does not exist)");
          setState(() {
            _stepsCount = '0';
            _waterIntake = '0';
            _calorieBurnedToday = '0';
          });
        }
      } catch (e) {
        // Catch any errors during Firestore fetching and set 'NA'
        debugPrint("Error fetching daily activity data: $e");
        setState(() {
          _stepsCount = 'Start';
          _waterIntake = 'Start';
          _calorieBurnedToday = 'Start';
        });
      }
    } else {
      // If no user is logged in, set 'NA'
      debugPrint("No user logged in, cannot load daily activity data.");
      setState(() {
        _stepsCount = 'Start';
        _waterIntake = 'Start';
        _calorieBurnedToday = 'Start';
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
  String _getGreeting() { // Changed to private method
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  /// Helper function to display 'NA' for null, empty, or '0' values.
  String _displayValue(String? value, {String? fallback}) { // Changed to private method
    if (value == null || value.isEmpty || value == '0') {
      return fallback ?? 'NA'; // Use fallback if provided, else default to 'NA'
    }
    return value;
  }

  Future<void> _loadStreakCount() async { // Changed to private method
    if (_user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(_user!.uid)
        .collection('activity_logs') // Assuming streak is stored here
        .doc('streak') // Assuming a specific document for streak
        .get();

    if (doc.exists) {
      final data = doc.data();
      setState(() {
        _streakCount = data?['streakCount'] ?? 0;
      });
    } else {
      debugPrint("No streak document found for user: ${_user!.uid}");
      setState(() {
        _streakCount = 0; // Reset to 0 if no streak document
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    themeController.onThemeChanged = () {
      if (mounted) setState(() {});
    };
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
                      debugPrint('Error loading quote: ${snapshot.error}');
                      return Text(
                        "❌ Couldn't load quote",
                        style: TextStyle(color: AppTheme.titleTextColor),
                      );
                    } else {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.appBarBg.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [ // Changed to const for optimization
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
                                style: TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color: AppTheme.titleTextColor,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.refresh, color: AppTheme.titleTextColor),
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
                  '${_getGreeting()},',
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
                  _name, // Use private _name
                  style: GoogleFonts.berkshireSwash(
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
                _buildWorkoutStreak(), // Changed to private method

                const SizedBox(height: 10),

                // Daily Goals Card (now includes Firestore data)
                _buildDailyGoals(), // Changed to private method

                const SizedBox(height: 20),

                // Start Workout Button
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle( // Removed const here as WidgetStateProperty.all might not be const callable
                        backgroundColor: WidgetStateProperty.all(AppTheme.appBarBg), // Changed from WidgetStatePropertyAll
                        elevation: WidgetStateProperty.all(6), // Changed from WidgetStatePropertyAll
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Progresspage()),
                      ),
                      child: Text('Start Workout',
                          style: TextStyle(color: AppTheme.titleTextColor, fontWeight: FontWeight.bold, letterSpacing: 1)),
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
  Widget _buildWorkoutStreak() { // Changed to private method
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.88,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.transparent, // Keeps color transparent
          borderRadius: BorderRadius.circular(28.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '🔥 Workout Streak',
              style: GoogleFonts.notoSans(
                color: AppTheme.textColor,
                fontSize: 24,
                fontWeight: FontWeight.w600,
                shadows: [
                  Shadow(
                    offset: Offset(0, 0),
                    blurRadius: 8,
                    color: AppTheme.textShadowColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            FrostedGlassBox(
              width: double.infinity,
              height: 60,
              color: AppTheme.titleTextColor.withOpacity(0.15),
              padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(7, (index) {
                  return index < _streakCount // Use private _streakCount
                      ? const Text(
                    '🔥',
                    style: TextStyle(fontSize: 28),
                  )
                      : Text(
                    '◯',
                    style: TextStyle(fontSize: 28, color: AppTheme.titleTextColor),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }


  /// Builds the daily goals display, including data from SharedPreferences and Firestore.
  Widget _buildDailyGoals() { // Changed to private method
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width * 0.84,
        height: 350,
        decoration: BoxDecoration(
          color: AppTheme.textShadowColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(28.0),
          boxShadow: [
            BoxShadow(
              color: AppTheme.appBarBg.withOpacity(0.35),
              blurRadius: 4,
              offset: const Offset(0, 3), // Added const
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
                fontSize: 24,
                letterSpacing: 1,
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

                dailyGoalsTile('Protein', displayValue(proteinResult, fallback:'+/-'), themeController.isDarkMode.value ? Color(0xFF000000): Colors.teal.shade400),
                // Display Calories from SharedPreferences
                dailyGoalsTile('Calories', displayValue(calorieResult, fallback:'+/-'), themeController.isDarkMode.value ? Color(0xFF000000): Colors.red.shade400),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Display Water from Firestore (waterCups)

                dailyGoalsTile('Water', '${displayValue(waterIntake)} cups', themeController.isDarkMode.value ? Color(0xFF000000): Colors.blueAccent),
                // Display Steps from Firestore (stepCount)
                dailyGoalsTile('Steps', displayValue(stepsCount), themeController.isDarkMode.value ? Color(0xFF000000): Colors.orange),

              ],
            ),
          ],
        ),
      ),
    );
  }

  /// A reusable tile widget for displaying daily goals.
  Widget _dailyGoalsTile(String title, String value, Color color) { // Changed to private method
    double height = 120;
    double radius = height / 2;
    return Container(
      width: MediaQuery.of(context).size.width * 0.32,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.6),
            blurRadius: 20,
            offset: const Offset(2, 2), // Added const
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: BackdropFilter(
          blendMode: BlendMode.luminosity,
          filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0), // Sigma values are 0.0, so blur is effectively off.
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300.withOpacity(0.5),
              borderRadius: BorderRadius.circular(radius+2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.notoSans(
                      color: AppTheme.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: GoogleFonts.notoSans(
                      color: AppTheme.textColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
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
