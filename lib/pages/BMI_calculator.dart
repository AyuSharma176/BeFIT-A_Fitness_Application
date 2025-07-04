import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:befit/services/app_theme.dart';

class BMIcalculatorPage extends StatelessWidget {
  const BMIcalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BMICalculator();
  }
}

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  String gender = 'Male';
  String _displaytext = "";
  Color _color = Colors.transparent;
  Image _image = Image.asset('assets/bmi_images/bmi1.png');
  final TextEditingController _weightcontroller = TextEditingController();
  final TextEditingController _heightcontroller = TextEditingController();
  final TextEditingController result = TextEditingController();

  void BMIcalculate(String weight, String height) {
    if (weight.isEmpty || height.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter both weight and height")),
      );
      return;
    }

    double? squareweight = double.tryParse(weight);
    double? squareheight = double.tryParse(height);

    if (squareweight == null || squareheight == null || squareheight == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid input. Please check your entries.")),
      );
      return;
    }

    double res = squareweight / (squareheight * squareheight);

    setState(() {
      result.text = res.toStringAsFixed(2);

      if (res < 18.5) {
        _displaytext = "UNDERWEIGHT";
        _color = Colors.blueAccent;
        _image = Image.asset('assets/bmi_images/bmi1.png');
      } else if (res <= 24.9) {
        _displaytext = "NORMAL";
        _color = Colors.green;
        _image = Image.asset('assets/bmi_images/bmi2.png');
      } else if (res <= 29.9) {
        _displaytext = "OVERWEIGHT";
        _color = Colors.amber;
        _image = Image.asset('assets/bmi_images/bmi3.png');
      } else if (res <= 39.9) {
        _displaytext = "OBESE";
        _color = Colors.deepOrange;
        _image = Image.asset('assets/bmi_images/bmi4.png');
      } else {
        _displaytext = "MORBIDITY OBESE";
        _color = Colors.red;
        _image = Image.asset('assets/bmi_images/bmi5.png');
      }
    });
  }

  Widget _customInputField(TextEditingController? controller, String hint) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white.withOpacity(0.95),
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.deepPurple, width: 1.5),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }


  Widget _genderSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: ['Male', 'Female', 'Other'].map((g) {
        final isSelected = gender == g;
        return GestureDetector(
          onTap: () => setState(() => gender = g),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? AppTheme.primaryColor : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: isSelected ? AppTheme.primaryColor : Colors.grey),
            ),
            child: Text(
              g,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
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
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top Heading
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text(
                      'BMI Calculator',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  'Please enter your details',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),

                _customInputField(_weightcontroller, 'Enter your weight (kgs)'),
                _customInputField(_heightcontroller, 'Enter your height (meters)'),
                _customInputField(null, 'Enter your age'),

                const SizedBox(height: 10),
                _genderSelector(),
                const SizedBox(height: 30),

                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      BMIcalculate(_weightcontroller.text, _heightcontroller.text);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          backgroundColor: _color,
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _image,
                              const SizedBox(height: 10),
                              Text(
                                'Your calculated BMI is ${result.text}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 15),
                              AnimatedTextKit(
                                animatedTexts: [
                                  TyperAnimatedText(
                                    _displaytext,
                                    textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                                isRepeatingAnimation: false,
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Close', style: TextStyle(color: Colors.white)),
                            )
                          ],
                        ),
                      );
                    },
                    child: const Text('Calculate', style: TextStyle(fontSize: 16)),
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
