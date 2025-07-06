import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/app_theme.dart';
import 'weight_details_page.dart';

class Progresspage extends StatefulWidget {
  const Progresspage({Key? key}) : super(key: key);

  @override
  State<Progresspage> createState() => _ProgresspageState();
}

class _ProgresspageState extends State<Progresspage> {
  int waterCups = 0;
  int calories = 0;
  int steps = 0;
  double currentWeight = 0.0;
  List<Map<String, dynamic>> weeklyData = [];

  Timer? _timer;
  int _seconds = 0;
  double _caloriesBurned = 0.0;
  final double caloriesPerSecond = 0.123;

  int _savedSteps = 0;

  @override
  void initState() {
    super.initState();
    _loadTodayData();
    _fetchLatestWeight();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
        _caloriesBurned = _seconds * caloriesPerSecond;
        steps = _savedSteps + (_seconds / 2).floor();
      });
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
  }

  Future<void> _saveProgressAndReset() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final now = DateTime.now();
    final docId =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('activity_logs')
        .doc(docId);

    await docRef.set({
      'calorieBurned': _caloriesBurned,
      'stepCount': steps,
      'waterCups': waterCups,
      'timestamp': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    setState(() {
      _seconds = 0;
      _caloriesBurned = 0.0;
      _savedSteps = steps;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Progress saved to Firebase.")),
    );

    _loadTodayData();
  }

  Future<void> saveDailyProgress({
    required int calories,
    required int steps,
    required int waterCups,
  }) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final today = DateTime.now();
    final docId =
        "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('activity_logs')
        .doc(docId)
        .set({
          'calorieBurned': calories,
          'stepCount': steps,
          'waterCups': waterCups,
          'timestamp': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
  }

  Future<Map<String, dynamic>> fetchTodayProgress() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final today = DateTime.now();
    final docId =
        "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('activity_logs')
        .doc(docId)
        .get();

    return doc.exists ? doc.data() as Map<String, dynamic> : {};
  }

  Future<List<Map<String, dynamic>>> fetchPast7DaysProgress() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final today = DateTime.now();
    final DateTime startOfToday = DateTime(today.year, today.month, today.day);
    final DateTime weekAgo = startOfToday.subtract(const Duration(days: 6));
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('activity_logs')
        .where('timestamp', isGreaterThanOrEqualTo: Timestamp.fromDate(weekAgo))
        .orderBy('timestamp')
        .get();
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<void> _fetchLatestWeight() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('weight_logs')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();
    if (snapshot.docs.isNotEmpty) {
      final data = snapshot.docs.first.data();
      final weight = (data['weight'] as num?)?.toDouble() ?? 0.0;
      setState(() {
        currentWeight = weight;
      });
    }
  }

  Future<void> _loadTodayData() async {
    final data = await fetchTodayProgress();
    final weekData = await fetchPast7DaysProgress();
    setState(() {
      calories = data['calorieBurned']?.toInt() ?? 0;
      steps = data['stepCount']?.toInt() ?? 0;
      _savedSteps = steps;
      waterCups = data['waterCups'] ?? 0;
      weeklyData = weekData;
    });
  }

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
          title: const Text('Track Workout'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildDailyView(MediaQuery.of(context).size.width),
              _buildWaterIntakeCard(),
              _buildCaloriesAndStepsCard(),
              _buildWeightDetailsCard(),
              if (weeklyData.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Weekly Summary',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 180,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: weeklyData.map((data) {
                            final timestamp = data['timestamp'] as Timestamp?;
                            final date = timestamp?.toDate() ?? DateTime.now();
                            final day = [
                              'Mon',
                              'Tue',
                              'Wed',
                              'Thu',
                              'Fri',
                              'Sat',
                              'Sun',
                            ][date.weekday - 1];
                            final steps =
                                (data['stepCount'] as num?)?.toDouble() ?? 0.0;
                            final calories =
                                (data['calorieBurned'] as num?)?.toDouble() ??
                                0.0;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 10,
                                      height: (steps / 2000) * 100,
                                      color: Colors.green,
                                    ),
                                    const SizedBox(width: 4),
                                    Container(
                                      width: 10,
                                      height: (calories / 200) * 100,
                                      color: Colors.orange,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  day,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _standardCard({required String title, required Widget child}) {
    return Card(
      color: Colors.black.withOpacity(0.4),
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildDailyView(double width) {
    final duration = Duration(seconds: _seconds);
    final time =
        "${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}";

    return Column(
      children: [
        Text(
          time,
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Calories Burned: ${_caloriesBurned.toStringAsFixed(2)} kcal",
          style: const TextStyle(fontSize: 20, color: Colors.white70),
        ),
        const SizedBox(height: 8),
        Text(
          "Steps: $steps",
          style: const TextStyle(fontSize: 20, color: Colors.white70),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start'),
              onPressed: _startTimer,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.pause),
              label: const Text('Pause'),
              onPressed: _pauseTimer,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text('Save'),
              onPressed: () async {await updateStreakOnWorkout();
                await _saveProgressAndReset();}
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildWaterIntakeCard() {
    return _standardCard(
      title: 'Water Intake',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Cups: $waterCups',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.remove_circle_outline,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    if (waterCups > 0) waterCups--;
                  });
                  saveDailyProgress(
                    calories: calories,
                    steps: steps,
                    waterCups: waterCups,
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline, color: Colors.white),
                onPressed: () {
                  setState(() {
                    waterCups++;
                  });
                  saveDailyProgress(
                    calories: calories,
                    steps: steps,
                    waterCups: waterCups,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCaloriesAndStepsCard() {
    return _standardCard(
      title: 'Daily Summary',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Calories Burned: $calories kcal',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Total Steps: $steps',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightDetailsCard() {
    return _standardCard(
      title: 'Weight Details',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Weight: ${currentWeight.toStringAsFixed(1)} kg',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WeightDetailsPage(),
                ),
              );
              _fetchLatestWeight();
            },
            child: const Text('View/Add Weight Details'),
          ),
        ],
      ),
    );
  }
}
Future<void> updateStreakOnWorkout() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final now = DateTime.now();
  final todayStr = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

  final streakDocRef = FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('activity_logs')
      .doc('streak');

  final streakDoc = await streakDocRef.get();

  if (streakDoc.exists) {
    final data = streakDoc.data();
    final lastDateStr = data?['lastWorkoutDate'];
    final lastDate = DateTime.tryParse(lastDateStr ?? '') ?? DateTime(2000);
    final streakCount = data?['streakCount'] ?? 0;

    final difference = now.difference(lastDate).inDays;

    if (difference == 1) {
      await streakDocRef.set({
        'streakCount': streakCount + 1,
        'lastWorkoutDate': todayStr,
      });
    } else if (difference == 0) {
      // Already logged today – do nothing
    } else {
      await streakDocRef.set({
        'streakCount': 1,
        'lastWorkoutDate': todayStr,
      });
    }
  } else {
    await streakDocRef.set({
      'streakCount': 1,
      'lastWorkoutDate': todayStr,
    });
  }
}
