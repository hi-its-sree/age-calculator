import 'package:flutter/material.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                      Text("Settings",style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500,),)
                    ],
                  )
              ),

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
                    child: Row(
                      children: [
                        Text("App Settings",style: TextStyle(fontSize: 15,fontWeight:FontWeight.w500,color: Colors.grey.shade700),)
                      ],
                    ),
                  ),

                  ListTile(
                    leading:Icon(Icons.person_outline,color: Colors.grey.shade700,),
                    title:Text("Personal Information",style: TextStyle(fontSize: 16.5,fontWeight:FontWeight.w500,color: Colors.black),),
                    subtitle: Text("Your Account Information",style: TextStyle(fontSize: 14,fontWeight:FontWeight.w300,color: Colors.grey.shade600),),
                    trailing:Icon(Icons.chevron_right,color: Colors.grey.shade700,),
                  ),

                  ListTile(
                    leading:Icon(Icons.notification_add_outlined,color: Colors.grey.shade700,),
                    title:Text("Notification Settings",style: TextStyle(fontSize: 16.5,fontWeight:FontWeight.w500,color: Colors.black),),
                    subtitle: Text("Chat and notification Settings",style: TextStyle(fontSize: 14,fontWeight:FontWeight.w300,color: Colors.grey.shade600),),
                    trailing:Icon(Icons.chevron_right,color: Colors.grey.shade700,),
                  ),

                  ListTile(
                    leading:Icon(Icons.privacy_tip_outlined,color: Colors.grey.shade700,),
                    title:Text("Privacy and Permissions",style: TextStyle(fontSize: 16.5,fontWeight:FontWeight.w500,color: Colors.black),),
                    subtitle: Text("Contact,My album and Blocked contact",style: TextStyle(fontSize: 14,fontWeight:FontWeight.w300,color: Colors.grey.shade600),),
                    trailing:Icon(Icons.chevron_right,color: Colors.grey.shade700,),
                  ),

                  ListTile(
                    leading:Icon(Icons.storage_outlined,color: Colors.grey.shade700,),
                    title:Text("Data and storage",style: TextStyle(fontSize: 16.5,fontWeight:FontWeight.w500,color: Colors.black),),
                    subtitle: Text("Data preferences and storage settings",style: TextStyle(fontSize: 14,fontWeight:FontWeight.w300,color: Colors.grey.shade600),),
                    trailing:Icon(Icons.chevron_right,color: Colors.grey.shade700,),
                  ),

                  ListTile(
                    leading:Icon(Icons.lock_outline,color: Colors.grey.shade700,),
                    title:Text("Password and Account",style: TextStyle(fontSize: 16.5,fontWeight:FontWeight.w500,color: Colors.black),),
                    subtitle: Text("Manage your account settings",style: TextStyle(fontSize: 14,fontWeight:FontWeight.w300,color: Colors.grey.shade600),),
                    trailing:Icon(Icons.chevron_right,color: Colors.grey.shade700,),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 15.0),
                    child: Row(
                      children: [
                        Text("Other settings",style: TextStyle(fontSize: 15,fontWeight:FontWeight.w500,color: Colors.grey.shade700),)
                      ],
                    ),
                  ),

                  ListTile(
                    leading:Icon(Icons.help,color: Colors.grey.shade700,),
                    title:Text("Help",style: TextStyle(fontSize: 16.5,fontWeight:FontWeight.w500,color: Colors.black),),
                    subtitle: Text("Get assistance and troubleshooting tips",style: TextStyle(fontSize: 14,fontWeight:FontWeight.w300,color: Colors.grey.shade600),),
                    trailing:Icon(Icons.chevron_right,color: Colors.grey.shade700,),
                  ),

                  ListTile(
                    leading:Icon(Icons.feedback_outlined,color: Colors.grey.shade700,),
                    title:Text("Feedback",style: TextStyle(fontSize: 16.5,fontWeight:FontWeight.w500,color: Colors.black),),
                    subtitle: Text("Find answers and answers to common questions.",style: TextStyle(fontSize: 14,fontWeight:FontWeight.w300,color: Colors.grey.shade600),),
                    trailing:Icon(Icons.chevron_right,color: Colors.grey.shade700,),
                  ),

                  ListTile(
                    leading:Icon(Icons.description_outlined,color: Colors.grey.shade700,),
                    title:Text("About",style: TextStyle(fontSize: 16.5,fontWeight:FontWeight.w500,color: Colors.black),),
                    subtitle: Text("Version 1.0",style: TextStyle(fontSize: 14,fontWeight:FontWeight.w300,color: Colors.grey.shade600),),
                    trailing:Icon(Icons.chevron_right,color: Colors.grey.shade700,),
                  ),

                  ListTile(
                    leading:Icon(Icons.delete,color: Colors.grey.shade700,),
                    title:Text("Delete Account",style: TextStyle(fontSize: 16.5,fontWeight:FontWeight.w500,color: Colors.red),),
                    subtitle: Text("Erase account & personal info",style: TextStyle(fontSize: 14,fontWeight:FontWeight.w300,color: Colors.grey.shade600),),
                    trailing:Icon(Icons.chevron_right,color: Colors.grey.shade700,),
                  ),

                  ],
              )
            ],
          )),
    );
  }
}
