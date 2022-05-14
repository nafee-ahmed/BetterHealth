import 'package:better_health/utils/common_functions.dart';
import 'package:better_health/widgets/doctor_list_item.dart';
import 'package:better_health/widgets/page_heading.dart';
import 'package:better_health/widgets/top_navbar.dart';
import 'package:flutter/material.dart';

class StudentRateScreen extends StatefulWidget {
  const StudentRateScreen({ Key? key }) : super(key: key);

  @override
  State<StudentRateScreen> createState() => _StudentRateScreenState();
}

class _StudentRateScreenState extends State<StudentRateScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;  // gets size of whole screen
    final ThemeData themeData = Theme.of(context);
    return Container(
      padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
      child: Column(
        children: [
          TopNavBar(),
          addSpaceVertically(20),
          PageHeading(themeData: themeData, text: 'Rate Doctors',),
          addSpaceVertically(18),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index){
                return DoctorListItem(size: size, themeData: themeData, page: 'ratingScreen',);
              },
            ),
          )
        ],
      ),
    );
  }
}