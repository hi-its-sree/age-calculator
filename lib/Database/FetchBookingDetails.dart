import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FetchBookingDetails
{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => firebaseAuth.currentUser;

  Future<List<Map<String,dynamic>>>fetchAllData() async{
    CollectionReference collection=FirebaseFirestore.instance.collection("Active");
    try
    {
      QuerySnapshot querysnapshot= await collection.get();
      return querysnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    }
    catch(e)
    {
      rethrow;
    }
  }

  Future<List<Map<String,dynamic>>>fetchCancelledData() async{
    CollectionReference collection=FirebaseFirestore.instance.collection("Cancelled");
    try
    {
      QuerySnapshot querysnapshot= await collection.get();
      return querysnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    }
    catch(e)
    {
      rethrow;
    }
  }

  Future<List<Map<String,dynamic>>>fetchCompletedData() async{
    CollectionReference collection=FirebaseFirestore.instance.collection("Completed");
    try
    {
      QuerySnapshot querysnapshot= await collection.get();
      return querysnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    }
    catch(e)
    {
      rethrow;
    }
  }
}