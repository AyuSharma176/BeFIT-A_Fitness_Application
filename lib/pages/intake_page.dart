import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/app_theme.dart';

class DietPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Calculator'),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.6,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/intake_images/fitness-man.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Column(
              children: [
                Spacer(flex: 6),
                ElevatedButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => IntakeCalculatorScreen(isProtein: false)),
                  ),
                  icon: Icon(Icons.local_fire_department),
                  label: Text('Calorie Intake Calculator'),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => IntakeCalculatorScreen(isProtein: true)),
                  ),
                  icon: Icon(Icons.restaurant_rounded),
                  label: Text('Protein Intake Calculator'),
                ),
                Spacer(flex: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IntakeCalculatorScreen extends StatefulWidget {
  final bool isProtein;
  IntakeCalculatorScreen({required this.isProtein});

  @override
  _IntakeCalculatorScreenState createState() => _IntakeCalculatorScreenState();
}

class _IntakeCalculatorScreenState extends State<IntakeCalculatorScreen> {
  final ageController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  String weightUnit = 'Kg';
  String heightUnit = 'Cm';
  String gender = 'Male';
  String activityLevel = '';
  String goal = '';
  String result = '';

  void calculateResult() {
    final age = int.tryParse(ageController.text) ?? 0;
    final weight = double.tryParse(weightController.text) ?? 0;
    final height = double.tryParse(heightController.text) ?? 0;

    double weightKg = weightUnit == 'Kg' ? weight : weight * 0.453592;
    double heightCm = heightUnit == 'Cm' ? height : height * 30.48;

    if (age > 150 || weight <= 0 || height <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter valid inputs.')));
      return;
    }

    double activityFactor = 1.2;
    if (activityLevel == 'Moderate') activityFactor = 1.55;
    else if (activityLevel == 'High') activityFactor = 1.9;

    if (!widget.isProtein) {
      double bmr = gender == 'Male'
          ? 10 * weightKg + 6.25 * heightCm - 5 * age + 5
          : 10 * weightKg + 6.25 * heightCm - 5 * age - 161;
      double tdee = bmr * activityFactor;

      if (goal == 'Lose Weight') tdee *= 0.85;
      else if (goal == 'Gain Muscle') tdee *= 1.15;

      result = '${tdee.toStringAsFixed(0)} kcal/day';
    } else {
      double multiplier = 0.8;
      if (activityLevel == 'Moderate') multiplier = 1.2;
      else if (activityLevel == 'High') multiplier = 2.0;
      if (goal == 'Gain Muscle') multiplier += 0.3;

      double protein = weightKg * multiplier;
      result = '${protein.toStringAsFixed(0)} grams/day';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Your Result"),
        content: Text(result),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isProtein ? "Protein Intake Calculator" : "Calorie Intake Calculator";
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
            SizedBox(height: 12),
            Text('Enter your details to calculate your daily needs.', textAlign: TextAlign.center),
            SizedBox(height: 24),

            Text('Age:'),
            TextField(
              controller: ageController,
              decoration: InputDecoration(hintText: 'Enter your age', suffixText: 'Years'),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            SizedBox(height: 16),

            Text('Weight:'),
            TextField(
              controller: weightController,
              decoration: InputDecoration(
                hintText: 'Enter your weight',
                suffixIcon: DropdownButton<String>(
                  value: weightUnit,
                  onChanged: (val) => setState(() => weightUnit = val!),
                  items: ['Kg', 'Lbs'].map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            SizedBox(height: 16),

            Text('Height:'),
            TextField(
              controller: heightController,
              decoration: InputDecoration(
                hintText: 'Enter your height',
                suffixIcon: DropdownButton<String>(
                  value: heightUnit,
                  onChanged: (val) => setState(() => heightUnit = val!),
                  items: ['Cm', 'Ft'].map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            SizedBox(height: 16),

            Text('Gender:'),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: Text('Male'),
                    value: 'Male',
                    groupValue: gender,
                    onChanged: (val) => setState(() => gender = val!),
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text('Female'),
                    value: 'Female',
                    groupValue: gender,
                    onChanged: (val) => setState(() => gender = val!),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            Text('Activity Level:'),
            DropdownButtonFormField<String>(
              value: activityLevel.isEmpty ? null : activityLevel,
              hint: Text('Select Activity Level'),
              onChanged: (val) => setState(() => activityLevel = val!),
              items: ['Low', 'Moderate', 'High'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
            ),
            SizedBox(height: 16),

            Text('Goal:'),
            DropdownButtonFormField<String>(
              value: goal.isEmpty ? null : goal,
              hint: Text('Select your goal'),
              onChanged: (val) => setState(() => goal = val!),
              items: ['Lose Weight', 'Maintain Weight', 'Gain Muscle'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
            ),
            SizedBox(height: 24),

            ElevatedButton(
              onPressed: calculateResult,
              child: Text("Calculate"),
            ),
          ],
        ),
      ),
    );
  }
}
