import 'package:better_health/utils/common_functions.dart';
import 'package:better_health/utils/constants.dart';
import 'package:flutter/material.dart';

class DateBox extends StatefulWidget {
  const DateBox({ Key? key, this.date = '', required this.text, required this.selectedText,
  this.year='', this.month='' }) : super(key: key);

  final String text;
  final String date;
  final String selectedText;
  final String year;
  final String month;

  @override
  State<DateBox> createState() => _DateBoxState();
}

class _DateBoxState extends State<DateBox> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
  
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: (widget.date != '') ? 75 : 90,
          padding: (widget.date != '') ? EdgeInsets.symmetric(horizontal: 16, vertical: 15) : EdgeInsets.symmetric(horizontal: 21, vertical: 13),
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
            color: COLOR_BOX_GREY,
            borderRadius: BorderRadius.all(
              Radius.circular(18)
            )
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  widget.text,
                  style: (widget.date != '') ? 
                  TextStyle(color: COLOR_GREY_TEXT) 
                  : 
                  TextStyle(
                    fontWeight: FontWeight.w700, 
                    color: COLOR_DARK_GREY,
                    fontSize: 15,
                  ),
                ),
              ),
              addSpaceVertically(5),
              if(widget.date != '')
              Text(
                widget.date,
                style: TextStyle(
                  color: COLOR_BLACK,
                  fontWeight: FontWeight.bold,
                ),
              ),
              



              if(widget.date != '')
              Text(
                '${widget.month}, ${widget.year}',
                style: TextStyle(color: COLOR_GREY_TEXT, fontSize: 8) 
              ),



            ],
          ),
        ),
        if(widget.selectedText == widget.text + widget.date)
        Positioned(
          right: (widget.date != '') ? 0 : 16,
          top:  (widget.date != '') ? 12 : 5,
          child: Material(
            color: Colors.transparent,
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.white,
                width: 2
              )
            ),
            child: Icon(Icons.check_circle, size: 20, color: COLOR_PRIMARY),
          ),
        )
      ],
    );
  }
}