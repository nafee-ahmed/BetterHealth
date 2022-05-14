import 'package:flutter/material.dart';

const COLOR_PRIMARY = Color.fromARGB(255, 94, 32, 229);

const COLOR_WHITE = Colors.white;
const COLOR_BLACK = Color.fromRGBO(48, 47, 48, 1.0);

const COLOR_GREY = Color.fromRGBO(141, 141, 141, 1.0);
const COLOR_LIGHT_GREY = Color.fromRGBO(166,169,175, 1);
const COLOR_BOX_GREY = Color.fromRGBO(242, 242, 242, 1);
const COLOR_GREY_TEXT = Color.fromRGBO(220, 219, 224, 1);
const COLOR_DARK_GREY = Color.fromRGBO(118, 118, 118, 1);

const COLOR_AMBER = Color.fromRGBO(255,218,100, 1);
const COLOR_RED = Color.fromRGBO(255,95,87, 1);
const COLOR_BLUE = Color.fromRGBO(0, 101, 255, 1);
const COLOR_GREEN = Color.fromRGBO(39, 201, 65, 1);

const TextTheme TEXT_THEME_DEFAULT = TextTheme(
    headline1: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 26),  // in use
    headline2: TextStyle(
        color: COLOR_GREY, fontWeight: FontWeight.w500, fontSize: 22),  // in use
    headline3: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 20),
    headline4: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 16),
    headline5: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 14),
    headline6: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 12),
    bodyText1: TextStyle(
        color: COLOR_LIGHT_GREY, fontSize: 14, fontWeight: FontWeight.w500,height: 1.5),
    bodyText2: TextStyle(
        color:  COLOR_GREY, fontSize: 14, fontWeight: FontWeight.w500,height: 1.5),
    subtitle1: TextStyle(
        color: COLOR_BLACK, fontSize: 12, fontWeight: FontWeight.w400),
    subtitle2: TextStyle(
        color: COLOR_GREY, fontSize: 12, fontWeight: FontWeight.w400)
);

const TextTheme TEXT_THEME_SMALL = TextTheme(
    headline1: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 22),
    headline2: TextStyle(
        color: COLOR_GREY, fontWeight: FontWeight.w500, fontSize: 20),
    headline3: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 18),
    headline4: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 14),
    headline5: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 12),
    headline6: TextStyle(
        color: COLOR_BLACK, fontWeight: FontWeight.w700, fontSize: 10),
    bodyText1: TextStyle(
        color: COLOR_LIGHT_GREY, fontSize: 12, fontWeight: FontWeight.w500,height: 1.5),
    bodyText2: TextStyle(
        color:  COLOR_GREY, fontSize: 12, fontWeight: FontWeight.w500,height: 1.5),
    subtitle1: TextStyle(
        color: COLOR_BLACK, fontSize: 10, fontWeight: FontWeight.w400),
    subtitle2: TextStyle(
        color: COLOR_GREY, fontSize: 10, fontWeight: FontWeight.w400)        
);




