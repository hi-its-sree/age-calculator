
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:rentzy/HomePages/MainHome.dart';
import 'package:rentzy/pageSet-1/LoginScreen.dart';

import '../Database/UserDetails.dart';

class ProfileSetup extends StatefulWidget {
  const ProfileSetup({super.key});

  @override
  State<ProfileSetup> createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {
  final formKey=GlobalKey<FormState>();
  var namecontroller=TextEditingController();
  var nicknamecontroller=TextEditingController();
  var datecontroller=TextEditingController();
  var mailcontroller=TextEditingController();
  var phonecontroller=TextEditingController();
  var addresscontroller=TextEditingController();
  var SelectedGender;
  File? SelectedImage;

  Future<void>SendProfile() async
  {
    try
        {
          await SaveDetails().ProfileDetailsToFirestore(
              Fullname: namecontroller.text,
              Nickname: nicknamecontroller.text,
              gender: SelectedGender,
              dob: datecontroller.text.toString(),
              email: mailcontroller.text,
              mobile: phonecontroller.text.toString(),
              address: addresscontroller.text.toString(),
              imageFile:SelectedImage!);

          alertDialog(context);
        }
        catch(e)
    {
        print(e);
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: ()
                        {
                          Navigator.pop(context);
                        }, icon: Icon(Icons.arrow_back,size: 30,color: Colors.black,),),
                      Text("Setup  Your Profile",style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: Colors.black))),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Center(
                  child:Stack(
                    children: [
                      SelectedImage==null? CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage("assets/images/Onboarding/user.jpg",),
                      ):CircleAvatar(
                        radius: 70,
                        backgroundImage: FileImage(SelectedImage!),
                      ),
                    Positioned(
                      left: 95,
                        top: 95,
                        child:ClipRRect(
                          borderRadius: BorderRadius.circular(9),
                          child: GestureDetector(
                            onTap: ()
                            {
                              showImagePickerOptions(context);

                            },
                            child: Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                color: Colors.black
                              ),
                              child: Icon(Icons.mode_edit_outlined,color: Colors.white,size: 23,)

                            ),
                          ),
                        )
                    )],
                  )
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60,
                              width: 380,
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
                                controller:namecontroller ,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  labelText: 'Full name',
                                    labelStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.black45),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: BorderSide(
                                      style: BorderStyle.none
                                    )
                                  ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide(
                                            style: BorderStyle.solid,
                                            width: 1.5
                                        )),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(style: BorderStyle.none),
                                    borderRadius: BorderRadius.circular(13)
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade300,
                                  hintText: 'John doe',
                                  hintStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.grey.shade400)
                                ),


                              ),
                            ),
                            SizedBox(height: 15,),

                            SizedBox(
                              height: 60,
                              width: 380,
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
                                controller:nicknamecontroller ,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  labelText:'Nick name',
                                    labelStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.black45),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide(
                                            style: BorderStyle.none
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide(
                                            style: BorderStyle.solid,
                                            width: 1.5
                                        )),

                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(style: BorderStyle.none),
                                        borderRadius: BorderRadius.circular(13)
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    hintText: 'John',
                                    hintStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.grey.shade400)
                                ),


                              ),
                            ),

                            SizedBox(height: 15,),
                            SizedBox(height: 60,
                                width: 380,
                                child: DropdownButtonFormField(

                                  validator: (value)
                                  {
                                    if(SelectedGender.isEmpty)
                                      {
                                        return 'required';
                                      }
                                    else
                                      {
                                        return null;
                                      }
                                  },
                                  value: SelectedGender,
                                  icon: Icon(Icons.arrow_drop_down),
                                  items:[
                                    DropdownMenuItem(child: Text("Male",style:TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.black45),),value: "Male",),
                                    DropdownMenuItem(child: Text("Female",style:TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.black45),),value: "Female",),
                                    DropdownMenuItem(child: Text("Rather not to say",style:TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.black45),),value:"Rather not to say",),
                                  ], onChanged: (value) {

                                  SelectedGender=value;

                                },
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide(
                                            style: BorderStyle.none
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
                                        borderSide: BorderSide(style: BorderStyle.none),
                                        borderRadius: BorderRadius.circular(13)
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    labelText:'Gender',
                                    labelStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.black45),
                                  ),

                                )

                            ),

                            SizedBox(height: 15,),

                            SizedBox(
                              height: 60,
                              width: 380,
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
                                controller:datecontroller ,
                                keyboardType: TextInputType.datetime,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  labelText: 'Date of Birth',
                                    labelStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.black45),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide(
                                            style: BorderStyle.none
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide(
                                            style: BorderStyle.solid,
                                            width: 1.5
                                        )),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(style: BorderStyle.none),
                                        borderRadius: BorderRadius.circular(13)
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    hintText: 'yyyy-mm-dd',
                                    hintStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.grey.shade400),
                                    suffixIcon: IconButton(
                                        onPressed: selectDate, icon: Icon(Icons.calendar_month,color: Colors.grey.shade400,))
                                ),
                                readOnly: false,


                              ),
                            ),

                            SizedBox(height: 15,),

                            SizedBox(
                              height: 60,
                              width: 380,
                              child: TextFormField(
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
                                controller:mailcontroller ,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide(
                                            style: BorderStyle.none
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
                                        borderSide: BorderSide(style: BorderStyle.none),
                                        borderRadius: BorderRadius.circular(13)

                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    hintText: 'sample@gmail.com',
                                    labelText:'Email',
                                    labelStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.black45),
                                    hintStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.grey.shade400),
                                    suffixIcon: Icon(Icons.email_outlined,color: Colors.grey.shade400,)
                                ),



                              ),
                            ),

                            SizedBox(height: 15,),

                            SizedBox(
                              height: 60,
                              width: 380,
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
                                controller:phonecontroller ,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide(
                                            style: BorderStyle.none
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
                                        borderSide: BorderSide(style: BorderStyle.none),
                                        borderRadius: BorderRadius.circular(13)

                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    hintText: '9025021303',
                                    labelText:'Mobile',
                                    labelStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.black45),
                                    hintStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.grey.shade400),
                                    suffixIcon: Icon(Icons.phone_iphone,color: Colors.grey.shade400,)
                                ),

                              ),
                            ),

                            SizedBox(height: 10,),
                            SizedBox(
                              height: 150,
                              width: 380,
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

                                maxLines: 3,

                                controller:addresscontroller ,
                                keyboardType: TextInputType.streetAddress,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide(
                                            style: BorderStyle.none
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
                                        borderRadius: BorderRadius.circular(13),
                                        borderSide: BorderSide(style: BorderStyle.none)
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                    hintText: '17/121,Cross Street',
                                    labelText:'Address',
                                    labelStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.black45),
                                    hintStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.grey.shade400),
                                    suffixIcon: Icon(Icons.add_location_alt_outlined,color: Colors.grey.shade400,)
                                ),

                              ),
                            ),

                                   GestureDetector(
                                     onTap: ()
                                     {
                                      final isValid=formKey.currentState!.validate();
                                      if(isValid)
                                        {
                                          FocusScope.of(context).unfocus();
                                          SendProfile();
                                        }

                                     },
                                     child: Container(
                                        height:60, width:380,
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(30),
                                         color: Colors.black,
                                       ),
                                       child: Center(
                                         child: Text("Continue",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),)
                                       ),
                                     ),
                                   ),
                          ],
                        ),
                      )),
                )
              ],
            ),
          )),
    );
  }
  Future<void> selectDate() async
  {
    DateTime? picked= await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2026)
  );
    if(picked!=null)
      {
        datecontroller.text=picked.toString().split(" ")[0];
      }
}

  Future<void> alertDialog(BuildContext context) async {
    // Show the dialog
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Image.asset("assets/images/ForgotPassword/popup.png", height: 125, width: 125),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  "Congratulations!!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  "Your account is ready to use. You will be redirected to the Home Page in a few seconds.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
                ),
                SizedBox(height: 20),
                SpinKitFadingCircle(color: Colors.black, duration: Duration(seconds: 3),size: 50.0,),
              ],
            ),

          ),
        );
      },
    );

    // Wait for 3 seconds before navigating to the next screen
    await Future.delayed(Duration(seconds: 3));

    // Close the dialog after 3 seconds and navigate to the next screen
    Navigator.of(context).pop(); // Close the dialog
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainHome()),
    );
  }


  void showImagePickerOptions(BuildContext context)
  {
    showModalBottomSheet(
      backgroundColor: Colors.grey.shade300,

        context: context,
        builder: (builder)
    {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: double.infinity,
          height:62,
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: ()
                  {
                    pickImageFromGallery();
                  },
                  child: Column(
                    children: [
                      Icon(Icons.image_sharp,size: 30,color: Colors.grey.shade800,),
                      SizedBox(height: 5.0,),
                      Text("Gallery",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)
                    ],
                  ),
                ),
              ),

              Expanded(
                child: InkWell(
                  onTap: ()
                  {
                    pickImageFromCamera();
                  },
                  child: Column(
                    children: [
                      Icon(Icons.camera_alt_outlined,size: 30,color: Colors.grey.shade800,),
                      SizedBox(height: 5.0,),
                      Text("Camera",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),)
                    ],
                  ),
                ),
              )
            ],
          ),

        ),
      );
    });
  }

  Future pickImageFromGallery() async
  {
     final returnedImage=await ImagePicker().pickImage(source: ImageSource.gallery);

     if(returnedImage ==null)
       return;
     setState(() {
       SelectedImage=File(returnedImage.path);
     });
     Navigator.pop(context);

  }

  Future pickImageFromCamera() async
  {
    final returnedImage=await ImagePicker().pickImage(source: ImageSource.camera);

    if(returnedImage ==null)
      return;
    setState(() {
      SelectedImage=File(returnedImage.path);
    });
    Navigator.pop(context);

  }

}

     
      

  
  
  
  






