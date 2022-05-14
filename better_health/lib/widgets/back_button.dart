import 'package:better_health/utils/constants.dart';
import 'package:flutter/material.dart';

class BackButtonCustom extends StatelessWidget {
  const BackButtonCustom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: Icon(Icons.arrow_back, color: COLOR_GREY,),
    );
  }
}