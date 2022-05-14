import 'package:better_health/utils/constants.dart';
import 'package:flutter/material.dart';

class PageHeading extends StatelessWidget {
  const PageHeading({
    Key? key,
    required this.themeData,
    required this.text,
  }) : super(key: key);

  final ThemeData themeData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Text(text, style: themeData.textTheme.headline1!.copyWith(color: COLOR_BLACK ),)
    );
  }
}