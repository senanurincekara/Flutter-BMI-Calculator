import 'package:bmi_calculator/screens/result_page.dart';
import 'package:bmi_calculator/themeData.dart/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

enum Gender { male, female }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Gender selectedGender = Gender.female;
  int height = 170;
  int age = 10;
  int weight = 20;

  void selectedgenderFunc(Gender gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  void _incrementAge() {
    setState(() {
      age++;
    });
  }

  void _decrementAge() {
    setState(() {
      age--;
    });
  }

  void _incrementWeight() {
    setState(() {
      weight++;
    });
  }

  void _decrementWeight() {
    setState(() {
      weight--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calculate,
              size: 40,
              color: nonselectedColor,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "BMI CALCULATOR",
              style: TextStyle(
                  color: appBarTextColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _genderNeuCard(
                  gender: Gender.male,
                  title: 'Male',
                  isSelected: selectedGender == Gender.male,
                  onTap: () => selectedgenderFunc(Gender.male),
                  iconData: Icon(Icons.male)),
              _genderNeuCard(
                  gender: Gender.female,
                  title: 'Female',
                  isSelected: selectedGender == Gender.female,
                  onTap: () => selectedgenderFunc(Gender.female),
                  iconData: Icon(Icons.female)),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          _ContainerCard(),
          SizedBox(
            height: 25,
          ),
          _calculateButton()
        ],
      ),
    );
  }

  double _calculateBMI() {
    double newheight = height / 100.0;
    return weight / (newheight * newheight);
  }

  Widget _calculateButton() {
    return GestureDetector(
      onTap: () {
        double bmi = _calculateBMI();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(
              bmi: bmi,
              gender: selectedGender,
              age: age,
              height: height,
            ),
          ),
        );
      },
      child: Neumorphic(
        style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(40),
            ),
            intensity: 0.9,
            depth: 2,
            shape: NeumorphicShape.flat,
            color: nonselectedColor),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width - 50,
          child: Row(
            children: [
              Icon(
                Icons.arrow_circle_right_rounded,
                size: 70,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "CALCULATE",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 4,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        topRight: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_right,
                      color: nonselectedColor,
                    ),
                    Icon(
                      Icons.arrow_right,
                      color: nonselectedColor,
                    ),
                    Icon(
                      Icons.arrow_right,
                      color: nonselectedColor,
                    ),
                    Icon(
                      Icons.arrow_right,
                      color: nonselectedColor,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _ContainerCard() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width - 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _heightSliderCard(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _weightAndAgeCard('AGE', age, _incrementAge, _decrementAge),
              _weightAndAgeCard(
                  'WEIGHT (kg)', weight, _incrementWeight, _decrementWeight)
            ],
          )
        ],
      ),
    );
  }

  Widget _weightAndAgeCard(
      String title, int label, VoidCallback increment, VoidCallback decrement) {
    return Neumorphic(
      style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(10),
          ),
          intensity: 0.9,
          depth: 2,
          shape: NeumorphicShape.flat,
          color: selectedColor),
      child: Container(
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width / 2.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            SizedBox(height: 5),
            Text(
              label.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: nonselectedColor),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buttons(Icons.remove, decrement),
                SizedBox(
                  width: 10,
                ),
                _buttons(Icons.add, increment)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buttons(IconData icon, VoidCallback onPressed) {
    return Neumorphic(
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.circle(),
        intensity: 0.9,
        depth: 1,
        shape: NeumorphicShape.flat,
        color: selectedColor,
      ),
      child: IconButton(
        icon: Icon(icon, color: textColor),
        onPressed: onPressed,
      ),
    );
  }

  Widget _heightSliderCard() {
    return Neumorphic(
      style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(10),
          ),
          intensity: 0.9,
          depth: 2,
          shape: NeumorphicShape.flat,
          color: selectedColor),
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width / 2.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Height",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  height.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: textColor),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "cm",
                  style: TextStyle(fontSize: 24, color: textColor),
                ),
              ],
            ),
            SizedBox(
              height: 300,
              child: RotatedBox(
                quarterTurns: -1,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbColor: Colors.white,
                    activeTrackColor: Colors.black,
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 10,
                    ),
                    trackHeight: 8,
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 15.0),
                  ),
                  child: Slider(
                      value: height.toDouble(),
                      min: 100,
                      max: 220,
                      divisions: 120,
                      label: height.round().toString(),
                      onChanged: (double newValue) {
                        setState(() {
                          height = newValue.round();
                        });
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _genderNeuCard(
      {required Gender gender,
      required String title,
      required bool isSelected,
      required VoidCallback onTap,
      required Icon iconData}) {
    return GestureDetector(
      onTap: onTap,
      child: Neumorphic(
        style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(10),
            ),
            intensity: 0.9,
            depth: 2,
            shape: NeumorphicShape.flat,
            color: isSelected ? selectedColor : nonselectedColor),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width / 2.8,
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              SizedBox(
                width: 15,
              ),
              iconData,
              SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
