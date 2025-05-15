import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  final formKey=GlobalKey<FormState>();
  var namecontroller=TextEditingController();
  var nicknamecontroller=TextEditingController();
  var datecontroller=TextEditingController();
  var mailcontroller=TextEditingController();
  var phonecontroller=TextEditingController();
  var addresscontroller=TextEditingController();
  var SelectedGender;


  Future<void> UpdateProfile() async {
    try {
      // Get current user
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('User not logged in');

      // Get current data from Firestore
      final docSnapshot = await FirebaseFirestore.instance
          .collection('userprofiles')
          .doc(user.uid)
          .get();

      if (!docSnapshot.exists) throw Exception('User document not found');

      // Get current data
      final currentData = docSnapshot.data() as Map<String, dynamic>;
      final Map<String, dynamic> updateData = {};

      // Check each field and add to update only if changed
      if (namecontroller.text.isNotEmpty &&
          currentData['Fullname'] != namecontroller.text) {
        updateData['Fullname'] = namecontroller.text;
      }

      if (nicknamecontroller.text.isNotEmpty &&
          currentData['Nickname'] != nicknamecontroller.text) {
        updateData['Nickname'] = nicknamecontroller.text;
      }

      if (SelectedGender != null &&
          currentData['gender'] != SelectedGender) {
        updateData['gender'] = SelectedGender;
      }

      if (datecontroller.text.isNotEmpty &&
          currentData['dob'] != datecontroller.text) {
        updateData['dob'] = datecontroller.text;
      }

      if (mailcontroller.text.isNotEmpty &&
          currentData['email'] != mailcontroller.text) {
        updateData['email'] = mailcontroller.text;
      }

      if (phonecontroller.text.isNotEmpty &&
          currentData['mobile'] != phonecontroller.text) {
        updateData['mobile'] = phonecontroller.text;
      }

      if (addresscontroller.text.isNotEmpty &&
          currentData['address'] != addresscontroller.text) {
        updateData['address'] = addresscontroller.text;
      }

      // Only proceed if there are changes
      if (updateData.isNotEmpty) {
        updateData['updatedAt'] = FieldValue.serverTimestamp();

        await FirebaseFirestore.instance
            .collection('userprofiles')
            .doc(user.uid)
            .update(updateData);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No changes detected')),
        );
      }

    } catch (e) {
      print('Error updating profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    var mediaQueryData=MediaQuery.of(context);
    var screenHeight=mediaQueryData.size.height;
    var screenWidth=mediaQueryData.size.width;

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
                      Text("Edit Profile",style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500,))
                    ],
                  )
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                            key: formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  TextFormField(

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
                                              borderSide: BorderSide(style: BorderStyle.solid,color: Colors.red.shade900),
                                              borderRadius: BorderRadius.circular(13)
                                          ),
                                          filled: true,
                                          fillColor: Color(0xFFCFD2D2),
                                          hintText: 'John doe',
                                          hintStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.grey.shade400)
                                      ),


                                    ),

                                  SizedBox(height: 15,),
                                     TextFormField(
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
                                              borderSide: BorderSide(style: BorderStyle.solid,color: Colors.red.shade900),
                                              borderRadius: BorderRadius.circular(13)
                                          ),
                                          filled: true,
                                          fillColor: Color(0xFFCFD2D2),
                                          hintText: 'John',
                                          hintStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.grey.shade400)
                                      ),


                                    ),


                                  SizedBox(height: 15,),
                                  DropdownButtonFormField(

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
                                              borderSide: BorderSide(style: BorderStyle.solid,color: Colors.red.shade900),
                                              borderRadius: BorderRadius.circular(13)
                                          ),
                                          filled: true,
                                          fillColor:Color(0xFFCFD2D2),
                                          labelText:'Gender',
                                          labelStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.black45),
                                        ),

                                      ),


                                  SizedBox(height: 15,),

                                    TextFormField(

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
                                              borderSide: BorderSide(style: BorderStyle.solid,color: Colors.red.shade900),
                                              borderRadius: BorderRadius.circular(13)
                                          ),
                                          filled: true,
                                          fillColor: Color(0xFFCFD2D2),
                                          hintText: 'yyyy-mm-dd',
                                          hintStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.grey.shade400),
                                          suffixIcon: IconButton(
                                              onPressed: selectDate, icon: Icon(Icons.calendar_month,color: Colors.grey.shade400,))
                                      ),
                                      readOnly: false,


                                    ),

                                  SizedBox(height: 15,),
                                  TextFormField(
                                      validator: (value)
                                      {
                                        final pattern= RegExp(r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}');
                                       if(pattern.hasMatch(value!))
                                        {
                                          return 'Enter a valid email';
                                        }
                                        else
                                        {
                                          return null;
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
                                              borderSide: BorderSide(style: BorderStyle.solid,color:Colors.red.shade900),
                                              borderRadius: BorderRadius.circular(13)

                                          ),
                                          filled: true,
                                          fillColor: Color(0xFFCFD2D2),
                                          hintText: 'sample@gmail.com',
                                          labelText:'Email',
                                          labelStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.black45),
                                          hintStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.grey.shade400),
                                          suffixIcon: Icon(Icons.email_outlined,color: Colors.grey.shade400,)
                                      ),
                                    ),
                                  SizedBox(height: 15,),
                                  TextFormField(

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
                                              borderSide: BorderSide(style: BorderStyle.solid,color: Colors.red.shade900),
                                              borderRadius: BorderRadius.circular(13),
                                          ),
                                          filled: true,
                                          fillColor: Color(0xFFCFD2D2),
                                          hintText: '9025021303',
                                          labelText:'Mobile',
                                          labelStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.black45),
                                          hintStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.grey.shade400),
                                          suffixIcon: Icon(Icons.phone_iphone,color: Colors.grey.shade400,)
                                      ),

                                    ),

                                  SizedBox(height: 10,),
                                  TextFormField(


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
                                              borderSide: BorderSide(style: BorderStyle.solid,color:Colors.red.shade900)
                                          ),
                                          filled: true,
                                          fillColor: Color(0xFFCFD2D2),
                                          hintText: '17/121,Cross Street',
                                          labelText:'Address',
                                          labelStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.black45),
                                          hintStyle: TextStyle(fontSize: 19,fontWeight: FontWeight.w400,color: Colors.grey.shade400),
                                          suffixIcon: Icon(Icons.add_location_alt_outlined,color: Colors.grey.shade400,)
                                      ),

                                    ),

                                  SizedBox(height:screenHeight*0.155,),


                                  GestureDetector(
                                    onTap: ()
                                    {
                                      final isValid=formKey.currentState!.validate();
                                      if(isValid)
                                      {
                                        FocusScope.of(context).unfocus();
                                        UpdateProfile();
                                      }

                                    },
                                    child: Container(
                                      height:screenHeight*0.060,
                                      width:screenWidth*0.90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.black,
                                      ),
                                      child: Center(
                                          child: Text("Update",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),)
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              )

            ],
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




}
