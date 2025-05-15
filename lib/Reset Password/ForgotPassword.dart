import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentzy/Reset%20Password/EmailSent.dart';
import 'package:rentzy/pageSet-1/LoginScreen.dart';
import 'package:rentzy/pageSet-1/SplashScreenPage.dart';

import '../Authentication/Auth.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}
class _ForgotPasswordState extends State<ForgotPassword> {
  final mailcontroller=TextEditingController();
  var formkey=GlobalKey<FormState>();


  @override
  void dispose() {
    // TODO: implement dispose
    mailcontroller.dispose();
    super.dispose();
  }

  Future<void> SendResetEmail() async {
    try {
      // Attempt to send the reset email
      await Authentication().ResetEmail(
        email: mailcontroller.text,
      );

      // Delay before navigating to the login screen
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => EmailSent(email:mailcontroller.text)));
      });

    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.message}");

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Image.asset("assets/images/ForgotPassword/warningpopup.jpg", height: 125, width: 125),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  if (e.code == 'invalid-credential')
                  Text('No user found for that email.'),
                  if (e.code == 'invalid-email')
                  Text('The email address is badly formatted.'),
                  if (e.code == 'too-many-requests')
                  Text('Too many requests. Please try again later.'),
                  if (e.code == 'operation-not-allowed')
                  Text('Password reset operation is not allowed.'),
                  if (e.code == 'network-request-failed')
                  Text('Network error, please check your internet connection.'),
                  if (e.code == 'expired-action-code')
                  Text('The reset link has expired.'),
                  if (e.code == 'invalid-action-code')
                  Text('The reset action code is invalid.'),
                  if (e.code == 'unknown')
                  Text('An unknown error occurred.'),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      // Catch any other general exceptions
      print("General exception: $e");
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
                      Text("Forgot Password",style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: Colors.black))),
                    ],
                  ),
                ),
                SizedBox(height:50,),
                SvgPicture.asset("assets/images/ForgotPassword/Forgotpassword.svg",height: 275,width: 160,fit: BoxFit.cover,),
                SizedBox(height: 25,),
                Text("Enter the Email to send you the reset email link to change ur password",textAlign:TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w500),),
                SizedBox(height: 25,),
                Form(
                  key: formkey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
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
                                      width: 1.75
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
                              suffixIcon: Icon(Icons.email_outlined,color: Colors.grey,)
                          ),



                        ),
                      ),
                    ),),
                SizedBox(height: 20,),
                MaterialButton(onPressed: (){
                  var isValid=formkey.currentState!.validate();
                  if(isValid)
                    {
                      FocusScope.of(context).unfocus();
                      SendResetEmail();

                    }
                },
                color: Colors.black,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
                ),
                  height: 45,
                  minWidth: 175,
                  splashColor:Colors.grey.shade800,
                child: Text("Send Email",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),),
                )

              ]),
          ),











      ));
  }
}

