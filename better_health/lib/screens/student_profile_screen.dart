import 'package:better_health/utils/common_functions.dart';
import 'package:better_health/utils/constants.dart';
import 'package:better_health/widgets/input.dart';
import 'package:better_health/widgets/long_button.dart';
import 'package:better_health/widgets/page_heading.dart';
import 'package:better_health/widgets/top_navbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({ Key? key }) : super(key: key);

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;  // gets size of whole screen
    final ThemeData themeData = Theme.of(context);

    Function? editProfile(){
      return null;
    }

    Function? deleteProfile(){
      return null;
    }

    return Container(
      padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TopNavBar(),
            addSpaceVertically(size.height*0.03),
            PageHeading(themeData: themeData, text: 'Edit Profile'),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  addSpaceVertically(size.height*0.02),
                  CircleAvatar(
                    backgroundColor: Colors.purple[50], 
                    foregroundColor: COLOR_BLACK, 
                    radius: 40,
                    child: FaIcon(FontAwesomeIcons.solidUser, size: 40,)
                  ),
                  addSpaceVertically(size.height*0.03),
                  Text('Mark Tom', style: themeData.textTheme.headline3!.copyWith(fontWeight: FontWeight.w700),),
                  addSpaceVertically(size.height*0.01),
                  SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Input(placeholder: 'Email ID', iconData: FontAwesomeIcons.solidEnvelope, validator: emailValidator, controller: emailController,),
                          addSpaceVertically(size.height*0.01),
                          Input(placeholder: 'Password', iconData: FontAwesomeIcons.lock, validator: passwordValidator, controller: passwordController,),
                          addSpaceVertically(size.height*0.01),
                          Input(placeholder: 'Name', iconData: FontAwesomeIcons.solidUser, validator: nameValidator, controller: nameController,),
                          addSpaceVertically(size.height*0.01),
                          LongButton(size: size, text: 'Edit', pressFunc: editProfile),
                          LongButton(size: size, text: 'Delete', pressFunc: deleteProfile, color: COLOR_BLUE,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



