import 'package:better_health/routes.dart';
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
  var selectedTime = '';
  var _selectedDay;
  var _focusedDay;

  Function? pressFunc(){
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;  // gets size of whole screen
    final ThemeData themeData = Theme.of(context);
    
    void onClickNotification(){
      Navigator.of(context).pushNamed(Routes.notificationPage);
    }
    return Container(
      padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
      child: SingleChildScrollView(
        child: Column(
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
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` here as well
                });
                print('date');
                print(_selectedDay);
                print(_focusedDay);
              },
            ),
            Text('Set Time', style: themeData.textTheme.headline3,),
            Container(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 0, crossAxisSpacing: 0, childAspectRatio: 3/2),
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
                
              ),
            ),
            LongButton(size: size, text: 'Set Schedule', pressFunc: pressFunc)
          ]
        ),
      )
    );
  }
}