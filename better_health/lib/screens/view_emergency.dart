import 'package:better_health/screens/doctor_view_item.dart';
import 'package:better_health/services/services.dart';
import 'package:better_health/utils/common_functions.dart';
import 'package:better_health/view_model/emergency_viewmodel.dart';
import 'package:better_health/widgets/page_heading.dart';
import 'package:better_health/widgets/top_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewEmergency extends StatefulWidget {
  const ViewEmergency({ Key? key }) : super(key: key);

  @override
  State<ViewEmergency> createState() => _ViewEmergencyState();
}

class _ViewEmergencyState extends State<ViewEmergency> {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;  // gets size of whole screen
    final ThemeData themeData = Theme.of(context);

    return Container(
      padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
      child: Column(
        children: [
          TopNavBar(),
          PageHeading(themeData: themeData, text: 'Emergency Calls'),
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
                    storedDocs.add(a);
                  }).toList();


                  return ListView.builder(
                    itemCount: storedDocs.length,
                    itemBuilder: (BuildContext context, int index){
                      return DoctorViewItem(size: size, themeData: themeData, page: 'emergencyView',
                      name: storedDocs[index]['name'], text: storedDocs[index]['text'],);
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


// ListView.builder(
//               itemCount: 10,
//               itemBuilder: (BuildContext context, int index){
//                 return DoctorViewItem(size: size, themeData: themeData, page: 'emergencyView',);
//               },
//             ),