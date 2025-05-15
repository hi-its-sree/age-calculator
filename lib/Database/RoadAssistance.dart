import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class RoadAssistance {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  User? get currentUser=>firebaseAuth.currentUser;

  Future<void> RoadsideAssistance({
    required String Fullname,
    required String mobile,
    required String location,
    required String issue
  }) async {

    User?user = currentUser;
    await _firestore.collection("Assistance").doc(user?.uid).set({
      'Fullname': Fullname,
      'mobile': mobile,
      'location': location,
      'issue': issue,
    });
  }
}