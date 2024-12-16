import 'package:flutter/material.dart';

void main() {
  runApp(const BasicCalculatorApp());
}

class BasicCalculatorApp extends StatelessWidget {
  const BasicCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorHMScreen(),
    );
  }
}

class CalculatorHMScreen extends StatefulWidget {
  const CalculatorHMScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorHMScreen> {
  String displayValue = '0';
  String activeOperator = '';
  double firstOperand = 0;
  double secondOperand = 0;
  bool awaitingInput = true;

  void handleButtonClick(String input) {
    setState(() {
      if (input == 'C') {
        displayValue = '0';
        activeOperator = '';
        firstOperand = 0;
        secondOperand = 0;
        awaitingInput = true;
      } else if (['+', '-', '*', '/'].contains(input)) {
        firstOperand = double.tryParse(displayValue) ?? 0;
        activeOperator = input;
        awaitingInput = true;
      } else if (input == '=') {
        secondOperand = double.tryParse(displayValue) ?? 0;

        switch (activeOperator) {
          case '+':
            displayValue = (firstOperand + secondOperand).toString();
            break;
          case '-':
            displayValue = (firstOperand - secondOperand).toString();
            break;
          case '*':
            displayValue = (firstOperand * secondOperand).toString();
            break;
          case '/':
            if (secondOperand != 0) {
              displayValue = (firstOperand / secondOperand).toString();
            } else {
              displayValue = 'Error';
            }
            break;
        }

        activeOperator = '';
        awaitingInput = true;
      } else {
        if (awaitingInput) {
          displayValue = input;
          awaitingInput = false;
        } else {
          displayValue += input;
        }
      }
    });
  }

  Widget createButton(String label, Color bgColor, Color textColor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: () => handleButtonClick(label),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            backgroundColor: bgColor,
          ),
          child: Text(
            label,
            style: TextStyle(fontSize: 24, color: textColor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              alignment: Alignment.centerRight,
              child: Text(
                displayValue,
                style: const TextStyle(fontSize: 48, color: Colors.white),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    createButton(
                        'C', const Color.fromRGBO(168, 0, 0, 1), Colors.white),
                    createButton('', Colors.black, Colors.white),
                    createButton('', Colors.black, Colors.white),
                    createButton('/', Colors.orange, Colors.white),
                  ],
                ),
                Row(
                  children: [
                    createButton('7', Colors.grey, Colors.white),
                    createButton('8', Colors.grey, Colors.white),
                    createButton('9', Colors.grey, Colors.white),
                    createButton('*', Colors.orange, Colors.white),
                  ],
                ),
                Row(
                  children: [
                    createButton('4', Colors.grey, Colors.white),
                    createButton('5', Colors.grey, Colors.white),
                    createButton('6', Colors.grey, Colors.white),
                    createButton('-', Colors.orange, Colors.white),
                  ],
                ),
                Row(
                  children: [
                    createButton('1', Colors.grey, Colors.white),
                    createButton('2', Colors.grey, Colors.white),
                    createButton('3', Colors.grey, Colors.white),
                    createButton('+', Colors.orange, Colors.white),
                  ],
                ),
                Row(
                  children: [
                    createButton('0', Colors.grey, Colors.white),
                    createButton('.', Colors.grey, Colors.white),
                    createButton('=', const Color.fromARGB(255, 255, 191, 0),
                        Colors.white),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
