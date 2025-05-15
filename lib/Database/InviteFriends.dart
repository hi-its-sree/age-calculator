import 'package:cloud_firestore/cloud_firestore.dart';

class InviteFriends
{
  Future<List<Map<String,dynamic>>>InviteDetails() async
  {
    CollectionReference collection=FirebaseFirestore.instance.collection("Friends");
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