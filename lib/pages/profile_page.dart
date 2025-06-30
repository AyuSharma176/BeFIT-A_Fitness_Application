import 'package:flutter/material.dart';
import '../services/edit.dart'; // Make sure this import is correct

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Your Profile', style: theme.appBarTheme.titleTextStyle),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileHeader(theme),
            const SizedBox(height: 20),
            _buildTabBar(theme),
            const SizedBox(height: 20),
            if (selectedTabIndex == 0) ...[
              _buildDateSelector(theme),
              const SizedBox(height: 20),
              _buildActivityItem(
                icon: Icons.directions_run,
                title: 'Indoor Run',
                duration: '24 min',
                distance: '5.56 km',
                calories: '348 kcal',
                color: Colors.pink,
              ),
              const SizedBox(height: 12),
              _buildActivityItem(
                icon: Icons.directions_bike,
                title: 'Outdoor Cycle',
                duration: '24 min',
                distance: '4.22 km',
                calories: '248 kcal',
                color: Colors.blue,
              ),
            ] else if (selectedTabIndex == 1) ...[
              const SizedBox(height: 20),
              const Text(
                "1200",
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              const Text("Kcal Burned", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Column(
                    children: [
                      Icon(Icons.favorite_border),
                      SizedBox(height: 5),
                      Text("246 Kcal"),
                      Text("Last 7 days"),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.local_fire_department),
                      SizedBox(height: 5),
                      Text("84k Kcal"),
                      Text("All Time"),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.bolt),
                      SizedBox(height: 5),
                      Text("72 Kcal"),
                      Text("Average"),
                    ],
                  ),
                ],
              ),
            ] else if (selectedTabIndex == 2) ...[
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(
                              'https://t4.ftcdn.net/jpg/09/55/69/87/360_F_955698734_605ipMO6Jrvh7ETAZpzfD9InRwnpOkVh.jpg'),
                        ),
                        SizedBox(width: 12),
                        Icon(Icons.bolt, color: Colors.grey),
                        SizedBox(width: 12),
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(
                              'https://t3.ftcdn.net/jpg/10/24/11/58/360_F_1024115848_VTfuHjHj9UVVvrUOaDQqm2clMspgRnGs.jpg'),
                        ),
                        SizedBox(width: 12),
                        Text(
                          "You vs Alexa",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Spacer(),
                        Text("3 workouts", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text("Today, 14 Jul",
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 12),
                    Stack(
                      children: [
                        Container(
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        Container(
                          height: 10,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("2246",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("vs"),
                        Text("6468",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(ThemeData theme) {
    return Column(
      children: const [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(
            'https://via.placeholder.com/150',
          ),
        ),
        SizedBox(height: 10),
        Text("John Doe", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text("johndoe@example.com", style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildTabBar(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildTabItem("Stats", 0),
        _buildTabItem("Kcal", 1),
        _buildTabItem("Duels", 2),
      ],
    );
  }

  Widget _buildTabItem(String label, int index) {
    final bool isSelected = selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() => selectedTabIndex = index);
      },
      child: Column(
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.black : Colors.grey)),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 2,
              width: 40,
              color: Colors.blue,
            ),
        ],
      ),
    );
  }

  Widget _buildDateSelector(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text("Today, 14 Jul", style: TextStyle(fontSize: 14, color: Colors.grey)),
        Icon(Icons.calendar_today, size: 16, color: Colors.grey),
      ],
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required String title,
    required String duration,
    required String distance,
    required String calories,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: 40, color: color),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('$duration · $distance · $calories',
                    style: const TextStyle(color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
