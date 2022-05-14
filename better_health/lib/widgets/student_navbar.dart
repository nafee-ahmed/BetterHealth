import 'package:better_health/utils/constants.dart';
import 'package:flutter/material.dart';

class StudentNavbar extends StatefulWidget {
  const StudentNavbar({ Key? key }) : super(key: key);

  @override
  State<StudentNavbar> createState() => _StudentNavbarState();
}

class _StudentNavbarState extends State<StudentNavbar> {
  int currentInd = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentInd,
      onTap: (index){
        
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: COLOR_PRIMARY,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Emergency',
          backgroundColor: COLOR_PRIMARY,
        ),
      ],
    );
  }
}