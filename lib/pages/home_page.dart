import 'dart:ui';
import 'package:befit/services/frostedGlassEffect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:befit/services/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cardio_section.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainHomePage extends StatefulWidget {
  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  final user = FirebaseAuth.instance.currentUser;
  String? userName;
  String chatResponse = '';
  String? calorieResult;
  String? proteinResult;
  String name = 'Loading...';
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
        });
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
  }
  Future<void> loadResults() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      calorieResult = prefs.getString('last_calorie_result');
      proteinResult = prefs.getString('last_protein_result');
    });
  }
  String displayValue(String? value) => (value == null || value.isEmpty) ? 'NA' : value;
  @override
  void initState() {
    super.initState();
    loadResults();
    fetchUserData();
  }
  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 17) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    String greeting = getGreeting();
    return Scaffold(
      extendBody: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.appBarBg,
              AppTheme.backgroundColor,
              AppTheme.appBarBg,
            ],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    '$greeting,',
                    style: GoogleFonts.notoSans(
                      color: AppTheme.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
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
                    // 'Jatin Kumar',
                    style: GoogleFonts.oswald(
                      color: AppTheme.textColor,
                      fontSize: 40,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 0),
                          color: AppTheme.textShadowColor.withOpacity(0.5),
                          blurRadius: 50,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
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
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Workout Streak',
                            style: GoogleFonts.notoSans(
                              color: AppTheme.textColor,
                              fontSize: 22,
                              fontWeight: FontWeight.normal,
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
                            width: MediaQuery.of(context).size.width * 0.76,
                            height: 50,
                            child: FrostedGlassBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('🔥'),
                                  Text('🔥'),
                                  Text('🔥'),
                                  Text('🔥'),
                                  Text('🔥'),
                                  Text('🔥'),
                                  Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppTheme.backgroundColor,
                                        width: 2,
                                      ),
                                      color: Colors.white.withOpacity(0.1),
                                    ),
                                    child: Text('🔥'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.84,
                      height: 350,
                      decoration: BoxDecoration(
                        // color: Colors.black.withOpacity(0.20),
                        color: AppTheme.appBarBg.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(28.0),
                        boxShadow: [
                          BoxShadow(
                            // color: Colors.black.withOpacity(0.20),
                            color: AppTheme.appBarBg.withOpacity(0.35),
                            blurRadius: 4,
                            offset: Offset(2, 2),
                            // blurStyle: BlurStyle.outer,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Daily Goals',
                            style: GoogleFonts.notoSans(
                              color: AppTheme.textColor,
                              fontSize: 22,
                              fontWeight: FontWeight.normal,
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
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              dailyGoalsTile(context, 'Protein', displayValue(proteinResult)),
                              dailyGoalsTile(context, 'Calories', displayValue(calorieResult)),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              dailyGoalsTile(context, 'Water', '2L'),
                              dailyGoalsTile(context, 'Steps', '5000'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateColor.resolveWith((states) => AppTheme.appBarBg,)
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Progresspage()),
                        ),
                        child: Text('Start Workout')),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget dailyGoalsTile(context, String title, String? value) {
  double height = 130;
  double radius = height / 2;
  return Container(
    width: MediaQuery.of(context).size.width * 0.34,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        BoxShadow(
          // color: Colors.black.withOpacity(0.6),
          color: AppTheme.appBarBg.withOpacity(0.80),
          blurRadius: 4,
          offset: Offset(2, 2),
          // blurStyle: BlurStyle.outer,
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(radius),
            border: Border.fromBorderSide(BorderSide.none),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: GoogleFonts.notoSans(
                  color: AppTheme.textColor,
                  fontSize: 20,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 0),
                      blurRadius: 1,
                      color: AppTheme.textShadowColor,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Text(
                value!.isEmpty ? 'NA' : value,
                style: GoogleFonts.notoSans(
                  color: AppTheme.textColor,
                  fontSize: 28,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 0),
                      blurRadius: 6,
                      color: AppTheme.textShadowColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    // child: FrostedGlassBox(
    //   width: MediaQuery.of(context).size.width * 0.4,
    //   height: 150,
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Text(
    //         title,
    //         style: GoogleFonts.notoSans(
    //           color: AppTheme.textColor,
    //           fontSize: 20,
    //           shadows: [
    //             Shadow(
    //               offset: Offset(0, 0),
    //               blurRadius: 1,
    //               color: AppTheme.textShadowColor,
    //             ),
    //           ],
    //         ),
    //       ),
    //       SizedBox(height: 5),
    //       Text(
    //         value,
    //         style: GoogleFonts.notoSans(
    //           color: AppTheme.textColor,
    //           fontSize: 28,
    //           shadows: [
    //             Shadow(
    //               offset: Offset(0, 0),
    //               blurRadius: 6,
    //               color: AppTheme.textShadowColor,
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // ),
  );
}
/*
* things left to implement:
*   -backend logic for streak registering. (worked for first time and stopped afterwards)
*   -the Username not fetching from firebase.
*   -the username doesn't display after signup only works after login.
*   -protien and caloire intake stored in sharedspecific.
* */

// Container backup
// Container(
//   width: MediaQuery.of(context).size.width * 0.4,
//   height: 150,
//   decoration: BoxDecoration(
//     color: Colors.black.withOpacity(0.20),
//     borderRadius: BorderRadius.circular(20.0),
//     boxShadow: [
//       BoxShadow(
//         color: Colors.black.withOpacity(0.20),
//         blurRadius: 4,
//         offset: Offset(2, 2),
//         // blurStyle: BlurStyle.outer,
//       ),
//     ],
//   ),
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Text(
//         'Calories',
//         style: GoogleFonts.notoSans(
//           color: AppTheme.textColor,
//           fontSize: 20,
//           shadows: [
//             Shadow(
//               offset: Offset(0, 0),
//               blurRadius: 1,
//               color: AppTheme.textShadowColor,
//             ),
//           ],
//         ),
//       ),
//       SizedBox(height: 5),
//       Text(
//         '2591',
//         style: GoogleFonts.notoSans(
//           color: AppTheme.textColor,
//           fontSize: 28,
//           shadows: [
//             Shadow(
//               offset: Offset(0, 0),
//               blurRadius: 6,
//               color: AppTheme.textShadowColor,
//             ),
//           ],
//         ),
//       ),
//     ],
//   ),
// ),

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
// import '../services/app_theme.dart'; // Make sure AppTheme is properly defined
//
// class MainHomePage extends StatefulWidget {
//   const MainHomePage({super.key});
//
//   @override
//   State<MainHomePage> createState() => _MainHomePageState();
// }
//
// class _MainHomePageState extends State<MainHomePage> {
//   List<bool> weeklyStreak = List.filled(7, false);
//   int streakCount = 0;
//   String userName = 'User';
//   String chatResponse = "Let's build your habits today!";
//
//   @override
//   void initState() {
//     super.initState();
//     initializeStreak();
//   }
//
//   void initializeStreak() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       userName = user.displayName ?? 'User';
//       await updateStreakIfNeeded(user.uid);
//       await loadStreak(user.uid);
//       setState(() {}); // To update the UI after loading
//     }
//   }
//
//   Future<void> updateStreakIfNeeded(String userId) async {
//     final docRef = FirebaseFirestore.instance.collection('users').doc(userId);
//     final doc = await docRef.get();
//
//     final today = DateTime.now();
//     final todayStr = "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
//
//     Map<String, dynamic> data = doc.data() ?? {};
//
//     String? lastUpdated = data['streak']?['lastUpdated'];
//     int currentStreak = data['streak']?['streakCount'] ?? 0;
//     Map<String, dynamic> history = Map<String, dynamic>.from(data['streak']?['history'] ?? {});
//
//     if (lastUpdated == todayStr) return; // Already registered today
//
//     final yesterday = today.subtract(Duration(days: 1));
//     final yesterdayStr = "${yesterday.year}-${yesterday.month.toString().padLeft(2, '0')}-${yesterday.day.toString().padLeft(2, '0')}";
//
//     bool maintainedStreak = history[yesterdayStr] == true;
//
//     history[todayStr] = true;
//
//     await docRef.set({
//       'streak': {
//         'lastUpdated': todayStr,
//         'streakCount': maintainedStreak ? currentStreak + 1 : 1,
//         'history': history,
//       }
//     }, SetOptions(merge: true));
//   }
//
//
//   Future<List<bool>> loadStreak(String userId) async {
//     final doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
//     final history = Map<String, dynamic>.from(doc.data()?['streak']['history'] ?? {});
//
//     List<bool> last7Days = [];
//     final today = DateTime.now();
//
//     for (int i = 6; i >= 0; i--) {
//       final day = today.subtract(Duration(days: i));
//       final dayStr = "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";
//       last7Days.add(history[dayStr] == true);
//     }
//
//     return last7Days;
//   }
//
//   Widget buildStreakBar() {
//     int todayIndex = DateTime.now().weekday - 1;
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 8),
//       margin: EdgeInsets.only(top: 12),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: List.generate(7, (index) {
//           final isToday = index == todayIndex;
//           final isStreak = weeklyStreak[index];
//
//           Widget icon = isStreak
//               ? Text('🔥', style: TextStyle(fontSize: 18))
//               : Container(
//             width: 8,
//             height: 8,
//             decoration: BoxDecoration(
//               color: Colors.redAccent,
//               shape: BoxShape.circle,
//             ),
//           );
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 4.0),
//             child: isToday
//                 ? Container(
//               padding: EdgeInsets.all(6),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(color: Colors.white70, width: 2),
//                 color: Colors.white.withOpacity(0.15),
//               ),
//               child: icon,
//             )
//                 : icon,
//           );
//         }),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true,
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               AppTheme.appBarBg,
//               AppTheme.backgroundColor,
//               AppTheme.appBarBg,
//             ],
//             stops: [0, 0.6, 1],
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 10),
//                 Text(
//                   'Hi',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 26,
//                     fontWeight: FontWeight.normal,
//                     shadows: [
//                       Shadow(
//                         offset: Offset(0, 0),
//                         blurRadius: 10,
//                         color: Colors.white,
//                       )
//                     ],
//                   ),
//                 ),
//                 Text(
//                   userName,
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   chatResponse,
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   'Streak: $streakCount 🔥',
//                   style: TextStyle(color: Colors.orangeAccent, fontSize: 16),
//                 ),
//                 buildStreakBar(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
