import 'package:calucatator/calculat/calculate.dart';
import 'package:flutter/material.dart';

class CalcScreen extends StatefulWidget {
  const CalcScreen({super.key});

  @override
  State<CalcScreen> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {
  final List<String> btn = [
    "C",
    "Del",
    "%",
    "÷",
    "7",
    "8",
    "9",
    "×",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "00",
    "0",
    ".",
    "=",
  ];
  Calculate calculate = Calculate();

  @override
  Widget build(BuildContext context) {
    final orientation = Orientation.portrait;
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.primary,
        title: Center(
          child: Text(
            "Calculator",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              children: [
                // Display Area
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          calculate.firstNum,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          calculate.input,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 35,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              calculate.op,
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            calculate.res.length > 15
                                ? Text(
                                    calculate.res,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    calculate.res,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Buttons Area
                Expanded(
                  flex: orientation == Orientation.portrait ? 6 : 2,
                  child: Container(
                    // padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      // color: Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: GridView.builder(
                      itemCount: btn.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                          ),
                      itemBuilder: (context, index) {
                        return buildButton(btn[index]);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton(String text) {
    Color bgColor;
    Color txtColor = Colors.white;
    double fontSize = 26;

    if (text == "C") {
      bgColor = Colors.redAccent;
    } else if (text == "Del") {
      bgColor = Colors.redAccent;
    } else if (text == "=") {
      bgColor = Colors.blueAccent;
    } else if (["÷", "×", "-", "+", "%"].contains(text)) {
      bgColor = Colors.orange;
    } else {
      bgColor = const Color(0xFF2E2E2E);
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          calculate.onBtnClick(text);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              color: txtColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
