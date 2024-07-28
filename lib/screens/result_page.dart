import 'package:bmi_calculator/screens/home_page.dart';
import 'package:bmi_calculator/themeData.dart/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class ResultPage extends StatefulWidget {
  final double bmi;
  final int age;
  final int height;
  final Gender gender;

  ResultPage(
      {required this.bmi,
      required this.gender,
      required this.age,
      required this.height});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    String bmiCategory;
    String message;

    if (widget.bmi < 18.5) {
      bmiCategory = 'Underweight';
      message =
          'You are underweight. It may be beneficial to consult a healthcare provider for personalized advice on how to gain weight in a healthy manner.';
    } else if (widget.bmi < 24.9) {
      bmiCategory = 'Normal weight';
      message =
          'You have a normal weight. Keep up the good work with your balanced diet and regular exercise to maintain this healthy weight range.';
    } else if (widget.bmi < 29.9) {
      bmiCategory = 'Overweight';
      message =
          'You are overweight. Consider adopting healthier eating habits and increasing physical activity to manage your weight effectively.';
    } else {
      bmiCategory = 'Obesity';
      message =
          'You are classified as obese. It is important to seek guidance from a healthcare professional to develop a personalized plan for achieving a healthier weight.';
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appBarTextColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'BMI Result',
          style: TextStyle(color: appBarTextColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _BMIcontainer(),
              SizedBox(
                height: 50,
              ),
              _resultContainer(bmiCategory, message)
            ],
          ),
        ),
      ),
    );
  }

  Widget _resultContainer(String bmiCategory, String message) {
    return Neumorphic(
      style: NeumorphicStyle(
          intensity: 0.35,
          depth: 5,
          shape: NeumorphicShape.flat,
          color: textColor),
      child: Container(
        height: MediaQuery.of(context).size.height / 2.1,
        width: MediaQuery.of(context).size.width / 1.11,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Gender:',
                    style: TextStyle(fontSize: 22, color: rtextColor),
                  ),
                  Text(
                    '${widget.gender == Gender.male ? 'Male' : 'Female'}',
                    style: TextStyle(fontSize: 22, color: nonselectedColor),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Age:',
                    style: TextStyle(fontSize: 22, color: rtextColor),
                  ),
                  Text(
                    '${widget.age}',
                    style: TextStyle(fontSize: 22, color: nonselectedColor),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Height:',
                    style: TextStyle(fontSize: 22, color: rtextColor),
                  ),
                  Text(
                    '${widget.height} cm',
                    style: TextStyle(fontSize: 22, color: nonselectedColor),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Category:',
                    style: TextStyle(fontSize: 22, color: rtextColor),
                  ),
                  Text(
                    '$bmiCategory',
                    style: TextStyle(fontSize: 22, color: bmicolor),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: const Color.fromARGB(62, 255, 255, 255))),
                height: MediaQuery.of(context).size.height / 4.5,
                width: MediaQuery.of(context).size.width / 1.3,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    message,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: rtextColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _BMIcontainer() {
    return Neumorphic(
      style: NeumorphicStyle(
          intensity: 0.6,
          depth: 5,
          shape: NeumorphicShape.flat,
          color: selectedColor),
      child: Container(
        height: MediaQuery.of(context).size.height / 4,
        width: MediaQuery.of(context).size.width / 1.5,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "Your BMI result:",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: nonselectedColor),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${widget.bmi.toStringAsFixed(1)}',
              style: TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  color: nonselectedColor),
            )
          ],
        ),
      ),
    );
  }
}
