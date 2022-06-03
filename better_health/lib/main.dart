import 'dart:ui';
import 'package:better_health/firebase_options.dart';
import 'package:better_health/models/currentUser.dart';
import 'package:better_health/models/rating.dart';
import 'package:better_health/models/selected_doctor.dart';
import 'package:better_health/routes.dart';
import 'package:better_health/screens/auth_screen.dart';
import 'package:better_health/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = window.physicalSize.width;  // getting width of screen

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CurrentUser(),
        ),
        ChangeNotifierProvider(
          create: (context) => SelectedDoctor(),
        ),
        ChangeNotifierProvider(
          create: (context) => Rating(),
        )
      ],
      builder: (context, child){
        return MaterialApp(
          title: 'Better Health',
          theme: ThemeData(
            primaryColor: COLOR_WHITE,
            colorScheme: ColorScheme.fromSwatch().copyWith(secondary: COLOR_PRIMARY),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: COLOR_WHITE,
              selectedItemColor: COLOR_PRIMARY,
              unselectedItemColor: COLOR_LIGHT_GREY
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                primary: COLOR_PRIMARY,
              )
            ),
            fontFamily: 'Poppins',
            textTheme: screenWidth < 500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT,
          ),
          home: AuthScreen(),
          onGenerateRoute: Routes.generateRoutes,
        );
      },
    );
  }
}
