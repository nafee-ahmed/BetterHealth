import 'package:better_health/utils/constants.dart';
import 'package:flutter/material.dart';

class LongButton extends StatelessWidget {
  const LongButton({
    Key? key,
    required this.size,
    required this.text,
    required this.pressFunc,
    this.color = COLOR_PRIMARY
  }) : super(key: key);

  final Size size;
  final String text;
  final VoidCallback pressFunc;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      margin: EdgeInsets.only(top: size.height*0.03),
      child: ElevatedButton(
        
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          primary: color
        ),
        onPressed: pressFunc,
        child: Text(text),
      ),
    );
  }
}