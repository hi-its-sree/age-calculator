import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:rentzy/BottomNavBar/Languages.dart';
import 'package:rentzy/BottomNavBar/PaymentMethod.dart';
import 'package:rentzy/BottomNavBar/PrivacyPolicy.dart';
import 'package:rentzy/BottomNavBar/Settings.dart';
import 'package:rentzy/HomePages/NotificationPage.dart';
import 'package:rentzy/HomePages/favourites.dart';
import 'package:rentzy/ProfilePages/EditProfile.dart';
import 'package:rentzy/pageSet-1/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Authentication/Auth.dart';
import '../Authentication/Authservice.dart';
import '../OrderPages/OrderTabs.dart';
import 'HelpCenter.dart';
import 'InviteFriends.dart';
import 'RoadAssistance.dart';
import 'ThemePage.dart';
class Profilepages extends StatefulWidget {
  const Profilepages({super.key, this.details, });
  final Map<String, dynamic>? details;
  @override
  State<Profilepages> createState() => _ProfilepagesState();
}

class _ProfilepagesState extends State<Profilepages> {

  File? SelectedImage;
  String currentOption = 'System Default';
  double rating=0;

  @override
  Widget build(BuildContext context) {


    var mediaQueryData = MediaQuery.of(context);
    var screenHeight = mediaQueryData.size.height;
    var screenWidth = mediaQueryData.size.width;


    return Scaffold(
      backgroundColor:Colors.grey.shade300,
      body: SafeArea(
          child: Column(
            children: [
              Container(
                  height: screenHeight * 0.058,
                  width: double.infinity,
                  color: Colors.white60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Profile",style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500,))
                    ],
                  )
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundImage: (widget.details?['profilePicture'] != null
                                  ? MemoryImage(base64Decode(widget.details?['profilePicture'] ?? ''))
                                  : const AssetImage("assets/images/ForgotPassword/popup.png")),
                            ),
                            Positioned(
                              left: 95,
                              top: 95,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(9),
                                child: GestureDetector(
                                  onTap: () {
                                    showImagePickerOptions(context);
                                  },
                                  child: Container(
                                    height: 32,
                                    width: 32,
                                    decoration: const BoxDecoration(color: Colors.black),
                                    child: const Icon(Icons.mode_edit_outlined, color: Colors.white, size: 23),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),



                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget.details?['Nickname'],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),
                          ],
                        ),
                      ),
                  
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.details?['mobile'],style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
                        ],
                      ),
                  
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Divider(
                          thickness: 1.0,
                          color: Colors.grey,
                          indent: 20.0,
                          endIndent: 20.0,
                        ),
                      ),
                  
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: ()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfilePage()));
                              },
                              child: ListTile(
                                leading: Icon(Icons.perm_identity),
                                title: Text("Edit profile"),
                                trailing: Icon(Icons.chevron_right),
                              ),
                            ),
                  
                            GestureDetector(
                              onTap: ()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentMethod()));
                              },
                              child: ListTile(
                                leading: Icon(Icons.payment_outlined),
                                title: Text("Payment methods"),
                                trailing: Icon(Icons.chevron_right),
                              ),
                            ),
                  
                            GestureDetector(
                              onTap: ()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Notificationpage()));
                              },
                              child: ListTile(
                                leading: Icon(Icons.notifications),
                                title: Text("Notifications"),
                                trailing: Icon(Icons.chevron_right),
                              ),
                            ),

                            GestureDetector(
                              onTap: ()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>FavouritesPage()));
                              },
                              child: ListTile(
                                leading: Icon(Icons.favorite),
                                title: Text("Favourite cars"),
                                trailing: Icon(Icons.chevron_right),
                              ),
                            ),
                  
                            GestureDetector(
                              onTap: ()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>OrdersTabs()));
                              },
                              child: ListTile(
                                leading: Icon(Icons.receipt_rounded),
                                title: Text("Bookings"),
                                trailing: Icon(Icons.chevron_right),
                              ),
                            ),

                            GestureDetector(
                              onTap: ()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>RoadAssistancePage()));
                              },
                              child: ListTile(
                                leading: Icon(Icons.car_repair),
                                title: Text("Roadside Assistance"),
                                trailing: Icon(Icons.chevron_right),
                              ),
                            ),
                  
                            GestureDetector(
                              onTap: ()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>LanguagesPage()));
                              },
                              child: ListTile(
                                leading: Icon(Icons.language),
                                title: Text("Languages"),
                                trailing: Icon(Icons.chevron_right),
                              ),
                            ),

                            GestureDetector(
                              onTap: ()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsPage()));
                              },
                              child: ListTile(
                                leading: Icon(Icons.settings),
                                title: Text("Settings"),
                                trailing: Icon(Icons.chevron_right),
                              ),
                            ),
                  
                            GestureDetector(
                              onTap: ()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>PrivacyPolicyPage()));
                              },
                              child: ListTile(
                                leading: Icon(Icons.privacy_tip),
                                title: Text("Privacy policy"),
                                trailing: Icon(Icons.chevron_right),
                              ),
                            ),
                  
                            GestureDetector(
                              onTap: ()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpCenterPage()));
                              },
                              child: ListTile(
                                leading: Icon(Icons.help_center_outlined),
                                title: Text("Help center"),
                                trailing: Icon(Icons.chevron_right),
                              ),
                            ),

                            GestureDetector(
                              onTap: ()
                              {
                                RateUs(context);
                              },
                              child: ListTile(
                                leading: Icon(Icons.star_rate),
                                title: Text("Rate us"),
                                trailing: Icon(Icons.chevron_right),
                              ),
                            ),

                            GestureDetector(
                              onTap: ()
                              {
                                ChangeThemePage(context);
                              },
                              child: ListTile(
                                leading: Icon(Icons.brightness_2_outlined),
                                title: Text("Theme"),
                                trailing: Icon(Icons.chevron_right),
                              ),
                            ),
                  
                            GestureDetector(
                              onTap: ()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>InviteFriendsPage()));
                              },
                              child: ListTile(
                                leading: Icon(Icons.group_add),
                                title: Text("Invite friends"),
                                trailing: Icon(Icons.chevron_right),
                              ),
                            ),
                  

                            GestureDetector(
                              onTap: ()
                              {
                                showLogoutConfirmation(context);
                              },
                              child: ListTile(
                                leading: Icon(Icons.logout,color: Colors.red,),
                                title: Text("Logout",style: TextStyle(color: Colors.red),),

                              ),
                            ),
                          ],
                        ),
                      )
                  
                    ],
                  ),
                ),
              )

            ],
          )
      ),
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

  ChangeThemePage(context) {
    List<String> option = ['System Default', 'Light', 'Dark'];

    showModalBottomSheet(
      context: context,
      builder: (builder) {
        String tempSelectedOption = currentOption;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return SizedBox(
              height: 250,
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Change Theme",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1.5,
                    color: Colors.grey,
                    indent: 15.0,
                    endIndent: 15.0,
                  ),
                  ...option.map((opt) => ListTile(
                    title: Text(opt),
                    leading: Radio(
                      value: opt,
                      groupValue: tempSelectedOption,
                      onChanged: (value) {
                        setModalState(() {
                          tempSelectedOption = value.toString();
                        });

                        // Also update the main state
                        setState(() {
                          currentOption = value.toString();
                        });
                      },
                      activeColor: Colors.black,
                      splashRadius: 20.0,
                    ),
                  )),
                ],
              ),
            );
          },
        );
      },
    );
  }

  RateUs(context)
  {
    showModalBottomSheet(context: context, builder: (context)
    {
      return Container(
        height: 420,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Tell us what you think about Rentzy!",style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500
                  ),)
                ],
              ),
            ),
            SizedBox(
                height: 180,
                width: 200,
                child: Lottie.asset("assets/animations/Animation - 1746003135235.json",fit: BoxFit.cover,)),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text("Your rating and feedback  is much valuable to us for serving you the best",style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        overflow:TextOverflow.ellipsis
                    ),maxLines: 2,textAlign: TextAlign.center,),
                  )
                ],
              ),
            ),
            SizedBox(height:17,),

            Center(
              child: Column(
                children: [
                  RatingBar.builder(
                    itemSize: 46,
                    itemPadding: EdgeInsets.symmetric(horizontal: 7.0),
                    updateOnDrag: true,
                    minRating:1,
                    itemBuilder: (context,_)=> Icon(Icons.star,color: Colors.amber,),
                    onRatingUpdate: (rating)
                        {
                          setState(() {
                            this.rating=rating;
                          });
                        },

                  ),
                  SizedBox(height:17,),

                  GestureDetector(
                    onTap: ()
                    {

                      Navigator.pop(context);

                      Future.delayed(Duration(seconds: 1), () {
                        Fluttertoast.showToast(
                          msg: "✨Thanks for your feedback! Your support keeps us going. 🚀",
                          textColor: Colors.black,
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.SNACKBAR,
                          backgroundColor: Colors.grey.shade100,
                        );
                      });
                    },
                    child: Container(
                      height: 40,
                      width: 70,
                     decoration: BoxDecoration(
                       color: Colors.black,
                       borderRadius: BorderRadius.circular(15),
                     ),
                      child: Center(
                        child: Text("Okay",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  )
                ],
              ),

            )
          ],
        ),
      );
    });
  }

  void showLogoutConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              const Text(
                "Are you sure you want to logout?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Cancel Button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  // Logout Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async => await _performLogout(context),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      ),
                      child: const Text(
                        "Yes, Logout",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Future<void> _performLogout(BuildContext context) async {
    try {
      // Close the bottom sheet first
      if (context.mounted) Navigator.pop(context);

      // Show loading indicator
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      // Perform logout operations
      await Authentication().signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);
      await prefs.remove('userData'); // Consider clearing other user data if needed

      // Navigate to login screen
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Loginscreen()),
              (route) => false,
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context); // Dismiss loading indicator
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logout failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
      debugPrint('Logout Error: $e');
    }
  }
}

















