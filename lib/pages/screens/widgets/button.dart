import 'package:flutter/material.dart';

class CommonButtonWidget extends StatelessWidget {
  final String buttonText;
  final GestureTapCallback? onPressed;
  const CommonButtonWidget({
    super.key,
    required this.buttonText,
    this.onPressed,
    required MaterialAccentColor buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
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
