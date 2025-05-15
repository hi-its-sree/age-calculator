import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../BookingPages/ConfirmationPage.dart';
import '../Database/FetchBookingDetails.dart';
import 'ActiveOrderDetailsPage.dart';

class OrdersCompleted extends StatefulWidget {
  const OrdersCompleted({super.key});

  @override
  State<OrdersCompleted> createState() => _OrdersCompletedState();
}

class _OrdersCompletedState extends State<OrdersCompleted> {
  List<Map<String, dynamic>> CompletedDetails = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  Future<void> loadDetails() async {
    try {
      List<Map<String, dynamic>>? details = await FetchBookingDetails().fetchCompletedData();
      setState(() {
        CompletedDetails = details ?? [];
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching Active details: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    var screenHeight = mediaQueryData.size.height;
    var screenWidth = mediaQueryData.size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Column(
          children: [
            if (isLoading)
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else if (CompletedDetails.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        "assets/animations/Animation - 1743144677149.json",
                        height: screenHeight * 0.3,
                        width: screenWidth * 0.8,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "No Completed orders",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "You don't have any completed bookings yet",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 20), // Add bottom padding
                  itemCount: CompletedDetails.length,
                  itemBuilder: (context, index) {
                    var completed = CompletedDetails[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 8.0),
                      child: Container(
                        height: screenHeight * 0.180,
                        width: screenWidth * 0.92,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade100,
                        ),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      height: screenHeight * 0.132,
                                      width: screenWidth * 0.30,
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey.shade300,
                                      ),
                                      child: Image.network(
                                        completed['profilePicture'],
                                        height: screenHeight * 0.19,
                                        width: screenWidth * 0.55,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  completed['rent'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        completed['model'],
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenHeight * 0.0023),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_month_sharp,
                                          color: Colors.grey, size: 16),
                                      SizedBox(width: screenWidth * 0.0063),
                                      Text(
                                        completed['pickupdate'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade500,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenHeight * 0.0023),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_month_sharp,
                                          color: Colors.grey, size: 16),
                                      SizedBox(width: screenWidth * 0.0063),
                                      Text(
                                        completed['returndate'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade500,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenHeight * 0.0023),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined,
                                          color: Colors.grey, size: 16),
                                      SizedBox(width: screenWidth * 0.0063),
                                      Text(
                                        completed['location'],
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade500,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 5.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>ActiveOrderDetailsPage()));
                                            },
                                            child: Container(
                                              height: screenHeight * 0.036,
                                              width: screenWidth * 0.380,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                color: Colors.white54,
                                                border: Border.all(
                                                  color: Colors.green,
                                                  width: 1.0,
                                                  style: BorderStyle.solid,
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "View details",
                                                  style: TextStyle(color: Colors.green),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}