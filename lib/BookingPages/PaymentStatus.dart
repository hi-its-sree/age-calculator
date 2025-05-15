import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rentzy/BottomNavBar/BottomNavigationBar.dart';
import 'package:rentzy/HomePages/MainHome.dart';

import 'PaymentMethodPages.dart';
class PaymentStatus extends StatefulWidget {
  const PaymentStatus({super.key, required this.car, required this.name, required this.pickupdate, required this.location, required this.days, required this.status});

  final Map<String,dynamic> car;
  final String name;
  final String pickupdate;
  final String location;
  final int days;
  final String status;
  @override
  State<PaymentStatus> createState() => _PaymentStatesState();
}

class _PaymentStatesState extends State<PaymentStatus> {
  @override
  Widget build(BuildContext context) {

    var mediaQueryData = MediaQuery.of(context);
    var screenHeight = mediaQueryData.size.height;
    var screenWidth = mediaQueryData.size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body:SafeArea(
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
                      onTap: ()
                      {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 23,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.053),
                  Text("Payment Status",style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),)
                ],
              )
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight*0.20,
                        width: screenWidth*0.60,
                        child: Image.asset("assets/images/Logos/PaymentSuccess.png",fit: BoxFit.cover,),),
                      Text("Payment Successful",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black),),
                      SizedBox(height: 10,),
                      Text("Your car rent Booking is Successful",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey.shade500)),
                  
                      SizedBox(height: screenHeight*0.015,),
                      Container(
                        height: screenHeight*0.20,
                        width: screenWidth*0.88,
                        decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey,width: 1.0,style: BorderStyle.solid)
                        ),
                        child:Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Booking Information",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 16),),
                            ),
                            Divider(
                              color: Colors.grey,
                              thickness: 0.75,
                              indent: 10.0,
                              endIndent: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                                    child: Row(
                                      children: [
                                        Text("\u25CF",),
                                        SizedBox(width: screenWidth*0.0123,),
                                        Text("Name",style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 15),),
                                        Spacer(),
                                        Text(widget.name,style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 14))
                                      ],
                                    ),
                                  ),
                  
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                                    child: Row(
                                      children: [
                                        Text("\u25CF",),
                                        SizedBox(width: screenWidth*0.0123,),
                                        Text("Model name",style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 15),),
                                        Spacer(),
                                        Text(widget.car['model'],style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 14))
                                      ],
                                    ),
                                  ),
                  
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                                    child: Row(
                                      children: [
                                        Text("\u25CF",),
                                        SizedBox(width: screenWidth*0.0123,),
                                        Text("Rental date",style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 15),),
                                        Spacer(),
                                        Text(widget.pickupdate,style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 14))
                                      ],
                                    ),
                                  ),
                  
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                                    child: Row(
                                      children: [
                                        Text("\u25CF",),
                                        SizedBox(width: screenWidth*0.0123,),
                                        Text("Location",style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 15),),
                                        Spacer(),
                                        Text(widget.location,style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 14))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                  
                          ],
                        ),
                      ),
                      SizedBox(height:screenHeight*0.0150),
                      Divider(
                        color: Colors.grey,
                        thickness: 0.75,
                        indent: 22.0,
                        endIndent: 22.0,
                      ),
                  
                      Text("Transaction Details",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 16),),
                      SizedBox(height: screenHeight*0.0150),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: Row(
                                children: [
                                  Text("Transaction ID",style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 15),),
                                  Spacer(),
                                  Text("#TR000${generateBookingID()}",style:TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 14))
                                ],
                              ),
                            ),
                  
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: Row(
                                children: [
                                  Text("Transaction Date",style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 15),),
                                  Spacer(),
                                  Text(
                                    DateFormat('yyyy-MM-dd').format(DateTime.now()), // Outputs only the date
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                            ),
                  
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: Row(
                                children: [
                                  Text("Payment method",style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 15),),
                                  Spacer(),
                                  Text("Razorpay",style:TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 14))
                                ],
                              ),
                            ),
                  
                          ],),),
                  
                      SizedBox(height:screenHeight*0.0150),
                      Divider(
                        color: Colors.grey,
                        thickness: 0.75,
                        indent: 22.0,
                        endIndent: 22.0,
                      ),
                  
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: Row(
                                children: [
                                  Text("Amount (x${widget.days} days)",style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 15),),
                                  Spacer(),
                                  Text("₹${(double.parse(widget.car['rent'])*widget.days)}",style:TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 14))
                                ],
                              ),
                            ),
                  
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: Row(
                                children: [
                                  Text("Insurance",style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 15),),
                                  Spacer(),
                                  Text(
                                    "₹950.00", // Outputs only the date
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                            ),
                  
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: Row(
                                children: [
                                  Text("Tax(5%)",style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 15),),
                                  Spacer(),
                                  Text("₹20.00",style:TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 14))
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(vertical:3.0),
                              child: Row(
                                children: [
                                  Text("Service fee",style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 15),),
                                  Spacer(),
                                  Text("₹75.00",style:TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 14))
                                ],),),
                  
                          ],),
                      ),

                      SizedBox(height:screenHeight*0.0150),
                      Divider(
                        color: Colors.grey,
                        thickness: 0.75,
                        indent: 22.0,
                        endIndent: 22.0,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 4.0),
                        child: Row(
                          children: [
                            Text("Total Amount",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black)),
                            Spacer(),
                            Text("₹${TotalAmount((double.parse(widget.car['rent'].toString()) * widget.days))}")
                          ],
                        ),
                      ),
                      
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Payment Status : ",style:TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black
                            )),
                            Text("Success",style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.green
                            ),)

                          ],
                        ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: GestureDetector(
                          onTap: ()
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNav()));
                          },
                          child: Container(
                            height: screenHeight*0.055,
                            width: screenWidth*0.88,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.black
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Back to home",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16),),

                              ],
                            ),
                          ),
                        ),
                      )


                    ],
                  ),
                ),
              )



            ],
          )
      ),
    );
  }


  String generateBookingID() {
    Random random = Random();
    int randomNumber = random.nextInt(90000) + 10000; // Ensures a 5-digit number
    return randomNumber.toString();
  }

  double TotalAmount(double rent)
  {
    double total=rent+950.00+20.00+75.00;
    return total;
  }
}
