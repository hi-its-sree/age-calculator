import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rentzy/Notifications/local_notificatons.dart';

import '../Database/RoadAssistance.dart';
import '../Notifications/PushNotifications.dart';
class RoadAssistancePage extends StatefulWidget {
  const RoadAssistancePage({super.key});

  @override
  State<RoadAssistancePage> createState() => _RoadAssistencePageState();
}

class _RoadAssistencePageState extends State<RoadAssistancePage> {

  List<Image> logos=[
    Image.asset("assets/images/Logos/Flat Tire.png",height: 85,),
    Image.asset("assets/images/Logos/BatteryDead1.png",height: 85,),
    Image.asset("assets/images/Logos/Carwontstart.png",height: 85),
    Image.asset("assets/images/Logos/fuel.png",height: 85),
    Image.asset("assets/images/Logos/accident.png",height: 85),
    Image.asset("assets/images/Logos/otherissue.png",height: 85)

  ];

  List<String>title=[
    "Flat Tire",
    "Battery Dead",
    "Car Breakdown",
    "Ran Out of fuel",
    "Accident/Crash",
    "Other Issue"
  ];

  final formKey = GlobalKey<FormState>();

  final TextEditingController locationController = TextEditingController();
  final TextEditingController issueController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();


  Future<void>DetailsToFirestore() async
  {
    try
        {
          await RoadAssistance().RoadsideAssistance(
              Fullname: nameController.text,
              mobile: phoneController.text,
              location:locationController.text,
              issue: issueController.text,
          );
        }
        catch(e)
    {
      print(e);
    }
  }

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
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Icon(
                          Icons.arrow_back,
                          size: 23,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.053),
                    const Text(
                      "Road Assistance",
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("🚗 Stranded? We've Got You Covered! 🔧",style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 19
                              ),)
                            ],
                          ),
                        ),
                    
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text("Quick, reliable roadside assistance—just tell us what’s wrong, and we’ll take care of it!",style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color:Colors.grey,
                                    overflow: TextOverflow.ellipsis
                                ),maxLines: 2,textAlign: TextAlign.center,),
                              )
                            ],
                          ),
                        ),
                    
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: SizedBox(
                            height: 310,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0,right: 13.0),
                              child: GridView.builder
                                (gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: screenHeight * 0.0070,
                                  mainAxisSpacing: screenHeight * 0.018,
                                  mainAxisExtent: screenHeight * 0.17,
                                  childAspectRatio: 1.0),
                                  shrinkWrap: true,
                                  itemCount: 6,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context,index)
                                  {
                                    return ClipRRect(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            border: Border.all(width: 0.75,color: Colors.grey),
                                            borderRadius: BorderRadius.circular(20.0),
                    
                    
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: logos[index],
                                            ),
                    
                                            Center(
                                                child:
                                                Text(title[index],style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey),)
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ),
                    
                        Container(
                          height: screenHeight*0.125,
                          width: screenWidth*0.90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.shade200,
                              border: Border.all(width: 0.75,color: Colors.grey),
                              boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 5,
                                blurRadius: 6,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height:screenHeight*0.190,
                                  width: screenWidth*0.200,
                                  child: Image.asset("assets/images/Logos/location.png"),
                                ),
                              ),
                    
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.5,horizontal: 10.0),
                                          child: Text("Your current Location",style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16
                                          ),),
                                        )
                                      ],
                                    ),
                    
                                     Padding(
                                      padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                      child: TextFormField(
                                        validator: (value)
                                        {
                                          if(value!.isEmpty)
                                          {
                                            return 'required';
                                          }
                                          else
                                          {
                                            return null;
                                          }
                                        },
                                        controller:locationController ,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                          isDense: true,
                                            isCollapsed: false,
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(13),
                                                borderSide: BorderSide(
                                                    style: BorderStyle.solid,
                                                    width: 0.5
                                                )
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(13),
                                                borderSide: BorderSide(
                                                    style: BorderStyle.solid,
                                                    width: 1.5
                                                )
                                            ),
                                            focusedErrorBorder:OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(13),
                                                borderSide: BorderSide(
                                                    style: BorderStyle.solid,
                                                    width: 1.5,
                                                    color: Colors.black
                                                )),
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(style: BorderStyle.solid,color: Colors.red.shade900),
                                                borderRadius: BorderRadius.circular(13)

                                            ),
                                            hintText: 'Nagercoil',
                                            labelText:'Location',
                                            labelStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.black45),
                                            hintStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.grey.shade400),
                                            suffixIcon: Icon(Icons.location_on_outlined,color: Colors.grey.shade400,)
                                        ),

                                      ),
                                    ),

                                  ],
                                ),
                              )
                    
                            ],
                          ),
                        ),
                    
                         Padding(
                           padding: const EdgeInsets.all(20.0),
                           child: TextFormField(
                              validator: (value)
                              {
                                if(value!.isEmpty)
                                {
                                  return 'required';
                                }
                                else if(value.length<5)
                                {
                                  return 'Please describe the issue';
                                }
                              },
                              controller:issueController ,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                             maxLines: 4,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 0.5
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: BorderSide(
                                          style: BorderStyle.solid,
                                          width: 1.5
                                      )
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(style: BorderStyle.solid,color: Colors.red.shade900),
                                      borderRadius: BorderRadius.circular(13)
                    
                                  ),

                                focusedErrorBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide(
                                        style: BorderStyle.solid,
                                        width: 1.5,
                                        color: Colors.black
                                    )),
                    
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  hintText: 'Enter the issue here',
                                  hintStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.grey.shade400),
                    
                              ),
                    
                            ),
                         ),
                    
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                          child: TextFormField(
                            validator: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'required';
                              }
                              else
                              {
                                return null;
                              }
                            },
                            controller:nameController ,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                labelText: 'Full name',
                                labelStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.black45),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide(
                                        style: BorderStyle.solid,
                                        width: 0.5,
                                        color: Colors.black
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide(
                                        style: BorderStyle.solid,
                                        width: 1.5
                                    )),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(style: BorderStyle.solid,color: Colors.red.shade900),
                                    borderRadius: BorderRadius.circular(13)
                                ),
                                focusedErrorBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide(
                                        style: BorderStyle.solid,
                                        width: 1.5,
                                        color: Colors.black
                                    )),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                hintText: 'John doe',
                                hintStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.grey.shade400),
                                suffixIcon:Icon(Icons.person,color:Colors.grey.shade400,)
                            ),
                    
                    
                          ),
                        ),
                    
                        SizedBox(height: 15,),
                        Padding(
                          padding: const EdgeInsets.only(left:20.0,right: 20.0),
                          child: TextFormField(
                            validator: (value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'required';
                              }
                              else if(value.length<10)
                              {
                                return 'Enter the valid mobile number';
                              }
                              else if(value.length>12)
                               {
                                 return 'Enter the mobile number which is valid for india';
                               }
                            },
                            controller:phoneController ,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide(
                                        style: BorderStyle.solid,
                                        width: 0.5,
                                        color: Colors.black
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide(
                                        style: BorderStyle.solid,
                                        width: 1.5
                                    )
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(style: BorderStyle.solid,color: Colors.red.shade900),
                                    borderRadius: BorderRadius.circular(13)
                    
                                ),

                                focusedErrorBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide(
                                        style: BorderStyle.solid,
                                        width: 1.5,
                                        color: Colors.black
                                    )),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                hintText: '9025021303',
                                labelText:'Mobile',
                                labelStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.black45),
                                hintStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Colors.grey.shade400),
                                suffixIcon: Icon(Icons.phone_iphone,color: Colors.grey.shade400,)
                            ),
                    
                          ),
                        ),
                    
                        SizedBox(height: 15,),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: GestureDetector(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();

                                try {
                                  await DetailsToFirestore();

                                  Future.delayed(Duration(seconds: 1)).then((_) {
                                    LocalNotification().showNotification(
                                        title: "Stranded? Rentzy Has Your Back!",
                                        body: "Knock knock! Who’s there? Your car’s savior, Sree! 🏎️💨 Call 9025021303 & let’s get you back on the road!"
                                    );
                                  });

                                  Fluttertoast.showToast(
                                    msg: "🚗 Road Assistance Requested! Help is on the way. Stay safe! 📍",
                                    textColor: Colors.black,
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.SNACKBAR,
                                    backgroundColor: Colors.grey.shade100,
                                  );

                                  Future.delayed(const Duration(seconds: 2), () {
                                    if (mounted) {
                                      Navigator.pop(context);
                                    }
                                  });
                                } catch (e) {
                                  print("Error submitting request: $e");
                                  Fluttertoast.showToast(
                                    msg: "Failed to submit request. Please try again.",
                                    backgroundColor: Colors.red,
                                  );
                                }
                              }
                            },
                            child: Container(
                              height: screenHeight*0.065,
                              width: screenWidth*0.890,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(30)
                              ),
                              child: Center(
                                child:Text("Request for help",style: TextStyle(fontSize:17,fontWeight:FontWeight.w500,color:Colors.white),),
                              ),
                            ),
                          ),
                        )
                    
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
