import 'package:flutter/material.dart';

class CommonButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final VoidCallback? onPressed;
  const CommonButtonWidget({
    super.key,
    required this.buttonText,
    required this.buttonColor,
    required this.onPressed, required MaterialAccentColor bottoncolor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
