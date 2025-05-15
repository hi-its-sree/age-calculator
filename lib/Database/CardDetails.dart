import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class CardDetails
{
  Future<List<Map<String, dynamic>>> fetchAllData() async {
    CollectionReference<Map<String, dynamic>> collection = FirebaseFirestore.instance.collection("CardDetails");

    try {
      QuerySnapshot<Map<String, dynamic>> querysnapshot = await collection.get();
      print(querysnapshot.docs.map((doc) => doc.data()));
      return querysnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error fetching card details: $e"); // Log errors properly
      return [];
    }
  }

  Future<void> deleteCard(String cardId) async {
    try {
      await FirebaseFirestore.instance.collection('CardDetails').doc(cardId).delete();
    } catch (e) {
      print('Error deleting card: $e');
      throw e;
    }
  }

  Future<void>CardDetailsToFirestore({
    required String Fullname,
    required String email,
    required String cardnumber,
    required String expiry,
    required String cvv,
    required String country,
    required String zip,
    required String image,
  }) async {

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore.collection("CardDetails").doc().set({
      'Fullname':Fullname,
      'email':email,
      'cardnumber':cardnumber,
      'expiry':expiry,
      'cvv': cvv,
      'country':country,
      'zip':zip,
      'image':image
    });
  }
}