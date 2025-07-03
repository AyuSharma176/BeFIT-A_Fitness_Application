import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'weight_details_page.dart';

class Progresspage extends StatefulWidget {
  const Progresspage({Key? key}) : super(key: key);

  @override
  State<Progresspage> createState() => _ProgresspageState();
}

class _ProgresspageState extends State<Progresspage> {
  bool showCalendar = false;
  String selectedView = 'Week';
  int waterCups = 8;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Toggle Bar
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFE8DAD8),
              ),
              child: Row(
                children: [
                  // Daily Button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showCalendar = false;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: showCalendar ? Colors.transparent : Colors.white,
                        ),
                        child: const Text(
                          'Daily',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),

                  // Calendar Button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showCalendar = true;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: showCalendar ? Colors.white : Colors.transparent,
                        ),
                        child: Text(
                          'Calendar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: showCalendar ? Colors.black : Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Daily OR Calendar Content
            showCalendar ? _buildCalendarView() : _buildDailyView(width),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyView(double width) {
    return Column(
      children: [
        // Stats Cards
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: width < 600 ? 2 : 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _buildCard(
              icon: Icons.local_fire_department,
              title: 'Calories',
              value: '1,024',
              unit: 'kcal',
              footer: 'This Week',
              color: const Color(0xFFFFD6AD),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WeightDetailsPage()),
                );
              },
              child: _buildCard(
                icon: Icons.monitor_weight,
                title: 'Weight',
                value: '75.2',
                unit: 'kg',
                footer: 'This Week',
                color: const Color(0xFFDCF299),
              ),
            ),
            _buildCard(
              icon: Icons.directions_walk,
              title: 'Steps',
              value: '60',
              unit: 'km',
              footer: 'Details',
              color: const Color(0xFFB5F7B5),
            ),
            _buildWaterCard(),
          ],
        ),

        const SizedBox(height: 20),

        // Workout Graph
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.access_time),
                  const SizedBox(width: 8),
                  const Text('Workout', style: TextStyle(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  DropdownButton<String>(
                    value: selectedView,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    underline: const SizedBox(),
                    style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
                    items: ['Week', 'Month', 'Year']
                        .map((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedView = newValue!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 130,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: _buildWorkoutBars(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWaterCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFD3CCFB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Icon(Icons.water_drop, color: Colors.black),
          ),
          const SizedBox(height: 12),
          Text(
            '$waterCups cup',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle, color: Colors.black),
                onPressed: () {
                  setState(() {
                    if (waterCups > 0) waterCups--;
                  });
                },
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.add_circle, color: Colors.black),
                onPressed: () {
                  setState(() {
                    waterCups++;
                  });
                },
              ),
            ],
          ),
          const Spacer(),
          const Align(
            alignment: Alignment.bottomLeft,
            child: Text('Tap + or - to adjust', style: TextStyle(fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }


  List<Widget> _buildWorkoutBars() {
    if (selectedView == 'Week') {
      return const [
        _Bar(day: 'Sun', height: 30),
        _Bar(day: 'Mon', height: 60),
        _Bar(day: 'Tue', height: 90),
        _Bar(day: 'Wed', height: 70),
        _Bar(day: 'Thu', height: 30),
        _Bar(day: 'Fri', height: 60),
        _Bar(day: 'Sat', height: 80),
      ];
    } else if (selectedView == 'Month') {
      return const [
        _Bar(day: 'W1', height: 80),
        _Bar(day: 'W2', height: 50),
        _Bar(day: 'W3', height: 60),
        _Bar(day: 'W4', height: 40),
      ];
    } else {
      return const [
        _Bar(day: 'Jan', height: 50),
        _Bar(day: 'Feb', height: 30),
        _Bar(day: 'Mar', height: 70),
        _Bar(day: 'Apr', height: 90),
        _Bar(day: 'May', height: 60),
        _Bar(day: 'Jun', height: 40),
      ];
    }
  }

  Widget _buildCalendarView() {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: DateTime.now(),
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      onDaySelected: (selectedDay, focusedDay) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Selected: ${selectedDay.toLocal()}")),
        );
      },
      selectedDayPredicate: (day) => false,
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String value,
    required String unit,
    required String footer,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(height: 12),
          Text('$value $unit',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Spacer(),
          Row(
            children: [
              Text(
                footer,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 14),
            ],
          )
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  final String day;
  final double height;

  const _Bar({required this.day, required this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 16,
          height: height,
          decoration: BoxDecoration(
            color: Colors.purpleAccent,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(day, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
