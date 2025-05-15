import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rentzy/BookingPages/BookingDetailsPage.dart';
import 'package:rentzy/BookingPages/ConfirmationPage.dart';
import 'package:rentzy/OrderPages/ActiveOrderDetailsPage.dart';
import '../BottomNavBar/CancellationPage.dart';
import '../Database/FetchBookingDetails.dart';

class OrdersActive extends StatefulWidget {
   OrdersActive({super.key, required this.status});
   var status;

  @override
  State<OrdersActive> createState() => _OrdersActiveState();
}

class _OrdersActiveState extends State<OrdersActive> {
  List<Map<String, dynamic>> ActiveDetails = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  Future<void> loadDetails() async {
    try {
      List<Map<String, dynamic>>? details =
      await FetchBookingDetails().fetchAllData();
      setState(() {
        ActiveDetails = details ?? [];
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (isLoading)
                Container(
                  height: screenHeight * 0.8,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (ActiveDetails.isEmpty)
                Container(
                  height: screenHeight * 0.8,
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
                          "No Active Orders",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "You don't have any active bookings yet",
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
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: ActiveDetails.length,
                  itemBuilder: (context, index) {
                    var active = ActiveDetails[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 8.0),
                      child: Container(
                        constraints: BoxConstraints(
                          minHeight: screenHeight * 0.18,
                        ),
                        width: screenWidth * 0.92,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade100,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      height: screenHeight * 0.132,
                                      width: screenWidth * 0.30,
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey.shade300,
                                      ),
                                      child: Image.network(
                                        active['profilePicture'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "₹${active['rent']}/day",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      active['model'],
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month_sharp,
                                          color: Colors.grey,
                                          size: 16,
                                        ),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            active['pickupdate'],
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey.shade500,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month_sharp,
                                          color: Colors.grey,
                                          size: 16,
                                        ),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            active['returndate'],
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey.shade500,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.grey,
                                          size: 16,
                                        ),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            active['location'],
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey.shade500,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ActiveOrderDetailsPage(
                                                        details: active,
                                                        status: widget.status,
                                                      ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: screenHeight * 0.035,
                                              width: screenWidth * 0.25,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(15),
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
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                  widget.status='cancelled';
                                              });
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CancellationPage(status:widget.status,active:active),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: screenHeight * 0.035,
                                              width: screenWidth * 0.25,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(15),
                                                color: Colors.white54,
                                                border: Border.all(
                                                  color: Colors.red,
                                                  width: 1.0,
                                                  style: BorderStyle.solid,
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Cancel order",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}