import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:befit/pages/app_theme.dart';

import 'app_theme.dart';

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Please enter your details',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              _customTextField(_weightcontroller, 'Enter your weight (kgs)', theme),
              const SizedBox(height: 20),
              _customTextField(_heightcontroller, 'Enter your height (meters)', theme),
              const SizedBox(height: 20),
              _customTextField(null, 'Enter your age', theme),
              const SizedBox(height: 20),
              _buildRadioTile('Male', theme),
              _buildRadioTile('Female', theme),
              _buildRadioTile('Other', theme),
              const SizedBox(height: 30),
              SizedBox(
                height: 50,
                width: 250,
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
                  child: const Text('Calculate'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _customTextField(TextEditingController? controller, String hint, ThemeData theme) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(hintText: hint),
    );
  }

  Widget _buildRadioTile(String value, ThemeData theme) {
    return RadioListTile(
      activeColor: AppTheme.primaryColor,
      title: Text(value),
      value: value,
      groupValue: gender,
      onChanged: (val) {
        setState(() {
          gender = val!;
        });
      },
    );
  }
}
