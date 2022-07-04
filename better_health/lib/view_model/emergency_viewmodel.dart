import 'package:better_health/routes.dart';
import 'package:better_health/services/services.dart';
import 'package:better_health/utils/constants.dart';
import 'package:better_health/utils/custom_exception.dart';
import 'package:flutter/material.dart';

import '../utils/common_functions.dart';

class EmergencyViewModel {
  static Future? emergencyRequest(final formKey, final emController, BuildContext context,
  double latitude, double longitude) async {
    if (formKey.currentState!.validate()) {
      Navigator.of(context).pushNamed(Routes.loadingPage);
      try {
        await EmergencyService.addEmergencyRequest(emController.text, latitude, longitude);
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Emergency alert sent to all the support team! Please await their call.'))
        );
        emController.text = '';
      } on CustomException catch (e) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message!))
        );
      }
    }
  }

  static Stream<dynamic> loadEmergencies() {
    return EmergencyService.loadEmergencies();
  }

  static Future<dynamic> getLatLng(String emergencyID) async {
    return await EmergencyService.getLatLng(emergencyID);
  }

  static Future handleEmergency(BuildContext context, String emergencyID) async {
    Navigator.of(context).pushNamed(Routes.loadingPage);
    try {
      await EmergencyService.handleEmergency(emergencyID);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } on CustomException catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message!))
      );
    }
  }
}