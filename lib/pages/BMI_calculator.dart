import 'package:flutter/material.dart';
import 'package:befit/services/app_theme.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class BMIcalculatorPage extends StatelessWidget {
  const BMIcalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BMICalculator();
  }
}

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  String gender= 'Male';
  String _displaytext="";
  Color _color = Colors.transparent;
  Image _image = Image.asset('assets/images/bmi1.png');
  TextEditingController _weightcontroller = TextEditingController();
  TextEditingController _heightcontroller = TextEditingController();
  var result = TextEditingController();

  void BMIcalculate(String weight, String height) async {

    var squareweight = double.parse(weight);
    var squareheight = double.parse(height);

    var res = (squareweight)/(squareheight*squareheight);
    setState(() {
      result.text = res.toStringAsFixed(2);
    });
    if(res < 18.5){
      _displaytext = "UNDERWEIGHT";
      _color = Colors.blueAccent;
    }
    else if (res >= 18.5 && res <= 24.9) {
      _displaytext = "NORMAL";
      _color = Colors.green;
      _image = Image.asset('assets/bmi_images/images/bmi2.png');
    }
    else if (res >= 25 && res <= 29.9) {
      _displaytext = "OVERWEIGHT";
      _color = Colors.yellow;
      _image = Image.asset('assets/bmi_images/images/bmi3.png');
    }

    // Obese
    else if (res >= 30 && res <= 39.9) {
      _displaytext = "OBESE";
      _color =  Colors.orange;
      _image = Image.asset('assets/bmi_images/images/bmi4.png');
    }

    // Extreme
    else if (res >= 40) {
      _displaytext = "MORBIDITY OBESE";
      _color = Colors.red;
      _image = Image.asset('assets/bmi_images/images/bmi5.png');
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xFFDAF1DE),
      appBar: AppBar(
        title: Text('BMI Calculator', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Color(0xFF051F20),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text('Please enter the measurements', textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold ),),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                      hintText: ' Enter your weight(kgs)',
                      hintStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Color(0xFF8EB69B),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      )
                  ),
                  controller: _weightcontroller,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                      hintText: ' Enter your height(meter)',
                      hintStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Color(0xFF8EB69B),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      )
                  ),
                  controller: _heightcontroller,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                SizedBox(height: 20,),
                TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  decoration: InputDecoration(
                      hintText: ' Enter your age',
                      hintStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Color(0xFF8EB69B),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      )
                  ),
                ),
                SizedBox(height: 20),
                RadioListTile(
                  title: Text('Male'),
                  value: 'Male',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                RadioListTile(
                  title: Text('Female'),
                  value: 'Female',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                RadioListTile(
                  title: Text('Other'),
                  value: 'Other',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                SizedBox(height: 30),
                SizedBox(
                  height: 50, width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      BMIcalculate(_weightcontroller.text, _heightcontroller.text);
                      setState(() {
                      });
                      showDialog(context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            backgroundColor: _color,
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _image,
                                Text('Your calculated BMI is '+ result.text, textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),
                                SizedBox(height: 15),

                                AnimatedTextKit(animatedTexts: [
                                  TyperAnimatedText(_displaytext, textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple, backgroundColor: Colors.white70))
                                ])
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('Close'),
                              )
                            ],
                          )
                      );
                    },
                    child: Text('Calculate', style: TextStyle(fontSize: 20, color: Colors.blueGrey, fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}