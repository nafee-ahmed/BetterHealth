import 'package:better_health/widgets/long_button.dart';
import 'package:better_health/widgets/page_heading.dart';
import 'package:better_health/widgets/top_navbar.dart';
import 'package:flutter/material.dart';
import 'package:better_health/widgets/input.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/common_functions.dart';


class EmergencyRequestScreen extends StatefulWidget {
  const EmergencyRequestScreen({ Key? key }) : super(key: key);

  @override
  State<EmergencyRequestScreen> createState() => _EmergencyRequestScreenState();
}

class _EmergencyRequestScreenState extends State<EmergencyRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emergencyController = TextEditingController();

  Function? emergencyPress(){
    return null;
  }

  @override
  void dispose() {
    emergencyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;  // gets size of whole screen
    final ThemeData themeData = Theme.of(context);



    String? emergencyValidator(String? value){
      if(value!.isEmpty){
        return 'This is required';
      }
      else{
        return null;
      }
    }

    return Container(
      padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TopNavBar(),
            addSpaceVertically(size.height*0.01),
            PageHeading(themeData: themeData, text: 'Emergency Service',),
            Image.asset('assets/images/amb_img.jpeg'),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Input(placeholder: 'Description for Emergency', iconData: FontAwesomeIcons.truckMedical, minLines: 5, validator: emergencyValidator, controller: emergencyController,),
                  LongButton(size: size, text: 'Request', pressFunc: emergencyPress),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}





      


