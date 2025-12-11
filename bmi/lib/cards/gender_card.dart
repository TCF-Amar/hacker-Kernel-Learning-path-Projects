import 'package:flutter/material.dart';

class GenderCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String selectedGender;

  const GenderCard({
    super.key,
    required this.title,
    required this.icon,
    required this.selectedGender,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    bool isSelected = title.toLowerCase() == selectedGender.toLowerCase();

    return Expanded(
      child: Container(
          padding: EdgeInsets.all(w * 0.04),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff444494) : const Color(0xff1D1E33),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: w * 0.18),
            SizedBox(height: w * 0.02),
            Text(
              title,
              style: TextStyle(
                color: Colors.white70,
                fontSize: w * 0.03,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
