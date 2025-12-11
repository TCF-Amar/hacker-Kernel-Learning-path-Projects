import 'package:flutter/material.dart';

class CalculateScreen extends StatelessWidget {
  final String gender;
  final double height;
  final int weight;
  final int age;

  const CalculateScreen({
    super.key,
    required this.gender,
    required this.height,
    required this.weight,
    required this.age,
  });

  double calculateBMI() {
    double h = height / 100; // meter me convert
    return weight / (h * h);
  }

  String getCategory(double bmi) {
    if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi < 30) {
      return "Normal";
    } else if (bmi < 35) {
      return "Overweight";
    } else {
      return "Obese";
    }
  }

  @override
  Widget build(BuildContext context) {
    double bmi = calculateBMI();
    String category = getCategory(bmi);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Text("BMI Result"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Gender: $gender",
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            "Height: ${height.toInt()} cm",
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            "Weight: $weight kg",
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            "Age: $age",
            style: const TextStyle(fontSize: 18),
          ),

          const SizedBox(height: 15),

          Text(
            "BMI: ${bmi.toStringAsFixed(1)}",
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Text(
            "Category: $category",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text("OK"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
