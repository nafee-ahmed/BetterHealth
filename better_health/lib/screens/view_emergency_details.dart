import 'package:better_health/models/selected_emergency.dart';
import 'package:better_health/services/emergency/emergency_service.dart';
import 'package:better_health/utils/common_functions.dart';
import 'package:better_health/view_model/auth_view_model.dart';
import 'package:better_health/view_model/emergency_viewmodel.dart';
import 'package:better_health/widgets/long_button.dart';
import 'package:better_health/widgets/page_heading.dart';
import 'package:better_health/widgets/top_navbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';

class ViewEmergencyDetails extends StatefulWidget {
  const ViewEmergencyDetails({ Key? key }) : super(key: key);

  @override
  State<ViewEmergencyDetails> createState() => _ViewEmergencyDetailsState();
}

class _ViewEmergencyDetailsState extends State<ViewEmergencyDetails> {
  static double latitude = 0;
  static double longitude = 0;
  late GoogleMapController googleMapController;
  static CameraPosition cameraPosition = CameraPosition(target: LatLng(latitude, longitude), zoom: 14);
  Set<Marker> markers = {};

  void onLeftPress(){
    Navigator.of(context).pop();
  }

  Function? setter() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;  // gets size of whole screen
    final ThemeData themeData = Theme.of(context);
    // print(context.read<SelectedDoctor>().id);
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
              child: TopNavBar(iconData: FontAwesomeIcons.arrowLeft, onLeftPress: onLeftPress,),
            ),
            PageHeading(themeData: themeData, text: 'Emergency Details'),
            addSpaceVertically(size.height * 0.01),
            SizedBox(
              height: size.height * 0.6,
              width: size.width,
              child: FutureBuilder<dynamic>(
                future: EmergencyViewModel.getLatLng(context.read<SelectedEmergency>().id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    latitude = snapshot.data['lat'];
                    longitude = snapshot.data['long'];
                    markers.add(Marker(markerId: MarkerId('currentLocation'), position: LatLng(latitude, longitude)));
                    cameraPosition = CameraPosition(target: LatLng(latitude, longitude), zoom: 14);
            
                    return GoogleMap(
                      initialCameraPosition:  cameraPosition,
                      markers:  markers,
                      zoomControlsEnabled: false,
                      mapType: MapType.normal,
                    );
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text(snapshot.error.toString());
                  } else {
                    return Center(child: CircularProgressIndicator(color: COLOR_PRIMARY),);
                  }
                }
              ),
            ),
            Consumer<SelectedEmergency>(
              builder: (context, value, child) {
                return Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)
                      )
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addSpaceVertically(size.height * 0.02),
                          Text(
                            value.name,
                            style: themeData.textTheme.headline2!.copyWith(color: COLOR_WHITE, fontWeight: FontWeight.w500, fontSize: 25)
                          ),
                          addSpaceVertically(size.height * 0.02),
                          Text(
                            value.text,
                            style: themeData.textTheme.subtitle2!.apply(heightDelta: 2.0),
                          ),
                          addSpaceVertically(size.height * 0.02),
                          LongButton(size: size, color: COLOR_BLACK, text: 'Handle', pressFunc: () => EmergencyViewModel.handleEmergency(context, context.read<SelectedEmergency>().id))
                        ],
                      ),
                    ),
                    // child: Padding(
                    //   padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
                    //   child: Text(value.name, style: themeData.textTheme.headline2!.copyWith(fontWeight: FontWeight.w700, color: COLOR_BLACK)),
                    // ),
                  ),
                );
              },
            ), 
          ]
        )
      )
    );
  }
}