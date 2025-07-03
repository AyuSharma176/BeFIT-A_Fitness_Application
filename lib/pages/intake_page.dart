import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Intake Calculator',
      theme: AppTheme.theme,
      home: DietPage(),
    );
  }
}

class DietPage extends StatelessWidget {
  const DietPage({super.key});

  Widget customCardButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.brown.shade100,
                  child: Icon(icon, color: Colors.brown),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade800,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.brown.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.brown.shade300, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Choose Calculator')),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 24),
        children: [
          customCardButton(
            icon: Icons.local_fire_department,
            title: 'Calorie Intake Calculator',
            subtitle: 'Calculate your daily calorie needs.',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => IntakeCalculatorScreen(isProtein: false)),
            ),
          ),
          customCardButton(
            icon: Icons.restaurant_rounded,
            title: 'Protein Intake Calculator',
            subtitle: 'Estimate your daily protein intake.',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => IntakeCalculatorScreen(isProtein: true)),
            ),
          ),
          customCardButton(
            icon: Icons.fastfood_rounded,
            title: 'Meal Calculator',
            subtitle: 'Check estimated calories in your meal.',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MealCalculatorScreen()),
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

  Widget buildTextField(String label, TextEditingController controller, String hint, String suffix) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextField(
          controller: controller,
          decoration: InputDecoration(hintText: hint, suffixText: suffix),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
      ],
    );
  }

  Widget buildUnitField(String label, TextEditingController controller, String unit, List<String> options, ValueChanged<String> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(hintText: 'Enter your $label'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            SizedBox(width: 12),
            DropdownButton<String>(
              value: unit,
              onChanged: (String? val) {
                if (val != null) onChanged(val);
              },
              items: options.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isProtein ? "Protein Intake Calculator" : "Calorie Intake Calculator";
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
            SizedBox(height: 12),
            Text('Enter your details to calculate your daily needs.', textAlign: TextAlign.center),
            SizedBox(height: 24),
            buildTextField('Age:', ageController, 'Enter your age', 'Years'),
            SizedBox(height: 16),
            buildUnitField('Weight:', weightController, weightUnit, ['Kg', 'Lbs'], (val) => setState(() => weightUnit = val)),
            SizedBox(height: 16),
            buildUnitField('Height:', heightController, heightUnit, ['Cm', 'Ft'], (val) => setState(() => heightUnit = val)),
            SizedBox(height: 16),
            Text('Gender:'),
            Row(
              children: [
                Expanded(child: RadioListTile(title: Text('Male'), value: 'Male', groupValue: gender, onChanged: (val) => setState(() => gender = val!))),
                Expanded(child: RadioListTile(title: Text('Female'), value: 'Female', groupValue: gender, onChanged: (val) => setState(() => gender = val!))),
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

class MealCalculatorScreen extends StatefulWidget {
  @override
  _MealCalculatorScreenState createState() => _MealCalculatorScreenState();
}

class _MealCalculatorScreenState extends State<MealCalculatorScreen> {
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController foodController = TextEditingController();

  final Map<String, double> foodCaloriesPer100g = {
    'rice': 130,
    'chapati': 104,
    'egg': 155,
    'milk': 42,
    'chicken': 165,
    'banana': 89,
    'apple': 52,
    'paneer': 265,
    'dal': 116,
    'potato': 77,
  };

  void calculateCalories() {
    String food = foodController.text.trim().toLowerCase();
    double quantity = double.tryParse(quantityController.text.trim()) ?? 0;

    if (!foodCaloriesPer100g.containsKey(food)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Food not found in database. Try rice, dal, egg...')),
      );
      return;
    }

    double calPer100g = foodCaloriesPer100g[food]!;
    double estimatedCalories = (calPer100g / 100) * quantity;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Estimated Calories"),
        content: Text("$quantity g of $food ≈ ${estimatedCalories.toStringAsFixed(1)} kcal"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("OK"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meal Calculator")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            Text("Enter Food Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 24),
            DropdownButtonFormField<String>(
              value: foodController.text.isEmpty ? null : foodController.text,
              items: foodCaloriesPer100g.keys.map((food) {
                return DropdownMenuItem(
                  value: food,
                  child: Text(food[0].toUpperCase() + food.substring(1)),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  foodController.text = val!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Select Food Item',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(
                labelText: 'Quantity in grams',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: calculateCalories,
              icon: Icon(Icons.calculate),
              label: Text('Estimate Calories'),
            ),
          ],
        ),
      ),
    );
  }
}