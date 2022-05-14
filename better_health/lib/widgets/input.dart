import 'package:better_health/utils/constants.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({ 
    Key? key, 
    required this.placeholder, 
    required this.iconData, 
    this.minLines=1,
    required this.validator,
    this.obscureText = false,
    required this.controller,
    }) : super(key: key);
  final String placeholder; 
  final IconData iconData;
  final int minLines;
  final FormFieldValidator<String?> validator;
  final TextEditingController controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;  // gets size of whole screen
    final ThemeData themeData = Theme.of(context);   // gets themeData from main.dart

    return Container(
      padding: EdgeInsets.only(top: size.height*0.015),
      child: Row(
        children: [
          SizedBox(height: 40, 
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(iconData, color: COLOR_LIGHT_GREY,),
            )
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              validator: validator,
              style: themeData.textTheme.bodyText1,
              maxLines: minLines,
              decoration: InputDecoration(
                labelText: placeholder,
                labelStyle: themeData.textTheme.bodyText1,
                contentPadding: EdgeInsets.only(bottom: 0.0),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: COLOR_LIGHT_GREY, width: 0.5)
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: COLOR_PRIMARY, width: 1.5)
                ),
              ), 
            ),
          )
        ],
      ),
    );
  }
}