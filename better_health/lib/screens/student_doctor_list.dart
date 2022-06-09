import 'package:better_health/models/currentUser.dart';
import 'package:better_health/models/selected_doctor.dart';
import 'package:better_health/routes.dart';
import 'package:better_health/utils/constants.dart';
import 'package:better_health/view_model/auth_view_model.dart';
import 'package:better_health/view_model/booking_view_model.dart';
import 'package:better_health/widgets/top_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/common_functions.dart';
import '../widgets/doctor_list_item.dart';

class DoctorList extends StatefulWidget {
  const DoctorList({ Key? key }) : super(key: key);

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  // late Future<Map<String, dynamic>> future;

  void viewDoctor(String name, String speciality, double rating, String about, String id){
    context.read<SelectedDoctor>().name = name;
    context.read<SelectedDoctor>().speciality = speciality;
    context.read<SelectedDoctor>().about= about;
    context.read<SelectedDoctor>().rating = rating;
    context.read<SelectedDoctor>().id = id;
    Navigator.of(context).pushNamed(Routes.doctorRequestPage);
  }

  void initState() {
    BuildContext cont = context;
    super.initState();
    // future = AuthViewModel.getStudentCurrentUser(cont);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;  // gets size of whole screen
    final ThemeData themeData = Theme.of(context);

    return Container(
      padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopNavBar(onLeftPress: () => onClickNotification(context),),
          addSpaceVertically(size.height*0.07),
          Text('Hello there, ', style: themeData.textTheme.headline2,),
          // FutureBuilder<Map<String, dynamic>>(
          //   future:  AuthViewModel.getStudentCurrentUser(context),
          //   builder: (context, AsyncSnapshot snapshot) {
          //     if(snapshot.hasData) {
          //       Map<String, dynamic> user = snapshot.data as Map<String, dynamic>;
          //       return Text(user['name'].toString() +' 👋🏻', style: themeData.textTheme.headline2!.copyWith(fontWeight: FontWeight.w700, color: COLOR_BLACK));
          //     } else if (snapshot.hasError) {
          //       print(snapshot.stackTrace);
          //       return Text(snapshot.error.toString());
          //     } else {
          //       return CircularProgressIndicator(color: COLOR_PRIMARY,);
          //     }
              
          //   },
          // ),
          Consumer<CurrentUser>(
            builder: (context, value, child) {
              return
              Text(value.name +' 👋🏻', style: themeData.textTheme.headline2!.copyWith(fontWeight: FontWeight.w700, color: COLOR_BLACK));
            }
          ),
          addSpaceVertically(size.height*0.04),
          Text('Top Doctors', style: themeData.textTheme.headline3,),
          addSpaceVertically(size.height*0.03),
          Expanded(
            child: StreamBuilder<dynamic>(
              stream: BookingViewModel.loadTopDoctors(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (snapshot.hasData) {
                  final List docList = [];
                  snapshot.data!.docs.map((DocumentSnapshot doc) {
                    Map a = doc.data() as Map<String, dynamic>;
                    docList.add({...a, 'id': doc.reference.id});
                  }).toList();

                  return ListView.builder(
                    itemCount: docList.length,
                    itemBuilder: (BuildContext context, int index){
                      return DoctorListItem(
                        size: size, themeData: themeData, 
                        rating: docList[index]['rating'].toDouble(),
                        executeOnTap: () => viewDoctor(docList[index]['name'], docList[index]['speciality'], 0, docList[index]['about'], docList[index]['id']), name: docList[index]['name'], speciality: docList[index]['speciality'],
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator(color: COLOR_PRIMARY),);
                }
              },
            )
          ),
        ],
      ),
    );
  }
}


