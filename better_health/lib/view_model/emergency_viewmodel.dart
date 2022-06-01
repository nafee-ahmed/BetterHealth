import 'package:better_health/services/services.dart';
import 'package:better_health/utils/constants.dart';
import 'package:better_health/utils/custom_exception.dart';
import 'package:flutter/material.dart';

import '../utils/common_functions.dart';

class EmergencyViewModel {
  static Future? emergencyRequest(final formKey, final emController, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      Loader(context);
      try {
        await EmergencyService.addEmergencyRequest(emController.text);
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
}