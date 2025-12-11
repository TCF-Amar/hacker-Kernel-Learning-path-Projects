class Calculate {
  String input = "";
  String firstNum = "";
  String op = "";
  String res = "";

  final List operators = ["+", "-", "×", "÷", "%"];

  void onBtnClick(String text) {
    if (text == "C") {
      clearAll();
      return;
    }

    if (text == "Del") {
      deleteLast();
      return;
    }

    if (operators.contains(text)) {
      handleOperator(text);
      return;
    }

    if (text == "=") {
      calculateFinal();
      return;
    }

    input += text;
  }


  void deleteLast() {
    if (input.isNotEmpty) {
      input = input.substring(0, input.length - 1);
    }
  }

  bool containsOperator(String val) {
    return val.contains('+') ||
        val.contains('-') ||
        val.contains('×') ||
        val.contains('÷') ||
        val.contains('%');
  }


  void handleOperator(String newOp) {

    if (firstNum.isNotEmpty && input.isEmpty) {
      op = newOp;
      return;
    }

    if (firstNum.isEmpty && input.isNotEmpty && res.isNotEmpty && containsOperator(input)) {
      firstNum = res;
      input = "";
      op = newOp;
      return;
    }
    if (firstNum.isNotEmpty && input.isNotEmpty && op.isNotEmpty) {
      res = performOperation(
        double.parse(firstNum),
        double.parse(input),
        op,
      );

      firstNum = res;
      input = "";

    } else {
      firstNum = input;
      input = "";
    }

    op = newOp;
  }


  void calculateFinal() {
    if (firstNum.isEmpty || input.isEmpty || op.isEmpty) return;


    res = performOperation(
      double.parse(firstNum),
      double.parse(input),
      op,
    );

    input = "$firstNum$op$input";
    firstNum = "";
    op = "";
  }


  String performOperation(double num1, double num2, String operator) {
    double result = 0;

    switch (operator) {
      case "+":
        result = num1 + num2;
        break;
      case "-":
        result = num1 - num2;
        break;
      case "×":
        result = num1 * num2;
        break;
      case "÷":
        if (num2 == 0) return "Na Na Na Ye Toh Nahi Hoga";
        result = num1 / num2;
        break;
      case "%":
        if (num2 == 0) return "Na Na Na Ye Toh Nahi Hoga";
        result = num1 % num2;
        break;
    }

    return clean(result);
  }


  String clean(double val) {
    if (val == val.toInt()) {
      return val.toInt().toString();
    }
    return val.toString();
  }


  void clearAll() {
    input = "";
    firstNum = "";
    // secondNum = "";
    op = "";
    res = "";
  }
}
