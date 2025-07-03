import 'package:flutter/material.dart';

class WeightDetailsPage extends StatelessWidget {
  const WeightDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weightController = TextEditingController();

    final List<Map<String, dynamic>> weightData = [
      {'month': 'Mar', 'weight': 76.2},
      {'month': 'Apr', 'weight': 75.8},
      {'month': 'May', 'weight': 75.3},
      {'month': 'Jun', 'weight': 75.1},
      {'month': 'Jul', 'weight': 74.8},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom Header with Centered Title and Back Button
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
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Past 5 Months Label
              const Text(
                'Past 5 Months',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Weight Chart
              SizedBox(
                height: 180,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: weightData
                      .map((data) => _WeightBar(
                    month: data['month'],
                    height: (data['weight'] - 73) * 20,
                    weight: data['weight'],
                  ))
                      .toList(),
                ),
              ),

              const SizedBox(height: 30),

              // Update Weight Section
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
                        onPressed: () {
                          String newWeight = weightController.text.trim();
                          if (newWeight.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Weight updated to $newWeight kg')),
                            );
                            // Add Firestore/local update logic here
                          }
                        },
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
