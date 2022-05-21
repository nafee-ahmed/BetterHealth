import 'package:better_health/screens/doctor_home_screen.dart';
import 'package:better_health/screens/login_screen.dart';
import 'package:better_health/screens/student_home_screen.dart';
import 'package:better_health/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class AuthStreamListener extends StatelessWidget {
  const AuthStreamListener({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: MyUser.stream,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return FutureBuilder(
            future: MyUser.getUserType(),
            builder: (context, snapshot){
              if(snapshot.data == 'doctor'){
                return DoctorHomeScreen();
              }
              else{
                return StudentHomeScreen();
              }
            },
          );
        }
        else{
          return LoginScreen();
        }
      },
    );
  }
}