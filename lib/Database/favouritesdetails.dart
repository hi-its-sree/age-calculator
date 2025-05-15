import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rentzy/pageSet-1/OnBoardingScreen2.dart';
class FavouriteDetails{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;


  Future<bool> isCarAlreadyFavourite(String model) async {
    final snapshot = await _firestore.collection("Favourites")
        .where('model', isEqualTo: model)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  Future<void>FavouriteDetailsToFirestore({
    required String model,
    required String image,
    required String rent,
    required String seats,
    required String transmission,
    required String body,
    required String fuel_capacity,
    required String airbags,
    required String  mileage,
    required String description

  }) async {
    await _firestore.collection("Favourites").doc().set({
      'model': model,
      'image': image,
      'rent': rent,
      'seats': seats,
      'transmission':transmission,
      'class':body,
      'fuel capacity':fuel_capacity,
      'airbags':airbags,
      'mileage':mileage,
      'description':description
    });
  }
  
  Future<List<Map<String,dynamic>>>FetchFavouritesDetails() async
  {
     CollectionReference fav=_firestore.collection("Favourites");
     try
         {
            QuerySnapshot querysnapshot=await fav.get();
            return  querysnapshot.docs.map((doc)=>doc.data() as Map<String,dynamic>).toList();
         }
     catch(e)
    {
     rethrow;
    }
}


  }


