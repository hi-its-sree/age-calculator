import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rentzy/BottomNavBar/BottomNavigationBar.dart';
import '../BottomNavBar/CancellationPage.dart';
import '../BottomNavBar/ReviewPage.dart';
import '../Database/FetchUserDetails.dart';

class ActiveOrderDetailsPage extends StatefulWidget {
  const ActiveOrderDetailsPage({super.key, this.details, required this.status});
  final Map<String,dynamic>? details;
  final String status;

  @override
  State<ActiveOrderDetailsPage> createState() => _ActiveOrderDetailsPageState();
}

class _ActiveOrderDetailsPageState extends State<ActiveOrderDetailsPage> {
  Map<String, dynamic>? userDetails;

  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  Future<void> loadDetails() async {
    try {
      Map<String, dynamic>? details = await FetchDetails().fetchUserDetails();
      setState(() {
        userDetails = details;
      });
    } catch (e) {
      print("Error fetching user details: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    var screenHeight = mediaQueryData.size.height;
    var screenWidth = mediaQueryData.size.width;

    final rentalDays = calculateRentalDays(
        pickupdate: widget.details?['pickupdate']?.toString() ?? '',
        returndate: widget.details?['returndate']?.toString() ?? ''
    ) ?? 1;

    final rent = double.tryParse(widget.details?['rent']?.toString() ?? '0') ?? 0;
    final totalAmount = TotalAmount(rent * rentalDays);

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.058,
              width: double.infinity,
              color: Colors.white60,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 23,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.053),
                  const Text("Booking Details", style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        height: screenHeight * 0.428,
                        width: screenWidth * 0.92,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade100
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.details?['model']?.toString() ?? 'No model',
                                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "Rentzy",
                                    style: GoogleFonts.kaushanScript(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.deepOrange
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.053),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Container(
                                            height: screenHeight * 0.125,
                                            width: screenWidth * 0.290,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade300,
                                                borderRadius: BorderRadius.circular(16),
                                                image: DecorationImage(
                                                  image: NetworkImage(widget.details?['profilePicture']?.toString() ?? ''),
                                                  fit: BoxFit.cover,
                                                  onError: (exception, stackTrace) => const Icon(Icons.error),
                                                )
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.directions_car, size: 17, color: Colors.grey),
                                              SizedBox(width: screenWidth * 0.015),
                                              Text(widget.details?['class']?.toString() ?? 'N/A'),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
                                          child: Expanded(
                                            child: Row(
                                              children: [
                                                // Seats
                                                const Icon(
                                                  FontAwesomeIcons.chair,
                                                  size: 16,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(width: screenWidth * 0.015),
                                                Text(
                                                  widget.details?['seats']?.toString() ?? 'N/A',
                                                  style: const TextStyle(fontSize: 12),
                                                ),
                                                SizedBox(width: screenWidth * 0.045),

                                                // Fuel Capacity
                                                const Icon(
                                                  Icons.gas_meter_outlined,
                                                  size: 17,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(width: screenWidth * 0.015),
                                                Text(
                                                  widget.details?['fuel_capacity']?.toString() ?? 'N/A',
                                                  style: const TextStyle(fontSize: 12),
                                                ),
                                                SizedBox(width: screenWidth * 0.035),

                                                // Mileage
                                                const Icon(
                                                  Icons.speed,
                                                  size: 17,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(width: screenWidth * 0.015),
                                                Text(
                                                  widget.details?['mileage']?.toString() ?? 'N/A',
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: const TextStyle(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4.5, vertical: 5.0),
                                          child: Row(
                                            children: [
                                              const Icon(FontAwesomeIcons.cogs, size: 17, color: Colors.grey),
                                              SizedBox(width: screenWidth * 0.025),
                                              Text(widget.details?['transmission']?.toString() ?? 'N/A')
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: Divider(
                                thickness: 1.0,
                                indent: 10.0,
                                endIndent: 10.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
                              child: Column(
                                children: [
                                  const Row(
                                    children: [
                                      Text("Pick-up date"),
                                      Spacer(),
                                      Text("Return date")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(widget.details?['pickupdate']?.toString() ?? 'N/A'),
                                      const Spacer(),
                                      Column(
                                        children: [
                                          Image.asset(
                                            "assets/images/HomeCarousel/car (1).png",
                                            height: screenHeight * 0.080,
                                            fit: BoxFit.cover,
                                          ),
                                          Text('$rentalDays days')
                                        ],
                                      ),
                                      const Spacer(),
                                      Text(widget.details?['returndate']?.toString() ?? 'N/A')
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0),
                              child: Divider(
                                thickness: 1.0,
                                indent: 10.0,
                                endIndent: 10.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Note:All details are based on your car rental booking to ensure accuracy and consistency.",
                                      style: TextStyle(
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                          overflow: TextOverflow.ellipsis
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: screenHeight * 0.255,
                      width: screenWidth * 0.92,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade100
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                const Icon(FontAwesomeIcons.shieldAlt, size: 35, color: Colors.black),
                                SizedBox(width: screenWidth * 0.037),
                                const Text("Insurance", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black))
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 1.0,
                            indent: 10.0,
                            endIndent: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                const Icon(Icons.check_circle, color: Colors.blue, size: 27),
                                SizedBox(width: screenWidth * 0.021),
                                const Text("Standard Coverage", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.black)),
                                const Spacer(),
                                const Text("₹950.00", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 45.0, right: 5.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Basic standard coverage that covers damage to the rental vehicle and the and third-party liability, ensuring financial safety during the rental period. 🚗💨.",
                                    style: TextStyle(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                    maxLines: 4,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.0122),
                    Container(
                      height: screenHeight * 0.190,
                      width: screenWidth * 0.92,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade100
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: Row(
                                children: [
                                  const Text("Status", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15)),
                                  const Spacer(),
                                  Container(
                                    height: screenHeight * 0.032,
                                    width: screenWidth * 0.215 ,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(
                                            color: widget.status == 'active'
                                                ? Colors.green
                                                : widget.status == 'cancelled'
                                                ? Colors.red
                                                : Colors.green,
                                            width: 1.0
                                        )
                                    ),
                                    child: Center(
                                      child: Text(
                                        widget.status == 'active'
                                            ? "Paid"
                                            : widget.status == 'cancelled'
                                            ? "Cancelled"
                                            : "Completed",
                                        style: TextStyle(
                                          color: widget.status == 'active'
                                              ? Colors.green
                                              : widget.status == 'cancelled'
                                              ? Colors.red
                                              : Colors.green,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: Row(
                                children: [
                                  const Text("Payment Method", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15)),
                                  const Spacer(),
                                  const Text("Razorpay", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 15)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: Row(
                                children: [
                                  const Text(
                                    "Payment Date",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    DateFormat('yyyy-MM-dd').format(DateTime.now()),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: Row(
                                children: [
                                  const Text(
                                    "Booking ID",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Text(
                                    "64647482839",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.0122),
                    Container(
                      height: screenHeight * 0.205,
                      width: screenWidth * 0.92,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade100
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Amount (x$rentalDays days)",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "₹${(rent * rentalDays).toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: Row(
                                children: [
                                  const Text("Insurance", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15)),
                                  const Spacer(),
                                  const Text(
                                    "₹950.00",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: Row(
                                children: [
                                  const Text("Tax(5%)", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15)),
                                  const Spacer(),
                                  const Text("₹20.00", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 15))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: Row(
                                children: [
                                  const Text("Service fee", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15)),
                                  const Spacer(),
                                  const Text("₹75.00", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 15))
                                ],
                              ),
                            ),
                            const Divider(thickness: 1.0),
                            Row(
                              children: [
                                const Text("Total", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15)),
                                const Spacer(),
                                Text(
                                  "₹${totalAmount.toStringAsFixed(2)}",
                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: screenHeight * 0.235,
                        width: screenWidth * 0.92,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade100
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.cancel_outlined, size: 35, color: Colors.red),
                                  SizedBox(width: screenWidth * 0.037),
                                  const Text("Cancellation Policy", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black))
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 1.0,
                              indent: 10.0,
                              endIndent: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0, bottom: 5.0),
                              child: Row(
                                children: [
                                  Text(
                                      "Before the pick-up time (Local Time)",
                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.grey))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0, bottom: 3.0),
                              child: Row(
                                children: [
                                  const Text(
                                      "Free cancellation available",
                                      style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500, color: Colors.blue))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                              child: Row(
                                children: [
                                  Text(
                                      "After the pick-up time (Local Time)",
                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.grey))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0, top: 3.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Cancellation will incur a charge equivalent to total rental fee",
                                      style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500, color: Colors.black, overflow: TextOverflow.ellipsis),
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: GestureDetector(
                        onTap: widget.status == 'active'
                            ? () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CancellationPage(status: widget.status)
                              )
                          );
                        }
                            : null,
                        child: Container(
                          height: screenHeight * 0.060,
                          width: screenWidth * 0.920,
                          decoration: BoxDecoration(
                              color: Colors.white38,
                              border: Border.all(
                                  color: Colors.red,
                                  width: 1.0,
                                  style: BorderStyle.solid
                              ),
                              borderRadius: BorderRadius.circular(26)
                          ),
                          child: Center(
                            child: Text(
                              widget.status == 'active'
                                  ? "Cancel Booking"
                                  : widget.status == 'cancelled'
                                  ? "Cancelled"
                                  : "Completed",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.red
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserReviewPage(
                                      dp: userDetails?['profilePicture']!,
                                      name: userDetails?['Fullname']!,
                                      model: 'car'
                                  )
                              )
                          );
                        },
                        child: Container(
                          height: screenHeight * 0.060,
                          width: screenWidth * 0.920,
                          decoration: BoxDecoration(
                              color: Colors.white38,
                              border: Border.all(
                                  color: Colors.green,
                                  width: 1.0,
                                  style: BorderStyle.solid
                              ),
                              borderRadius: BorderRadius.circular(26)
                          ),
                          child: const Center(
                            child: Text(
                              "Write a Review",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.green
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const BottomNav())
                          );
                        },
                        child: Container(
                          height: screenHeight * 0.060,
                          width: screenWidth * 0.920,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade700,
                                  width: 1.0,
                                  style: BorderStyle.solid
                              ),
                              borderRadius: BorderRadius.circular(26),
                              color: Colors.white38
                          ),
                          child: Center(
                            child: Text(
                              "Back to home",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.grey.shade700
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  int? calculateRentalDays({
    required String pickupdate,
    required String returndate,
  }) {
    try {
      final pickupDate = DateTime.parse(pickupdate);
      final returnDate = DateTime.parse(returndate);
      final difference = returnDate.difference(pickupDate).inDays;
      return difference < 0 ? null : difference + 1;
    } catch (e) {
      debugPrint('Date parsing error: $e');
      return null;
    }
  }

  double TotalAmount(double rent) {
    return rent + 950.00 + 20.00 + 75.00;
  }
}