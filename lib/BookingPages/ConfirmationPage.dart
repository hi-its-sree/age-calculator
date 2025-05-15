import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rentzy/BookingPages/PaymentMethodPages.dart';
class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({super.key,required this.days, required this.car, required this.name, required this.pickupdate, required this.returndate, required this.location});
  final int days;
  final Map<String,dynamic> car;
  final String name;
  final String pickupdate;
  final String returndate;
  final String location;





  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  Widget build(BuildContext context) {

    var mediaQueryData = MediaQuery.of(context);
    var screenHeight = mediaQueryData.size.height;
    var screenWidth = mediaQueryData.size.width;
    print(widget.days);

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
                      Text("Time for Confirmation",style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),)
                    ],
                  )),
              
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.network(widget.car['image'],),

                      SizedBox(height: screenHeight*0.012),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(widget.car['model'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight*0.012,),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                widget.car['description'],
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ),
                            ),
                          ),
                  
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.star,color: Colors.yellow[900],),
                                    Text("5.0",style:TextStyle(
                                        fontSize: 12,
                                        fontWeight:FontWeight.w400,
                                        color: Colors.grey
                                    ),)
                                  ],
                                ),
                  
                                Row(
                                  children: [
                                    Text("(100+ reviews)",style:TextStyle(
                                        fontSize: 10,
                                        fontWeight:FontWeight.w400,
                                        color: Colors.grey
                                    ),)
                                  ],)
                              ],),
                          )
                        ],),
                  
                  
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Divider(
                          thickness: 1.0,
                          indent: 14.0,
                          endIndent: 14.0,
                        ),
                      ),
                  
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 2.0),
                            child: Text("Booking Informations",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black)),
                          ),
                        ],
                      ),
                  
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          children: [
                  
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: Row(
                                children: [
                                  Text("\u25CF",),
                                  SizedBox(width: screenWidth*0.0123,),
                                  Text("Booking ID",style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 15),),
                                  Spacer(),
                                  Text(generateBookingID(),style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 14))
                                ],
                              ),
                            ),
                  
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
                              padding: const EdgeInsets.symmetric(vertical:3.0),
                              child: Row(
                                children: [
                                  Text("\u25CF",),
                                  SizedBox(width: screenWidth*0.0123,),
                                  Text("Pick up Date",style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 15),),
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
                                  Text("Return Date",style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 15),),
                                  Spacer(),
                                  Text(widget.returndate,style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 14))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical:3.0),
                              child: Row(
                                children: [
                                  Text("\u25CF",),
                                  SizedBox(width: screenWidth*0.0123,),
                                  Text("Location",style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 15),),
                                  Spacer(),
                                  Text(widget.location,style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 14))
                                ],),),
                          ],),),
                  
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Divider(
                          thickness: 1.0,
                          indent: 14.0,
                          endIndent: 14.0,
                        ),),
                  
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            Text("Payment",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black)),
                          ],),),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical:3.0),
                              child: Row(
                                children: [
                                  Text("\u25CF",),
                                  SizedBox(width: screenWidth*0.0123,),
                                  Text("Amount (x${widget.days} days)",style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 15),),
                                  Spacer(),
                                  Text("₹${(double.parse(widget.car['rent'])*widget.days)}",style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 14))
                                ],),),

                            Padding(
                              padding: const EdgeInsets.symmetric(vertical:3.0),
                              child: Row(
                                children: [
                                  Text("\u25CF",),
                                  SizedBox(width: screenWidth*0.0123,),
                                  Text("Insurance",style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 15),),
                                  Spacer(),
                                  Text("₹950.00",style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 14))
                                ],),),

                            Padding(
                              padding: const EdgeInsets.symmetric(vertical:3.0),
                              child: Row(
                                children: [
                                  Text("\u25CF",),
                                  SizedBox(width: screenWidth*0.0123,),
                                  Text("Tax(5%)",style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 15),),
                                  Spacer(),
                                  Text("₹20.00",style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 14))
                                ],),),

                            Padding(
                              padding: const EdgeInsets.symmetric(vertical:3.0),
                              child: Row(
                                children: [
                                  Text("\u25CF",),
                                  SizedBox(width: screenWidth*0.0123,),
                                  Text("Service fee",style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 15),),
                                  Spacer(),
                                  Text("₹75.00",style:TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 14))
                                ],),),

                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Divider(
                          thickness: 1.0,
                          indent: 14.0,
                          endIndent: 14.0,
                        ),),
                      
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 4.0),
                        child: Row(
                          children: [
                            Text("Total Amount",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black)),
                            Spacer(),
                        Text("₹${TotalAmount((double.parse(widget.car['rent'].toString()) * widget.days))}")
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: GestureDetector(
                          onTap: ()
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Paymentmethodpages(
                                  days: widget.days,
                                  car: widget.car,
                                  name: widget.name,
                                  pickupdate: widget.pickupdate,
                                  returndate: widget.returndate,
                                  location: widget.location,
                                ),
                              ),
                            );
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
                                Text("Pay Now",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16),),
                                SizedBox(width: screenWidth*0.009,),
                                Icon(Icons.arrow_forward_outlined,color: Colors.white,size: 20,)
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
          )),

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
