import 'package:better_health/screens/doctor_home_screen.dart';
import 'package:better_health/screens/login_screen.dart';
import 'package:better_health/screens/student_home_screen.dart';
import 'package:better_health/services/user/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({ Key? key }) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
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
      ),
    );
  }
}
