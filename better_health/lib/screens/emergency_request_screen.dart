import 'dart:async';

import 'package:better_health/view_model/emergency_viewmodel.dart';
import 'package:better_health/widgets/long_button.dart';
import 'package:better_health/widgets/page_heading.dart';
import 'package:better_health/widgets/top_navbar.dart';
import 'package:flutter/material.dart';
import 'package:better_health/widgets/input.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/common_functions.dart';


class EmergencyRequestScreen extends StatefulWidget {
  const EmergencyRequestScreen({ Key? key }) : super(key: key);

  @override
  State<EmergencyRequestScreen> createState() => _EmergencyRequestScreenState();
}

class _EmergencyRequestScreenState extends State<EmergencyRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emergencyController = TextEditingController();
  static double latitude = 23.78;
  static double longitude = 90.42;

  // Completer<GoogleMapController> googleMapController = Completer();
  late GoogleMapController googleMapController;
  static CameraPosition initialCameraPosition = CameraPosition(target: LatLng(latitude, longitude), zoom: 14);
  Set<Marker> markers = {};

  @override
  void dispose() {
    emergencyController.dispose();
    super.dispose();
  }

  Future<Position?> _processCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Enable location services'))
      );
      // return Future.error('Enable location services');
      return null;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location Permission denied'))
        );
        // return Future.error("Location Permission denied");
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Go to settings and enable location permission'))
      );
      // return Future.error('Go to settings and enable location permission');
      return null;
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  @override
  void initState() {
    markers.add(Marker(markerId: MarkerId('currentLocation'), position: LatLng(latitude, longitude)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;  // gets size of whole screen
    final ThemeData themeData = Theme.of(context);

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
              child: TopNavBar(onLeftPress: () => onClickNotification(context),),
            ),
            // addSpaceVertically(size.height*0.01),
            PageHeading(themeData: themeData, text: 'Emergency Service',),
            // Image.asset('assets/images/amb_img.jpeg'),
            SizedBox(
              height: size.height * 0.6,
              width: size.width,
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition:  initialCameraPosition,
                    markers:  markers,
                    zoomControlsEnabled: false,
                    mapType: MapType.normal,
                    onMapCreated: (GoogleMapController controller) {
                      // googleMapController.complete(controller);
                      googleMapController = controller;
                    },
                    onTap: (LatLng latLng) {
                      latitude = latLng.latitude;
                      longitude = latLng.longitude;
                      print(latitude);
                      markers.clear();
                        markers.add(Marker(markerId: MarkerId('currentLocation'), position: LatLng(latitude, longitude)));
                      setState(() {
                        
                      });
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () async {
                        Position? position = await _processCurrentLocation();
                        if (position == null) return;
                        latitude = position.latitude;
                        longitude = position.longitude;
                        print(latitude.toString() + ' ' + longitude.toString());

                        googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(latitude, longitude), zoom: 14)));
                        markers.clear();
                        markers.add(Marker(markerId: MarkerId('currentLocation'), position: LatLng(latitude, longitude)));
                        setState(() {

                        });
                      },
                      icon: FaIcon(FontAwesomeIcons.locationCrosshairs),
                    ),
                  )
                ] 
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25, 15, 25, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Input(placeholder: 'Description for Emergency', iconData: FontAwesomeIcons.truckMedical, validator: emergencyValidator, controller: emergencyController,),
                    LongButton(size: size, text: 'Request', pressFunc: () => EmergencyViewModel.emergencyRequest(_formKey, emergencyController, context, latitude, longitude)),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}





      


