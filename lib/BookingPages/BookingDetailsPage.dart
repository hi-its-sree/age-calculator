import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rentzy/BookingPages/ConfirmationPage.dart';
class Bookingdetailspage extends StatefulWidget {
  const Bookingdetailspage({super.key, required this.car, });

  final Map<String, dynamic> car;

  @override
  State<Bookingdetailspage> createState() => _BookingdetailspageState();
}

class _BookingdetailspageState extends State<Bookingdetailspage> {

  var namecontroller=TextEditingController();
  var emailcontroller=TextEditingController();
  var mobilecontroller=TextEditingController();
  var pickupdatecontroller=TextEditingController();
  var returndatecontroller=TextEditingController();
  var locationcontroller=TextEditingController();
  var selectedgender=0;
  var selectedtime=0;
  final formKey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    var mediaQueryData = MediaQuery.of(context);
    var screenHeight = mediaQueryData.size.height;
    var screenWidth = mediaQueryData.size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(child:
      Column(
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
                  Text("Booking Details",style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),)
                ],
              )
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SvgPicture.asset("assets/images/HomeCarousel/booking.svg",height: screenHeight*0.27,),
                  Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                  autocorrect: true,
                                  autofocus: true,
                                  controller: namecontroller,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    enabledBorder:OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: Colors.grey,width: 1.0,style: BorderStyle.solid)
                                    ),
                                    prefixIcon: Icon(Icons.perm_identity,color: Colors.black,),
                                    labelText: "Username",
                                    labelStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),
                                    hintText: "John doe",
                                    hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.grey),
                                    hintFadeDuration: Duration(seconds: 1),
                                    filled: true,
                                    fillColor: Colors.white54,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(color: Colors.black,width: 1.0,style: BorderStyle.solid)
                                    ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: Colors.red,width: 1.0,style: BorderStyle.solid)

                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: Colors.grey,width: 1.0,style: BorderStyle.solid)
                                    )
                                  ),
                                ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:  TextFormField(
                                  validator: (value)
                                  {
                                    final pattern= RegExp(r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}');
                                    if(value!.isEmpty)
                                    {
                                      return 'required';
                                    }
                                    else if(pattern.hasMatch(value))
                                    {
                                      return null;
                                    }
                                    else
                                    {
                                      return 'Enter a valid email';
                                    }
                                  },
                                  autocorrect: true,
                                  autofocus: true,
                                  controller: emailcontroller,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(color: Colors.grey,width: 1.0,style: BorderStyle.solid)
                                      ),
                                      prefixIcon: Icon(Icons.email_outlined,color: Colors.grey,),
                                      labelText: "Email",
                                      labelStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),
                                      hintText: "johndoe12@gmail.com",
                                      hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.grey),
                                      hintFadeDuration: Duration(seconds: 1),
                                      filled: true,
                                      fillColor: Colors.white54,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(color: Colors.black,width: 1.0,style: BorderStyle.solid)
                                      ),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(color: Colors.red,width: 1.0,style: BorderStyle.solid)

                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(color: Colors.grey,width: 1.0,style: BorderStyle.solid)
                                      )
                                  ),
                                )
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                  },
                                  autocorrect: true,
                                  autofocus: true,
                                  controller: mobilecontroller,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(color: Colors.grey,width: 1.0,style: BorderStyle.solid)
                                      ),
                                      prefixIcon: Icon(Icons.local_phone_outlined,color: Colors.grey,),
                                      labelText: "Mobile no.",
                                      labelStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),
                                      hintText: "9025021303",
                                      hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.grey),
                                      hintFadeDuration: Duration(seconds: 1),
                                      filled: true,
                                      fillColor: Colors.white54,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(color: Colors.black,width: 1.0,style: BorderStyle.solid)
                                      ),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(color: Colors.red,width: 1.0,style: BorderStyle.solid)

                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(color: Colors.grey,width: 1.0,style: BorderStyle.solid)
                                      )
                                  ),
                                ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                children: [
                                  Text("Gender",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 10.0,top: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap:()
                                    {
                                      setState(() {
                                        selectedgender=1;
                                      });
                                    },
                                    child: Container(
                                      height: screenHeight*0.036,
                                      width: screenWidth*0.23,
                                      decoration: BoxDecoration(
                                          color: selectedgender == 1 ?Colors.black :Colors.white54,
                                        borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(Icons.male,color: selectedgender==1?Colors.white:Colors.black,),
                                          Text("Male",style: TextStyle(color: selectedgender == 1 ? Colors.white : Colors.black))
                                        ],
                                      )
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: ()
                                    {
                                      setState(() {
                                        selectedgender=2;
                                      });
                                    },
                                    child: Container(
                                        height: screenHeight*0.036,
                                        width: screenWidth*0.23,
                                        decoration: BoxDecoration(
                                            color: selectedgender == 2 ? Colors.black:Colors.white54,
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(Icons.female,color: selectedgender==2?Colors.white:Colors.black,),
                                            Text("Female",style: TextStyle(color: selectedgender == 2 ? Colors.white : Colors.black))
                                          ],
                                        )
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: ()
                                    {
                                      setState(() {
                                        selectedgender=3;
                                      });
                                    },
                                    child: Container(
                                        height: screenHeight*0.036,
                                        width: screenWidth*0.23,
                                        decoration: BoxDecoration(
                                            color: selectedgender == 3 ? Colors.black:Colors.white54,
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(Icons.transgender_sharp,color: selectedgender==3?Colors.white:Colors.black,),
                                            Text("Others",style: TextStyle(color: selectedgender == 3 ? Colors.white : Colors.black))
                                          ],
                                        )
                                    ),
                                  )
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 10.0,top: 10.0),
                              child: Row(
                                children: [
                                  Text("Rental Date and Time",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 10.0,left: 10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap:()
                                    {
                                      setState(() {
                                        selectedtime=1;
                                      });
                                    },
                                    child: Container(
                                      height:screenHeight*0.036,
                                      width: screenWidth*0.20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: selectedtime==1?Colors.black: Colors.white54
                                      ),
                                      child: Center(
                                        child: Text("Hour",style: TextStyle(
                                          color: selectedtime==1?Colors.white:Colors.black
                                        ),),
                                      ),
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: ()
                                    {
                                      setState(() {
                                        selectedtime=2;
                                      });
                                    },
                                    child: Container(
                                      height:screenHeight*0.036,
                                      width: screenWidth*0.20,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: selectedtime==2?Colors.black:Colors.white54
                                      ),
                                      child: Center(
                                        child: Text("Day",style: TextStyle(color: selectedtime==2?Colors.white:Colors.black),),
                                      ),
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        selectedtime=3;
                                      });
                                    },
                                    child: Container(
                                      height:screenHeight*0.036,
                                      width: screenWidth*0.20,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: selectedtime==3?Colors.black:Colors.white54
                                      ),
                                      child: Center(
                                        child: Text("Weekly",style: TextStyle(color: selectedtime==3?Colors.white:Colors.black)),
                                      ),
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: ()
                                    {
                                      setState(() {
                                        selectedtime=4;
                                      });
                                    },
                                    child: Container(
                                      height:screenHeight*0.036,
                                      width: screenWidth*0.20,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color:selectedtime==4?Colors.black:Colors.white54
                                      ),
                                      child: Center(
                                        child: Text("Monthly",style: TextStyle(color: selectedtime==4?Colors.white:Colors.black)),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Container(

                                  width: screenWidth*0.921,
                                  decoration:BoxDecoration(borderRadius: BorderRadius.circular(30),
                                  color: Colors.white54,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:CrossAxisAlignment.center,
                                        children: [
                                           Padding(
                                             padding: const EdgeInsets.symmetric(vertical: 8.0),
                                             child: Text("Pick-up date"),
                                           ),

                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
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
                                                    onTap: ()
                                                    {
                                                      selectDate(pickupdatecontroller);
                                                    },
                                                    readOnly: true,
                                                    controller: pickupdatecontroller,
                                                    keyboardType: TextInputType.datetime,
                                                    textInputAction: TextInputAction.done,
                                                    decoration: InputDecoration(
                                                      prefixIcon: Icon(Icons.calendar_month,color: Colors.grey.shade400,size: 17,),
                                                      hintFadeDuration: Duration(seconds:1),
                                                      hintText: 'yyyy-mm-dd',
                                                      hintStyle: TextStyle(fontSize: 15.5,fontWeight: FontWeight.w400,color: Colors.grey.shade400),

                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(15),
                                                          borderSide: BorderSide(
                                                              style: BorderStyle.none,
                                                          )
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              style: BorderStyle.none,
                                                          )),
                                                        focusedErrorBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10),
                                                            borderSide: BorderSide(color: Colors.grey,width: 1.0,style: BorderStyle.none)
                                                        )
                                                    ),
                                                  ),
                                              ),

                                       ]
                                      ),
                                    ),

                                    Container(
                                      height: screenHeight * 0.05,
                                      width: 1,
                                      color: Colors.grey.shade400,
                                    ),


                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                           Padding(
                                             padding: const EdgeInsets.symmetric(vertical: 8.0),
                                             child: Text("Return date"),
                                           ),

                                          TextFormField(
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
                                                  readOnly: true,
                                                  controller: returndatecontroller,
                                                  onTap: ()
                                                  {
                                                    selectDate(returndatecontroller);
                                                  },
                                                  keyboardType: TextInputType.datetime,
                                                  textInputAction: TextInputAction.done,
                                                  decoration: InputDecoration(
                                                    prefixIcon:Icon(Icons.calendar_month,color: Colors.grey.shade400,size: 17,),
                                                    hintFadeDuration: Duration(seconds:1),
                                                    hintText: 'yyyy-mm-dd',
                                                    hintStyle: TextStyle(fontSize: 15.5,fontWeight: FontWeight.w400,color: Colors.grey.shade400),

                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(15),
                                                        borderSide: BorderSide(
                                                          style: BorderStyle.none,
                                                        )
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          style: BorderStyle.none,
                                                        )),

                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),



                            Padding(
                              padding: const EdgeInsets.only(left: 10.0,top: 10.0),
                              child: Row(
                                children: [
                                  Text("Trip Location",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                    controller: locationcontroller,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                        enabledBorder:OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(color: Colors.grey,width: 1.0,style: BorderStyle.solid)
                                        ),
                                        prefixIcon: Icon(Icons.perm_identity,color: Colors.grey,),
                                        labelText: "Off to",
                                        labelStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),
                                        hintText: "Nagercoil",
                                        hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.grey),
                                        hintFadeDuration: Duration(seconds: 1),
                                        filled: true,
                                        fillColor: Colors.white54,
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(color: Colors.black,width: 1.0,style: BorderStyle.solid)
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(color: Colors.red,width: 1.0,style: BorderStyle.solid)

                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(color: Colors.grey,width: 1.0,style: BorderStyle.solid)
                                        )
                                    ),

                                  ),
                            ),



                          ],
                        ),
                      )),

                  SizedBox(height: screenHeight * 0.020),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(

                      onTap: ()
                      {
                        final isValid=formKey.currentState!.validate();
                        if(isValid)
                        {
                          FocusScope.of(context).unfocus();
                          int? days = calculateRentalDays()??0;
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ConfirmationPage(days:days,car:widget.car,name:namecontroller.text,pickupdate:pickupdatecontroller.text,returndate:returndatecontroller.text,location:locationcontroller.text)));
                        }
                      },

                      child: Container(
                        height: screenHeight*0.060,
                        width: screenWidth*0.90,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Book now",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),),
                            SizedBox(width: screenWidth*0.009,),
                            Icon(Icons.arrow_forward_outlined,color: Colors.white,size: 20,)],
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


  Future<void> selectDate(TextEditingController controller) async
  {
    DateTime? picked= await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2026)
    );
    if(picked!=null)
    {
      controller.text=picked.toString().split(" ")[0];
    }
  }

  int? calculateRentalDays() {
    try {

      final pickupDate = DateTime.parse(pickupdatecontroller.text);
      final returnDate = DateTime.parse(returndatecontroller.text);

      final int  difference = returnDate.difference(pickupDate).inDays;

      if (difference < 0) return null;

      return difference + 1;
    } catch (e) {

      return null;
    }
  }
}


