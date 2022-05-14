import 'package:better_health/screens/doctor_view_item.dart';
import 'package:better_health/widgets/page_heading.dart';
import 'package:better_health/widgets/top_navbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/common_functions.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;  // gets size of whole screen
    final ThemeData themeData = Theme.of(context);

    void backPress(){
      Navigator.of(context).pop();
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
        padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
          child: Column(
            children: [
              TopNavBar(iconData: FontAwesomeIcons.arrowLeft, onLeftPress: backPress,),
              PageHeading(themeData: themeData, text: 'Notifications'),
              addSpaceVertically(size.height*0.05),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index){
                    return DoctorViewItem(size: size, themeData: themeData, page: 'student', image: 'student_image',);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}