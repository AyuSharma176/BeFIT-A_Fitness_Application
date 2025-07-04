import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WeightDetailsPage extends StatefulWidget {
  const WeightDetailsPage({Key? key}) : super(key: key);

  @override
  State<WeightDetailsPage> createState() => _WeightDetailsPageState();
}

class _WeightDetailsPageState extends State<WeightDetailsPage> {
  final TextEditingController weightController = TextEditingController();
  List<Map<String, dynamic>> weightData = [];

  @override
  void initState() {
    super.initState();
    _fetchWeightData();
  }

  Future<void> _fetchWeightData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not signed in!'))
      );
      return;
    }


    final now = DateTime.now();
    final fiveMonthsAgo = DateTime(now.year, now.month - 4);

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('weight_logs')
        .where('timestamp', isGreaterThanOrEqualTo: Timestamp.fromDate(now))
        .orderBy('timestamp')
        .get();

    final tempData = <String, Map<String, dynamic>>{};
    for (var doc in snapshot.docs) {
      final data = doc.data();
      final timestamp = data['timestamp'] as Timestamp?;
      final date = timestamp?.toDate() ?? DateTime.now();
      final month = _monthAbbreviation(date.month);

      if (!tempData.containsKey(month) || date.isAfter(DateTime.now().subtract(const Duration(days: 30)))) {
        tempData[month] = {
          'month': month,
          'weight': (data['weight'] as num?)?.toDouble() ?? 0.0,
        };
      }
    }

    final sortedKeys = tempData.keys.toList();
    sortedKeys.sort((a, b) => _monthIndex(a).compareTo(_monthIndex(b)));

    setState(() {
      weightData = sortedKeys.map((k) => tempData[k]!).toList();
    });
  }

  int _monthIndex(String monthAbbr) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months.indexOf(monthAbbr);
  }

  String _monthAbbreviation(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  Future<void> _saveWeight() async {
    final newWeight = double.tryParse(weightController.text.trim());
    if (newWeight == null) return;

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('weight_logs')
        .add({
      'weight': newWeight,
      'timestamp': Timestamp.now(),
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save weight: $error')),
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Weight updated to ${newWeight.toStringAsFixed(1)} kg')),
    );

    weightController.clear();
    await _fetchWeightData();

    // Navigate back to ProgressPage
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Text(
                    'Weight',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Past 5 Months',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 180,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: weightData.map((data) => _WeightBar(
                    month: data['month'],
                    height: (data['weight'] - 60) * 5,
                    weight: data['weight'],
                  )).toList(),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Update Weight',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter new weight (kg)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.monitor_weight),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveWeight,
                        child: const Text('Save'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
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
}

class _WeightBar extends StatelessWidget {
  final String month;
  final double height;
  final double weight;

  const _WeightBar({
    required this.month,
    required this.height,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('${weight.toStringAsFixed(1)} kg', style: const TextStyle(fontSize: 12)),
        Container(
          width: 20,
          height: height,
          margin: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        Text(month, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
