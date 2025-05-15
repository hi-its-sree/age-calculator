import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:rentzy/BottomNavBar/ProfilePages.dart';
import 'package:rentzy/Database/FetchUserDetails.dart';
import 'package:rentzy/HomePages/CategoryPage.dart';
import 'package:rentzy/HomePages/NewArrivals.dart';
import 'package:rentzy/HomePages/NotificationPage.dart';
import 'package:rentzy/HomePages/favourites.dart';
import 'package:rentzy/pageSet-1/OnBoardingScreen2.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Database/CarDetails.dart';
import 'CarDetailsPages.dart';


List<String>carousel_image=["assets/images/HomeCarousel/slider1.png",
"assets/images/HomeCarousel/slider2.png",
"assets/images/HomeCarousel/slider3.png"];

List<String>logo_set2=[
  "assets/images/Logos/mahindra.png",
  "assets/images/Logos/mercedes.png",
  "assets/images/Logos/suzuki.png",
  "assets/images/Logos/toyota.png"];

List<String>logo_name2=["Mahindra","Mercedes","Suzuki","Toyota"];

List<String> percentage=[
  "20%",
  "30%",
  "15%"
];

List<String>deals=[
  "Week deals!!",
  "Daily deals!!",
  "New Arrivals!!"
];

class MainHome extends StatefulWidget {
  const MainHome({super.key,});


  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {

  List<Map<String, dynamic>>?cars = [];
  List<Map<String, dynamic>>?NewCars = [];
  Map<String, dynamic>? userDetails;
  List<Map<String, dynamic>>? AudiCategory = [];
  List<Map<String, dynamic>>? BMWCategory = [];
  List<Map<String, dynamic>>? HondaCategory = [];
  List<Map<String, dynamic>>? HyundaiCategory = [];
  List<Map<String, dynamic>>? MahindraCategory = [];
  List<Map<String, dynamic>>? MercedesCategory = [];
  List<Map<String, dynamic>>? SuzukiCategory = [];
  List<Map<String, dynamic>>? ToyotaCategory = [];
  var iconColour=0;
  @override
  void initState() {
    super.initState();
    loadCars();
    loadDetails();
    loadCategoryCars();
    Arrivals();
  }

  Future<void> loadCars() async {
    List<Map<String, dynamic>> fetchedCars = await CarDetails().fetchAllData();
    setState(() {
      cars = fetchedCars;
    });
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

  Future<void>Arrivals() async{
    try{
      List<Map<String,dynamic>>?newcars=await CarDetails().NewArrivals();
      setState(() {
        NewCars=newcars;
      });
    }
    catch(e)
    {
      print("Error fetching user details:$e");
    }

}

  Future<void> loadCategoryCars() async {
    try {
      List<Map<String, dynamic>> AudiCars = await CarDetails().fetchAudiCars();
      setState(() {
        AudiCategory = AudiCars;
      });

      List<Map<String, dynamic>> BMWCars = await CarDetails().fetchBMWCars();
      setState(() {
        BMWCategory = BMWCars;
      });

      List<Map<String, dynamic>> HondaCars = await CarDetails().fetchHondaCars();
      setState(() {
        HondaCategory = HondaCars;
      });

      List<Map<String,dynamic>>HyundaiCars=await CarDetails().fetchHyundaiCars();
      setState(() {
        HyundaiCategory=HyundaiCars;
      });

      List<Map<String,dynamic>>MahindraCars=await CarDetails().fetchMahindraCars();
      setState(() {
        MahindraCategory=MahindraCars;
      });

      List<Map<String,dynamic>>MercedesaCars=await CarDetails().fetchMercedesCars();
      setState(() {
        MercedesCategory=MercedesaCars;
      });

      List<Map<String,dynamic>>SuzukiCars=await CarDetails().fetchSuzukiCars();
      setState(() {
        SuzukiCategory=SuzukiCars;
      });

      List<Map<String,dynamic>>ToyotaCars=await CarDetails().fetchToyotaCars();
      setState(() {
        ToyotaCategory=ToyotaCars;
      });
    }
    catch (e) {
      print("Error fetching user details: $e");
    }

  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    var screenheight = mediaQueryData.size.height;
    var screenwidth = mediaQueryData.size.width;
    int activeIndex = 0;


    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: screenheight / 14,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: ()
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Profilepages(details:userDetails)));
                            },
                            child: CircleAvatar(
                                radius: 18,
                                backgroundImage: userDetails?['profilePicture'] != null
                                    ? MemoryImage(base64Decode(
                                    userDetails?['profilePicture'] ?? ''))
                                    : AssetImage(
                                    "assets/images/ForgotPassword/popup.png")
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(Time(), style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey.shade500),)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(userDetails?['Nickname'] ?? 'Guest',
                                        style: TextStyle(fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: ()
                                {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Notificationpage()));
                                },
                                child: Icon(Icons.notifications_on_outlined)),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: GestureDetector(
                          //       onTap: () {
                          //         Navigator.push(context, MaterialPageRoute(
                          //             builder: (context) => FavouritesPage()
                          //         ));
                          //       },
                          //       child: Icon(Icons.favorite_border)),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text("Welcome back!!! ", style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text("Ready to hit the road...",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),),
                      ),
                    ],
                  ),
                  SizedBox(height: screenheight / 50,),

                  Container(
                    height: screenheight / 5.5,
                    width: screenwidth / 1.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey.shade400,
                    ),
                    child:
                    CarouselSlider.builder(
                        itemCount: carousel_image.length,
                        itemBuilder: (context, index, realIndex) {
                          final url_images = carousel_image[index];
                          final deal = deals[index];
                          final perc = percentage[index];
                          return carouselSlider(url_images, deal, perc);
                        },
                        options: CarouselOptions(
                            autoPlay: true,
                            reverse: true,
                            autoPlayAnimationDuration: Duration(seconds: 2),
                            viewportFraction: 1,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                            onPageChanged: (index, reason) {
                              setState(() {
                                activeIndex = index;
                              });
                            }
                        )),

                  ),
                  SizedBox(height: screenheight / 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text("Brands for you ", style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 15.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        CategoryPage(
                                            car: AudiCategory, name: "Audi")));
                              },
                              child: Container(
                                height: screenheight / 14,
                                width: screenwidth / 6.5,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade400
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/Logos/audi.png", height: 25,
                                    width: 25,),
                                ),

                              ),
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text("Audi")
                              ],
                            )
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 15.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        CategoryPage(
                                            car: BMWCategory, name: "BMW")));
                              },
                              child: Container(
                                height: screenheight / 14,
                                width: screenwidth / 6.5,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade400
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/Logos/bmw.png", height: 25,
                                    width: 25,),
                                ),

                              ),
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text("BMW")
                              ],
                            )
                          ],
                        ),

                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 15.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        CategoryPage(
                                            car: HondaCategory, name: "Honda")));
                              },
                              child: Container(
                                height: screenheight / 14,
                                width: screenwidth / 6.5,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade400
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/Logos/honda.png", height: 25,
                                    width: 25,),
                                ),

                              ),
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text("Honda")
                              ],
                            )
                          ],
                        ),

                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 15.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        CategoryPage(car: HyundaiCategory,
                                            name: "Hyundai")));
                              },
                              child: Container(
                                height: screenheight / 14,
                                width: screenwidth / 6.5,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade400
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/Logos/hyundai.png",
                                    height: 25, width: 25,),
                                ),

                              ),
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text("Hyundai")
                              ],
                            )
                          ],
                        ),

                      )
                    ],
                  ),

                  SizedBox(height: screenheight * 0.0110,),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 15.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        CategoryPage(car: MahindraCategory,
                                            name: "Mahindra")));
                              },
                              child: Container(
                                height: screenheight / 14,
                                width: screenwidth / 6.5,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade400
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/Logos/mahindra.png",
                                    height: 25, width: 25,),
                                ),

                              ),
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text("Mahindra")
                              ],
                            )
                          ],
                        ),

                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 15.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        CategoryPage(car: MercedesCategory,
                                            name: "Mercedes")));
                              },
                              child: Container(
                                height: screenheight / 14,
                                width: screenwidth / 6.5,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade400
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/Logos/mercedes.png",
                                    height: 25, width: 25,),
                                ),

                              ),
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text("Mercedes")
                              ],
                            )
                          ],
                        ),

                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 15.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        CategoryPage(car: SuzukiCategory,
                                            name: "Suzuki")));
                              },
                              child: Container(
                                height: screenheight / 14,
                                width: screenwidth / 6.5,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade400
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/Logos/suzuki.png",
                                    height: 25, width: 25,),
                                ),

                              ),
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text("Suzuki")
                              ],
                            )
                          ],
                        ),

                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 15.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        CategoryPage(car: ToyotaCategory,
                                            name: "Toyota")));
                              },
                              child: Container(
                                height: screenheight / 14,
                                width: screenwidth / 6.5,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade400
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/images/Logos/toyota.png",
                                    height: 25, width: 25,),
                                ),

                              ),
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Text("Toyota")
                              ],
                            )
                          ],
                        ),

                      )
                    ],
                  ),


                  SizedBox(height: screenheight / 70,),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text("New Arrivals", style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  SizedBox(height: screenheight / 70,),


                  SizedBox(
                    height: screenheight * 0.25,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          var indexCars=NewCars?[index];
                          return
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 5.0, right: 5.0),
                              child: GestureDetector(
                                onTap: ()
                                {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NewArrivals(car:NewCars)));
                                },
                                child: Container(
                                  height: screenheight * 0.210,
                                  width: screenwidth * 0.919,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey.shade400,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20)),
                                            child: Container(
                                              height: screenheight * 0.190,
                                              width: screenwidth * 0.919,
                                              child: Image.network(
                                                indexCars?['image'],
                                                fit: BoxFit.cover,),
                                            ),
                                          )

                                        ],
                                      ),
                                      SizedBox(height: screenheight / 70,),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(indexCars?['model'],
                                                  style: TextStyle(fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      overflow: TextOverflow
                                                          .ellipsis), maxLines: 1,),
                                              ),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: Text("₹${indexCars?['rent']}/day",
                                                    style: TextStyle(fontSize: 16,
                                                        fontWeight: FontWeight.w400,
                                                        color: Colors.green)),
                                            ),

                                          ],
                                        ),
                                      )


                                    ],
                                  ),

                                ),
                              ),
                            );
                        }),
                  ),

                  SizedBox(height: screenheight * 0.0143,),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text("Recommended for you", style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                      )
                    ],
                  ),

                  SizedBox(height: screenheight * 0.0143,),
                  GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cars?.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: screenheight * 0.001,
                          mainAxisSpacing: screenheight * 0.014,
                          mainAxisExtent: screenheight * 0.30,
                          childAspectRatio: 0.75),
                      itemBuilder: (context, index) {
                        var car = cars?[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(22),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        CarDetailsPage(car: car!,)));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white60,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(22),
                                              topRight: Radius.circular(22)),
                                          child: Stack(
                                              children: [
                                                 Container(
                                                    height: screenheight * 0.19,
                                                    width: screenwidth * 0.447,
                                                    color: Colors.grey,
                                                    child: Image.network(
                                                      car?['image'],
                                                      fit: BoxFit.cover,),
                                                  ),

                                                Positioned(
                                                  left: screenwidth * 0.34,
                                                  bottom: screenheight * 0.142,

                                                  child: Container(
                                                      height: screenheight *
                                                          0.035,
                                                      width: screenwidth *
                                                          0.098,
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey
                                                              .shade300,
                                                          shape: BoxShape.circle
                                                      ),
                                                      child:Icon(CupertinoIcons.suit_heart, color: Colors.black, size: 18,)
                                                  ),
                                                )
                                              ]
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: screenheight * 0.011,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        children: [
                                          Text(car?['model'], style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black),),

                                        ],
                                      ),
                                    ),
                                    SizedBox(height: screenheight * 0.002,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        children: [
                                          Text(car?['rating'], style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey),),
                                          SizedBox(width: screenwidth * 0.012,),
                                          Icon(CupertinoIcons.star_fill,
                                            color: Colors.yellow, size: 17,)
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: screenheight * 0.002,),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.event_seat_outlined,
                                            color: Colors.grey, size: 17,),
                                          SizedBox(width: screenwidth * 0.012,),
                                          Text(car?['seats'], style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey)),
                                          Spacer(),
                                          Icon(Icons.currency_rupee,
                                            color: Colors.grey, size: 17,),
                                          Text("${car?['rent']}/day",
                                              style: TextStyle(fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),


                          ),
                        );
                      })
                ],
              ),
            ),
          )),
    );
  }

  String Time() {
    int currentHour = DateTime
        .now()
        .hour;

    // Determine the greeting based on the hour of the day
    if (currentHour >= 5 && currentHour < 12) {
      return "Good Morning!👋";
    } else if (currentHour >= 12 && currentHour < 18) {
      return "Good Afternoon!👋";
    } else if (currentHour >= 18 && currentHour < 22) {
      return "Good Evening!👋";
    } else {
      return "Good Night!👋";
    }
  }

  carouselSlider(String url_images, String deal, String perc) {
    var screenheight = MediaQuery
        .of(context)
        .size
        .height;
    var screenwidth = MediaQuery
        .of(context)
        .size
        .width;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: screenheight / 5,
            width: screenwidth / 2.25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenheight / 70,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: screenwidth / 8,),
                    Text(perc, style: TextStyle(color: Colors.black,
                        fontSize: 27,
                        fontWeight: FontWeight.w500),),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: screenwidth / 25,),
                    Text(deal, style: TextStyle(color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500))
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: screenwidth / 25,),
                    Expanded(child: Text("Get a new car discount,",
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                      maxLines: 2,))
                  ],
                ),

                Row(
                  children: [
                    SizedBox(width: screenwidth / 25,),
                    Expanded(child: Text("only valid for this week",
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                      maxLines: 2,))
                  ],
                )
              ],
            ),
          ),
        ),

        Container(
          height: screenheight / 5,
          width: screenwidth / 2.40,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 20.0),
            child: Image.asset(url_images, fit: BoxFit.cover,),
          ),
        )


      ],

    );
  }
}




