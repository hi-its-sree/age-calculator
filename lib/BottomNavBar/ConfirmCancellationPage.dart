import 'package:flutter/material.dart';
import 'package:rentzy/BottomNavBar/BottomNavigationBar.dart';

import '../HomePages/MainHome.dart';
class ConfirmCancellationPage extends StatefulWidget {
   ConfirmCancellationPage({super.key, this.details, required String status});
  final Map<String,dynamic>?details;
  var status;

  @override
  State<ConfirmCancellationPage> createState() => _ConfirmCancellationPageState();
}

class _ConfirmCancellationPageState extends State<ConfirmCancellationPage> {
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
                  Text("Cancellation Successful!!",style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 19,
                      color: Colors.black
                  ),)
                ],
              ),
              SizedBox(
                height: screenHeight*0.0123,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text("Your refund has been processed.It may take 3-5 business days for the funds to appear in your bank account",style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Colors.grey,
                          overflow:TextOverflow.ellipsis,
                      ),maxLines: 4,textAlign: TextAlign.justify,),
                    )
                  ],
                ),
              ),
              Spacer(),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: GestureDetector(
                  onTap: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNav()));
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
