import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CarDetails
{
  Future<List<Map<String,dynamic>>>fetchAllData() async{
    CollectionReference collection=FirebaseFirestore.instance.collection("Cars");
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

  Future<List<Map<String,dynamic>>>fetchAudiCars() async
  {
    CollectionReference category=FirebaseFirestore.instance.collection("Types").doc("Categories").collection("Audi");
    try
        {
          QuerySnapshot querysnapshot = await category.get();
          return querysnapshot.docs.map((doc)=>doc.data() as Map<String,dynamic>).toList();

        }
    catch(e)
    {
      rethrow;
    }
  }




  Future<List<Map<String,dynamic>>>fetchBMWCars() async
  {
    CollectionReference category=FirebaseFirestore.instance.collection("Types").doc("Categories").collection("BMW");
    try
    {
      QuerySnapshot querysnapshot = await category.get();
      return querysnapshot.docs.map((doc)=>doc.data() as Map<String,dynamic>).toList();

    }
    catch(e)
    {
      rethrow;
    }
  }

  Future<List<Map<String,dynamic>>>fetchHondaCars() async
  {
    CollectionReference category=FirebaseFirestore.instance.collection("Types").doc("Categories").collection("Honda");
    try
    {
      QuerySnapshot querysnapshot = await category.get();
      return querysnapshot.docs.map((doc)=>doc.data() as Map<String,dynamic>).toList();

    }
    catch(e)
    {
      rethrow;
    }
  }

  Future<List<Map<String,dynamic>>>fetchHyundaiCars() async
  {
    CollectionReference category=FirebaseFirestore.instance.collection("Types").doc("Categories").collection("Hyundai");
    try
    {
      QuerySnapshot querysnapshot = await category.get();
      return querysnapshot.docs.map((doc)=>doc.data() as Map<String,dynamic>).toList();

    }
    catch(e)
    {
      rethrow;
    }
  }


  Future<List<Map<String,dynamic>>>fetchMahindraCars() async
  {
    CollectionReference category=FirebaseFirestore.instance.collection("Types").doc("Categories").collection("Mahindra");
    try
    {
      QuerySnapshot querysnapshot = await category.get();
      return querysnapshot.docs.map((doc)=>doc.data() as Map<String,dynamic>).toList();

    }
    catch(e)
    {
      rethrow;
    }
  }


  Future<List<Map<String,dynamic>>>fetchMercedesCars() async
  {
    CollectionReference category=FirebaseFirestore.instance.collection("Types").doc("Categories").collection("Mercedes");
    try
    {
      QuerySnapshot querysnapshot = await category.get();
      return querysnapshot.docs.map((doc)=>doc.data() as Map<String,dynamic>).toList();

    }
    catch(e)
    {
      rethrow;
    }
  }


  Future<List<Map<String,dynamic>>>fetchSuzukiCars() async
  {
    CollectionReference category=FirebaseFirestore.instance.collection("Types").doc("Categories").collection("Suzuki");
    try
    {
      QuerySnapshot querysnapshot = await category.get();
      return querysnapshot.docs.map((doc)=>doc.data() as Map<String,dynamic>).toList();

    }
    catch(e)
    {
      rethrow;
    }
  }

  Future<List<Map<String,dynamic>>>fetchToyotaCars() async
  {
    CollectionReference category=FirebaseFirestore.instance.collection("Types").doc("Categories").collection("Toyota");
    try
    {
      QuerySnapshot querysnapshot = await category.get();
      return querysnapshot.docs.map((doc)=>doc.data() as Map<String,dynamic>).toList();

    }
    catch(e)
    {
      rethrow;
    }
  }


  Future<List<Map<String,dynamic>>>NewArrivals() async
  {
    CollectionReference category=FirebaseFirestore.instance.collection("New Arrivals");
    try
    {
      QuerySnapshot querysnapshot = await category.get();
      return querysnapshot.docs.map((doc)=>doc.data() as Map<String,dynamic>).toList();

    }
    catch(e)
    {
      rethrow;
    }
  }

}

