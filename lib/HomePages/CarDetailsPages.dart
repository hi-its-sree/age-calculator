import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rentzy/BookingPages/BookingDetailsPage.dart';
import 'package:rentzy/HomePages/Reviews.dart';
import 'package:rentzy/HomePages/favourites.dart';
import '../Database/FetchReviewDetails.dart';
import '../Database/favouritesdetails.dart';

List<String> logos = [
  "assets/images/SpecificationImages/seat.svg",
  "assets/images/SpecificationImages/fuel_tank.svg",
  "assets/images/SpecificationImages/engine.svg",
  "assets/images/SpecificationImages/airbag.svg",
  "assets/images/SpecificationImages/mileage.svg",
  "assets/images/SpecificationImages/bodytype.svg",
];

List<String> specs = [
  "Capacity",
  "Fuel capacity",
  "Transmission",
  "Airbags",
  "Mileage",
  "Body Type"
];

class CarDetailsPage extends StatefulWidget {
  const CarDetailsPage({super.key, required this.car});

  final Map<String, dynamic> car;


  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  bool isLiked = false;
  List<Map<String, dynamic>> reviewDetails = [];

  @override
  void initState() {
    super.initState();
    getReviews();
  }

  Future<void> getReviews() async {
    try {
      final reviews = await ReviewDetails().fetchAllData(widget.car['model']);
      if (kDebugMode) {
        print("Fetched Reviews: $reviews");
      }
      setState(() {
        reviewDetails = reviews;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching reviews: $e");
      }
    }
  }

  Uint8List? decodeBase64ImageSafe(String? base64) {
    if (base64 == null || base64.isEmpty) return null;

    try {
      String cleanBase64 = base64.replaceFirst(RegExp(r'^data:image\/[^;]+;base64,'), '');
      cleanBase64 = cleanBase64.replaceAll(RegExp(r'\s'), '');
      int paddingLength = cleanBase64.length % 4;
      if (paddingLength != 0) {
        cleanBase64 = cleanBase64.padRight(cleanBase64.length + (4 - paddingLength), '=');
      }
      return base64Decode(cleanBase64);
    } catch (e) {
      if (kDebugMode) {
        print("Error decoding base64 image: $e");
        print("Problematic base64 string (first 50 chars): ${base64.substring(0, 50)}...");
      }
      return null;
    }
  }

  Widget buildProfileImage(String? base64Image) {
    final Uint8List? imageBytes = decodeBase64ImageSafe(base64Image);

    if (imageBytes != null) {
      return ClipOval(
        child: Image.memory(
          imageBytes,
          width: 34,
          height: 34,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return buildDefaultAvatar();
          },
        ),
      );
    } else {
      return buildDefaultAvatar();
    }
  }

  Widget buildDefaultAvatar() {
    return CircleAvatar(
      radius: 17,
      backgroundColor: Colors.grey[200],
      child: Icon(Icons.person, size: 20, color: Colors.grey),
    );
  }

  Future<void> SendFavourites() async {
    try {
      bool exists = await FavouriteDetails().isCarAlreadyFavourite(widget.car['model']);

      if (exists) {
        Fluttertoast.showToast(
          msg: "Hey , this car is already in your favorites! 🚗❤️",
          textColor: Colors.black,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.grey.shade100,
        );
      } else if (!exists) {
        await FavouriteDetails().FavouriteDetailsToFirestore(
          model: widget.car['model'],
          image: widget.car['image'],
          rent: widget.car['rent'],
          seats: widget.car['seats'],
          transmission: widget.car['transmission'],
          body: widget.car['class'],
          fuel_capacity: widget.car['fuel capacity'],
          airbags: widget.car['airbags'],
          mileage: widget.car['mileage'],
          description: widget.car['description'],
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaquerydata = MediaQuery.of(context);
    var screenheight = mediaquerydata.size.height;
    var screenwidth = mediaquerydata.size.width;

    List<dynamic> car_specs = [
      widget.car['seats'],
      widget.car['fuel capacity'],
      widget.car['transmission'],
      widget.car['airbags'],
      widget.car['mileage'],
      widget.car['class']
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: screenheight * 0.058,
              width: double.infinity,
              color: Colors.white60,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back, size: 23, color: Colors.black),
                    ),
                  ),
                  SizedBox(width: screenwidth * 0.3),
                  Text(
                    "Car details",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Divider(
              height: 2.0,
              color: Colors.grey,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(widget.car['image']),
                    Container(
                      width: screenwidth,
                      decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: screenheight * 0.016),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                Text(
                                  widget.car['model'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isLiked = !isLiked;
                                    });
                                    Future.delayed(Duration(seconds: 1), () {
                                      SendFavourites();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FavouritesPage()),
                                      );
                                    });
                                  },
                                  child: Container(
                                    height: screenheight * 0.050,
                                    width: screenwidth * 0.100,
                                    child: Icon(
                                      isLiked
                                          ? CupertinoIcons.heart_fill
                                          : CupertinoIcons.heart,
                                      color: isLiked ? Colors.pink : null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenheight * 0.012),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.car['description'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.star, color: Colors.yellow[900]),
                                        Text(
                                          widget.car['rating'],
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "(${reviewDetails.length} reviews)",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: screenheight * 0.040,
                            thickness: 1.0,
                            color: Colors.grey,
                            indent: screenwidth * 0.040,
                            endIndent: screenwidth * 0.040,
                          ),
                          SizedBox(height: screenheight * 0.0013),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Car features",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenheight * 0.02),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 6,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 0.75,
                                crossAxisSpacing: screenheight * 0.011,
                                mainAxisSpacing: screenheight * 0.02,
                                mainAxisExtent: screenheight * 0.15,
                              ),
                              itemBuilder: (context, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Container(
                                    color: Colors.grey[350],
                                    child: Column(
                                      children: [
                                        SizedBox(height: screenheight * 0.020),
                                        Row(
                                          children: [
                                            SizedBox(width: screenwidth * 0.025),
                                            Container(
                                              height: screenheight * 0.033,
                                              width: screenwidth * 0.075,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white60,
                                              ),
                                              child: Center(
                                                child: SvgPicture.asset(
                                                  logos[index],
                                                  height: screenheight * 0.020,
                                                  width: screenwidth * 0.30,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12.0, top: 12.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              specs[index],
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              car_specs[index],
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  "Reviews(${reviewDetails.length})",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ReviewPage(
                                          reviewdetails: reviewDetails,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "See all",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenheight * 0.020),
                          SizedBox(
                            height: screenheight * 0.175,
                            child: reviewDetails.isEmpty
                                ? Center(child: Text("No reviews available"))
                                : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: min(3, reviewDetails.length),
                              itemBuilder: (BuildContext context, int index) {
                                var details = reviewDetails[index];
                                return Container(
                                  width: screenwidth * 0.85,
                                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white30,
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            buildProfileImage(details['dp']),
                                            SizedBox(width: screenwidth * 0.018),
                                            Text(
                                              details['name'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              details['rating'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(width: screenwidth * 0.018),
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow[900],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        Expanded(
                                          child: Text(
                                            details['review'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 6,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: screenheight * 0.020),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Bookingdetailspage(car: widget.car),
                                  ),
                                );
                              },
                              child: Container(
                                height: screenheight * 0.060,
                                width: screenwidth * 0.90,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Book now",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: screenwidth * 0.004),
                                    Icon(
                                      Icons.arrow_forward_outlined,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).padding.bottom),
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
  }
}