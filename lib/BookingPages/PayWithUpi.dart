import 'package:flutter/material.dart';
class Paywithupi extends StatefulWidget {
  const Paywithupi({super.key});

  @override
  State<Paywithupi> createState() => _PaywithupiState();
}

class _PaywithupiState extends State<Paywithupi> {
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
                      Text("Pay With UPI",style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),)
                    ],
                  )),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
                    child: Text("Select a Payment Method ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),),
                  ),
                ],
              ),

              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    height: screenHeight*0.070,
                    width: screenWidth*0.890,
                    decoration: BoxDecoration(
                        color: Color(0xFFcdcdcd),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black38,
                          width: 1.0,
                          style: BorderStyle.solid
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Image.asset("assets/images/Logos/gpay.png",height: 35,width: 30,fit: BoxFit.fitWidth,),
                          ),
                          Text("Pay with Gpay")
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                height: screenHeight*0.070,
                width: screenWidth*0.890,
                decoration: BoxDecoration(
                    color: Color(0xFFcdcdcd),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.black38,
                        width: 1.0,
                        style: BorderStyle.solid
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Image.asset("assets/images/Logos/phonepe.png",height: 30,width: 25,fit: BoxFit.cover),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text("Pay with Phone Pe"),
                      )
                    ],
                  ),
                ),
              ),

              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    height: screenHeight*0.070,
                    width: screenWidth*0.890,
                    decoration: BoxDecoration(
                        color: Color(0xFFcdcdcd),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Colors.black38,
                            width: 1.0,
                            style: BorderStyle.solid
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Image.asset("assets/images/Logos/paytm.png",height: 35,width: 30,fit: BoxFit.fitWidth,),
                          ),
                          Text("Pay with Paytm")
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                height: screenHeight*0.070,
                width: screenWidth*0.890,
                decoration: BoxDecoration(
                    color: Color(0xFFcdcdcd),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.black38,
                        width: 1.0,
                        style: BorderStyle.solid
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                            child: Image.asset("assets/images/Logos/amazonpay.jpg",height: 28,width: 28,fit: BoxFit.cover)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text("Pay with Amazon Pay"),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight*0.440,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                      Text("Continue",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16),),
                      SizedBox(width: screenWidth*0.009,),
                      Icon(Icons.arrow_forward_outlined,color: Colors.white,size: 20,)
                    ],
                  ),
                ),
              )





            ],
          )),
    );
  }
}
