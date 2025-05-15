import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Database/CarDetails.dart';
import 'CarDetailsPages.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchPageState();
}

class _SearchPageState extends State<Searchpage> {
  List<Map<String, dynamic>> allCars = [];
  List<Map<String, dynamic>> filteredCars = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAllCars();
  }

  Future<void> loadAllCars() async {
    try {

      List<Map<String, dynamic>> hyundaiCars = await CarDetails().fetchHyundaiCars();
      List<Map<String, dynamic>> hondaCars = await CarDetails().fetchHondaCars();
      List<Map<String, dynamic>> audiCars = await CarDetails().fetchAudiCars();
      List<Map<String, dynamic>> bmwCars = await CarDetails().fetchBMWCars();
      List<Map<String, dynamic>> mahindraCars = await CarDetails().fetchMahindraCars();
      List<Map<String, dynamic>> mercedesCars = await CarDetails().fetchMercedesCars();
      List<Map<String, dynamic>> suzukiCars = await CarDetails().fetchSuzukiCars();
      List<Map<String, dynamic>> toyotaCars = await CarDetails().fetchToyotaCars();

      // Combine all lists into one comprehensive list
      allCars = [
        ...hyundaiCars,
        ...hondaCars,
        ...audiCars,
        ...bmwCars,
        ...mahindraCars,
        ...mercedesCars,
        ...suzukiCars,
        ...toyotaCars,
      ];

      // Remove duplicates if any (optional)
      allCars = allCars.toSet().toList();

      setState(() {
        filteredCars = allCars;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching car details: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterCars(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredCars = allCars;
      });
      return;
    }

    final searchLower = query.toLowerCase();

    final filtered = allCars.where((car) {
      final modelLower = car['model']?.toString().toLowerCase() ?? '';
      final brandLower = car['class']?.toString().toLowerCase() ?? '';
      final typeLower = car['rent']?.toString().toLowerCase() ?? '';
      final featuresLower = car['transmission']?.toString().toLowerCase() ?? '';
      final fuelTypeLower = car['fuelType']?.toString().toLowerCase() ?? '';

      return modelLower.contains(searchLower) ||
          brandLower.contains(searchLower) ||
          typeLower.contains(searchLower) ||
          featuresLower.contains(searchLower) ||
          fuelTypeLower.contains(searchLower);
    }).toList();

    setState(() {
      filteredCars = filtered;
    });
  }

  void clearSearch() {
    searchController.clear();
    filterCars('');
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    var screenHeight = mediaQueryData.size.height;
    var screenWidth = mediaQueryData.size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.058,
              width: double.infinity,
              color: Colors.white60,
              child: Row(
                children: [

                  SizedBox(width: screenWidth * 0.063),
                  const Text(
                    "Search for Your Perfect Ride",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.black,
                      size: 23,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.015),

            // Search bar
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: SizedBox(
                    height: screenHeight * 0.050,
                    width: screenWidth * 0.80,
                    child: CupertinoSearchTextField(
                      controller: searchController,
                      borderRadius: BorderRadius.circular(12),
                      keyboardType: TextInputType.text,
                      onChanged: filterCars,
                      onSubmitted: (data) {
                        FocusScope.of(context).unfocus();
                        filterCars(data);
                      },

                      autocorrect: true,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                      suffixIcon:  Icon(
                          Icons.close_outlined,
                          size: 20,
                          color: Colors.black,
                        ),
                      placeholder: "Search by model or type ",
                      placeholderStyle: const TextStyle(fontSize: 17, color: Colors.black45),
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: screenHeight * 0.0143),

            // Main content
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredCars.isEmpty
                  ? Center(
                child: Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.3),
                  child: Text(
                    searchController.text.isEmpty
                        ? "No cars available"
                        : "No cars found matching '${searchController.text}'",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
                  : GridView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: filteredCars.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: screenHeight * 0.0040,
                  mainAxisSpacing: screenHeight * 0.010,
                  mainAxisExtent: screenHeight * 0.30,
                ),
                itemBuilder: (context, index) {
                  final car = filteredCars[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 9.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CarDetailsPage(car: car),
                          ),
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white60,
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: screenHeight * 0.19,
                                    width: screenWidth * 0.435,
                                    color: Colors.grey,
                                    child: Image.network(
                                      car['image'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    left: screenWidth * 0.34,
                                    bottom: screenHeight * 0.142,
                                    child: Container(
                                      height: screenHeight * 0.035,
                                      width: screenWidth * 0.098,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        CupertinoIcons.suit_heart,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.011),

                              // Car model and brand
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      car['model'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                    
                                  ],
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.002),

                              // Rating
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "4.9",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    SizedBox(width: screenWidth * 0.012),
                                    const Icon(
                                      CupertinoIcons.star_fill,
                                      color: Colors.yellow,
                                      size: 17,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.002),

                              // Seats and price
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.event_seat_outlined,
                                      color: Colors.grey,
                                      size: 17,
                                    ),
                                    SizedBox(width: screenWidth * 0.012),
                                    Text(
                                      car['seats'],
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.currency_rupee,
                                      color: Colors.grey,
                                      size: 17,
                                    ),
                                    Text(
                                      "${car['rent']}/day",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey.shade700,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}