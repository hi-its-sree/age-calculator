import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {

    var mediaquerydata=MediaQuery.of(context);
    var screenHeight=mediaquerydata.size.height;
    var screenWidth=mediaquerydata.size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 17.0),
                child: Container(
                  height:screenHeight*0.075,
                  width: screenWidth*0.90,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                      border:Border.all(color: Colors.black,width: 1.0)
                  ),
                  child:Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 10.0),
                    child: Row(
                      children: [
                        Icon(Icons.headset_mic_outlined,color: Colors.black,),
                        SizedBox(width: screenWidth*0.0200,),
                        Text("Customer Service",style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),),
                        Spacer(),
                        Icon(Icons.chevron_right,size:30,)
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 17.0),
                child: Container(
                  height:screenHeight*0.075,
                  width: screenWidth*0.90,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                      border:Border.all(color: Colors.black,width: 1.0)
                  ),
                  child:Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 10.0),
                    child: Row(
                      children: [
                        Icon(Icons.public,color: Colors.black,),
                        SizedBox(width: screenWidth*0.0200,),
                        Text("Website",style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),),
                        Spacer(),
                        Icon(Icons.chevron_right,size:30,)
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 17.0),
                child: Container(
                  height:screenHeight*0.075,
                  width: screenWidth*0.90,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                      border:Border.all(color: Colors.black,width: 1.0)
                  ),
                  child:Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 10.0),
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.whatsapp,color: Colors.black,),
                        SizedBox(width: screenWidth*0.0200,),
                        Text("Whatsapp",style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),),
                        Spacer(),
                        Icon(Icons.chevron_right,size:30,)
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 17.0),
                child: Container(
                  height:screenHeight*0.075,
                  width: screenWidth*0.90,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                      border:Border.all(color: Colors.black,width: 1.0)
                  ),
                  child:Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 10.0),
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.facebook,color: Colors.black,),
                        SizedBox(width: screenWidth*0.0200,),
                        Text("Facebook",style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),),
                        Spacer(),
                        Icon(Icons.chevron_right,size:30,)
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 17.0),
                child: Container(
                  height:screenHeight*0.075,
                  width: screenWidth*0.90,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                      border:Border.all(color: Colors.black,width: 1.0)
                  ),
                  child:Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 10.0),
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.xTwitter,color: Colors.black,),
                        SizedBox(width: screenWidth*0.0200,),
                        Text("X (formerly Twitter)",style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),),
                        Spacer(),
                        Icon(Icons.chevron_right,size:30,)
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 17.0),
                child: Container(
                  height:screenHeight*0.075,
                  width: screenWidth*0.90,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                      border:Border.all(color: Colors.black,width: 1.0)
                  ),
                  child:Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 10.0),
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.instagram,color: Colors.black,),
                        SizedBox(width: screenWidth*0.0200,),
                        Text("Instagram",style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),),
                        Spacer(),
                        Icon(Icons.chevron_right,size:30,)
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 17.0),
                child: Container(
                  height:screenHeight*0.075,
                  width: screenWidth*0.90,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                      border:Border.all(color: Colors.black,width: 1.0)
                  ),
                  child:Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 10.0),
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.snapchat,color: Colors.black,),
                        SizedBox(width: screenWidth*0.0200,),
                        Text("Snapchat",style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),),
                        Spacer(),
                        Icon(Icons.chevron_right,size:30,)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),)
    );
  }
}
