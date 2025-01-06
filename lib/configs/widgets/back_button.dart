import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final Color iconColor;
  const CustomBackButton({super.key, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
        child: Icon(Icons.arrow_back_ios, color: iconColor));
  }
}
