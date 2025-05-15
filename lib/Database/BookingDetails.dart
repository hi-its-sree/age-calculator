import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingDetails {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Future<String> ActiveDetailsToFirestore({
    required String Fullname,
    required String model,
    required String class_type,
    required String seats,
    required String fuel_capacity,
    required String mileage,
    required String transmission,
    required String pickupdate,
    required String returndate,
    required String days,
    required String imageFile,
    required String location,
    required String rent,
  }) async {
    final docRef = await _firestore.collection("Active").add({
      'Fullname': Fullname,
      'model': model,
      'class': class_type,
      'seats': seats,
      'fuel_capacity': fuel_capacity,
      'mileage': mileage,
      'transmission': transmission,
      'pickupdate': pickupdate,
      'returndate': returndate,
      'days': days,
      'profilePicture': imageFile,
      'location': location,
      'rent': rent,
      'createdAt': FieldValue.serverTimestamp(),
      'userId': currentUser?.uid,
      'status': 'active',
    });
    return docRef.id;
  }


  Future<String> CompletedDetailsToFirestore({
    required String Fullname,
    required String model,
    required String class_type,
    required String seats,
    required String fuel_capacity,
    required String mileage,
    required String transmission,
    required String pickupdate,
    required String returndate,
    required String days,
    required String imageFile,
    required String location,
    required String rent,
  }) async {
    final docRef = await _firestore.collection("Completed").add({
      'Fullname': Fullname,
      'model': model,
      'class': class_type,
      'seats': seats,
      'fuel_capacity': fuel_capacity,
      'mileage': mileage,
      'transmission': transmission,
      'pickupdate': pickupdate,
      'returndate': returndate,
      'days': days,
      'profilePicture': imageFile,
      'location': location,
      'rent': rent,
      'createdAt': FieldValue.serverTimestamp(),
      'userId': currentUser?.uid,
      'status': 'active',
    });
    return docRef.id;
  }

  Future<void> deleteActiveBooking(String bookingId) async {
    await _firestore.collection("Active").doc(bookingId).delete();
  }

  Future<void> CancelledDetailsToFirestore({
    required String Fullname,
    required String model,
    required String class_type,
    required String seats,
    required String fuel_capacity,
    required String mileage,
    required String transmission,
    required String pickupdate,
    required String returndate,
    required String days,
    required String imageFile,
    required String location,
    required String rent,
    required String option,
    String? bookingId,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('User not authenticated');

    final docId = bookingId ?? 'cancel_${DateTime.now().millisecondsSinceEpoch}';
    final cancellationData = {
      'userId': user.uid,
      'Fullname': Fullname,
      'model': model,
      'class': class_type,
      'seats': seats,
      'fuel_capacity': fuel_capacity,
      'mileage': mileage,
      'transmission': transmission,
      'pickupdate': pickupdate,
      'returndate': returndate,
      'days': days,
      'profilePicture': imageFile,
      'location': location,
      'rent': rent,
      'option': option,
      'originalBookingId': bookingId,
      'cancelledAt': FieldValue.serverTimestamp(),
      'status': 'cancelled',
    };

    // Write to main cancellations collection
    await _firestore.collection("Cancelled").doc(docId).set(cancellationData);

    // Also store in user's personal cancellation history
    await _firestore
        .collection("users")
        .doc(user.uid)
        .collection("UserCancellations")
        .doc(docId)
        .set(cancellationData);
  }
}