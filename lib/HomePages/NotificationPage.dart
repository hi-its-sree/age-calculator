import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Notificationpage extends StatefulWidget {
  const Notificationpage({super.key});

  @override
  State<Notificationpage> createState() => _NotificationpageState();
}

class _NotificationpageState extends State<Notificationpage> {

  List<IconData>icons_set1=[Icons.credit_card, Icons.discount_outlined];
  List<String>title_set=["New Card Found","Exciting Discounts"];
  List<String>subtitle_set=["Hey!!Your new card  has been added","Hey there is exciting discount for new Arrivals"];

  List<IconData>icons_set2=[Icons.local_offer_outlined, Icons.cake,Icons.system_update,];
  List<String>title_set2=["Weekly Offers","HBD🎂✨","New Updates"];
  List<String>subtitle_set2=["Hey!!Offers for weekly deals","A year older, a year bolder! 🎂 Making memories, one candle at a time! 🎁 ","New updates, new possibilities! 🔄 Upgrade for a smoother experience!"];

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
        
          Padding(
            padding: const EdgeInsets.only(left: 15.0,top: 15.0),
            child: Row(
              children: [
                Text("Today",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),)
              ],
            ),
          ),

          ListView.builder(
            itemCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index)
          {
            return   Padding(
              padding: const EdgeInsets.only(top: 12.0,left: 12.0,right: 12.0),
              child: Container(
                height: screenHeight*0.113,
                width: screenWidth*0.80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white30,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0,left: 5.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.black,
                      child: Center(child:Icon(icons_set1[index],color: Colors.white,),),),
                    title: Text(title_set[index],style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),),
                    subtitle: Text(subtitle_set[index],style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w400,overflow: TextOverflow.ellipsis),maxLines: 3,),
                  ),
                ),
              ),
            );
          }),



          Padding(
            padding: const EdgeInsets.only(left: 15.0,top: 15.0),
            child: Row(
              children: [
                Text("Previous",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),)
              ],
            ),
          ),

          ListView.builder(
              itemCount: icons_set2.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index)
          {
            return  Padding(
              padding: const EdgeInsets.only(top: 12.0,left: 12.0,right: 12.0),
              child: Container(
                height: screenHeight*0.113,
                width: screenWidth*0.80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white30,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0,left: 5.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.black,
                      child: Center(child:Icon(icons_set2[index],color: Colors.white,),),),
                    title: Text(title_set2[index],style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),),
                    subtitle: Text(subtitle_set2[index],style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w400,overflow: TextOverflow.ellipsis),maxLines: 3,),
                  ),
                ),
              ),
            );
          })




        ],
      )),
    );
  }
}

