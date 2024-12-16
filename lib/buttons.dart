import 'package:flutter/material.dart';

// Stateless widget for custom calculator buttons
class CalculatorButton extends StatelessWidget {
  // Defining required properties
  final Color buttonColor;
  final Color textColor;
  final String label;
  final VoidCallback? onPressed;

  // Constructor
  const CalculatorButton({
    super.key,
    required this.buttonColor,
    required this.textColor,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(0.2),
        child: ClipRRect(
          child: Container(
            color: buttonColor,
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
