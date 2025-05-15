import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../BookingPages/ConfirmationPage.dart';
import '../Database/FetchBookingDetails.dart';
import 'ActiveOrderDetailsPage.dart';

class OrdersCancelled extends StatefulWidget {
  const OrdersCancelled({super.key});

  @override
  State<OrdersCancelled> createState() => _OrdersCancelledState();
}

class _OrdersCancelledState extends State<OrdersCancelled> {
  List<Map<String, dynamic>> CancelledDetails = [];
  bool isLoading = true;
  var status = 'cancelled';

  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  Future<void> loadDetails() async {
    try {
      List<Map<String, dynamic>>? details = await FetchBookingDetails().fetchCancelledData();
      setState(() {
        CancelledDetails = details?.where((item) => item != null).toList() ?? [];
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
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : CancelledDetails.isEmpty
            ? Center(
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
                "No Cancelled Orders",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "You don't have any cancelled bookings yet",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        )
            : ListView.builder(
          itemCount: CancelledDetails.length,
          itemBuilder: (context, index) {
            var active = CancelledDetails[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: screenHeight * 0.132,
                              width: screenWidth * 0.30,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade300,
                              ),
                              child: active['profilePicture'] != null
                                  ? Image.network(
                                active['profilePicture'].toString(),
                                height: screenHeight * 0.19,
                                width: screenWidth * 0.55,
                                fit: BoxFit.fitWidth,
                                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                              )
                                  : Icon(Icons.image_not_supported),
                            ),
                          ),
                        ),
                        Text(
                          "₹${active['rent']?.toString() ?? '0'}/day",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    active['model']?.toString() ?? 'No model',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.0023),
                            Row(
                              children: [
                                Icon(Icons.calendar_month_sharp, color: Colors.grey, size: 16),
                                SizedBox(width: screenWidth * 0.0063),
                                Text(
                                  active['pickupdate']?.toString() ?? 'Not specified',
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
                                Icon(Icons.calendar_month_sharp, color: Colors.grey, size: 16),
                                SizedBox(width: screenWidth * 0.0063),
                                Text(
                                  active['returndate']?.toString() ?? 'Not specified',
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
                                Icon(Icons.location_on_outlined, color: Colors.grey, size: 16),
                                SizedBox(width: screenWidth * 0.0063),
                                Text(
                                  active['location']?.toString() ?? 'Location not available',
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
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ActiveOrderDetailsPage(
                                              status: status,
                                              details: active,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: screenHeight * 0.035,
                                        width: screenWidth * 0.250,
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
                                  Container(
                                    height: screenHeight * 0.035,
                                    width: screenWidth * 0.250,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white54,
                                      border: Border.all(
                                        color: Colors.red,
                                        width: 1.0,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Cancelled",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}