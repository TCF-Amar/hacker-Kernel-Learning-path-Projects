import 'package:bmi/tabs/calculate_screen.dart';
import 'package:flutter/material.dart';

import '../cards/gender_card.dart';
import '../cards/info_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String selectedGender;
  double height = 100;
  int weight = 0;
  int age = 0;

  void increaseWeight() {
    setState(() {
      weight++;
    });
  }

  void decreaseWeight() {
    setState(() {
      if (weight > 1) weight--;
    });
  }

  void increaseAge() {
    setState(() {
      age++;
    });
  }

  void decreaseAge() {
    setState(() {
      if (age > 1) age--;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedGender = "";
    height = 100;
    weight = 50;
    age = 18;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final h = size.height;
    final w = size.width;

    return Padding(
      padding: EdgeInsets.all(w * 0.05),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        selectedGender = "male";
                      });
                    },
                    child: GenderCard(
                      title: "Male",
                      icon: Icons.male,
                      selectedGender: selectedGender,
                    ),
                  ),
                ),
                SizedBox(width: w * 0.04),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        selectedGender = "female";
                      });
                    },
                    child: GenderCard(
                      title: "Female",
                      icon: Icons.female,
                      selectedGender: selectedGender,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: h * 0.02),

          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff1D1E33),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(w * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Height",
                    style: TextStyle(color: Colors.white70, fontSize: w * 0.05),
                  ),

                  SizedBox(height: h * 0.02),

                  // Height Number Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        height.toStringAsFixed(3),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: w * 0.13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: w * 0.02),
                      Text(
                        "cm",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: w * 0.05,
                        ),
                      ),
                    ],
                  ),

                  Slider(
                    value: height.clamp(100.0, 220.0),
                    min: 100,
                    max: 220,
                    onChanged: (value) {
                      setState(() {
                        height = value.clamp(100.0, 220.0);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: h * 0.02),

          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  child: InfoCard(
                    title: "Weight",
                    value: weight.toString(),
                    inc: increaseWeight,
                    dec: decreaseWeight,
                  ),
                ),
                SizedBox(width: w * 0.04),
                Expanded(
                  child: InfoCard(
                    title: "Age",
                    value: age.toString(),
                    inc: increaseAge,
                    dec: decreaseAge,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: h * 0.03),

          SizedBox(
            width: double.infinity,
            height: h * 0.07,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                var res = await showDialog(
                  context: context,
                  builder: (_) => CalculateScreen(
                    gender: selectedGender,
                    height: height,
                    weight: weight,
                    age: age,
                  ),
                );
              },
              child: Text(
                "CALCULATE",
                style: TextStyle(
                  fontSize: w * 0.06,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
