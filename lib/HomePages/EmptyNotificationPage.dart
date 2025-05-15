import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class EmptyNotificationPage extends StatefulWidget {
  const EmptyNotificationPage({super.key});

  @override
  State<EmptyNotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<EmptyNotificationPage> {
  @override
  Widget build(BuildContext context) {

    var mediaQueryData = MediaQuery.of(context);
    var screenHeight = mediaQueryData.size.height;
    var screenWidth = mediaQueryData.size.width;

    return Scaffold(
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
                  Text("Notifications",style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),)
                ],
              )
              ),
              SizedBox(height: screenHeight*0.15,),
              Center(
                child: SvgPicture.asset("assets/images/ForgotPassword/empty notification.svg",height: screenHeight*0.30,fit: BoxFit.cover,),
              ),
              SizedBox(height: screenHeight*0.033,),
              Text("No Notifications",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.black),),
              SizedBox(height: screenHeight*0.0083,),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0,right: 12.0),
                    child: Text("You're all caught up! 📬 No notifications right now, but we'll keep you posted when something new pops up.",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14.5,color: Colors.grey,overflow: TextOverflow.ellipsis),maxLines: 3,),
                  )),
              Spacer()
              
          ]),
      ));
  }
}
