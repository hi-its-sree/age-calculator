import 'package:rentzy/Authentication/Auth.dart';
import 'package:rentzy/pageSet-1/LoginScreen.dart';
import 'package:rentzy/pageSet-1/SignupScreen.dart';
import 'package:rentzy/pageSet-1/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

List<String>logo=[
  "assets/images/Onboarding/google.svg",
  "assets/images/Onboarding/facebook.svg",
  "assets/images/Onboarding/apple.svg"
];

List<String>names=[
  "Continue with Google",
  "Continue with Facebook",
  "Continue with Apple"
];

Future<void>GoogleSignin() async
{
  try
      {
        await Authentication().SigninWithGoogle();
      }
  catch(e)
      {
        print(e.toString());
      }
}

class LetsUIn extends StatefulWidget {
  const LetsUIn({super.key});

  @override
  State<LetsUIn> createState() => _LetsUInState();
}

class _LetsUInState extends State<LetsUIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                      }, icon: Icon(Icons.arrow_back,size: 30,color: Colors.black,),)
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/Onboarding/car_onboarding.png",height:200,width:200,fit:BoxFit.fitWidth,)
                ],
              ),
              SizedBox(height: 20,),
              Text("Let's You in",textAlign: TextAlign.center,style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 35,fontWeight: FontWeight.w600,color: Colors.black)),),
              SizedBox(height: 10,),


        Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: ()
              {
                GoogleSignin();

              },
              child: Container(
                height: 45,
                width: 390,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12 ),
                    color: Colors.transparent,
                    border: Border.all(color: Colors.black12)
                ),

                child: Row(
                  children: [
                    SizedBox(width: 100,),
                    SvgPicture.asset("assets/images/Onboarding/google.svg",height: 25,width: 30,),
                    SizedBox(width: 10,),
                    Text("Continue with Google",textAlign: TextAlign.center,style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.black)),)
                  ],
                ),

              ),
            )
        ),

              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 45,
                    width: 390,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12 ),
                        color: Colors.transparent,
                        border: Border.all(color: Colors.black12)
                    ),

                    child: Row(
                      children: [
                        SizedBox(width: 100,),
                        SvgPicture.asset("assets/images/Onboarding/facebook.svg",height: 25,width: 30,),
                        SizedBox(width: 10,),
                        Text("Continue with Facebook",textAlign: TextAlign.center,style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.black)),)
                      ],
                    ),

                  )
              ),


              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 45,
                    width: 390,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12 ),
                        color: Colors.transparent,
                        border: Border.all(color: Colors.black12)
                    ),

                    child: Row(
                      children: [
                        SizedBox(width: 100,),
                        SvgPicture.asset("assets/images/Onboarding/apple.svg",height: 25,width: 30,),
                        SizedBox(width: 10,),
                        Text("Continue with Apple",textAlign: TextAlign.center,style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.black)),)
                      ],
                    ),

                  )
              ),


              SizedBox(height: 20,),

              Row(
                children: [
                  Expanded(
                      child: Divider(
                        indent: 15,
                        color: Colors.black12,)
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text("or",style: GoogleFonts.lato(textStyle: TextStyle(color:Colors.black,fontWeight: FontWeight.w500,fontSize: 17)),),
                  ),
                  Expanded
                    (child: Divider(
                      endIndent: 15,
                      color: Colors.black12)
                  )
                ],
              ),

              SizedBox(height: 20,),
              GestureDetector(
                onTap: ()
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Loginscreen()));
                },
                child: Container(
                  height: 50,
                  width: 390,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.black87,
                  ),
                  child: Center(
                      child: Text("Sign in with password",style: GoogleFonts.lato(fontSize: 17,fontWeight: FontWeight.w600,color: Colors.white),)),
                ),
              ),
              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account",style: GoogleFonts.lato(textStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 17,color: Colors.black54)),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                      },
                      child: RichText(
                          text: TextSpan(
                              text:"Sign up",
                              style: GoogleFonts.lato(textStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black
                              )))
                      ),
                    ),
                  ),
                ],
              ),
              Spacer()
            ],),
        ),


      ),
    );
  }
}
