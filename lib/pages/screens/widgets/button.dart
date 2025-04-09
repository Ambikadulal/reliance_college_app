import 'package:flutter/material.dart';

class CommonButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color bottoncolor;
  final VoidCallback onPressed; 
  const CommonButtonWidget({
    super.key,
    required this.buttonText,
    required this.bottoncolor,
    required this.onPressed, 
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        // onPressed: () {
        //   Navigator.of(
        //     context,
        //   ).push(MaterialPageRoute(builder: (context) => Signin()));
          
        //   // Handle Register
        // },
        
        style: ElevatedButton.styleFrom(
          backgroundColor: bottoncolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(buttonText, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}