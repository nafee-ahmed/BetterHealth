import 'package:better_health/models/currentUser.dart';
import 'package:better_health/screens/doctor_home_screen.dart';
import 'package:better_health/screens/login_screen.dart';
import 'package:better_health/screens/student_home_screen.dart';
import 'package:better_health/utils/constants.dart';
import 'package:better_health/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/user/my_user.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({ Key? key }) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

// class _AuthScreenState extends State<AuthScreen> {

//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       body: StreamBuilder<dynamic>(
//         stream: AuthViewModel.getStream(),
//         builder: (context, snapshot) {
//           if(snapshot.hasData){
//             return FutureBuilder(
//               future: MyUser.getUserType(),
//               builder: (context, snapshot) {
//                 if(snapshot.data == 'doctor'){
//                   return DoctorHomeScreen();
//                 }
//                 else{
//                   return StudentHomeScreen();
//                 }
//               },
//             );
//           }
//           else{
//             return LoginScreen();
//           }
//         },
//       ),
//     );
//   }
// }



class _AuthScreenState extends State<AuthScreen> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<dynamic>(
        stream: AuthViewModel.getStream(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return FutureBuilder<Map<String, dynamic>>(
              future: AuthViewModel.getUserDetails(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final map = snapshot.data as Map<String, dynamic>;
                  WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                    context.read<CurrentUser>().name = map['name'];
                    context.read<CurrentUser>().email = map['email'];
                  });
                  
                  if(map['type'] == 'doctor'){
                    return DoctorHomeScreen();
                  }
                  else{
                    return StudentHomeScreen();
                  }
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text(snapshot.error.toString());
                } else {
                  return Center(child: CircularProgressIndicator(color: COLOR_PRIMARY),);
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