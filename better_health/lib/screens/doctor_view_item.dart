import 'package:better_health/utils/common_functions.dart';
import 'package:better_health/utils/constants.dart';
import 'package:better_health/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DoctorViewItem extends StatelessWidget {
  const DoctorViewItem({
    Key? key,
    required this.size,
    required this.themeData,
    this.acceptFunc,
    this.rejectFunc,
    this.page = 'bookingList',
    this.image = 'student_image',
    this.name = '',
    this.text = ''
  }) : super(key: key);

  final Size size;
  final ThemeData themeData;
  final Function? acceptFunc;
  final Function? rejectFunc;
  final String page;
  final String image;
  final String name;
  final String text;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(bottom: 25),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 80),
        child: Container(
          width: size.width,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: COLOR_BOX_GREY,
          ),
      
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Image.asset(
                      'assets/images/$image.png',
                      width: 50, height: 50,
                    ),
                    addSpaceHorizontally(13),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addSpaceVertically(4),
                          Text(name == '' ? 'Fake Filler Data' : name, style: themeData.textTheme.headline5,),
                          Text(text == '' ? 'This is a fake filler data' : text,)
                        ],
                      ),
                    ),
                ],
              ),
              
              if(page == 'bookingList') Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ActionButton(buttonFunc: acceptFunc, iconData: FontAwesomeIcons.check, color: COLOR_GREEN,),
                  ActionButton(buttonFunc: rejectFunc, iconData: FontAwesomeIcons.xmark, color: COLOR_RED,)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

