import 'package:befit/services/frostedGlassEffect.dart';
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
  String _image = 'assets/bmi_images/bmi1.png';
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

    double res = (squareweight*10000) / (squareheight * squareheight);

    setState(() {
      result.text = res.toStringAsFixed(2);

      if (res < 18.5) {
        _displaytext = "UNDERWEIGHT";
        _image = 'assets/bmi_images/bmi1.png';
        _color = Colors.blueAccent;
      } else if (res <= 24.9) {
        _displaytext = "NORMAL";
        _color = Colors.green;
        _image = 'assets/bmi_images/bmi2.png';
      } else if (res <= 29.9) {
        _displaytext = "OVERWEIGHT";
        _color = Colors.amber;
        _image = 'assets/bmi_images/bmi3.png';
      } else if (res <= 39.9) {
        _displaytext = "OBESE";
        _color = Colors.deepOrange;
        _image = 'assets/bmi_images/bmi4.png';
      } else {
        _displaytext = "MORBIDlY OBESE";
        _color = Colors.red;
        _image ='assets/bmi_images/bmi5.png';
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
          fillColor: Colors.grey.shade100.withOpacity(0.95),
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.titleTextColor, width: 1.5),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
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
              border: Border.all(color: Colors.grey),
            ),
            child: Text(
              g,
              style: TextStyle(
                color: isSelected ? AppTheme.titleTextColor : Colors.black,
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
            stops: [0, 0.6, 1],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FrostedGlassBox(
                  color: AppTheme.titleTextColor.withOpacity(0.35),
                  width: double.infinity,
                  height: 60,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Center(
                    child: Text(
                      'BMI Calculator',
                      style: TextStyle(
                        color: AppTheme.titleTextColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Please enter your details',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                      color: AppTheme.titleTextColor,
                    letterSpacing: 1
                  ),
                ),
                SizedBox(height: 20,),
                _customInputField(_weightcontroller, 'Enter your weight (kgs)'),
                _customInputField(_heightcontroller, 'Enter your height (centi-meters)'),
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
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: _color.withOpacity(0.7),
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                width: 6
                              )),
                          backgroundColor: AppTheme.primaryColor,
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                  ),
                                  padding: EdgeInsets.all(16),
                                  width: 250,
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(_image, fit: BoxFit.fill),
                                  )
                              ),
                              // const SizedBox(height: 10),
                              Text(
                                'Your calculated BMI is ${result.text}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppTheme.titleTextColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 15),
                              AnimatedTextKit(
                                animatedTexts: [
                                  TyperAnimatedText(
                                    speed: Duration(milliseconds: 100),
                                    _displaytext,
                                    textStyle: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 20,
                                          offset: const Offset(0,-5),
                                          color: _color
                                        ),
                                        Shadow(
                                            blurRadius: 20,
                                            offset: const Offset(-5,0),
                                            color: _color
                                        ),
                                        Shadow(
                                            blurRadius: 20,
                                            offset: const Offset(0,5),
                                            color: _color
                                        ),
                                        Shadow(
                                            blurRadius: 20,
                                            offset: const Offset(5,0),
                                            color: _color
                                        )
                                      ],
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.titleTextColor,
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
                              child: Text('Close', style: TextStyle(color: AppTheme.titleTextColor, fontSize: 16
                              )),
                            )
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.appBarBg.withOpacity(0.1)
                    ),
                    child: Text('Calculate',
                        style: TextStyle(fontSize: 20, letterSpacing: 1, fontWeight: FontWeight.bold, color: AppTheme.titleTextColor
                        )),
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
