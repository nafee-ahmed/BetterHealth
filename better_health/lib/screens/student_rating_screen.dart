import 'package:better_health/utils/common_functions.dart';
import 'package:better_health/utils/constants.dart';
import 'package:better_health/view_model/booking_view_model.dart';
import 'package:better_health/view_model/rating_view_model.dart';
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
  double rating = 0;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;  // gets size of whole screen
    final ThemeData themeData = Theme.of(context);
    return Container(
      padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
      child: Column(
        children: [
          TopNavBar(onLeftPress: () => onClickNotification(context),),
          addSpaceVertically(20),
          PageHeading(themeData: themeData, text: 'Rate Doctors',),
          addSpaceVertically(18),
          Expanded(
            child: FutureBuilder<dynamic>(
              future: BookingViewModel.getDoctorListForRating(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List list = snapshot.data;
                  if (list.length == 0) return Column(
                    children: [
                      Text('Nothing to display!', style: themeData.textTheme.displayMedium,),
                      addSpaceVertically(size.height * 0.02),
                      Text(
                        'Your clinic sessions will become available to rate once the doctors you sent booking requests to, accept your booking',
                        textAlign: TextAlign.center,
                      )
                    ],
                  );

                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index){
                      print(list[index]['rating']);
                      return DoctorListItem(
                        size: size, themeData: themeData, 
                        page: 'ratingScreen',
                        name: list[index]['doctorName'],
                        speciality: 'Treated you on ' + list[index]['day'] + ', ' + list[index]['date'] + ' ' + list[index]['month'] + ' ' + list[index]['year'] + ', ' + ' ' + list[index]['time'],
                        executeOnTap: () => RatingViewModel.addRating(rating, list[index]['doctorID'], list[index]['date'], list[index]['month'], context),
                        rating: list[index]['rating'],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text(snapshot.error.toString());
                } else {
                  return Center(child: CircularProgressIndicator(color: COLOR_PRIMARY,));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}