import 'dart:math';

import 'package:better_health/models/selected_doctor.dart';
import 'package:better_health/utils/custom_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/common_functions.dart';

class BookingService {
  static Future sendDoctorSchedule(Map<DateTime, List<String>> events) async {
    try {
      final user = await FirebaseAuth.instance.currentUser;
      // print('here ');
      // print(events);

      Map<String, List<String>> newMap = {};
      events.forEach((key, value){
        int corrected = key.millisecondsSinceEpoch;
        newMap[corrected.toString()] = value;
      });

      await FirebaseFirestore.instance.collection('bookings').doc(user!.uid).set({'events': newMap});
    } on FirebaseAuthException catch (e) {
      throw CustomException(e.message);
    }
  }

  static Future getSchedules() async {
    try {
      final user = await FirebaseAuth.instance.currentUser;
      return FirebaseFirestore.instance.collection('bookings').doc(user!.uid).get();
    } on FirebaseAuthException catch (e) {
      print(e);
      rethrow;
    }
  }

  static Stream<QuerySnapshot> loadTopDoctors() {
    try {
      return FirebaseFirestore.instance.collection('users').orderBy('rating', descending: true).where('userType', isEqualTo: 'doctor').snapshots();
    } on FirebaseAuthException catch (e) {
      print(e.stackTrace);
      throw CustomException(e.message);
    }
  }

  static Future getScheduleByID(String id) async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('bookings').doc(id).get();
      var doc;
      if(snapshot.data() != null) doc = snapshot.data() as Map<String, dynamic>;  // renders the data
      else return {'event': null, 'bookingSent': false};

      Map<String, dynamic> isBookingSentMap = await isBookingSent(id);
      bool bookingSent = isBookingSentMap['bookingSent'];
      if(bookingSent == true) {
        String date = isBookingSentMap['date'];
        String day = isBookingSentMap['day'];
        String month = isBookingSentMap['month'];
        String time = isBookingSentMap['time'];
        return {'event': doc, 'bookingSent': bookingSent, 'date': date, 
                'day': day, 'month': month, 'time': time};
      } else {
        return {'event': doc, 'bookingSent': bookingSent};
      }      
    } catch (e) {
      print(e);
    }
  }

  static Future<Map<String, dynamic>> isBookingSent(String docID) async {
    try {
      final user = await FirebaseAuth.instance.currentUser;
      final bookingSentQueries = await FirebaseFirestore.instance.collection('schedules')
      .where('doctorID', isEqualTo: docID)
      .where('patientID', isEqualTo: user!.uid)
      .where('status', isEqualTo: 'pending').get();

      for(var q in bookingSentQueries.docs) {
        if(q.exists == true) {
          return { 'bookingSent': true, 'date': q['date'], 'day': q['day'], 'month': q['month'], 'time': q['time'] };
        }
      }
      return {'bookingSent': false};
    } on FirebaseAuthException catch (e) {
      throw CustomException(e.message);
    }
  }

  static Future sendBookingRequest(String date, String day, String month, String year, String time, 
  String docID) async {
    try {
      final user = await FirebaseAuth.instance.currentUser;
      return FirebaseFirestore.instance.collection('schedules').add({
        'patientID': user!.uid,
        'status': 'pending',
        'date': date,
        'day': day,
        'month': month,
        'year': year,
        'time': time,
        'doctorID': docID,
      });
    } on FirebaseAuthException catch (e) {
      throw CustomException(e.message);
    }
  }

  static Future editBookingRequest(String date, String day, String month, String year, String time, 
  String docID) async {
    try {
      final user = await FirebaseAuth.instance.currentUser;
      final snapshots = await FirebaseFirestore.instance.collection('schedules')
      .where('patientID', isEqualTo: user!.uid)
      .where('doctorID', isEqualTo: docID)
      .where('status', isEqualTo: 'pending').get();
      String documentID = '';

      for(var s in snapshots.docs) {
        documentID = s.reference.id;
        await FirebaseFirestore.instance.collection('schedules').doc(documentID).update({
          'date': date,
          'day': day,
          'month': month,
          'year': year,
          'time': time,
        });
      }
    } on FirebaseAuthException catch (e) {
      throw CustomException(e.message);
    }
  }

  static Future deleteBookingRequest(BuildContext context, String doctorID) async {
    try {
      final user = await FirebaseAuth.instance.currentUser;
      final snapshots = await FirebaseFirestore.instance.collection('schedules')
      .where('patientID', isEqualTo: user!.uid)
      .where('doctorID', isEqualTo: doctorID)
      .where('status', isEqualTo: 'pending').get();

      for(var s in snapshots.docs) {
        await FirebaseFirestore.instance.collection('schedules').doc(s.reference.id).delete();
      }
    } on FirebaseAuthException catch (e) {
      throw CustomException(e.message);
    }
  }

  static Stream getBookingRequestList() async* {
    try {
      final user = await FirebaseAuth.instance.currentUser;
      final snapshot = await FirebaseFirestore.instance.collection('schedules')
      .where('doctorID', isEqualTo: user!.uid)
      .where('status', isEqualTo: 'pending').get();

      List list = [];

      for (var s in snapshot.docs) {
        if (s.exists == true) {
          final user = await FirebaseFirestore.instance.collection('users').doc(s['patientID']).get();
          final userData = user.data() as Map<String, dynamic>;
          // print(userData['name']);
          list.add({ 'date': s['date'], 'day': s['day'], 'month': s['month'], 'time': s['time'], 'year': s['year'],
          'id': s.reference.id, 'studentName': userData['name'] });
        }
      }

      yield list;
    } on FirebaseAuthException catch (e) {
      throw CustomException(e.message);
    }
  }

  static Future acceptBookingRequest(String reqID) async {
    try {
      final user = await FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection('schedules').doc(reqID).update({
        'status': 'confirmed'
      });
    } on FirebaseAuthException catch (e) {
      throw CustomException(e.message);
    }
  }

  static Future rejectBookingRequest(String reqID) async {
    try {
      await FirebaseFirestore.instance.collection('schedules').doc(reqID).delete();
    } on FirebaseAuthException catch (e) {
      throw CustomException(e.message);
    }
  }

  static Future getDoctorListForRating() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final docs = await FirebaseFirestore.instance.collection('schedules')
      .where('patientID', isEqualTo: user!.uid).
      where('status', isEqualTo: 'confirmed').get();
      var list = [];
      for(var doc in docs.docs) {
        if (doc.exists == true) {
          final user = await FirebaseFirestore.instance.collection('users').doc(doc['doctorID']).get();
          String doctorID = user.reference.id;
          final userData = user.data() as Map<String, dynamic>;
          double rating = doc.data().toString().contains('rating') ? doc.get('rating') : 0;
          list.add({ 'doctorName': userData['name'], 'day': doc['day'], 'date': doc['date'], 'month': doc['month'], 'year': doc['year'], 'time': doc['time'],
          'doctorID': doctorID, 'rating': rating });
        }
      }
      return list;
    } on FirebaseAuthException catch (e) {
      throw CustomException(e.message);
    }
  }
}



// doc.data().toString().contains('id') ? doc.get('id') : '',