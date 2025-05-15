import 'package:flutter/material.dart';
import 'package:rentzy/HomePages/MainHome.dart';
class ReviewConfirmationPage extends StatefulWidget {
  const ReviewConfirmationPage({super.key});

  @override
  State<ReviewConfirmationPage> createState() => _ReviewConfirmationPageState();
}

class _ReviewConfirmationPageState extends State<ReviewConfirmationPage> {
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
              Spacer(),
              Center(
                child:Container(
                  height: screenHeight*0.190,
                  width: screenWidth*0.190,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black

                  ),
                  child: Center(
                    child: Icon(Icons.done_sharp,color: Colors.white,size: 40,),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Thanks for your feedback!!!",style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 19,
                    color: Colors.black
                  ),)
                ],
              ),
              SizedBox(
                height: screenHeight*0.0123,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Your review has been successfully submitted!!!",style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Colors.grey
                  ),)
                ],
              ),
              Spacer(),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: GestureDetector(
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MainHome()));
                  },
                  child: Container(
                    height: screenHeight*0.0600,
                    width: screenWidth*0.890,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.black
                    ),
                    child: Center(
                      child:Text("Back to Home",style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                      ),),
                    ),
                  ),
                ),
              ),





            ],
          )),
    );
  }
}
