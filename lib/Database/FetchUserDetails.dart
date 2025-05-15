import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


  class FetchDetails {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;


    User? get currentUser => firebaseAuth.currentUser;

    Future<Map<String, dynamic>?> fetchUserDetails() async {
      User? user = currentUser;


      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("userprofiles")
            .doc(user?.uid) // Use the current user's UID
            .get();


        if (userDoc.exists) {
          return userDoc.data() as Map<String, dynamic>;
        } else {
          throw Exception("User profile not found.");
        }
      } catch (e) {
        rethrow;
      }
    }
  }


