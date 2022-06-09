import 'package:better_health/services/messaging/messaging_service.dart';
import 'package:better_health/utils/custom_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmergencyService {
  static Future addEmergencyRequest(String emText) async {
    String userName = 'undefined';
    String matric = 'undefined';
    final user = await FirebaseAuth.instance.currentUser;
    final userStore = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: user!.email).get();
    try {
      for (var user in userStore.docs) {
        final authUser = user.data();
        userName = authUser['name'];
        matric = authUser['matric'];
        print(userName);
      }
      final emRequest = await FirebaseFirestore.instance.collection('emergencies').doc(user.uid).set({
        'text': emText,
        'name': userName,
        'matric': matric,
      });

      String notificationTitle = 'Emergency Call';  // sends notification
      String notificationBody = 'New emergency call received from $userName';
      final doctors = await FirebaseFirestore.instance.collection('users').where('userType', isEqualTo: 'doctor').get();

      for(var doctor in doctors.docs) {
        final doctorData = doctor.data();
        await FirebaseFirestore.instance.collection('notifications').add({
          'title': notificationTitle,
          'body': notificationBody,
          'type': 'emergencyRequest',
          'receiverID': doctor.reference.id,
          'senderID': user.uid
        });
        await MessagingService.sendNotification(notificationTitle, notificationBody, doctorData['token']);
      }
    } on FirebaseAuthException catch (e) {
      throw CustomException(e.message);
    }
  }

  static Stream<QuerySnapshot> loadEmergencies() {
    try {
      return FirebaseFirestore.instance.collection('emergencies').snapshots();
    } on FirebaseAuthException catch (e) {
      throw CustomException(e.message);
    }
  }
}



// final userFireStore = await FirebaseFirestore.instance.collection('users').doc(docID).get();  // sends notification
//       print('receiver ID');
//       print(userFireStore.data()!['token']);
//       String notificationTitle = 'Booking Request';
//       String notificationBody = 'New booking request received from ${user.email}.';
      
     
