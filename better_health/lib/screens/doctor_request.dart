import 'package:better_health/models/selected_doctor.dart';
import 'package:better_health/services/bookings/booking_service.dart';
import 'package:better_health/utils/constants.dart';
import 'package:better_health/utils/custom_exception.dart';
import 'package:better_health/view_model/booking_view_model.dart';
import 'package:better_health/widgets/datebox.dart';
import 'package:better_health/widgets/long_button.dart';
import 'package:better_health/widgets/page_heading.dart';
import 'package:better_health/widgets/top_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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

  Function? setter() {
    setState(() {
    });
  }

  final List<String> times = ["9:00 AM", "9:10 AM", "9:20 AM", "9:30 AM", "9:40 AM", "9:50 AM"];

  Map<DateHolder, List<dynamic>> scheduleMap = {};

  var isSelected = false;
  var selectedText = '';
  var selectedTime = '';
  int selectedIndex = 0;
  var bookingSent = false;
  bool firsRender = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;  // gets size of whole screen
    final ThemeData themeData = Theme.of(context);
    // print(context.read<SelectedDoctor>().id);
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
                      Consumer<SelectedDoctor>(
                        builder: (context, value, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RatingBar.builder(
                                initialRating: value.rating,
                                ignoreGestures: true,
                                itemSize: 20,
                                itemBuilder: (context, _) => Icon(Icons.star, color: COLOR_AMBER,),
                                onRatingUpdate: (rating){
                                },
                              ),
                              addSpaceVertically(4),
                              Text(
                                '${value.name}', 
                                style: themeData.textTheme.headline5,
                              ),
                              Text('${value.speciality}',)
                            ],
                          );
                        },
                      )
                
                    ],
                  ),
                ),
              ),
              Consumer<SelectedDoctor>(
                builder: (context, value, child) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: Text('${value.about}'),
                  );
                },
              ),
              addSpaceVertically(size.height*0.04),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Text('Choose Date', style: themeData.textTheme.headline3,),
              ),
              FutureBuilder<dynamic>(
                future: BookingViewModel.getScheduleByID(context.read<SelectedDoctor>().id),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    if (snapshot.data!['event'] != null) {
                      scheduleMap = {};
                      Map<String, dynamic> a = snapshot.data['event'] as Map<String, dynamic>;
                      Map<String, dynamic> myMap = a['events'];
                      myMap.forEach((key, value) {
                        int intKey = int.parse(key);
                        final DateTime d = DateTime.fromMillisecondsSinceEpoch(intKey);

                        String day = getDay(DateFormat('EEEE').format(d));
                        String month = getMonth(DateFormat('MMM').format(d));
                        String year = DateFormat('yyyy').format(d);
                        String date = DateFormat('d').format(d);

                        DateHolder computedKey = DateHolder(day, month, year, date);
                        List<dynamic> computedVal = value as List<dynamic>;
                        scheduleMap[computedKey] = computedVal;  // just renders data
                      });

                      bookingSent = snapshot.data['bookingSent'];
                      if(bookingSent == true && firsRender == true) {
                        int index = 0;
                        scheduleMap.forEach((key, value) {
                          if (key.day == snapshot.data['day'] && key.date == snapshot.data['date'] && key.month == snapshot.data['month']) {
                            selectedIndex = index;
                            selectedText = key.day + key.date;
                            firsRender = false;

                            value.forEach((element) {
                              if (element == snapshot.data['time']) selectedTime = element;
                            });
                          }
                          index++;
                        });
                      }
                      // print(scheduleMap);
                      // print(snapshot.data);
                      
                    } else {
                      return Column(
                        children: [
                          addSpaceVertically(size.height * 0.02),
                          Text('Nothing to display!', style: themeData.textTheme.displayMedium,),
                          addSpaceVertically(size.height * 0.02),
                          Text(
                            'Wait for this doctor to set the time and date he\'s available',
                            textAlign: TextAlign.center,
                          )
                        ],
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 125,
                          padding: EdgeInsets.only(left: 20),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: scheduleMap.keys.length,
                            itemBuilder: (context, index) => GestureDetector(
                              child: DateBox(date: scheduleMap.keys.elementAt(index).date, text: scheduleMap.keys.elementAt(index).day, selectedText: selectedText,
                              year: scheduleMap.keys.elementAt(index).year, month: scheduleMap.keys.elementAt(index).month,),  // dates[index].name
                              onTap: (){
                                setState(() {
                                  selectedIndex = index;
                                  selectedTime = '';
                                  selectedText = scheduleMap.keys.elementAt(index).day + scheduleMap.keys.elementAt(index).date;
                                });
                                print('selectedText' + selectedText);

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
                            itemCount: scheduleMap.values.elementAt(selectedIndex).length,
                            itemBuilder: (context, index) => GestureDetector(
                              child: DateBox(text: scheduleMap.values.elementAt(selectedIndex)[index], selectedText: selectedTime),
                              onTap: (){
                                setState(() {
                                  selectedTime = scheduleMap.values.elementAt(selectedIndex)[index];
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
                          child: bookingSent == false 
                          ? LongButton(size: size, text: 'Send Request', 
                            pressFunc: () => BookingViewModel.sendBookingRequest(selectedIndex, setter, selectedTime, context, scheduleMap))
                          : LongButton(size: size, text: 'Edit Request', pressFunc: () => BookingViewModel.editBookingRequest(selectedIndex, selectedTime, setter, context, scheduleMap)),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: bookingSent == true ? LongButton(size: size, text: 'Delete Request', pressFunc: () => BookingViewModel.deleteBookingRequest(context, setter), color: COLOR_BLUE,) : null,
                        )
                      ],
                    );
                  }
                  else if (snapshot.hasError) {
                    print(snapshot.error);
                    print(snapshot.stackTrace);
                    return Text(snapshot.error.toString());
                  } else {
                    return Center(child: CircularProgressIndicator(color: COLOR_PRIMARY),);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
