import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SaveDetails {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  User? get currentUser=>firebaseAuth.currentUser;

  Future<void> userDetailsToFirestore({
    required String email,
    required String password,
  }) async {
    await _firestore.collection("users").add({
      'email': email,
      'password': password,
    });
  }

  Future<void>ProfileDetailsToFirestore({
    required String Fullname,
    required String Nickname,
    required String gender,
    required String dob,
    required String email,
    required String mobile,
    required String address,
    required File imageFile
}) async {
    User?user=currentUser;
    final base64Image = base64Encode(imageFile.readAsBytesSync());
    await _firestore.collection("userprofiles").doc(user?.uid).set({
      'Fullname':Fullname,
      'Nickname':Nickname,
      'gender':gender,
      'dob':dob,
      'email':email,
      'mobile':mobile,
      'address':address,
      'profilePicture': base64Image
    });
  }


}





