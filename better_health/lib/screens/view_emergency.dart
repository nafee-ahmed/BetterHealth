import 'package:better_health/models/selected_emergency.dart';
import 'package:better_health/routes.dart';
import 'package:better_health/screens/doctor_view_item.dart';
import 'package:better_health/utils/common_functions.dart';
import 'package:better_health/view_model/emergency_viewmodel.dart';
import 'package:better_health/widgets/page_heading.dart';
import 'package:better_health/widgets/top_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewEmergency extends StatefulWidget {
  const ViewEmergency({ Key? key }) : super(key: key);

  @override
  State<ViewEmergency> createState() => _ViewEmergencyState();
}

class _ViewEmergencyState extends State<ViewEmergency> {

  void viewEmergencyDetails(String name, String text, String emergencyID, double latitude, double longitude) {
    print(latitude);
    context.read<SelectedEmergency>().id = emergencyID;
    context.read<SelectedEmergency>().name = name;
    context.read<SelectedEmergency>().text = text;
    context.read<SelectedEmergency>().latitude = latitude;
    context.read<SelectedEmergency>().longitude = longitude;
    Navigator.of(context).pushNamed(Routes.doctorViewEmergencyDetails);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;  // gets size of whole screen
    final ThemeData themeData = Theme.of(context);

    return Container(
      padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
      child: Column(
        children: [
          TopNavBar(onLeftPress: () => onClickNotification(context),),
          addSpaceVertically(size.height * 0.015),
          PageHeading(themeData: themeData, text: 'Pending Emergency Calls'),
          addSpaceVertically(size.height*0.05),
          Expanded(
            child: StreamBuilder<dynamic?>(
              stream: EmergencyViewModel.loadEmergencies(),
              builder:(context, snapshot) {
                if(snapshot.hasError){
                  return Text(snapshot.error.toString());
                } else if(snapshot.hasData){

                  final List storedDocs = [];
                  snapshot.data!.docs.map((DocumentSnapshot doc) {
                    Map a = doc.data() as Map<String, dynamic>;
                    String emergencyID = doc.reference.id;
                    storedDocs.add({...a, 'emergencyID': emergencyID});
                  }).toList();

                  if (storedDocs.length == 0) return Column(
                    children: [
                      Text('Nothing to display!', style: themeData.textTheme.displayMedium,),
                      addSpaceVertically(size.height * 0.02),
                      Text(
                        'No more pending emergency calls. Wait for students to send emergency calls.',
                        textAlign: TextAlign.center,
                      )
                    ],
                  );


                  return ListView.builder(
                    itemCount: storedDocs.length,
                    itemBuilder: (BuildContext context, int index){
                      return GestureDetector(
                        onTap: () => viewEmergencyDetails(storedDocs[index]['name'], storedDocs[index]['text'], storedDocs[index]['emergencyID'], storedDocs[index]['latitude'], storedDocs[index]['longitude']),
                        child: DoctorViewItem(size: size, themeData: themeData, page: 'emergencyView',
                        name: storedDocs[index]['name'], text: storedDocs[index]['text'],),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator(),);
                }
              },
            )
          )
        ],
      ),
    );
  }
}