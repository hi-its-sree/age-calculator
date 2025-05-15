import 'package:cloud_firestore/cloud_firestore.dart';
class ReviewDetails
{
  Future<List<Map<String, dynamic>>> fetchAllData(String model) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("Reviews")
          .where("model", isEqualTo: model)
          .get();

      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        // data['id'] = doc.id; // Include document ID
        return data;
      }).toList();
    } catch (e) {
      print("Error fetching reviews: $e");
      rethrow;
    }
  }
}