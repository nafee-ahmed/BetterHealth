import 'package:better_health/routes.dart';
import 'package:better_health/services/services.dart';
import 'package:better_health/utils/constants.dart';
import 'package:better_health/view_model/booking_view_model.dart';
import 'package:better_health/widgets/datebox.dart';
import 'package:better_health/widgets/long_button.dart';
import 'package:better_health/widgets/page_heading.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils/common_functions.dart';
import '../widgets/top_navbar.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({ Key? key }) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  
  final List<String> times = ["9:00 AM", "10:00 AM", "11:00 AM", "12:00 AM", "1:00 PM", "2:00 PM"];
  var _selectedTime = '';
  var _selectedDay;
  var _focusedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  TextEditingController eventController = TextEditingController();

  Map<DateTime, List<String>> selectedEvents = {};

  @override
  void dispose() {
    eventController.dispose();
    super.dispose();
  }


  List<String> getEventsFromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;  // gets size of whole screen
    final ThemeData themeData = Theme.of(context);
    
    void onClickNotification(){
      Navigator.of(context).pushNamed(Routes.notificationPage);
    }

    Function? setter() {
      setState(() {
      });
    }

    return Container(
      padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
      child: SingleChildScrollView(
        child: FutureBuilder<dynamic?>(
          future: BookingViewModel.getSchedules(),
          builder: (context, AsyncSnapshot snapshot) {
            if(snapshot.hasData) {
              if(snapshot.data!.data() != null){
                Map<String, dynamic> a = snapshot.data!.data() as Map<String, dynamic>;
                Map<String, dynamic> myMap = a['events'];
                myMap.forEach((key, value) {
                  int intKey = int.parse(key);
                  final DateTime d = DateTime.fromMillisecondsSinceEpoch(intKey).toUtc();
                  selectedEvents[d] = value.cast<String>();
                });
                print('selected events from schedule_screen');
                print(selectedEvents);
              }

              

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopNavBar(onLeftPress: onClickNotification,),
                  PageHeading(themeData: themeData, text: 'Set Schedule'),
                  TableCalendar(
                    firstDay: DateTime.utc(2020, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now(),
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    calendarFormat: _calendarFormat,
                    onFormatChanged: (format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    },
                    eventLoader: getEventsFromDay,
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay; // update `_focusedDay` here as well
                      });
                      // print('date'); print(_selectedDay); print(_focusedDay);
                    },
                  ),
                  Text('Set Time', style: themeData.textTheme.headline3,),
                  Container(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 0, crossAxisSpacing: 0, childAspectRatio: 3/2),
                      itemCount: selectedEvents[_selectedDay]?.length ?? 0,
                      itemBuilder: (context, index) => DateBox(text: selectedEvents[_selectedDay]![index], selectedText: ''),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      
                    ),
                  ),
                  
                  LongButton(size: size, text: 'Add Schedule', pressFunc: () => BookingViewModel.addScheduleButton(context, eventController, selectedEvents, _selectedDay, setter)),
                  addSpaceVertically(size.height * 0.01)
                ]
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text(snapshot.error.toString());
            } else {
              return Center(child: CircularProgressIndicator(color: COLOR_PRIMARY,),);
            }
          }
        ),
      )
    );
  }
}