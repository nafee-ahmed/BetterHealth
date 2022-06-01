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