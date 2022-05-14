import 'package:better_health/utils/constants.dart';
import 'package:better_health/widgets/datebox.dart';
import 'package:better_health/widgets/long_button.dart';
import 'package:better_health/widgets/page_heading.dart';
import 'package:better_health/widgets/top_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/common_functions.dart';

class DoctorRequest extends StatefulWidget {
  const DoctorRequest({ Key? key }) : super(key: key);

  @override
  State<DoctorRequest> createState() => _DoctorRequestState();
}

class _DoctorRequestState extends State<DoctorRequest> {

  void onLeftPress(){
    Navigator.of(context).pop();
  }

  Function? requestPress(){
    return null;
  }

  final List<Date> dates = [
    Date("Su", "13", false),
    Date("Mon", "14", false),
    Date("Tu", "15", false),
    Date("We", "16", false),
    Date("Th", "17", false),
    Date("Sa", "18", false),
  ];

  final List<String> times = ["9:00 AM", "9:10 AM", "9:20 AM", "9:30 AM", "9:40 AM", "9:50 AM"];

  var isSelected = false;
  var selectedText = '';
  var selectedTime = '';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;  // gets size of whole screen
    final ThemeData themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
                child: TopNavBar(iconData: FontAwesomeIcons.arrowLeft, onLeftPress: onLeftPress,),
              ),
              PageHeading(themeData: themeData, text: 'Book Consult'),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Container(
                  width: size.width,
                  height: 90,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Image.asset('assets/images/doctor_image.png'),
                      addSpaceHorizontally(14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RatingBar.builder(
                            initialRating: 3,
                            ignoreGestures: true,
                            itemSize: 20,
                            itemBuilder: (context, _) => Icon(Icons.star, color: COLOR_AMBER,),
                            onRatingUpdate: (rating){
                            },
                          ),
                          addSpaceVertically(4),
                          Text('Dr. Angela Hopkins', style: themeData.textTheme.headline5,),
                          Text('Dentist',)
                        ],
                      ),
                
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Text('This is an experienced doctor specializing as a dentist, serving the university'),
              ),
              addSpaceVertically(size.height*0.04),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Text('Choose Date', style: themeData.textTheme.headline3,),
              ),
              Container(
                height: 100,
                padding: EdgeInsets.only(left: 20),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dates.length,
                  itemBuilder: (context, index) => GestureDetector(
                    child: DateBox(date: dates[index].number, text: dates[index].name, selectedText: selectedText,),
                    onTap: (){
                      setState(() {
                        selectedText = dates[index].name;
                      });
                      print(selectedText);
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
                child: Text('Choose Time', style: themeData.textTheme.headline3,),
              ),
              addSpaceHorizontally(20),
              Container(
                // height: 150,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 0, crossAxisSpacing: 0, childAspectRatio: 4/2),
                  itemCount: times.length,
                  itemBuilder: (context, index) => GestureDetector(
                    child: DateBox(text: times[index], selectedText: selectedTime),
                    onTap: (){
                      setState(() {
                        selectedTime = times[index];
                      });
                      print(selectedTime);
                    },
                  ),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  
                )
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: LongButton(size: size, text: 'Register', pressFunc: requestPress),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class DateBox extends StatefulWidget {
//   const DateBox({ Key? key, this.date = '', required this.text, required this.selectedText }) : super(key: key);

//   final String text;
//   final String date;
//   final String selectedText;

//   @override
//   State<DateBox> createState() => _DateBoxState();
// }

// class _DateBoxState extends State<DateBox> {
//   @override
//   Widget build(BuildContext context) {
//     final ThemeData themeData = Theme.of(context);
  
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Container(
//           width: (widget.date != '') ? 70 : 90,
//           padding: (widget.date != '') ? EdgeInsets.symmetric(horizontal: 16, vertical: 20) : EdgeInsets.symmetric(horizontal: 16, vertical: 13),
//           margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//           decoration: BoxDecoration(
//             color: COLOR_BOX_GREY,
//             borderRadius: BorderRadius.all(
//               Radius.circular(18)
//             )
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               FittedBox(
//                 fit: BoxFit.fitWidth,
//                 child: Text(
//                   widget.text,
//                   style: (widget.date != '') ? 
//                   TextStyle(color: COLOR_GREY_TEXT) 
//                   : 
//                   TextStyle(
//                     fontWeight: FontWeight.w700, 
//                     color: COLOR_DARK_GREY,
//                     fontSize: 15,
//                   ),
//                 ),
//               ),
//               addSpaceVertically(5),
//               if(widget.date != '')
//               Text(
//                 widget.date,
//                 style: TextStyle(
//                   color: COLOR_BLACK,
//                   fontWeight: FontWeight.bold,
//                 ),
//               )
//             ],
//           ),
//         ),
//         if(widget.selectedText == widget.text)
//         Positioned(
//           right: (widget.date != '') ? 0 : 16,
//           top:  5,
//           child: Material(
//             color: Colors.transparent,
//             shape: CircleBorder(
//               side: BorderSide(
//                 color: Colors.white,
//                 width: 2
//               )
//             ),
//             child: Icon(Icons.check_circle, size: 20, color: COLOR_PRIMARY),
//           ),
//         )
//       ],
//     );
//   }
// }


class Date{
  String name;
  String number;
  bool isSelected;
  Date(this.name, this.number, this.isSelected);
}