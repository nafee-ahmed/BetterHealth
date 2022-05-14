import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/constants.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.buttonFunc,
    required this.iconData,
    this.color=COLOR_PRIMARY,
  }) : super(key: key);

  final Function? buttonFunc;
  final IconData iconData;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        if(buttonFunc != null) buttonFunc!();
      },
      child: FaIcon(iconData, size: 20,),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        primary: color,
      ),
    );
  }
}