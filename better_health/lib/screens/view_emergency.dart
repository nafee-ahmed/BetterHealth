import 'package:better_health/screens/doctor_view_item.dart';
import 'package:better_health/utils/common_functions.dart';
import 'package:better_health/widgets/page_heading.dart';
import 'package:better_health/widgets/top_navbar.dart';
import 'package:flutter/material.dart';

class ViewEmergency extends StatefulWidget {
  const ViewEmergency({ Key? key }) : super(key: key);

  @override
  State<ViewEmergency> createState() => _ViewEmergencyState();
}

class _ViewEmergencyState extends State<ViewEmergency> {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;  // gets size of whole screen
    final ThemeData themeData = Theme.of(context);

    return Container(
      padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
      child: Column(
        children: [
          TopNavBar(),
          PageHeading(themeData: themeData, text: 'Emergency Calls'),
          addSpaceVertically(size.height*0.05),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index){
                return DoctorViewItem(size: size, themeData: themeData, page: 'emergencyView',);
              },
            ),
          )
        ],
      ),
    );
  }
}