import 'package:rentzy/pageSet-1/OnBoardingScreen2.dart';
import 'package:rentzy/pageSet-1/SplashScreenPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Welcomescreen extends StatefulWidget {
  const Welcomescreen({super.key});

  @override
  State<Welcomescreen> createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
          child: Column(
            children: [
              Spacer(),
              Image.asset("assets/images/Onboarding/welcome1.png",fit: BoxFit.cover,height: 450,),
              Text("Rentzy",textAlign: TextAlign.center,style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 35,fontWeight: FontWeight.w600,color: Colors.black54)),),
              SizedBox(height: 15,),
              Text("Drive Your Dreams, Anytime, Anywhere!",textAlign: TextAlign.center,style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: Colors.black45))),
              SizedBox(height: 30,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:CrossAxisAlignment.center ,
                children: [
                  Container(
                    height: 40,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:Colors.black54,
                          foregroundColor: Colors.white,
                          shadowColor: Colors.blueGrey
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>OnBoardingScreen2()));
                      },
                      child: Center(
                        child: Text("Get Started",textAlign: TextAlign.center,style: GoogleFonts.lato(textStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color: Colors.white60)),),
                      ),
                    ),
                  )
                ],
              ),

              Spacer(),
            ],
          )),
    );
  }
}
