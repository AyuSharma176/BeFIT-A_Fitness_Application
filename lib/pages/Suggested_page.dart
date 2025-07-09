// import 'package:flutter/material.dart';
// import 'day_workout_page.dart';
// import 'package:befit/services/app_theme.dart';
//
// class SuggestedPage extends StatelessWidget {
//   SuggestedPage({super.key});
//
//   final List<String> days = [
//     'Monday', 'Tuesday', 'Wednesday',
//     'Thursday', 'Friday', 'Saturday', 'Sunday'
//   ];
//
//   final Map<String, List<Map<String, dynamic>>> workoutData = {
//     'Monday': [
//       {'name': 'Bench Press', 'image': 'assets/SuggestedWorkout_images/bench.gif', 'reps': '× 15'},
//       {'name': 'Inclined Bench Press', 'image': 'assets/SuggestedWorkout_images/inclined.gif', 'reps': '× 15'},
//       {'name': 'Declined Bench Press', 'image': 'assets/SuggestedWorkout_images/declined.gif', 'reps': '× 15'},
//       {'name': 'Shoulder Press', 'image': 'assets/SuggestedWorkout_images/shoulder.gif', 'reps': '× 15'},
//       {'name': 'Side Raises', 'image': 'assets/SuggestedWorkout_images/sideraises.gif', 'reps': '× 15'},
//       {'name': 'Front Raises', 'image': 'assets/SuggestedWorkout_images/frontrases.gif', 'reps': '× 15'},
//     ],
//     'Tuesday': [
//       {'name': 'Lat Pull Down', 'image': 'assets/SuggestedWorkout_images/img_2.png', 'reps': '× 15'},
//       {'name': 'Cable Push Down', 'image': 'assets/SuggestedWorkout_images/back.gif', 'reps': '× 15'},
//       {'name': 'Deadlifts', 'image': 'assets/SuggestedWorkout_images/deadlift.png', 'reps': '× 15'},
//       {'name': 'Rear Delt Fly', 'image': 'assets/SuggestedWorkout_images/img_3.png', 'reps': '× 15'},
//     ],
//     'Wednesday': [
//       {'name': 'Bicep Curls', 'image': 'assets/SuggestedWorkout_images/bicepcurl.png', 'reps': '× 15'},
//       {'name': 'Hammer Curls', 'image': 'assets/SuggestedWorkout_images/hammercurl.png', 'reps': '× 15'},
//       {'name': 'Tricep Extensions', 'image': 'assets/SuggestedWorkout_images/tricepcurl.png', 'reps': '× 15'},
//       {'name': 'Skull Crushers', 'image': 'assets/SuggestedWorkout_images/skullcrusher.png', 'reps': '× 15'},
//     ],
//     'Thursday': [
//       {'name': 'Squats', 'image': 'assets/SuggestedWorkout_images/squats.gif', 'reps': '× 15'},
//       {'name': 'Lunges', 'image': 'assets/SuggestedWorkout_images/lunges.png', 'reps': '× 15'},
//       {'name': 'Leg Press', 'image': 'assets/SuggestedWorkout_images/legpress.gif', 'reps': '× 15'},
//       {'name': 'Calf Raises', 'image': 'assets/SuggestedWorkout_images/calfraises.png', 'reps': '× 15'},
//     ],
//     'Friday': [
//       {'name': 'Push-ups', 'image': 'assets/SuggestedWorkout_images/pushups.png', 'reps': '× 15'},
//       {'name': 'Pull-ups', 'image': 'assets/SuggestedWorkout_images/pullups.gif', 'reps': '× 15'},
//       {'name': 'Dips', 'image': 'assets/SuggestedWorkout_images/dips.png', 'reps': '× 15'},
//       {'name': 'Planks', 'image': 'assets/SuggestedWorkout_images/plank.png', 'reps': '× 15'},
//     ],
//     'Saturday': [
//       {'name': 'Mountain Climbers', 'image': 'assets/SuggestedWorkout_images/mountainclimbers.png', 'reps': '× 15'},
//       {'name': 'Jumping Jacks', 'image': 'assets/SuggestedWorkout_images/jumpingjacks.png', 'reps': '× 15'},
//       {'name': 'Burpees', 'image': 'assets/SuggestedWorkout_images/burpees.png', 'reps': '× 15'},
//       {'name': 'High Knees', 'image': 'assets/SuggestedWorkout_images/highknees.png', 'reps': '× 15'},
//     ],
//     'Sunday': [
//       {'name': 'Yoga Stretch', 'image': 'assets/SuggestedWorkout_images/yogastrech.png', 'reps': '× 15'},
//       {'name': 'Breathing', 'image': 'assets/SuggestedWorkout_images/breathing.png', 'reps': '× 15'},
//       {'name': 'Foam Rolling', 'image': 'assets/SuggestedWorkout_images/foamrolling.png', 'reps': '× 15'},
//       {'name': 'Walking', 'image': 'assets/SuggestedWorkout_images/walking.png', 'reps': '× 15'},
//     ],
//   };
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [AppTheme.appBarBg, AppTheme.backgroundColor],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 40),
//             Center(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//                 decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.25),
//                       blurRadius: 12,
//                       offset: Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: const Text(
//                   '💪 Suggested Workouts',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     letterSpacing: 1.2,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Center(
//               child: Text(
//                 "Let's Make You Strong 💥",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white,
//                   letterSpacing: 0.5,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: GridView.builder(
//                 itemCount: days.length,
//                 padding: const EdgeInsets.symmetric(horizontal: 4),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 14,
//                   mainAxisSpacing: 14,
//                   childAspectRatio: 1.0,
//                 ),
//                 itemBuilder: (context, index) {
//                   final day = days[index];
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => DayWorkoutPage(
//                             day: day,
//                             exercises: workoutData[day] ?? [],
//                           ),
//                         ),
//                       );
//                     },
//                     child: AnimatedContainer(
//                       duration: Duration(milliseconds: 300),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.08),
//                         borderRadius: BorderRadius.circular(18),
//                         border: Border.all(color: Colors.white12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 8,
//                             offset: Offset(2, 2),
//                           ),
//                         ],
//                       ),
//                       child: Center(
//                         child: Text(
//                           day,
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Colors.white,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'day_workout_page.dart';
import 'package:befit/services/app_theme.dart';

class SuggestedPage extends StatelessWidget {
  SuggestedPage({super.key});

  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  final Map<String, List<Map<String, dynamic>>> workoutData = {
    'Monday': [
      {
        'name': 'Bench Press',
        'image': 'assets/SuggestedWorkout_images/bench.gif',
        'reps': '× 15',
      },
      {
        'name': 'Inclined Bench Press',
        'image': 'assets/SuggestedWorkout_images/inclined.gif',
        'reps': '× 15',
      },
      {
        'name': 'Declined Bench Press',
        'image': 'assets/SuggestedWorkout_images/declined.gif',
        'reps': '× 15',
      },
      {
        'name': 'Shoulder Press',
        'image': 'assets/SuggestedWorkout_images/shoulder.gif',
        'reps': '× 15',
      },
      {
        'name': 'Side Raises',
        'image': 'assets/SuggestedWorkout_images/sideraises.gif',
        'reps': '× 15',
      },
      {
        'name': 'Front Raises',
        'image': 'assets/SuggestedWorkout_images/frontrases.gif',
        'reps': '× 15',
      },
    ],
    'Tuesday': [
      {
        'name': 'Lat Pull Down',
        'image': 'assets/SuggestedWorkout_images/img_2.png',
        'reps': '× 15',
      },
      {
        'name': 'Cable Push Down',
        'image': 'assets/SuggestedWorkout_images/back.gif',
        'reps': '× 15',
      },
      {
        'name': 'Deadlifts',
        'image': 'assets/SuggestedWorkout_images/deadlift.png',
        'reps': '× 15',
      },
      {
        'name': 'Rear Delt Fly',
        'image': 'assets/SuggestedWorkout_images/img_3.png',
        'reps': '× 15',
      },
    ],
    'Wednesday': [
      {
        'name': 'Bicep Curls',
        'image': 'assets/SuggestedWorkout_images/bicepcurl.png',
        'reps': '× 15',
      },
      {
        'name': 'Hammer Curls',
        'image': 'assets/SuggestedWorkout_images/hammercurl.png',
        'reps': '× 15',
      },
      {
        'name': 'Tricep Extensions',
        'image': 'assets/SuggestedWorkout_images/tricepcurl.png',
        'reps': '× 15',
      },
      {
        'name': 'Skull Crushers',
        'image': 'assets/SuggestedWorkout_images/skullcrusher.png',
        'reps': '× 15',
      },
    ],
    'Thursday': [
      {
        'name': 'Squats',
        'image': 'assets/SuggestedWorkout_images/squats.gif',
        'reps': '× 15',
      },
      {
        'name': 'Lunges',
        'image': 'assets/SuggestedWorkout_images/lunges.png',
        'reps': '× 15',
      },
      {
        'name': 'Leg Press',
        'image': 'assets/SuggestedWorkout_images/legpress.gif',
        'reps': '× 15',
      },
      {
        'name': 'Calf Raises',
        'image': 'assets/SuggestedWorkout_images/calfraises.png',
        'reps': '× 15',
      },
    ],
    'Friday': [
      {
        'name': 'Push-ups',
        'image': 'assets/SuggestedWorkout_images/pushups.png',
        'reps': '× 15',
      },
      {
        'name': 'Pull-ups',
        'image': 'assets/SuggestedWorkout_images/pullups.gif',
        'reps': '× 15',
      },
      {
        'name': 'Dips',
        'image': 'assets/SuggestedWorkout_images/dips.png',
        'reps': '× 15',
      },
      {
        'name': 'Planks',
        'image': 'assets/SuggestedWorkout_images/plank.png',
        'reps': '× 15',
      },
    ],
    'Saturday': [
      {
        'name': 'Mountain Climbers',
        'image': 'assets/SuggestedWorkout_images/mountainclimbers.png',
        'reps': '× 15',
      },
      {
        'name': 'Jumping Jacks',
        'image': 'assets/SuggestedWorkout_images/jumpingjacks.png',
        'reps': '× 15',
      },
      {
        'name': 'Burpees',
        'image': 'assets/SuggestedWorkout_images/burpees.png',
        'reps': '× 15',
      },
      {
        'name': 'High Knees',
        'image': 'assets/SuggestedWorkout_images/highknees.png',
        'reps': '× 15',
      },
    ],
    'Sunday': [
      {
        'name': 'Yoga Stretch',
        'image': 'assets/SuggestedWorkout_images/yogastrech.png',
        'reps': '× 15',
      },
      {
        'name': 'Breathing',
        'image': 'assets/SuggestedWorkout_images/breathing.png',
        'reps': '× 15',
      },
      {
        'name': 'Foam Rolling',
        'image': 'assets/SuggestedWorkout_images/foamrolling.png',
        'reps': '× 15',
      },
      {
        'name': 'Walking',
        'image': 'assets/SuggestedWorkout_images/walking.png',
        'reps': '× 15',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.appBarBg, Colors.transparent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Suggested Workouts',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppTheme.titleTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Let\'s make you strong 💥',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.titleTextColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: days.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  final day = days[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DayWorkoutPage(
                            day: day,
                            exercises: workoutData[day] ?? [],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppTheme.primaryColor, AppTheme.appBarBg],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 5,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          day,
                          style: TextStyle(
                            color: AppTheme.titleTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
