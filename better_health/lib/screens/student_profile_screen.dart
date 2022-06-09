import 'package:better_health/models/currentUser.dart';
import 'package:better_health/utils/common_functions.dart';
import 'package:better_health/utils/constants.dart';
import 'package:better_health/view_model/auth_view_model.dart';
import 'package:better_health/widgets/input.dart';
import 'package:better_health/widgets/long_button.dart';
import 'package:better_health/widgets/page_heading.dart';
import 'package:better_health/widgets/top_navbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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

  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    oldPasswordController.dispose();
    super.dispose();
  }
  
  @override
  void initState() {
    super.initState();
    nameController.text = context.read<CurrentUser>().name;
    emailController.text = context.read<CurrentUser>().email;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;  // gets size of whole screen
    final ThemeData themeData = Theme.of(context);

    return Container(
      padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TopNavBar(onLeftPress: () => onClickNotification(context),),
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
                  Consumer<CurrentUser>(
                    builder: (context, value, child){
                      return value.name == ''
                      ? CircularProgressIndicator(color: COLOR_PRIMARY,)
                      : Text('${value.name}', style: themeData.textTheme.headline3!.copyWith(fontWeight: FontWeight.w700),);
                    }
                  ),
                  addSpaceVertically(size.height*0.01),
                  SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Consumer<CurrentUser>(
                        builder: (context, value, child){
                          // nameController.text = value.name;
                          // emailController.text = value.email;
                          
                          return (value.name == '' && value.email == '')
                          ? CircularProgressIndicator(color: COLOR_PRIMARY,)
                          : Column(
                            children: [
                              Input(placeholder: 'Email ID', iconData: FontAwesomeIcons.solidEnvelope, validator: emailValidator, controller: emailController),
                              addSpaceVertically(size.height*0.01),
                              Input(placeholder: 'Current password', iconData: FontAwesomeIcons.key, validator: passwordValidator, controller: oldPasswordController, obscureText: true,),
                              Input(placeholder: 'New password', iconData: FontAwesomeIcons.lock, validator: updatePasswordValidator, controller: passwordController, obscureText: true,),
                              Input(placeholder: 'Confirm password', iconData: FontAwesomeIcons.lockOpen, validator: (val){
                                if(val != passwordController.text){
                                  return 'Please repeat the same password';
                                }
                                return null;
                              }, controller: confirmPasswordController, obscureText: true,),
                              addSpaceVertically(size.height*0.01),
                              Input(placeholder: 'Name', iconData: FontAwesomeIcons.solidUser, validator: nameValidator, controller: nameController,),
                              addSpaceVertically(size.height*0.01),
                              LongButton(size: size, text: 'Edit', pressFunc: () => AuthViewModel.editProfile(nameController.text.trim(), oldPasswordController.text.trim(), passwordController.text.trim(), emailController.text.trim(), _formKey, context)),
                              LongButton(size: size, text: 'Delete', pressFunc: () => AuthViewModel.deleteProfile(oldPasswordController.text.trim(), context), color: COLOR_BLUE,),
                            ],
                          );
                        }
                      )
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
