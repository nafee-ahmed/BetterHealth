import 'package:better_health/screens/booking_request.dart';
import 'package:better_health/screens/doctor_profile_screen.dart';
import 'package:better_health/screens/schedule_screen.dart';
import 'package:better_health/screens/view_emergency.dart';
import 'package:better_health/utils/constants.dart';
import 'package:better_health/view_model/messaging_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({ Key? key }) : super(key: key);

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  var indexClicked = 0;

  @override
  void initState() {
    super.initState();
    MessagingViewModel.NotificationInit();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _screens = [
      BookingRequest(), ViewEmergency(), ScheduleScreen(), DoctorProfileScreen(), 
    ];

    void _itemTapped(int index){
      setState(() {
        indexClicked = index;
      });
    }

    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: COLOR_WHITE,
        bottomNavigationBar: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 8),
          height: size.width < 370 ? size.height * 0.10 : size.height * 0.09,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),            
            boxShadow: [                                                               
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 30,
                offset: Offset(0, 10),
              ),
            ],
          ),

          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: _itemTapped,
              currentIndex: indexClicked,
              items: const [
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.house),
                  label: 'Home',
                  backgroundColor: COLOR_PRIMARY,
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.truckMedical),
                  label: 'View Emergency',
                  backgroundColor: COLOR_PRIMARY,
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.solidCalendar),
                  label: 'Schedule',
                  backgroundColor: COLOR_PRIMARY,
                ),


                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.solidUser),
                  label: 'Profile',
                  backgroundColor: COLOR_PRIMARY,
                ),
              ],
            ),
          ),
        ),
        body: Container(
          child: _screens[indexClicked],
        ),
      ),
    );
  }
}