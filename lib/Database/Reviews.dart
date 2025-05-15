import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Reviews
{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  User? get currentUser=>firebaseAuth.currentUser;
  Future<void>ReviewstoFireStore({
    required String name,
    required String model,
    required String review,
    required String rating,
    required String dp
  }) async {
    User?user=currentUser;
    await _firestore.collection("Reviews").doc(user?.uid).set({
      'name':name,
      'model':model,
      'review':review,
      'rating':rating,
      'dp':dp
    });
  }
}